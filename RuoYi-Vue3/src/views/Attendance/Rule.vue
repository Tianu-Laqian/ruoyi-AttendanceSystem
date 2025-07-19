<template>
  <div class="app-container">
    <el-card class="box-card">
      <template #header>
        <div class="card-header">
          <span>考勤规则设置</span>
        </div>
      </template>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="规则名称" prop="ruleName">
          <el-input v-model="form.ruleName" placeholder="请输入规则名称" />
        </el-form-item>
        <el-form-item label="上班时间" prop="workStartTime">
          <el-time-picker 
            v-model="form.workStartTime" 
            format="HH:mm" 
            value-format="HH:mm" 
            placeholder="选择上班时间" 
            style="width: 100%;"
            clearable
          />
        </el-form-item>
        <el-form-item label="下班时间" prop="workEndTime">
          <el-time-picker 
            v-model="form.workEndTime" 
            format="HH:mm" 
            value-format="HH:mm" 
            placeholder="选择下班时间" 
            style="width: 100%;"
            clearable
          />
        </el-form-item>
        <el-form-item label="迟到阈值(分钟)" prop="lateMinutes">
          <el-input-number v-model="form.lateMinutes" :min="0" :max="60" placeholder="迟到阈值(分钟)" style="width: 100%;"/>
        </el-form-item>
        <el-form-item label="早退阈值(分钟)" prop="earlyLeaveMinutes">
          <el-input-number v-model="form.earlyLeaveMinutes" :min="0" :max="60" placeholder="早退阈值(分钟)" style="width: 100%;"/>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="0">启用</el-radio>
            <el-radio label="1">停用</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitForm" v-hasPermi="['attend:rule:edit']">保存设置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, getCurrentInstance, watch } from 'vue';
import { getActiveRule, updateRule } from "@/api/attend/rule";
import { ElMessage } from 'element-plus';

// 获取全局代理对象
const { proxy } = getCurrentInstance();

// 遮罩层
const loading = ref(false);
// 表单引用
const formRef = ref(null);

// 表单参数
const form = reactive({
  id: null,
  ruleName: null,
  workStartTime: null,
  workEndTime: null,
  lateMinutes: 10,
  earlyLeaveMinutes: 10,
  status: "0",
  remark: null
});

// 表单校验
const rules = reactive({
  ruleName: [
    { required: true, message: "规则名称不能为空", trigger: "blur" }
  ],
  startTime: [
    { required: true, message: "上班时间不能为空", trigger: "blur" }
  ],
  endTime: [
    { required: true, message: "下班时间不能为空", trigger: "blur" }
  ],
  status: [
    { required: true, message: "状态不能为空", trigger: "change" }
  ]
});

/** 获取考勤规则 */
const getRule = () => {
  loading.value = true;
  getActiveRule().then(response => {
    if (response.data) {
      // 处理时间格式
      const data = { ...response.data };
      
      // 确保时间格式正确 (HH:mm)
      if (data.startTime) {
        // 如果是完整的日期时间格式，只保留时间部分
        if (data.startTime.includes(' ')) {
          data.startTime = data.startTime.split(' ')[1].substring(0, 5);
        } else if (data.startTime.includes(':')) {
          // 如果已经是时间格式，确保只有HH:mm
          data.startTime = data.startTime.substring(0, 5);
        }
      }
      
      if (data.endTime) {
        // 如果是完整的日期时间格式，只保留时间部分
        if (data.endTime.includes(' ')) {
          data.endTime = data.endTime.split(' ')[1].substring(0, 5);
        } else if (data.endTime.includes(':')) {
          // 如果已经是时间格式，确保只有HH:mm
          data.endTime = data.endTime.substring(0, 5);
        }
      }
      
      Object.assign(form, data);
      console.log("处理后的表单数据:", form);
    }
    loading.value = false;
  }).catch((error) => {
    console.error("获取考勤规则失败:", error);
    loading.value = false;
  });
};

/** 提交按钮 */
const submitForm = () => {
  if (!formRef.value) return;
  
  formRef.value.validate(valid => {
    if (valid) {
      loading.value = true;
      
      // 创建表单数据的副本，确保不直接修改原始表单
      const formData = { ...form };
      
      // 确保时间格式正确
      if (formData.startTime && typeof formData.startTime === 'string') {
        // 确保格式为 HH:mm
        formData.startTime = formData.startTime.substring(0, 5);
      }
      
      if (formData.endTime && typeof formData.endTime === 'string') {
        // 确保格式为 HH:mm
        formData.endTime = formData.endTime.substring(0, 5);
      }
      
      updateRule(formData).then(response => {
        ElMessage.success("保存成功");
        loading.value = false;
        // 重新获取规则以确保数据同步
        getRule();
      }).catch((error) => {
        console.error("保存失败:", error);
        ElMessage.error("保存失败，请检查数据格式");
        loading.value = false;
      });
    }
  });
};

onMounted(() => {
  getRule();
});
</script>

<style scoped>
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style> 