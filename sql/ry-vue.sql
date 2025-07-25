/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80036
 Source Host           : localhost:3306
 Source Schema         : ry-vue

 Target Server Type    : MySQL
 Target Server Version : 80036
 File Encoding         : 65001

 Date: 11/07/2025 21:20:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for attend_record
-- ----------------------------
DROP TABLE IF EXISTS `attend_record`;
CREATE TABLE `attend_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `attend_date` date NOT NULL COMMENT '打卡日期',
  `clock_in_time` datetime NULL DEFAULT NULL COMMENT '上班打卡时间',
  `clock_out_time` datetime NULL DEFAULT NULL COMMENT '下班打卡时间',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1异常）',
  `exception_info` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '异常详情',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '考勤记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of attend_record
-- ----------------------------
INSERT INTO `attend_record` VALUES (35, 3, 100, 'qwe', '2025-07-11', NULL, NULL, '1', '未上班打卡', NULL, 'system', '2025-07-11 21:17:50', '', NULL);

-- ----------------------------
-- Table structure for attend_rule
-- ----------------------------
DROP TABLE IF EXISTS `attend_rule`;
CREATE TABLE `attend_rule`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '规则ID',
  `rule_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '规则名称',
  `work_start_time` time NOT NULL COMMENT '上班时间',
  `work_end_time` time NOT NULL COMMENT '下班时间',
  `late_minutes` int NOT NULL DEFAULT 0 COMMENT '迟到阈值(分钟)',
  `early_leave_minutes` int NOT NULL DEFAULT 0 COMMENT '早退阈值(分钟)',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '考勤规则表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of attend_rule
-- ----------------------------
INSERT INTO `attend_rule` VALUES (1, '标准工作制', '10:00:00', '20:05:00', 20, 15, '0', 'admin', '2025-07-10 00:00:00', 'admin', '2025-07-11 21:17:47', '标准工作制考勤规则');

-- ----------------------------
-- Table structure for attend_user_status
-- ----------------------------
DROP TABLE IF EXISTS `attend_user_status`;
CREATE TABLE `attend_user_status`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1请假 2外勤）',
  `start_date` date NOT NULL COMMENT '开始日期',
  `end_date` date NOT NULL COMMENT '结束日期',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户考勤状态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of attend_user_status
-- ----------------------------
INSERT INTO `attend_user_status` VALUES (2, 1, 'admin', '2', '2025-07-11', '2025-07-25', 'admin', '2025-07-11 20:43:12', '', NULL, NULL);
INSERT INTO `attend_user_status` VALUES (4, 2, 'cs', '1', '2025-07-11', '2025-07-25', 'admin', '2025-07-11 21:18:25', '', NULL, NULL);

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日历信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '调度器状态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-06-29 01:32:22', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-06-29 01:32:22', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-06-29 01:32:22', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-06-29 01:32:22', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-06-29 01:32:22', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-06-29 01:32:22', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-06-29 01:32:22', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-06-29 01:32:22', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '根部门', 0, '管理员', '15888888888', 'admin@qq.com', '0', '0', 'admin', '2025-06-29 01:32:20', 'cs', '2025-06-29 04:09:35');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '一级部门', 1, 'admin', '15888888888', 'admin@qq.com', '0', '0', 'admin', '2025-06-29 01:32:20', 'cs', '2025-06-29 04:10:04');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-06-29 01:32:20', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-06-29 01:32:20', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-06-29 01:32:20', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, 'admin', '15888888888', 'admin@qq.com', '0', '0', 'admin', '2025-06-29 01:32:20', 'cs', '2025-06-29 04:10:15');
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-06-29 01:32:20', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-06-29 01:32:20', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-06-29 01:32:20', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-06-29 01:32:20', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-06-29 01:32:22', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-06-29 01:32:21', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-06-29 01:32:21', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-06-29 01:32:21', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-06-29 01:32:21', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-06-29 01:32:21', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-06-29 01:32:21', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-06-29 01:32:21', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-06-29 01:32:21', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-06-29 01:32:21', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-06-29 01:32:21', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-06-29 01:32:23', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-06-29 01:32:23', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-06-29 01:32:23', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 118 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-06-29 01:34:46');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-06-29 02:54:55');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-06-29 03:01:11');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '验证码已失效', '2025-06-29 03:11:52');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-06-29 03:12:55');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-06-29 03:43:41');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-06-29 03:44:47');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-06-29 04:08:42');
INSERT INTO `sys_logininfor` VALUES (108, 'cs', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-06-29 04:08:46');
INSERT INTO `sys_logininfor` VALUES (109, 'cs', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-06-29 04:13:12');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-06-29 04:13:13');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-07-01 16:43:18');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-07-01 16:54:31');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-07-01 16:59:28');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-09 17:03:22');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-09 17:34:57');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-09 21:26:17');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-09 23:02:41');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 17:28:52');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 18:07:06');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-07-11 18:07:13');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 18:07:15');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-07-11 18:07:53');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 18:07:55');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-07-11 18:08:57');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 18:08:58');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 18:09:34');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-07-11 18:09:53');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 18:09:54');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-07-11 18:10:34');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 18:10:35');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-07-11 18:11:57');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 18:11:58');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-07-11 18:12:41');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 18:12:42');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 18:12:54');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-07-11 18:13:33');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 18:13:33');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-07-11 18:16:41');
INSERT INTO `sys_logininfor` VALUES (139, 'cs', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-11 18:16:45');
INSERT INTO `sys_logininfor` VALUES (140, 'qwe', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-11 18:16:55');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 18:17:01');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-07-11 18:17:14');
INSERT INTO `sys_logininfor` VALUES (143, 'cs', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 18:17:18');
INSERT INTO `sys_logininfor` VALUES (144, 'cs', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-07-11 18:17:25');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 18:17:29');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 18:56:23');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-07-11 20:55:27');
INSERT INTO `sys_logininfor` VALUES (148, 'cs', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 20:55:31');
INSERT INTO `sys_logininfor` VALUES (149, 'cs', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-07-11 21:02:13');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 21:02:20');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-07-11 21:16:08');
INSERT INTO `sys_logininfor` VALUES (152, 'cs', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 21:16:26');
INSERT INTO `sys_logininfor` VALUES (153, 'cs', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-07-11 21:17:02');
INSERT INTO `sys_logininfor` VALUES (154, 'qwe', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-11 21:17:04');
INSERT INTO `sys_logininfor` VALUES (155, 'qwe', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 21:17:08');
INSERT INTO `sys_logininfor` VALUES (156, 'qwe', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-07-11 21:17:21');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-07-11 21:17:26');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-06-29 01:32:20', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-06-29 01:32:20', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-06-29 01:32:20', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-06-29 01:32:20', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-06-29 01:32:20', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-06-29 01:32:20', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-06-29 01:32:20', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-06-29 01:32:20', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-06-29 01:32:20', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-06-29 01:32:20', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-06-29 01:32:20', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-06-29 01:32:20', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-06-29 01:32:20', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-06-29 01:32:20', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-06-29 01:32:20', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-06-29 01:32:20', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-06-29 01:32:20', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-06-29 01:32:20', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-06-29 01:32:20', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-06-29 01:32:20', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-06-29 01:32:20', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-06-29 01:32:20', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-06-29 01:32:20', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '考勤记录', 2003, 4, 'Attendance', 'Attendance/index', NULL, '', 1, 0, 'C', '0', '0', '', 'sunny', 'cs', '2025-06-29 04:12:22', 'admin', '2025-07-11 20:50:28', '');
INSERT INTO `sys_menu` VALUES (2001, '考勤规则', 2003, 4, 'AttendanceRule', 'Attendance/Rule', NULL, '', 1, 0, 'C', '0', '0', '', 'tool', 'admin', '2025-07-11 18:05:57', 'admin', '2025-07-11 20:50:55', '');
INSERT INTO `sys_menu` VALUES (2002, '考勤员工状态', 2003, 7, 'AttendanceStatus', 'Attendance/Status', NULL, '', 1, 0, 'C', '0', '0', '', 'edit', 'admin', '2025-07-11 18:21:45', 'admin', '2025-07-11 20:51:16', '');
INSERT INTO `sys_menu` VALUES (2003, '考勤管理', 0, 7, 'attend', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'server', 'admin', '2025-07-11 20:50:08', 'admin', '2025-07-11 20:51:06', '');
INSERT INTO `sys_menu` VALUES (2004, '考勤列表', 2000, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'attend:record:list', '#', 'admin', '2025-07-11 20:52:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '考勤导出', 2000, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'attend:record:export', '#', 'admin', '2025-07-11 20:53:22', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '考勤详情', 2000, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'attend:record:query', '#', 'admin', '2025-07-11 20:53:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2007, '考勤新增', 2000, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'attend:record:add', '#', 'admin', '2025-07-11 20:54:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '考勤编辑', 2000, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'attend:record:edit', '#', 'admin', '2025-07-11 20:54:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '考勤删除', 2000, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'attend:record:remove', '#', 'admin', '2025-07-11 20:54:35', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 147 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '菜单管理', 3, 'com.ruoyi.project.system.controller.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2025-06-29 03:41:00', 15);
INSERT INTO `sys_oper_log` VALUES (101, '角色管理', 2, 'com.ruoyi.project.system.controller.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-06-29 01:32:20\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-06-29 03:41:14', 58);
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 3, 'com.ruoyi.project.system.controller.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-06-29 03:41:20', 913);
INSERT INTO `sys_oper_log` VALUES (103, '通知公告', 3, 'com.ruoyi.project.system.controller.SysNoticeController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/notice/2', '127.0.0.1', '内网IP', '[2]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-06-29 03:41:32', 1097);
INSERT INTO `sys_oper_log` VALUES (104, '通知公告', 3, 'com.ruoyi.project.system.controller.SysNoticeController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/notice/1', '127.0.0.1', '内网IP', '[1]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-06-29 03:41:35', 924);
INSERT INTO `sys_oper_log` VALUES (105, '用户管理', 2, 'com.ruoyi.project.system.controller.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-06-29 01:32:20\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"测试部门\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":105,\"email\":\"cs@cs.com\",\"loginDate\":\"2025-06-29 01:32:20\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"cs\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"pwdUpdateDate\":\"2025-06-29 01:32:20\",\"remark\":\"测试员\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2,\"userName\":\"ry\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-06-29 03:42:03', 44);
INSERT INTO `sys_oper_log` VALUES (106, '部门管理', 2, 'com.ruoyi.project.system.controller.SysDeptController.edit()', 'PUT', 1, 'cs', '测试部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"根部门\",\"email\":\"admin@qq.com\",\"leader\":\"管理员\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"cs\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-06-29 04:09:35', 111);
INSERT INTO `sys_oper_log` VALUES (107, '部门管理', 2, 'com.ruoyi.project.system.controller.SysDeptController.edit()', 'PUT', 1, 'cs', '测试部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":101,\"deptName\":\"一级部门\",\"email\":\"admin@qq.com\",\"leader\":\"admin\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"parentName\":\"根部门\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"cs\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-06-29 04:10:04', 80);
INSERT INTO `sys_oper_log` VALUES (108, '部门管理', 2, 'com.ruoyi.project.system.controller.SysDeptController.edit()', 'PUT', 1, 'cs', '测试部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"测试部门\",\"email\":\"admin@qq.com\",\"leader\":\"admin\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"parentName\":\"一级部门\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"cs\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-06-29 04:10:15', 53);
INSERT INTO `sys_oper_log` VALUES (109, '菜单管理', 1, 'com.ruoyi.project.system.controller.SysMenuController.add()', 'POST', 1, 'cs', '测试部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"cs\",\"icon\":\"sunny\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"考勤管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"/\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-06-29 04:12:22', 47);
INSERT INTO `sys_oper_log` VALUES (110, '部门管理', 3, 'com.ruoyi.project.system.controller.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/102', '127.0.0.1', '内网IP', '102', '{\"msg\":\"存在下级部门,不允许删除\",\"code\":601}', 0, NULL, '2025-06-29 04:13:36', 3);
INSERT INTO `sys_oper_log` VALUES (111, '部门管理', 3, 'com.ruoyi.project.system.controller.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/109', '127.0.0.1', '内网IP', '109', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-06-29 04:13:39', 19);
INSERT INTO `sys_oper_log` VALUES (112, '部门管理', 3, 'com.ruoyi.project.system.controller.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/108', '127.0.0.1', '内网IP', '108', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-06-29 04:13:40', 22);
INSERT INTO `sys_oper_log` VALUES (113, '部门管理', 3, 'com.ruoyi.project.system.controller.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/102', '127.0.0.1', '内网IP', '102', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-06-29 04:13:42', 18);
INSERT INTO `sys_oper_log` VALUES (114, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"/Attendance\",\"createTime\":\"2025-06-29 04:12:22\",\"icon\":\"sunny\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"考勤管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"/Attendance\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-09 21:36:34', 24);
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance\",\"createTime\":\"2025-06-29 04:12:22\",\"icon\":\"sunny\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"考勤管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"Attendance\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-09 21:36:59', 9);
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/index\",\"createTime\":\"2025-06-29 04:12:22\",\"icon\":\"sunny\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"考勤管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"Attendance\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-09 21:37:12', 8);
INSERT INTO `sys_oper_log` VALUES (117, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/1', '127.0.0.1', '内网IP', '[1]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-09 22:11:31', 13);
INSERT INTO `sys_oper_log` VALUES (118, '考勤记录', 5, 'com.ruoyi.project.attend.controller.AttendRecordController.export()', 'GET', 1, 'admin', '研发部门', '/attend/record/export', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"b0b087de-e3e1-4256-832b-b0b3761be2e3_考勤记录数据.xlsx\",\"code\":200}', 0, NULL, '2025-07-09 23:32:43', 860);
INSERT INTO `sys_oper_log` VALUES (119, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-09\",\"clockInTime\":\"2025-07-09 23:50:01\",\"clockOutTime\":\"2025-07-11 23:24:04\",\"createBy\":\"2\",\"createTime\":\"2025-07-09 23:24:11\",\"deptId\":1,\"id\":3,\"params\":{},\"remark\":\"adsqwe\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-09 23:50:02', 119);
INSERT INTO `sys_oper_log` VALUES (120, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-09\",\"clockInTime\":\"2025-07-09 23:50:42\",\"clockOutTime\":\"2025-07-11 23:24:04\",\"createBy\":\"2\",\"createTime\":\"2025-07-09 23:24:11\",\"deptId\":1,\"id\":2,\"params\":{},\"remark\":\"adsqwe\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-09 23:50:45', 27);
INSERT INTO `sys_oper_log` VALUES (121, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-09\",\"clockInTime\":\"2025-07-09 23:52:19\",\"clockOutTime\":\"2025-07-11 23:24:04\",\"createBy\":\"2\",\"createTime\":\"2025-07-09 23:24:11\",\"deptId\":1,\"id\":2,\"params\":{},\"remark\":\"adsqwe\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-09 23:52:20', 6);
INSERT INTO `sys_oper_log` VALUES (122, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-09\",\"clockInTime\":\"2025-07-10 00:01:00\",\"clockOutTime\":\"2025-07-11 23:24:04\",\"createBy\":\"2\",\"createTime\":\"2025-07-09 23:24:11\",\"deptId\":1,\"id\":2,\"params\":{},\"remark\":\"adsqwe\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 00:01:01', 5);
INSERT INTO `sys_oper_log` VALUES (123, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-09\",\"clockInTime\":\"2025-07-10 00:05:36\",\"clockOutTime\":\"2025-07-11 23:24:04\",\"createBy\":\"2\",\"createTime\":\"2025-07-09 23:24:11\",\"deptId\":1,\"id\":2,\"params\":{},\"remark\":\"adsqwe\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 00:06:30', 7);
INSERT INTO `sys_oper_log` VALUES (124, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-09\",\"clockInTime\":\"0002-11-28 00:05:43\",\"clockOutTime\":\"2025-07-11 23:24:04\",\"createBy\":\"2\",\"createTime\":\"2025-07-09 23:24:11\",\"deptId\":1,\"id\":2,\"params\":{},\"remark\":\"adsqwe\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 00:09:40', 6);
INSERT INTO `sys_oper_log` VALUES (125, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-09\",\"clockInTime\":\"0002-11-28 00:05:43\",\"clockOutTime\":\"2025-07-11 23:24:04\",\"createBy\":\"2\",\"createTime\":\"2025-07-09 23:24:11\",\"deptId\":1,\"id\":2,\"params\":{},\"remark\":\"adsqwe\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 00:09:51', 4);
INSERT INTO `sys_oper_log` VALUES (126, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-09\",\"clockInTime\":\"0002-11-28 00:05:43\",\"clockOutTime\":\"2025-07-11 23:24:04\",\"createBy\":\"2\",\"createTime\":\"2025-07-09 23:24:11\",\"deptId\":1,\"id\":2,\"params\":{},\"remark\":\"adsqwe\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 00:10:09', 4);
INSERT INTO `sys_oper_log` VALUES (127, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-09\",\"clockInTime\":\"2025-07-10 00:15:49\",\"clockOutTime\":\"2025-07-11 23:24:04\",\"createBy\":\"2\",\"createTime\":\"2025-07-09 23:24:11\",\"deptId\":1,\"id\":2,\"params\":{},\"remark\":\"adsqwe\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 00:15:50', 5);
INSERT INTO `sys_oper_log` VALUES (128, '考勤记录', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.add()', 'POST', 1, 'admin', '研发部门', '/attend/record', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-10\",\"clockInTime\":\"2025-07-21 12:00:00\",\"clockOutTime\":\"2025-07-23 12:00:00\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:33:47\",\"deptId\":103,\"id\":4,\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 00:33:47', 12);
INSERT INTO `sys_oper_log` VALUES (129, '考勤记录', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.add()', 'POST', 1, 'admin', '研发部门', '/attend/record', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-29\",\"clockInTime\":\"2025-07-30 12:00:00\",\"clockOutTime\":\"2025-07-31 12:00:00\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:35:14\",\"deptId\":103,\"id\":5,\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 00:35:14', 5);
INSERT INTO `sys_oper_log` VALUES (130, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-29\",\"clockInTime\":\"2025-07-08 12:00:00\",\"clockOutTime\":\"2025-07-31 12:00:00\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:35:14\",\"deptId\":103,\"id\":5,\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 00:35:26', 6);
INSERT INTO `sys_oper_log` VALUES (131, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-29\",\"clockInTime\":\"2025-07-25 12:00:00\",\"clockOutTime\":\"2025-07-31 12:00:00\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:35:14\",\"deptId\":103,\"id\":5,\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 00:35:41', 5);
INSERT INTO `sys_oper_log` VALUES (132, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-29\",\"clockInTime\":\"2025-07-25 12:00:00\",\"clockOutTime\":\"2025-07-01 12:00:00\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:35:14\",\"deptId\":103,\"id\":5,\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 00:36:28', 4);
INSERT INTO `sys_oper_log` VALUES (133, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-29\",\"clockInTime\":\"2025-07-25 12:00:00\",\"clockOutTime\":\"2025-07-30 12:00:00\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:35:14\",\"deptId\":103,\"id\":5,\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 00:36:35', 4);
INSERT INTO `sys_oper_log` VALUES (134, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-29\",\"clockInTime\":\"2025-07-25 12:00:00\",\"clockOutTime\":\"2025-07-24 12:00:00\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:35:14\",\"deptId\":103,\"id\":5,\"params\":{},\"remark\":\"asdqwe\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 00:36:48', 4);
INSERT INTO `sys_oper_log` VALUES (135, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-29\",\"clockInTime\":\"2025-07-21 12:00:00\",\"clockOutTime\":\"2025-07-24 12:00:00\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:35:14\",\"deptId\":103,\"id\":5,\"params\":{},\"remark\":\"asdqwe\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 00:52:58', 5);
INSERT INTO `sys_oper_log` VALUES (136, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-29\",\"clockInTime\":\"2025-07-19 12:00:00\",\"clockOutTime\":\"2025-07-24 12:00:00\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:35:14\",\"deptId\":103,\"id\":5,\"params\":{},\"remark\":\"asdqwe\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 00:53:07', 4);
INSERT INTO `sys_oper_log` VALUES (137, '考勤记录', 5, 'com.ruoyi.project.attend.controller.AttendRecordController.export()', 'GET', 1, 'admin', '研发部门', '/attend/record/export', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"f564fd4a-a2eb-434a-a6b7-8aed6e62af2b_考勤记录数据.xlsx\",\"code\":200}', 0, NULL, '2025-07-10 00:57:08', 881);
INSERT INTO `sys_oper_log` VALUES (138, '考勤记录', 5, 'com.ruoyi.project.attend.controller.AttendRecordController.export()', 'GET', 1, 'admin', '研发部门', '/attend/record/export', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"d3769424-1889-44c5-b9dc-66ead99a562d_考勤记录数据.xlsx\",\"code\":200}', 0, NULL, '2025-07-10 00:57:17', 42);
INSERT INTO `sys_oper_log` VALUES (139, '考勤记录', 5, 'com.ruoyi.project.attend.controller.AttendRecordController.export()', 'GET', 1, 'admin', '研发部门', '/attend/record/export', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"5278048c-afd1-4205-96bb-7f770e130d30_考勤记录数据.xlsx\",\"code\":200}', 0, NULL, '2025-07-10 00:57:40', 40);
INSERT INTO `sys_oper_log` VALUES (140, '考勤记录', 5, 'com.ruoyi.project.attend.controller.AttendRecordController.export()', 'GET', 1, 'admin', '研发部门', '/attend/record/export', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"85deb2cf-e5c5-408a-8127-86b02098e41e_考勤记录数据.xlsx\",\"code\":200}', 0, NULL, '2025-07-10 00:57:47', 30);
INSERT INTO `sys_oper_log` VALUES (141, '考勤记录', 5, 'com.ruoyi.project.attend.controller.AttendRecordController.export()', 'GET', 1, 'admin', '研发部门', '/attend/record/export', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"e17b8792-f56b-4292-b863-bc93d3a8c425_考勤记录数据.xlsx\",\"code\":200}', 0, NULL, '2025-07-10 01:01:58', 33);
INSERT INTO `sys_oper_log` VALUES (142, '用户管理', 5, 'com.ruoyi.project.system.controller.SysUserController.export()', 'POST', 1, 'admin', '研发部门', '/system/user/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2025-07-10 01:05:33', 637);
INSERT INTO `sys_oper_log` VALUES (143, '考勤记录', 5, 'com.ruoyi.project.attend.controller.AttendRecordController.export()', 'GET', 1, 'admin', '研发部门', '/attend/record/export', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2025-07-10 01:14:53', 575);
INSERT INTO `sys_oper_log` VALUES (144, '考勤记录', 5, 'com.ruoyi.project.attend.controller.AttendRecordController.export()', 'GET', 1, 'admin', '研发部门', '/attend/record/export', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2025-07-10 01:31:15', 48);
INSERT INTO `sys_oper_log` VALUES (145, '考勤记录', 5, 'com.ruoyi.project.attend.controller.AttendRecordController.export()', 'GET', 1, 'admin', '研发部门', '/attend/record/export', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2025-07-10 01:33:22', 30);
INSERT INTO `sys_oper_log` VALUES (146, '考勤记录', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/record', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-09\",\"clockInTime\":\"2025-07-10 00:15:49\",\"clockOutTime\":\"2025-07-11 23:24:04\",\"createBy\":\"2\",\"createTime\":\"2025-07-09 23:24:11\",\"deptId\":1,\"id\":2,\"params\":{},\"remark\":\"adsqwe\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-10 01:41:57\",\"userId\":1,\"userName\":\"qw\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 01:41:57', 25);
INSERT INTO `sys_oper_log` VALUES (147, '考勤记录', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/record', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-29\",\"clockInTime\":\"2025-07-19 12:00:00\",\"clockOutTime\":\"2025-07-24 12:00:00\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:35:14\",\"deptId\":103,\"id\":5,\"params\":{},\"remark\":\"asdqwe\",\"status\":\"1\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 17:29:16\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 17:29:17', 18);
INSERT INTO `sys_oper_log` VALUES (148, '考勤记录', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/record', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-29\",\"clockInTime\":\"2025-07-19 12:00:00\",\"clockOutTime\":\"2025-07-24 12:00:00\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:35:14\",\"deptId\":103,\"id\":5,\"params\":{},\"remark\":\"asdqwe\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 17:29:20\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 17:29:20', 5);
INSERT INTO `sys_oper_log` VALUES (149, '考勤记录', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.add()', 'POST', 1, 'admin', '研发部门', '/attend/record', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-02 12:00:00\",\"clockOutTime\":\"2025-07-25 12:00:00\",\"createBy\":\"admin\",\"createTime\":\"2025-07-11 17:48:04\",\"deptId\":103,\"id\":6,\"params\":{},\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 17:48:04', 14);
INSERT INTO `sys_oper_log` VALUES (150, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 17:48:11\",\"deptId\":103,\"params\":{},\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2025-07-11 17:48:11', 5);
INSERT INTO `sys_oper_log` VALUES (151, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 17:48:15\",\"deptId\":103,\"params\":{},\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2025-07-11 17:48:15', 2);
INSERT INTO `sys_oper_log` VALUES (152, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/6', '127.0.0.1', '内网IP', '[6]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 17:48:29', 8);
INSERT INTO `sys_oper_log` VALUES (153, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 17:48:30\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"迟到528分钟\",\"id\":7,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 17:48:30', 10);
INSERT INTO `sys_oper_log` VALUES (154, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 17:48:32\",\"id\":7,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 17:48:32', 10);
INSERT INTO `sys_oper_log` VALUES (155, '考勤记录', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/record', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 17:48:30\",\"clockOutTime\":\"2025-07-11 17:48:32\",\"createBy\":\"admin\",\"deptId\":103,\"id\":7,\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 17:48:44\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 17:48:44', 4);
INSERT INTO `sys_oper_log` VALUES (156, '考勤记录', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/record', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 17:48:30\",\"clockOutTime\":\"2025-07-11 17:48:32\",\"createBy\":\"admin\",\"deptId\":103,\"id\":7,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 17:48:46\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 17:48:46', 5);
INSERT INTO `sys_oper_log` VALUES (157, '菜单管理', 1, 'com.ruoyi.project.system.controller.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createBy\":\"admin\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"rule\",\"perms\":\"rule\",\"query\":\"\",\"routeName\":\"考勤规则\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:05:57', 14);
INSERT INTO `sys_oper_log` VALUES (158, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"Attendance/rule\",\"perms\":\"rule\",\"routeName\":\"考勤规则\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:06:25', 7);
INSERT INTO `sys_oper_log` VALUES (159, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"Attendance/rule\",\"perms\":\"rule\",\"routeName\":\"考勤规则\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:07:36', 7);
INSERT INTO `sys_oper_log` VALUES (160, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"Attendance/rule\",\"perms\":\"monitor:online:list\",\"routeName\":\"考勤规则\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:08:33', 6);
INSERT INTO `sys_oper_log` VALUES (161, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"Attendance/rule\",\"perms\":\"monitor:online:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:08:50', 6);
INSERT INTO `sys_oper_log` VALUES (162, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2000,\"path\":\"Attendance/rule\",\"perms\":\"monitor:online:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:09:48', 6);
INSERT INTO `sys_oper_log` VALUES (163, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2000,\"path\":\"Attendance/rule\",\"perms\":\"monitor:online:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:10:29', 7);
INSERT INTO `sys_oper_log` VALUES (164, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2000,\"path\":\"Attendance/rule\",\"perms\":\"monitor:online:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:11:08', 7);
INSERT INTO `sys_oper_log` VALUES (165, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2000,\"path\":\"Attendance/rule\",\"perms\":\"monitor:online:list\",\"routeName\":\"rule\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:11:54', 7);
INSERT INTO `sys_oper_log` VALUES (166, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2000,\"path\":\"AttendanceRule\",\"perms\":\"monitor:online:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:12:38', 6);
INSERT INTO `sys_oper_log` VALUES (167, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2000,\"path\":\"AttendanceRule\",\"perms\":\"monitor:online:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:13:30', 5);
INSERT INTO `sys_oper_log` VALUES (168, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2000,\"path\":\"AttendanceRule\",\"perms\":\"monitor:online:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:16:21', 6);
INSERT INTO `sys_oper_log` VALUES (169, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2000,\"path\":\"AttendanceRule\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:16:29', 7);
INSERT INTO `sys_oper_log` VALUES (170, '角色管理', 2, 'com.ruoyi.project.system.controller.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-06-29 01:32:20\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2000,2001],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:16:38', 32);
INSERT INTO `sys_oper_log` VALUES (171, '用户管理', 2, 'com.ruoyi.project.system.controller.SysUserController.resetPwd()', 'PUT', 1, 'admin', '研发部门', '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:17:10', 81);
INSERT INTO `sys_oper_log` VALUES (172, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"AttendanceRule\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:18:03', 6);
INSERT INTO `sys_oper_log` VALUES (173, '考勤规则', 2, 'com.ruoyi.project.attend.controller.AttendRuleController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/rule', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:00:00\",\"earlyLeaveMinutes\":15,\"id\":1,\"lateMinutes\":15,\"params\":{},\"remark\":\"标准工作制考勤规则\",\"ruleName\":\"标准工作制\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 18:18:55\",\"workEndTime\":\"18:00:00\",\"workStartTime\":\"09:00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:18:55', 9);
INSERT INTO `sys_oper_log` VALUES (174, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/7', '127.0.0.1', '内网IP', '[7]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:19:06', 4);
INSERT INTO `sys_oper_log` VALUES (175, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 18:19:10\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"迟到559分钟\",\"id\":8,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:19:11', 7);
INSERT INTO `sys_oper_log` VALUES (176, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 18:19:11\",\"id\":8,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:19:11', 8);
INSERT INTO `sys_oper_log` VALUES (177, '考勤规则', 2, 'com.ruoyi.project.attend.controller.AttendRuleController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/rule', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:00:00\",\"earlyLeaveMinutes\":15,\"id\":1,\"lateMinutes\":15,\"params\":{},\"remark\":\"标准工作制考勤规则\",\"ruleName\":\"标准工作制\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 18:20:00\",\"workEndTime\":\"18:00:00\",\"workStartTime\":\"09:00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:20:00', 4);
INSERT INTO `sys_oper_log` VALUES (178, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2000,\"path\":\"AttendanceRule\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:20:15', 5);
INSERT INTO `sys_oper_log` VALUES (179, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"AttendanceRule\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:20:33', 5);
INSERT INTO `sys_oper_log` VALUES (180, '菜单管理', 1, 'com.ruoyi.project.system.controller.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Status\",\"createBy\":\"admin\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"考勤员工状态\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"AttendanceStatus\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:21:45', 8);
INSERT INTO `sys_oper_log` VALUES (181, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Status\",\"createTime\":\"2025-07-11 18:21:45\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"考勤员工状态\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"AttendanceStatus\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:22:24', 7);
INSERT INTO `sys_oper_log` VALUES (182, '用户考勤状态', 1, 'com.ruoyi.project.attend.controller.AttendUserStatusController.add()', 'POST', 1, 'admin', '研发部门', '/attend/status', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-11 18:22:43\",\"endDate\":\"2025-07-11\",\"id\":1,\"params\":{},\"startDate\":\"2025-07-01\",\"status\":\"1\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:22:43', 9);
INSERT INTO `sys_oper_log` VALUES (183, '用户考勤状态', 2, 'com.ruoyi.project.attend.controller.AttendUserStatusController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/status', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-11 18:22:44\",\"endDate\":\"2025-07-18\",\"id\":1,\"params\":{},\"startDate\":\"2025-07-01\",\"status\":\"1\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 18:23:04\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:23:04', 5);
INSERT INTO `sys_oper_log` VALUES (184, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/8', '127.0.0.1', '内网IP', '[8]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:23:15', 4);
INSERT INTO `sys_oper_log` VALUES (185, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 18:23:17\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"迟到563分钟\",\"id\":9,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:23:17', 6);
INSERT INTO `sys_oper_log` VALUES (186, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 18:23:18\",\"id\":9,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:23:18', 7);
INSERT INTO `sys_oper_log` VALUES (187, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/9', '127.0.0.1', '内网IP', '[9]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:23:25', 4);
INSERT INTO `sys_oper_log` VALUES (188, '用户考勤状态', 2, 'com.ruoyi.project.attend.controller.AttendUserStatusController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/status', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-11 18:22:44\",\"endDate\":\"2025-07-18\",\"id\":1,\"params\":{},\"startDate\":\"2025-07-01\",\"status\":\"1\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 18:23:37\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:23:37', 4);
INSERT INTO `sys_oper_log` VALUES (189, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 18:23:51\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"迟到563分钟\",\"id\":10,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:23:51', 7);
INSERT INTO `sys_oper_log` VALUES (190, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 18:23:52\",\"id\":10,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:23:52', 7);
INSERT INTO `sys_oper_log` VALUES (191, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/10', '127.0.0.1', '内网IP', '[10]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:23:54', 3);
INSERT INTO `sys_oper_log` VALUES (192, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 18:23:58\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"迟到563分钟\",\"id\":11,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:23:58', 8);
INSERT INTO `sys_oper_log` VALUES (193, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/11', '127.0.0.1', '内网IP', '[11]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 18:24:01', 4);
INSERT INTO `sys_oper_log` VALUES (194, '考勤规则', 2, 'com.ruoyi.project.attend.controller.AttendRuleController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/rule', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:00:00\",\"earlyLeaveMinutes\":15,\"id\":1,\"lateMinutes\":15,\"params\":{},\"remark\":\"标准工作制考勤规则\",\"ruleName\":\"标准工作制\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 19:12:31\",\"workEndTime\":\"18:00:00\",\"workStartTime\":\"09:00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:12:32', 5);
INSERT INTO `sys_oper_log` VALUES (195, '考勤规则', 2, 'com.ruoyi.project.attend.controller.AttendRuleController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/rule', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:00:00\",\"earlyLeaveMinutes\":15,\"id\":1,\"lateMinutes\":15,\"params\":{},\"remark\":\"标准工作制考勤规则\",\"ruleName\":\"标准工作制\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 19:19:07\",\"workEndTime\":\"18:00\",\"workStartTime\":\"09:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:19:07', 25);
INSERT INTO `sys_oper_log` VALUES (196, '考勤规则', 2, 'com.ruoyi.project.attend.controller.AttendRuleController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/rule', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:00:00\",\"earlyLeaveMinutes\":15,\"id\":1,\"lateMinutes\":15,\"params\":{},\"remark\":\"标准工作制考勤规则\",\"ruleName\":\"标准工作制\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 19:19:11\",\"workEndTime\":\"18:00\",\"workStartTime\":\"10:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:19:11', 6);
INSERT INTO `sys_oper_log` VALUES (197, '考勤规则', 2, 'com.ruoyi.project.attend.controller.AttendRuleController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/rule', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:00:00\",\"earlyLeaveMinutes\":15,\"id\":1,\"lateMinutes\":20,\"params\":{},\"remark\":\"标准工作制考勤规则\",\"ruleName\":\"标准工作制\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 19:19:19\",\"workEndTime\":\"18:00\",\"workStartTime\":\"10:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:19:19', 6);
INSERT INTO `sys_oper_log` VALUES (198, '考勤规则', 2, 'com.ruoyi.project.attend.controller.AttendRuleController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/rule', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:00:00\",\"earlyLeaveMinutes\":15,\"id\":1,\"lateMinutes\":20,\"params\":{},\"remark\":\"标准工作制考勤规则\",\"ruleName\":\"标准工作制\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 19:27:36\",\"workEndTime\":\"20:00\",\"workStartTime\":\"10:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:27:36', 6);
INSERT INTO `sys_oper_log` VALUES (199, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 19:27:48\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"迟到567分钟\",\"id\":12,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:27:48', 16);
INSERT INTO `sys_oper_log` VALUES (200, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 19:27:55\",\"exceptionInfo\":\"早退32分钟\",\"id\":12,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:27:55', 10);
INSERT INTO `sys_oper_log` VALUES (201, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/12', '127.0.0.1', '内网IP', '[12]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:28:03', 7);
INSERT INTO `sys_oper_log` VALUES (202, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 19:32:30\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"未打下班卡\",\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'exception_info\' in \'class com.ruoyi.project.attend.domain.AttendRecord\'', '2025-07-11 19:32:30', 128);
INSERT INTO `sys_oper_log` VALUES (203, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 19:37:00\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"未打下班卡\",\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'exception_info\' in \'class com.ruoyi.project.attend.domain.AttendRecord\'', '2025-07-11 19:37:00', 117);
INSERT INTO `sys_oper_log` VALUES (204, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 19:39:09\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"未打下班卡\",\"id\":13,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:39:09', 124);
INSERT INTO `sys_oper_log` VALUES (205, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 19:39:14\",\"exceptionInfo\":\"未打下班卡\",\"id\":13,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:39:14', 13);
INSERT INTO `sys_oper_log` VALUES (206, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/13', '127.0.0.1', '内网IP', '[13]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:40:03', 12);
INSERT INTO `sys_oper_log` VALUES (207, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 19:40:05\",\"createBy\":\"admin\",\"deptId\":103,\"id\":14,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:40:05', 21);
INSERT INTO `sys_oper_log` VALUES (208, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 19:40:11\",\"id\":14,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:40:11', 12);
INSERT INTO `sys_oper_log` VALUES (209, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/14', '127.0.0.1', '内网IP', '[14]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:54:17', 12);
INSERT INTO `sys_oper_log` VALUES (210, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 19:54:20\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"迟到594分钟\",\"id\":15,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:54:20', 18);
INSERT INTO `sys_oper_log` VALUES (211, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 19:54:33\",\"exceptionInfo\":\"迟到594分钟\",\"id\":15,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:54:33', 12);
INSERT INTO `sys_oper_log` VALUES (212, '考勤规则', 2, 'com.ruoyi.project.attend.controller.AttendRuleController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/rule', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:00:00\",\"earlyLeaveMinutes\":15,\"id\":1,\"lateMinutes\":20,\"params\":{},\"remark\":\"标准工作制考勤规则\",\"ruleName\":\"标准工作制\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 19:54:48\",\"workEndTime\":\"19:00\",\"workStartTime\":\"10:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:54:48', 9);
INSERT INTO `sys_oper_log` VALUES (213, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/15', '127.0.0.1', '内网IP', '[15]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:54:53', 4);
INSERT INTO `sys_oper_log` VALUES (214, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 19:54:55\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"迟到594分钟\",\"id\":16,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:54:55', 10);
INSERT INTO `sys_oper_log` VALUES (215, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 19:54:57\",\"exceptionInfo\":\"迟到594分钟\",\"id\":16,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:54:57', 9);
INSERT INTO `sys_oper_log` VALUES (216, '考勤规则', 2, 'com.ruoyi.project.attend.controller.AttendRuleController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/rule', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:00:00\",\"earlyLeaveMinutes\":15,\"id\":1,\"lateMinutes\":20,\"params\":{},\"remark\":\"标准工作制考勤规则\",\"ruleName\":\"标准工作制\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 19:57:42\",\"workEndTime\":\"21:00\",\"workStartTime\":\"10:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:57:42', 12);
INSERT INTO `sys_oper_log` VALUES (217, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/16', '127.0.0.1', '内网IP', '[16]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:57:46', 5);
INSERT INTO `sys_oper_log` VALUES (218, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 19:57:48\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"迟到597分钟\",\"id\":17,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:57:48', 13);
INSERT INTO `sys_oper_log` VALUES (219, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 19:57:49\",\"exceptionInfo\":\"早退62分钟\",\"id\":17,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:57:49', 11);
INSERT INTO `sys_oper_log` VALUES (220, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/17', '127.0.0.1', '内网IP', '[17]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:58:01', 4);
INSERT INTO `sys_oper_log` VALUES (221, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 19:58:11\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"迟到598分钟\",\"id\":18,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:58:11', 12);
INSERT INTO `sys_oper_log` VALUES (222, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/18', '127.0.0.1', '内网IP', '[18]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:58:35', 14);
INSERT INTO `sys_oper_log` VALUES (223, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 19:58:36\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"迟到598分钟\",\"id\":19,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 19:58:36', 27);
INSERT INTO `sys_oper_log` VALUES (224, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/19', '127.0.0.1', '内网IP', '[19]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:00:12', 11);
INSERT INTO `sys_oper_log` VALUES (225, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 20:00:15\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"迟到600分钟\",\"id\":20,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:00:15', 21);
INSERT INTO `sys_oper_log` VALUES (226, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 20:00:18\",\"exceptionInfo\":\"迟到600分钟，早退59分钟\",\"id\":20,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:00:18', 12);
INSERT INTO `sys_oper_log` VALUES (227, '考勤规则', 2, 'com.ruoyi.project.attend.controller.AttendRuleController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/rule', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:00:00\",\"earlyLeaveMinutes\":15,\"id\":1,\"lateMinutes\":20,\"params\":{},\"remark\":\"标准工作制考勤规则\",\"ruleName\":\"标准工作制\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 20:00:56\",\"workEndTime\":\"21:00\",\"workStartTime\":\"19:51\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:00:56', 9);
INSERT INTO `sys_oper_log` VALUES (228, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/20', '127.0.0.1', '内网IP', '[20]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:00:59', 4);
INSERT INTO `sys_oper_log` VALUES (229, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 20:01:01\",\"createBy\":\"admin\",\"deptId\":103,\"id\":21,\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:01:01', 10);
INSERT INTO `sys_oper_log` VALUES (230, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 20:01:04\",\"exceptionInfo\":\"早退58分钟\",\"id\":21,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:01:04', 9);
INSERT INTO `sys_oper_log` VALUES (231, '考勤记录', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/record', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-29\",\"clockInTime\":\"2025-07-19 12:00:00\",\"clockOutTime\":\"2025-07-24 12:00:00\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:35:14\",\"deptId\":103,\"id\":5,\"params\":{},\"remark\":\"asdqwe\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 20:08:31\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:08:31', 5);
INSERT INTO `sys_oper_log` VALUES (232, '考勤记录', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/record', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-10\",\"clockInTime\":\"2025-07-21 12:00:00\",\"clockOutTime\":\"2025-07-23 12:00:00\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:33:48\",\"deptId\":103,\"id\":4,\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 20:08:33\",\"userId\":1,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:08:33', 6);
INSERT INTO `sys_oper_log` VALUES (233, '考勤记录', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.add()', 'POST', 1, 'admin', '研发部门', '/attend/record', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-02 20:18:00\",\"clockOutTime\":\"2025-07-15 11:00:00\",\"createBy\":\"admin\",\"createTime\":\"2025-07-11 20:08:56\",\"deptId\":103,\"id\":22,\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:08:56', 5);
INSERT INTO `sys_oper_log` VALUES (234, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/2', '127.0.0.1', '内网IP', '[2]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:09:08', 3);
INSERT INTO `sys_oper_log` VALUES (235, '考勤记录', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.add()', 'POST', 1, 'admin', '研发部门', '/attend/record', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-02 00:00:00\",\"clockOutTime\":\"2025-07-18 00:00:00\",\"createBy\":\"admin\",\"createTime\":\"2025-07-11 20:09:21\",\"deptId\":103,\"id\":23,\"params\":{},\"remark\":\"zzzz\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-09 23:24:14\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:09:21', 6);
INSERT INTO `sys_oper_log` VALUES (236, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/23', '127.0.0.1', '内网IP', '[23]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:09:30', 3);
INSERT INTO `sys_oper_log` VALUES (237, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/21', '127.0.0.1', '内网IP', '[21]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:13:51', 10);
INSERT INTO `sys_oper_log` VALUES (238, '考勤规则', 2, 'com.ruoyi.project.attend.controller.AttendRuleController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/rule', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:00:00\",\"earlyLeaveMinutes\":15,\"id\":1,\"lateMinutes\":20,\"params\":{},\"remark\":\"标准工作制考勤规则\",\"ruleName\":\"标准工作制\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 20:14:08\",\"workEndTime\":\"18:00\",\"workStartTime\":\"10:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:14:08', 13);
INSERT INTO `sys_oper_log` VALUES (239, '用户考勤状态', 3, 'com.ruoyi.project.attend.controller.AttendUserStatusController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/status/1', '127.0.0.1', '内网IP', '[1]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:42:16', 13);
INSERT INTO `sys_oper_log` VALUES (240, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/22', '127.0.0.1', '内网IP', '[22]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:42:43', 5);
INSERT INTO `sys_oper_log` VALUES (241, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/25', '127.0.0.1', '内网IP', '[25]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:42:54', 4);
INSERT INTO `sys_oper_log` VALUES (242, '用户考勤状态', 1, 'com.ruoyi.project.attend.controller.AttendUserStatusController.add()', 'POST', 1, 'admin', '研发部门', '/attend/status', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-11 20:43:11\",\"endDate\":\"2025-07-25\",\"id\":2,\"params\":{},\"startDate\":\"2025-07-11\",\"status\":\"2\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:43:11', 8);
INSERT INTO `sys_oper_log` VALUES (243, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/26', '127.0.0.1', '内网IP', '[26]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:43:15', 4);
INSERT INTO `sys_oper_log` VALUES (244, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 20:43:36\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"迟到643分钟\",\"id\":27,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:43:36', 11);
INSERT INTO `sys_oper_log` VALUES (245, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 20:43:38\",\"exceptionInfo\":\"迟到643分钟\",\"id\":27,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:43:38', 8);
INSERT INTO `sys_oper_log` VALUES (246, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/27', '127.0.0.1', '内网IP', '[27]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:44:06', 3);
INSERT INTO `sys_oper_log` VALUES (247, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 20:44:08\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"迟到644分钟\",\"id\":28,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:44:09', 7);
INSERT INTO `sys_oper_log` VALUES (248, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 20:44:11\",\"exceptionInfo\":\"迟到644分钟\",\"id\":28,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:44:11', 7);
INSERT INTO `sys_oper_log` VALUES (249, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/28', '127.0.0.1', '内网IP', '[28]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:45:00', 11);
INSERT INTO `sys_oper_log` VALUES (250, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'admin', '研发部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 20:45:02\",\"createBy\":\"admin\",\"deptId\":103,\"exceptionInfo\":\"迟到645分钟\",\"id\":29,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:45:02', 18);
INSERT INTO `sys_oper_log` VALUES (251, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'admin', '研发部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 20:45:03\",\"exceptionInfo\":\"迟到645分钟\",\"id\":29,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:45:03', 13);
INSERT INTO `sys_oper_log` VALUES (252, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2000,\"path\":\"AttendanceRule\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:47:47', 16);
INSERT INTO `sys_oper_log` VALUES (253, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2000,\"path\":\"AttendanceRule\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:48:16', 7);
INSERT INTO `sys_oper_log` VALUES (254, '菜单管理', 1, 'com.ruoyi.project.system.controller.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"icon\":\"server\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"考勤管理\",\"menuType\":\"M\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"attend\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"新增菜单\'考勤管理\'失败，菜单名称已存在\",\"code\":500}', 0, NULL, '2025-07-11 20:49:52', 2);
INSERT INTO `sys_oper_log` VALUES (255, '菜单管理', 1, 'com.ruoyi.project.system.controller.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"server\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"考勤目录\",\"menuType\":\"M\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"attend\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:50:08', 8);
INSERT INTO `sys_oper_log` VALUES (256, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/index\",\"createTime\":\"2025-06-29 04:12:22\",\"icon\":\"sunny\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"考勤记录\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2003,\"path\":\"Attendance\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:50:28', 8);
INSERT INTO `sys_oper_log` VALUES (257, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Rule\",\"createTime\":\"2025-07-11 18:05:57\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"考勤规则\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2003,\"path\":\"AttendanceRule\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:50:55', 6);
INSERT INTO `sys_oper_log` VALUES (258, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-07-11 20:50:08\",\"icon\":\"server\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"考勤管理\",\"menuType\":\"M\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"attend\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:51:06', 6);
INSERT INTO `sys_oper_log` VALUES (259, '菜单管理', 2, 'com.ruoyi.project.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"Attendance/Status\",\"createTime\":\"2025-07-11 18:21:45\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"考勤员工状态\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2003,\"path\":\"AttendanceStatus\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:51:16', 8);
INSERT INTO `sys_oper_log` VALUES (260, '菜单管理', 1, 'com.ruoyi.project.system.controller.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"考勤列表\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"perms\":\"attend:record:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:52:57', 7);
INSERT INTO `sys_oper_log` VALUES (261, '菜单管理', 1, 'com.ruoyi.project.system.controller.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"考勤导出\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"perms\":\"attend:record:export\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:53:22', 6);
INSERT INTO `sys_oper_log` VALUES (262, '菜单管理', 1, 'com.ruoyi.project.system.controller.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"考勤详情\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"perms\":\"attend:record:query\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:53:43', 7);
INSERT INTO `sys_oper_log` VALUES (263, '菜单管理', 1, 'com.ruoyi.project.system.controller.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"考勤新增\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"perms\":\"attend:record:add\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:54:00', 6);
INSERT INTO `sys_oper_log` VALUES (264, '菜单管理', 1, 'com.ruoyi.project.system.controller.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"考勤编辑\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"perms\":\"attend:record:edit\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:54:15', 5);
INSERT INTO `sys_oper_log` VALUES (265, '菜单管理', 1, 'com.ruoyi.project.system.controller.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"考勤删除\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"perms\":\"attend:record:remove\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:54:35', 6);
INSERT INTO `sys_oper_log` VALUES (266, '角色管理', 2, 'com.ruoyi.project.system.controller.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-06-29 01:32:20\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[2003,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2000,2004,2005],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:55:22', 30);
INSERT INTO `sys_oper_log` VALUES (267, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'cs', '测试部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 20:55:42\",\"createBy\":\"cs\",\"deptId\":105,\"exceptionInfo\":\"迟到655分钟\",\"id\":24,\"params\":{},\"status\":\"1\",\"updateBy\":\"cs\",\"userId\":2,\"userName\":\"cs\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:55:42', 8);
INSERT INTO `sys_oper_log` VALUES (268, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'cs', '测试部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 20:55:44\",\"exceptionInfo\":\"迟到655分钟\",\"id\":24,\"params\":{},\"status\":\"1\",\"updateBy\":\"cs\",\"userId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 20:55:44', 7);
INSERT INTO `sys_oper_log` VALUES (269, '用户考勤状态', 1, 'com.ruoyi.project.attend.controller.AttendUserStatusController.add()', 'POST', 1, 'admin', '研发部门', '/attend/status', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-11 21:03:09\",\"endDate\":\"2025-07-25\",\"id\":3,\"params\":{},\"startDate\":\"2025-07-11\",\"status\":\"1\",\"userId\":2,\"userName\":\"cs\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:03:09', 11);
INSERT INTO `sys_oper_log` VALUES (270, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/30', '127.0.0.1', '内网IP', '[30]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:03:17', 4);
INSERT INTO `sys_oper_log` VALUES (271, '用户管理', 1, 'com.ruoyi.project.system.controller.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":100,\"nickName\":\"qwe\",\"params\":{},\"postIds\":[1],\"roleIds\":[2],\"sex\":\"0\",\"status\":\"0\",\"userId\":3,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:03:46', 83);
INSERT INTO `sys_oper_log` VALUES (272, '考勤规则', 2, 'com.ruoyi.project.attend.controller.AttendRuleController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/rule', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:00:00\",\"earlyLeaveMinutes\":15,\"id\":1,\"lateMinutes\":20,\"params\":{},\"remark\":\"标准工作制考勤规则\",\"ruleName\":\"标准工作制\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 21:05:39\",\"workEndTime\":\"22:05\",\"workStartTime\":\"10:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:05:39', 7);
INSERT INTO `sys_oper_log` VALUES (273, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/31', '127.0.0.1', '内网IP', '[31]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:05:45', 5);
INSERT INTO `sys_oper_log` VALUES (274, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/29', '127.0.0.1', '内网IP', '[29]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:15:29', 12);
INSERT INTO `sys_oper_log` VALUES (275, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/5', '127.0.0.1', '内网IP', '[5]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:15:32', 4);
INSERT INTO `sys_oper_log` VALUES (276, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/32', '127.0.0.1', '内网IP', '[32]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:15:34', 5);
INSERT INTO `sys_oper_log` VALUES (277, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/4', '127.0.0.1', '内网IP', '[4]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:15:36', 4);
INSERT INTO `sys_oper_log` VALUES (278, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'cs', '测试部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 21:16:47\",\"createBy\":\"cs\",\"deptId\":105,\"exceptionInfo\":\"迟到676分钟\",\"id\":33,\"params\":{},\"status\":\"1\",\"updateBy\":\"cs\",\"userId\":2,\"userName\":\"cs\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:16:47', 18);
INSERT INTO `sys_oper_log` VALUES (279, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'cs', '测试部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 21:16:49\",\"exceptionInfo\":\"迟到676分钟，早退48分钟\",\"id\":33,\"params\":{},\"status\":\"1\",\"updateBy\":\"cs\",\"userId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:16:49', 9);
INSERT INTO `sys_oper_log` VALUES (280, '上班打卡', 1, 'com.ruoyi.project.attend.controller.AttendRecordController.clockIn()', 'POST', 1, 'qwe', '根部门', '/attend/record/clockIn', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockInTime\":\"2025-07-11 21:17:12\",\"createBy\":\"qwe\",\"deptId\":100,\"exceptionInfo\":\"迟到677分钟\",\"id\":34,\"params\":{},\"status\":\"1\",\"updateBy\":\"qwe\",\"userId\":3,\"userName\":\"qwe\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:17:12', 9);
INSERT INTO `sys_oper_log` VALUES (281, '下班打卡', 2, 'com.ruoyi.project.attend.controller.AttendRecordController.clockOut()', 'PUT', 1, 'qwe', '根部门', '/attend/record/clockOut', '127.0.0.1', '内网IP', '{\"attendDate\":\"2025-07-11\",\"clockOutTime\":\"2025-07-11 21:17:13\",\"exceptionInfo\":\"迟到677分钟，早退47分钟\",\"id\":34,\"params\":{},\"status\":\"1\",\"updateBy\":\"qwe\",\"userId\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:17:13', 10);
INSERT INTO `sys_oper_log` VALUES (282, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/33', '127.0.0.1', '内网IP', '[33]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:17:35', 4);
INSERT INTO `sys_oper_log` VALUES (283, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/34', '127.0.0.1', '内网IP', '[34]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:17:37', 5);
INSERT INTO `sys_oper_log` VALUES (284, '考勤规则', 2, 'com.ruoyi.project.attend.controller.AttendRuleController.edit()', 'PUT', 1, 'admin', '研发部门', '/attend/rule', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-10 00:00:00\",\"earlyLeaveMinutes\":15,\"id\":1,\"lateMinutes\":20,\"params\":{},\"remark\":\"标准工作制考勤规则\",\"ruleName\":\"标准工作制\",\"status\":\"0\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-11 21:17:47\",\"workEndTime\":\"20:05\",\"workStartTime\":\"10:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:17:47', 9);
INSERT INTO `sys_oper_log` VALUES (285, '用户考勤状态', 3, 'com.ruoyi.project.attend.controller.AttendUserStatusController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/status/3', '127.0.0.1', '内网IP', '[3]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:18:09', 4);
INSERT INTO `sys_oper_log` VALUES (286, '用户考勤状态', 1, 'com.ruoyi.project.attend.controller.AttendUserStatusController.add()', 'POST', 1, 'admin', '研发部门', '/attend/status', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-11 21:18:24\",\"endDate\":\"2025-07-25\",\"id\":4,\"params\":{},\"startDate\":\"2025-07-11\",\"status\":\"1\",\"userId\":2,\"userName\":\"cs\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:18:24', 8);
INSERT INTO `sys_oper_log` VALUES (287, '考勤记录', 3, 'com.ruoyi.project.attend.controller.AttendRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/attend/record/36', '127.0.0.1', '内网IP', '[36]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-11 21:18:29', 4);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-06-29 01:32:20', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-06-29 01:32:20', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-06-29 01:32:20', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 0, 1, '0', '0', 'admin', '2025-06-29 01:32:20', 'admin', '2025-07-11 20:55:22', '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (2, 2000);
INSERT INTO `sys_role_menu` VALUES (2, 2003);
INSERT INTO `sys_role_menu` VALUES (2, 2004);
INSERT INTO `sys_role_menu` VALUES (2, 2005);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', 'admin', '00', 'admin@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-07-11 21:17:27', '2025-06-29 01:32:20', 'admin', '2025-06-29 01:32:20', '', '2025-07-11 21:17:26', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'cs', 'cs', '00', 'cs@cs.com', '15666666666', '1', '', '$2a$10$ehoanvToUSE5lfgdWIFaoeLEMhxgixb3.S1vkvJVyV6Ae2xN.edca', '0', '0', '127.0.0.1', '2025-07-11 21:16:26', '2025-06-29 01:32:20', 'admin', '2025-06-29 01:32:20', 'admin', '2025-07-11 21:16:26', '测试员');
INSERT INTO `sys_user` VALUES (3, 100, 'qwe', 'qwe', '00', '', '', '0', '', '$2a$10$5b3YM9wsCA5gMLDvc8l0NuLrYsqVvS6lsrX1tHNYFhQec4YtujjVW', '0', '0', '127.0.0.1', '2025-07-11 21:17:09', NULL, 'admin', '2025-07-11 21:03:46', '', '2025-07-11 21:17:08', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);
INSERT INTO `sys_user_post` VALUES (3, 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (3, 2);

SET FOREIGN_KEY_CHECKS = 1;
