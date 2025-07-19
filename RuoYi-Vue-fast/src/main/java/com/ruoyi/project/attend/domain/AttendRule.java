package com.ruoyi.project.attend.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.framework.aspectj.lang.annotation.Excel;
import com.ruoyi.framework.web.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 考勤规则对象 attend_rule
 */
public class AttendRule extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 规则ID */
    private Long id;

    /** 规则名称 */
    @Excel(name = "规则名称")
    private String ruleName;

    /** 上班时间 */
    @JsonFormat(pattern = "HH:mm")
    @Excel(name = "上班时间", width = 30, dateFormat = "HH:mm")
    private Date workStartTime;

    /** 下班时间 */
    @JsonFormat(pattern = "HH:mm")
    @Excel(name = "下班时间", width = 30, dateFormat = "HH:mm")
    private Date workEndTime;

    /** 迟到阈值(分钟) */
    @Excel(name = "迟到阈值(分钟)")
    private Integer lateMinutes;

    /** 早退阈值(分钟) */
    @Excel(name = "早退阈值(分钟)")
    private Integer earlyLeaveMinutes;

    /** 状态（0正常 1停用） */
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    private String status;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setRuleName(String ruleName) {
        this.ruleName = ruleName;
    }

    public String getRuleName() {
        return ruleName;
    }

    public void setWorkStartTime(Date workStartTime) {
        this.workStartTime = workStartTime;
    }

    public Date getWorkStartTime() {
        return workStartTime;
    }

    public void setWorkEndTime(Date workEndTime) {
        this.workEndTime = workEndTime;
    }

    public Date getWorkEndTime() {
        return workEndTime;
    }

    public void setLateMinutes(Integer lateMinutes) {
        this.lateMinutes = lateMinutes;
    }

    public Integer getLateMinutes() {
        return lateMinutes;
    }

    public void setEarlyLeaveMinutes(Integer earlyLeaveMinutes) {
        this.earlyLeaveMinutes = earlyLeaveMinutes;
    }

    public Integer getEarlyLeaveMinutes() {
        return earlyLeaveMinutes;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("ruleName", getRuleName())
            .append("workStartTime", getWorkStartTime())
            .append("workEndTime", getWorkEndTime())
            .append("lateMinutes", getLateMinutes())
            .append("earlyLeaveMinutes", getEarlyLeaveMinutes())
            .append("status", getStatus())
            .append("remark", getRemark())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
} 