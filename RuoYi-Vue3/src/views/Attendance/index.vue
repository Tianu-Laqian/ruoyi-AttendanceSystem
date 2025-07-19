<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="default" :inline="true" v-show="showSearch">
      <el-form-item label="用户账号" prop="userName" v-if="isAdmin">
        <el-input v-model="queryParams.userName" placeholder="请输入用户账号" clearable @keyup.enter.native="handleQuery"/>
      </el-form-item>
      <el-form-item label="打卡日期" prop="attendDate">
        <el-date-picker clearable v-model="queryParams.attendDate" type="date" 
        format="YYYY-MM-DD" value-format="YYYY-MM-DD" placeholder="请选择打卡日期"/>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable style="width: 200px">
          <el-option label="正常" value="0"/>
          <el-option label="异常" value="1"/>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain size="mini" @click="handleAdd" v-hasPermi="['attend:record:add']">
          <el-icon><Plus /></el-icon> 新增
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="primary" plain size="mini" @click="handleClockIn" :disabled="clockInDisabled">
          <el-icon><Clock /></el-icon> 上班打卡
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain size="mini" @click="handleClockOut" :disabled="clockOutDisabled">
          <el-icon><Check /></el-icon> 下班打卡
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain size="mini" @click="handleExport" v-hasPermi="['attend:record:export']">
          <el-icon><Download /></el-icon> 导出
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 表格部分日期显示 -->
    <el-table v-loading="loading" :data="recordList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column type="index" label="序号" width="55" align="center"/>
      <el-table-column label="用户ID" align="center" prop="userId" width="80"/>
      <el-table-column label="部门ID" align="center" prop="deptId" width="80"/>
      <el-table-column label="用户账号" align="center" prop="userName"/>
      <el-table-column label="打卡日期" align="center" prop="attendDate" width="180">
        <template #default="scope">
          <span>{{ formatDate(scope.row.attendDate) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="上班打卡时间" align="center" prop="clockInTime" width="180">
        <template #default="scope">
          <span>{{ formatDateTime(scope.row.clockInTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="下班打卡时间" align="center" prop="clockOutTime" width="180">
        <template #default="scope">
          <span>{{ formatDateTime(scope.row.clockOutTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status">
        <template #default="scope">
          <el-tag :type="scope.row.status === '0' ? 'success' : 'danger'">
            {{ scope.row.status === '0' ? '正常' : '异常' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="异常详情" align="center" prop="exceptionInfo" :show-overflow-tooltip="true"/>
      <el-table-column label="备注" align="center" prop="remark" :show-overflow-tooltip="true"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['attend:record:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['attend:record:remove']">删除</el-button>
          <el-button size="mini" type="text" icon="el-icon-view" @click="handleViewCalendar(scope.row)">查看打卡情况</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList"/>

    <!-- 添加或修改考勤记录对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="用户" prop="userId">
          <el-select v-model="form.userId" placeholder="请选择用户" @change="handleUserChange">
            <el-option
              v-for="item in userOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="打卡日期" prop="attendDate">
          <el-date-picker clearable v-model="form.attendDate" type="date" format="YYYY-MM-DD" value-format="YYYY-MM-DD" placeholder="请选择打卡日期"/>
        </el-form-item>
        <el-form-item label="上班打卡时间" prop="clockInTime">
          <el-date-picker clearable v-model="form.clockInTime" type="datetime"         
          format="YYYY/MM/DD HH:mm:ss"
          placeholder="请选择上班打卡时间"/>
        </el-form-item>
        <el-form-item label="下班打卡时间" prop="clockOutTime">
          <el-date-picker clearable v-model="form.clockOutTime" type="datetime"         
          format="YYYY/MM/DD HH:mm:ss"
           placeholder="请选择下班打卡时间"/>
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="form.status">
            <el-radio label="0">正常</el-radio>
            <el-radio label="1">异常</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="异常详情" prop="exceptionInfo" v-if="form.status === '1'">
          <el-input v-model="form.exceptionInfo" type="textarea" placeholder="请输入异常详情"/>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容"/>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 月度考勤日历对话框 -->
    <el-dialog 
      title="月度考勤日历" 
      v-model="calendarOpen" 
      width="80%" 
      append-to-body
      @opened="handleCalendarDialogOpened"
      @closed="handleCalendarDialogClosed">
      <attendance-calendar :user-name="selectedUserName" ref="calendarRef" />
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, nextTick, getCurrentInstance, computed } from 'vue';
import { listRecord, getRecord, delRecord, addRecord, updateRecord, clockIn, clockOut, getTodayAttendance } from "@/api/attend/record";
import { getUserProfile } from "@/api/system/user";
import { listUser } from "@/api/system/user";   // 导入获取用户列表的API
import { ElMessage, ElMessageBox } from 'element-plus';
import { parseTime } from '@/utils/ruoyi';
import { useRouter } from 'vue-router';
import AttendanceCalendar from './AttendanceCalendar.vue';
// 导入Element Plus图标
import { Plus, Clock, Check, Download, Setting, User } from '@element-plus/icons-vue';
import axios from 'axios'; // 导入axios
import { getToken } from '@/utils/auth'; // 导入获取token的函数
import { saveAs } from 'file-saver'; // 导入文件保存API
import useUserStore from '@/store/modules/user'; // 导入用户store

// 获取当前日期 yyyy-MM-dd
const getCurrentDate = () => {
  const now = new Date();
  const year = now.getFullYear();
  const month = String(now.getMonth() + 1).padStart(2, '0');
  const day = String(now.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
};

// 获取当前日期时间 yyyy-MM-dd HH:mm:ss
const getCurrentDateTime = () => {
  const now = new Date();
  const year = now.getFullYear();
  const month = String(now.getMonth() + 1).padStart(2, '0');
  const day = String(now.getDate()).padStart(2, '0');
  const hours = String(now.getHours()).padStart(2, '0');
  const minutes = String(now.getMinutes()).padStart(2, '0');
  const seconds = String(now.getSeconds()).padStart(2, '0');
  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
};

// 获取全局代理对象
const { proxy } = getCurrentInstance();
// 获取路由对象
const router = useRouter();

// 遮罩层
const loading = ref(true);
// 显示搜索条件
const showSearch = ref(true);
// 选中数组
const ids = ref([]);
// 非单个禁用
const single = ref(true);
// 非多个禁用
const multiple = ref(true);
// 总条数
const total = ref(0);
// 考勤记录表格数据
const recordList = ref([]);
// 弹出层标题
const title = ref("");
// 是否显示弹出层
const open = ref(false);
// 是否显示月度考勤日历弹出层
const calendarOpen = ref(false);
// 选中的用户名
const selectedUserName = ref("");
// 日历组件引用
const calendarRef = ref(null);
// 表单引用
const formRef = ref(null);
const queryForm = ref(null);

// 添加打卡状态控制变量
const clockInDisabled = ref(false);
const clockOutDisabled = ref(true);
const currentUserId = ref(null);
const currentUserName = ref('');
const currentDeptId = ref(null);

// 用户列表
const userOptions = ref([]);

// 查询参数
const queryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  userName: null,
  attendDate: null,
  status: null
});

// 表单参数
const form = reactive({
  id: null,
  userId: null,
  deptId: null,
  attendDate: null,
  clockInTime: null,
  clockOutTime: null,
  status: "0",
  exceptionInfo: null,
  remark: null
});

// 表单校验
const rules = reactive({
  userId: [
    { required: true, message: "用户ID不能为空", trigger: "blur" }
  ],
  attendDate: [
    { required: true, message: "打卡日期不能为空", trigger: "blur" }
  ]
});

// 日期格式化函数
const formatDate = (date) => {
  if (!date) return '';
  if (typeof date === 'string') {
    // 如果已经是字符串，确保格式正确
    if (date.includes('-')) {
      return date.split(' ')[0]; // 只返回日期部分
    }
  }
  return parseTime(date, '{y}-{m}-{d}');
};

// 日期时间格式化函数
const formatDateTime = (datetime) => {
  if (!datetime) return '';
  if (typeof datetime === 'string') {
    // 如果已经是字符串，确保格式正确
    if (datetime.includes('-') && datetime.includes(':')) {
      return datetime;
    }
  }
  return parseTime(datetime, '{y}-{m}-{d} {h}:{i}:{s}');
};

// 获取用户store
const userStore = useUserStore();

// 判断当前用户是否为管理员
const isAdmin = computed(() => {
  return userStore.roles.includes('admin');
});

/** 查询考勤记录列表 */
const getList = () => {
  loading.value = true;
  // 如果不是管理员，自动设置查询条件为当前用户
  if (!isAdmin.value && !queryParams.userName) {
    queryParams.userName = currentUserName.value;
  }
  
  listRecord(queryParams).then(response => {
    recordList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
};

// 获取当前用户信息
const getCurrentUserInfo = async () => {
  try {
    const res = await getUserProfile();
    currentUserId.value = res.data.userId;
    currentUserName.value = res.data.userName;
    currentDeptId.value = res.data.deptId;
    // 获取今日打卡记录
    checkTodayAttendance();
  } catch (error) {
    console.error('获取用户信息失败:', error);
  }
};

// 检查今日打卡状态
const checkTodayAttendance = async () => {
  try {
    const res = await getTodayAttendance(currentUserId.value);
    if (res.data) {
      if(res.data.status === '1'){
        clockInDisabled.value = true;
        clockOutDisabled.value = true;
      }
      // 已有打卡记录
      else if (res.data.clockInTime) {
        clockInDisabled.value = true; // 已上班打卡，禁用上班打卡按钮
        
        if (res.data.clockOutTime) {
          clockOutDisabled.value = true; // 已下班打卡，禁用下班打卡按钮
        } else {
          clockOutDisabled.value = false; // 未下班打卡，启用下班打卡按钮
        }
      }
    } else {
      // 今日无打卡记录
      clockInDisabled.value = false;
      clockOutDisabled.value = true;
    }
  } catch (error) {
    console.error('获取今日打卡记录失败:', error);
  }
};

// 获取所有用户列表
const getUserList = async () => {
  try {
    const res = await listUser({ pageSize: 999 }); // 获取足够多的用户
    userOptions.value = res.rows.map(user => {
      return {
        value: user.userId,
        label: user.userName,
        nickName: user.nickName,
        deptId: user.deptId
      };
    });
  } catch (error) {
    console.error('获取用户列表失败:', error);
  }
};

// 用户选择变更事件
const handleUserChange = (userId) => {
  if (userId) {
    const selectedUser = userOptions.value.find(user => user.value === userId);
    if (selectedUser) {
      form.userId = selectedUser.value;
      form.userName = selectedUser.label;
      form.deptId = selectedUser.deptId;
    }
  } else {
    form.userId = null;
    form.userName = null;
    form.deptId = null;
  }
};

// 取消按钮
const cancel = () => {
  open.value = false;
  reset();
};

// 表单重置
const reset = () => {
  Object.assign(form, {
    id: null,
    userId: null,
    deptId: null,
    userName: null,
    attendDate: null,
    clockInTime: null,
    clockOutTime: null,
    status: "0",
    exceptionInfo: null,
    remark: null
  });
  nextTick(() => {
    if (formRef.value) {
      formRef.value.resetFields();
    }
  });
};

/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.pageNum = 1;
  getList();
};

/** 重置按钮操作 */
const resetQuery = () => {
  nextTick(() => {
    if (queryForm.value) {
      queryForm.value.resetFields();
    }
    // 如果不是管理员，重置后需要保留用户名条件
    if (!isAdmin.value) {
      queryParams.userName = currentUserName.value;
    }
    handleQuery();
  });
};

/** 新增按钮操作 */
const handleAdd = () => {
  reset();
  getUserList(); // 获取用户列表
  Object.assign(form, {
    id: null,
    userId: null,
    deptId: null,
    userName: null,
    attendDate: getCurrentDate(),
    clockInTime: null,
    clockOutTime: null,
    status: "0",
    remark: null
  });
  open.value = true;
  title.value = "添加考勤记录";
};

/** 修改按钮操作 */
const handleUpdate = (row) => {
  reset();
  getUserList(); // 获取用户列表
  const id = row.id || ids.value[0];
  getRecord(id).then(response => {
    Object.assign(form, response.data);
    open.value = true;
    title.value = "修改考勤记录";
  });
};

/** 上班打卡操作 */
const handleClockIn = async () => {
  try {
    // 构建打卡数据
    const clockInData = {
      userId: currentUserId.value,
      userName: currentUserName.value,
      deptId: currentDeptId.value,
      attendDate: getCurrentDate(), // 当前日期
      clockInTime: getCurrentDateTime(), // 当前时间
      status: '0'
    };
    
    const res = await clockIn(clockInData);
    if (res.code === 200) {
      ElMessage.success("上班打卡成功");
      clockInDisabled.value = true;
      clockOutDisabled.value = false;
      getList(); // 刷新列表
    } else {
      ElMessage.error(res.msg || "上班打卡失败");
    }
  } catch (error) {
    console.error("打卡失败:", error);
    ElMessage.error("打卡失败，请稍后重试");
  }
};

/** 下班打卡操作 */
const handleClockOut = async () => {
  try {
    // 构建打卡数据
    const clockOutData = {
      userId: currentUserId.value,
      attendDate: getCurrentDate(), // 当前日期
      clockOutTime: getCurrentDateTime() // 当前时间
    };
    
    const res = await clockOut(clockOutData);
    if (res.code === 200) {
      ElMessage.success("下班打卡成功");
      clockOutDisabled.value = true;
      getList(); // 刷新列表
    } else {
      ElMessage.error(res.msg || "下班打卡失败");
    }
  } catch (error) {
    console.error("打卡失败:", error);
    ElMessage.error("打卡失败，请稍后重试");
  }
};

/** 提交按钮 */
const submitForm = () => {
  formRef.value.validate(valid => {
    if (valid) {
      // 日期格式标准化
      if (form.attendDate) {
        // 确保打卡日期格式为 yyyy-MM-dd
        if (typeof form.attendDate === 'object') {
          form.attendDate = formatDate(form.attendDate);
        }
      } else {
        form.attendDate = getCurrentDate();
      }
      
      // 处理上班和下班时间
      if (form.clockInTime) {
        // 确保时间格式为 yyyy-MM-dd HH:mm:ss
        if (typeof form.clockInTime === 'object') {
          form.clockInTime = formatDateTime(form.clockInTime);
        }
      }
      
      if (form.clockOutTime) {
        // 确保时间格式为 yyyy-MM-dd HH:mm:ss
        if (typeof form.clockOutTime === 'object') {
          form.clockOutTime = formatDateTime(form.clockOutTime);
        }
      }
      
      // 确保用户ID和用户名已设置
      if (!form.userId) {
        ElMessage.error("请选择用户");
        return;
      }
      
      if (form.id != null) {
        updateRecord(form).then(response => {
          ElMessage.success("修改成功");
          open.value = false;
          getList();
        }).catch(error => {
          console.error("修改失败:", error);
          ElMessage.error("修改失败，请检查数据格式");
        });
      } else {
        addRecord(form).then(response => {
          ElMessage.success("新增成功");
          open.value = false;
          getList();
        }).catch(error => {
          console.error("新增失败:", error);
          ElMessage.error("新增失败，请检查数据格式");
        });
      }
    }
  });
};

/** 删除按钮操作 */
const handleDelete = (row) => {
  const deleteIds = row.id || ids.value;
  ElMessageBox.confirm('是否确认删除考勤记录编号为"' + deleteIds + '"的数据项？').then(() => {
    return delRecord(deleteIds);
  }).then(() => {
    getList();
    ElMessage.success("删除成功");
  }).catch(() => {});
};

/** 导出按钮操作 */
const handleExport = () => {
  // 创建一个表单以正确处理下载请求
  const params = {
    userName: queryParams.userName || undefined,
    attendDate: queryParams.attendDate || undefined,
    status: queryParams.status || undefined
  };
  
  // 显示下载中提示
  ElMessage.success("正在导出数据，请稍候...");
  
  // 使用axios直接处理导出请求
  const baseApiUrl = import.meta.env.VITE_APP_BASE_API || '';
  const baseUrl = baseApiUrl + "/attend/record/export";
  
  // 构建查询参数URL
  const queryString = Object.entries(params)
    .filter(([_, value]) => value !== undefined)
    .map(([key, value]) => `${encodeURIComponent(key)}=${encodeURIComponent(value)}`)
    .join('&');
  
  const url = baseUrl + (queryString ? `?${queryString}` : '');
  
  // 使用axios处理二进制流下载
  axios({
    method: 'get',
    url: url,
    responseType: 'blob',
    headers: { 'Authorization': 'Bearer ' + getToken() }
  }).then((res) => {
    const blob = new Blob([res.data], { 
      type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' 
    });
    
    // 使用文件保存API保存文件
    saveAs(blob, `考勤记录_${new Date().getTime()}.xlsx`);
    ElMessage.success("导出成功");
  }).catch(err => {
    console.error("导出失败", err);
    ElMessage.error("导出失败");
  });
};

/** 查看月度考勤日历按钮操作 */
function handleViewCalendar(row) {
  selectedUserName.value = row.userName;
  calendarOpen.value = true;
  
  // 确保日历组件在每次打开时都重新获取数据
  nextTick(() => {
    // 通过ref获取日历组件实例并调用其fetchMonthlyData方法
    if (calendarRef.value) {
      calendarRef.value.fetchData();
    }
  });
}

/** 月度考勤日历对话框打开时触发 */
const handleCalendarDialogOpened = () => {
  // 在日历组件打开时，可以执行一些操作，例如重新获取数据
  if (calendarRef.value) {
    calendarRef.value.fetchData();
  }
};

/** 月度考勤日历对话框关闭时触发 */
const handleCalendarDialogClosed = () => {
  // 在日历组件关闭时，可以执行一些操作，例如清空数据
  if (calendarRef.value) {
    calendarRef.value.clearData();
  }
};

// 生命周期钩子
onMounted(() => {
  getCurrentUserInfo().then(() => {
    // 如果不是管理员，设置查询条件为当前用户
    if (!isAdmin.value) {
      queryParams.userName = currentUserName.value;
    }
    getList();
  });
});

/** 多选框选中数据 */
const handleSelectionChange = (selection) => {
  ids.value = selection.map(item => item.id);
  single.value = selection.length !== 1;
  multiple.value = !selection.length;
};
</script>

<style scoped>
/* 可以添加一些自定义样式 */
</style> 