-- 考勤记录表
CREATE TABLE attend_record (
                               id bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                               user_id bigint(20) NOT NULL COMMENT '用户ID',
                               dept_id bigint(20) COMMENT '部门ID',
                               user_name varchar(50) NOT NULL COMMENT '用户账号',
                               attend_date date NOT NULL COMMENT '打卡日期',
                               clock_in_time datetime COMMENT '上班打卡时间',
                               clock_out_time datetime COMMENT '下班打卡时间',
                               status char(1) DEFAULT '0' COMMENT '状态（0正常 1异常）',
                               remark varchar(500) DEFAULT NULL COMMENT '备注',
                               create_by varchar(64) DEFAULT '' COMMENT '创建者',
                               create_time datetime DEFAULT NULL COMMENT '创建时间',
                               update_by varchar(64) DEFAULT '' COMMENT '更新者',
                               update_time datetime DEFAULT NULL COMMENT '更新时间',
                               PRIMARY KEY (id)
) ENGINE=InnoDB COMMENT='考勤记录表';