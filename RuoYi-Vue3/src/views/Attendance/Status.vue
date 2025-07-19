<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="default" :inline="true" v-show="showSearch">
      <el-form-item label="用户账号" prop="userName">
        <el-input v-model="queryParams.userName" placeholder="请输入用户账号" clearable @keyup.enter.native="handleQuery"/>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable style="width: 200px">
          <el-option label="请假" value="1"/>
          <el-option label="外勤" value="2"/>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain size="mini" @click="handleAdd" v-hasPermi="['attend:status:add']">
          <el-icon><Plus /></el-icon> 新增
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain size="mini" @click="handleUpdate" :disabled="single" v-hasPermi="['attend:status:edit']">
          <el-icon><Edit /></el-icon> 修改
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain size="mini" @click="handleDelete" :disabled="multiple" v-hasPermi="['attend:status:remove']">
          <el-icon><Delete /></el-icon> 删除
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain size="mini" @click="handleExport" v-hasPermi="['attend:status:export']">
          <el-icon><Download /></el-icon> 导出
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="statusList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column type="index" label="序号" width="55" align="center"/>
      <el-table-column label="用户ID" align="center" prop="userId" width="80"/>
      <el-table-column label="用户账号" align="center" prop="userName"/>
      <el-table-column label="状态" align="center" prop="status">
        <template #default="scope">
          <el-tag :type="scope.row.status === '1' ? 'warning' : 'success'">
            {{ scope.row.status === '1' ? '请假' : '外勤' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="开始日期" align="center" prop="startDate" width="180">
        <template #default="scope">
          <span>{{ formatDate(scope.row.startDate) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="结束日期" align="center" prop="endDate" width="180">
        <template #default="scope">
          <span>{{ formatDate(scope.row.endDate) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="备注" align="center" prop="remark" :show-overflow-tooltip="true"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['attend:status:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['attend:status:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改用户考勤状态对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="用户" prop="userId">
          <el-select v-model="form.userId" placeholder="请选择用户" @change="handleUserChange" style="width: 100%;">
            <el-option
              v-for="item in userOptions"
              :key="item.value"
              :label="item.label + ' (' + item.nickName + ')'"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="1">请假</el-radio>
            <el-radio label="2">外勤</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="开始日期" prop="startDate">
          <el-date-picker v-model="form.startDate" type="date" placeholder="选择开始日期" format="YYYY-MM-DD" value-format="YYYY-MM-DD" style="width: 100%;" />
        </el-form-item>
        <el-form-item label="结束日期" prop="endDate">
          <el-date-picker v-model="form.endDate" type="date" placeholder="选择结束日期" format="YYYY-MM-DD" value-format="YYYY-MM-DD" style="width: 100%;" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, nextTick, getCurrentInstance } from 'vue';
import { listStatus, getStatus, delStatus, addStatus, updateStatus } from "@/api/attend/status";
import { listUser } from "@/api/system/user"; // 导入获取用户列表的API
import { ElMessage, ElMessageBox } from 'element-plus';
import { parseTime } from '@/utils/ruoyi';
// 导入Element Plus图标
import { Plus, Edit, Delete, Download } from '@element-plus/icons-vue';
import axios from 'axios'; // 导入axios
import { getToken } from '@/utils/auth'; // 导入获取token的函数
import { saveAs } from 'file-saver'; // 导入文件保存API

// 获取全局代理对象
const { proxy } = getCurrentInstance();

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
// 用户考勤状态表格数据
const statusList = ref([]);
// 弹出层标题
const title = ref("");
// 是否显示弹出层
const open = ref(false);
// 表单引用
const formRef = ref(null);
const queryForm = ref(null);
// 用户列表
const userOptions = ref([]);

// 查询参数
const queryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  userName: null,
  status: null
});

// 表单参数
const form = reactive({
  id: null,
  userId: null,
  userName: null,
  status: "1", // 默认为请假
  startDate: null,
  endDate: null,
  remark: null
});

// 表单校验
const rules = reactive({
  userId: [
    { required: true, message: "用户不能为空", trigger: "change" }
  ],
  status: [
    { required: true, message: "状态不能为空", trigger: "change" }
  ],
  startDate: [
    { required: true, message: "开始日期不能为空", trigger: "blur" }
  ],
  endDate: [
    { required: true, message: "结束日期不能为空", trigger: "blur" }
  ]
});

// 日期格式化函数
const formatDate = (date) => {
  if (!date) return '';
  if (typeof date === 'string') {
    // 如果已经是字符串，确保格式正确
    if (date.includes('-')) {
      return date;
    }
  }
  return parseTime(date, '{y}-{m}-{d}');
};

/** 查询用户考勤状态列表 */
const getList = () => {
  loading.value = true;
  listStatus(queryParams).then(response => {
    statusList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
};

// 获取所有用户列表
const getUserList = async () => {
  try {
    const res = await listUser({ pageSize: 999 }); // 获取足够多的用户
    userOptions.value = res.rows.map(user => {
      return {
        value: user.userId,
        label: user.userName,
        nickName: user.nickName
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
    }
  } else {
    form.userId = null;
    form.userName = null;
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
    userName: null,
    status: "1", // 默认为请假
    startDate: null,
    endDate: null,
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
    handleQuery();
  });
};

// 多选框选中数据
const handleSelectionChange = (selection) => {
  ids.value = selection.map(item => item.id);
  single.value = selection.length !== 1;
  multiple.value = !selection.length;
};

/** 新增按钮操作 */
const handleAdd = () => {
  reset();
  getUserList(); // 获取用户列表
  open.value = true;
  title.value = "添加用户考勤状态";
};

/** 修改按钮操作 */
const handleUpdate = (row) => {
  reset();
  getUserList(); // 获取用户列表
  const id = row.id || ids.value[0];
  getStatus(id).then(response => {
    Object.assign(form, response.data);
    open.value = true;
    title.value = "修改用户考勤状态";
  });
};

/** 提交按钮 */
const submitForm = () => {
  if (!formRef.value) return;
  
  formRef.value.validate(valid => {
    if (valid) {
      if (form.id != null) {
        updateStatus(form).then(response => {
          ElMessage.success("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addStatus(form).then(response => {
          ElMessage.success("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
};

/** 删除按钮操作 */
const handleDelete = (row) => {
  const statusIds = row.id || ids.value;
  ElMessageBox.confirm('是否确认删除用户考勤状态编号为"' + statusIds + '"的数据项?', "警告", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning"
  }).then(() => {
    return delStatus(statusIds);
  }).then(() => {
    getList();
    ElMessage.success("删除成功");
  }).catch(() => {});
};

/** 导出按钮操作 */
const handleExport = () => {
  const queryParams = {
    userName: queryParams.userName,
    status: queryParams.status
  };
  
  ElMessageBox.confirm('是否确认导出所有用户考勤状态数据项?', "警告", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning"
  }).then(() => {
    return axios({
      method: 'get',
      url: '/attend/status/export',
      params: queryParams,
      headers: { 'Authorization': 'Bearer ' + getToken() },
      responseType: 'blob'
    });
  }).then(response => {
    const blob = new Blob([response.data], { type: 'application/vnd.ms-excel' });
    saveAs(blob, '用户考勤状态数据.xlsx');
  });
};

onMounted(() => {
  getList();
});
</script> 