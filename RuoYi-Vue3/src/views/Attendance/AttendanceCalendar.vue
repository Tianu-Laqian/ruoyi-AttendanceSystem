<template>
  <div class="calendar-container">
    <div class="calendar-header">
      <div class="user-info">
        用户名称：{{ userName }}
      </div>
      <div class="calendar-title">
        <el-button type="primary" @click="prevMonth">上个月</el-button>
        <span class="month-title">{{ currentYearMonth }}</span>
        <el-button type="primary" @click="nextMonth">下个月</el-button>
      </div>
    </div>

    <div class="calendar-body">
      <div class="calendar-week-header">
        <div class="week-day">一</div>
        <div class="week-day">二</div>
        <div class="week-day">三</div>
        <div class="week-day">四</div>
        <div class="week-day">五</div>
        <div class="week-day">六</div>
        <div class="week-day">日</div>
      </div>

      <div class="calendar-days">
        <div
          v-for="(day, index) in calendarDays"
          :key="index"
          :class="[
            'calendar-day',
            { 'other-month': !day.currentMonth },
            { 'today': day.isToday },
            { 'has-record': day.hasRecord },
            { 'normal-status': day.status === '0' },
            { 'abnormal-status': day.status === '1' }
          ]"
        >
          <div class="day-number">{{ day.dayNumber }}</div>
          <div v-if="day.hasRecord" class="attendance-info">
            <div class="clock-in" v-if="day.clockInTime">
              上班: {{ formatTime(day.clockInTime) }}
            </div>
            <div class="clock-out" v-if="day.clockOutTime">
              下班: {{ formatTime(day.clockOutTime) }}
            </div>
            <div class="status" :class="day.status === '0' ? 'normal' : 'abnormal'">
              {{ day.status === '0' ? '正常' : '异常' }}
            </div>
          </div>
          <div v-else-if="day.currentMonth" class="no-record">
            无打卡记录
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch, defineExpose } from 'vue';
import { getMonthlyCalendar } from '@/api/attend/record';
import { parseTime } from '@/utils/ruoyi';
import { ElMessage } from 'element-plus';

const props = defineProps({
  userName: {
    type: String,
    required: true
  }
});

const emit = defineEmits(['close']);

// 当前年月
const currentYear = ref(new Date().getFullYear());
const currentMonth = ref(new Date().getMonth() + 1);
const currentYearMonth = computed(() => `${currentYear.value}年${currentMonth.value}月`);

// 日历数据
const calendarData = ref({});
const calendarDays = ref([]);

// 格式化时间
const formatTime = (time) => {
  if (!time) return '';
  return parseTime(new Date(time), '{h}:{i}:{s}');
};

// 获取月度考勤数据
const fetchMonthlyData = async () => {
  try {
    const yearMonth = `${currentYear.value}-${String(currentMonth.value).padStart(2, '0')}`;
    const res = await getMonthlyCalendar(props.userName, yearMonth);
    if (res.code === 200) {
      calendarData.value = res.data;
      generateCalendarDays();
    } else {
      ElMessage.error('获取考勤数据失败');
    }
  } catch (error) {
    console.error('获取考勤数据失败:', error);
    ElMessage.error('获取考勤数据失败');
  }
};

// 公开的方法，用于父组件调用以重新获取数据
const fetchData = () => {
  // 重置为当前月
  currentYear.value = new Date().getFullYear();
  currentMonth.value = new Date().getMonth() + 1;
  fetchMonthlyData();
};

// 清空数据
const clearData = () => {
  calendarData.value = {};
  calendarDays.value = [];
};

// 生成日历天数
const generateCalendarDays = () => {
  const days = [];
  const year = currentYear.value;
  const month = currentMonth.value;
  
  // 获取当月第一天是星期几 (0-6, 0是星期日)
  const firstDay = new Date(year, month - 1, 1).getDay();
  // 调整为星期一为一周的第一天
  const firstDayOfWeek = firstDay === 0 ? 6 : firstDay - 1;
  
  // 获取当月的天数
  const daysInMonth = new Date(year, month, 0).getDate();
  
  // 获取上个月的天数
  const prevMonthDays = new Date(year, month - 1, 0).getDate();
  
  // 填充上个月的日期
  for (let i = 0; i < firstDayOfWeek; i++) {
    const dayNumber = prevMonthDays - firstDayOfWeek + i + 1;
    const prevMonth = month === 1 ? 12 : month - 1;
    const prevYear = month === 1 ? year - 1 : year;
    const dateStr = `${prevYear}-${String(prevMonth).padStart(2, '0')}-${String(dayNumber).padStart(2, '0')}`;
    
    days.push({
      dayNumber,
      currentMonth: false,
      isToday: false,
      hasRecord: false,
      clockInTime: null,
      clockOutTime: null,
      status: null,
      date: dateStr
    });
  }
  
  // 填充当月的日期
  const today = new Date();
  const isCurrentMonth = today.getFullYear() === year && today.getMonth() + 1 === month;
  const todayDate = today.getDate();
  
  for (let i = 1; i <= daysInMonth; i++) {
    const dateStr = `${year}-${String(month).padStart(2, '0')}-${String(i).padStart(2, '0')}`;
    const dayData = calendarData.value.days && calendarData.value.days[dateStr];
    
    days.push({
      dayNumber: i,
      currentMonth: true,
      isToday: isCurrentMonth && i === todayDate,
      hasRecord: dayData ? dayData.hasRecord : false,
      clockInTime: dayData ? dayData.clockInTime : null,
      clockOutTime: dayData ? dayData.clockOutTime : null,
      status: dayData ? dayData.status : null,
      date: dateStr
    });
  }
  
  // 填充下个月的日期
  const remainingDays = 42 - days.length; // 6行7列 = 42天
  for (let i = 1; i <= remainingDays; i++) {
    const nextMonth = month === 12 ? 1 : month + 1;
    const nextYear = month === 12 ? year + 1 : year;
    const dateStr = `${nextYear}-${String(nextMonth).padStart(2, '0')}-${String(i).padStart(2, '0')}`;
    
    days.push({
      dayNumber: i,
      currentMonth: false,
      isToday: false,
      hasRecord: false,
      clockInTime: null,
      clockOutTime: null,
      status: null,
      date: dateStr
    });
  }
  
  calendarDays.value = days;
};

// 上个月
const prevMonth = () => {
  if (currentMonth.value === 1) {
    currentYear.value--;
    currentMonth.value = 12;
  } else {
    currentMonth.value--;
  }
  fetchMonthlyData();
};

// 下个月
const nextMonth = () => {
  if (currentMonth.value === 12) {
    currentYear.value++;
    currentMonth.value = 1;
  } else {
    currentMonth.value++;
  }
  fetchMonthlyData();
};

// 监听年月变化
watch([currentYear, currentMonth], () => {
  fetchMonthlyData();
});

// 组件挂载时获取数据
onMounted(() => {
  fetchMonthlyData();
});

// 暴露方法给父组件
defineExpose({
  fetchData,
  clearData
});
</script>

<style scoped>
.calendar-container {
  padding: 20px;
  background-color: #fff;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.calendar-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.user-info {
  font-size: 16px;
  font-weight: bold;
}

.calendar-title {
  display: flex;
  align-items: center;
}

.month-title {
  font-size: 18px;
  font-weight: bold;
  margin: 0 15px;
}

.calendar-week-header {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  background-color: #f5f7fa;
  border-top: 1px solid #ebeef5;
  border-bottom: 1px solid #ebeef5;
}

.week-day {
  text-align: center;
  padding: 10px;
  font-weight: bold;
}

.calendar-days {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  grid-template-rows: repeat(6, 1fr);
}

.calendar-day {
  border: 1px solid #ebeef5;
  min-height: 100px;
  padding: 5px;
  position: relative;
}

.day-number {
  font-size: 14px;
  font-weight: bold;
  margin-bottom: 5px;
}

.other-month {
  background-color: #f9f9f9;
  color: #c0c4cc;
}

.today {
  background-color: #f0f9eb;
}

.has-record {
  background-color: #ecf5ff;
}

.normal-status {
  border-left: 3px solid #67c23a;
}

.abnormal-status {
  border-left: 3px solid #f56c6c;
}

.attendance-info {
  font-size: 12px;
  line-height: 1.5;
}

.clock-in, .clock-out {
  margin-bottom: 2px;
}

.status {
  font-weight: bold;
}

.status.normal {
  color: #67c23a;
}

.status.abnormal {
  color: #f56c6c;
}

.no-record {
  font-size: 12px;
  color: #909399;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
</style> 