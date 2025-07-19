package com.ruoyi.project.attend.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Calendar;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.project.attend.mapper.AttendRecordMapper;
import com.ruoyi.project.attend.domain.AttendRecord;
import com.ruoyi.project.attend.domain.AttendRule;
import com.ruoyi.project.attend.domain.AttendUserStatus;
import com.ruoyi.project.attend.service.IAttendRecordService;
import com.ruoyi.project.attend.service.IAttendRuleService;
import com.ruoyi.project.attend.service.IAttendUserStatusService;

import javax.annotation.Resource;

/**
 * 考勤记录Service业务层处理
 */
@Service
public class AttendRecordServiceImpl implements IAttendRecordService {
    @Resource
    private AttendRecordMapper attendRecordMapper;
    
    @Autowired
    private IAttendRuleService attendRuleService;
    
    @Autowired
    private IAttendUserStatusService attendUserStatusService;

    /**
     * 查询考勤记录
     * 
     * @param id 考勤记录主键
     * @return 考勤记录
     */
    @Override
    public AttendRecord selectAttendRecordById(Long id) {
        return attendRecordMapper.selectAttendRecordById(id);
    }

    /**
     * 查询考勤记录列表
     * 
     * @param attendRecord 考勤记录
     * @return 考勤记录
     */
    @Override
    public List<AttendRecord> selectAttendRecordList(AttendRecord attendRecord) {
        // 获取当前用户信息
        boolean isAdmin = SecurityUtils.isAdmin(SecurityUtils.getLoginUser().getUser().getUserId()) || 
                          SecurityUtils.hasRole("admin");
        
        // 如果不是管理员，只能查看自己的考勤记录
        if (!isAdmin) {
            attendRecord.setUserId(SecurityUtils.getLoginUser().getUser().getUserId());
        }
        
        return attendRecordMapper.selectAttendRecordList(attendRecord);
    }

    /**
     * 新增考勤记录
     * 
     * @param attendRecord 考勤记录
     * @return 结果
     */
    @Override
    public int insertAttendRecord(AttendRecord attendRecord) {
        // 如果部门ID为空，则使用当前登录用户的部门ID
        if (attendRecord.getDeptId() == null) {
        attendRecord.setDeptId(SecurityUtils.getDeptId());
        }
        // 如果用户ID为空，则使用当前登录用户的ID
        if (attendRecord.getUserId() == null) {
        attendRecord.setUserId(SecurityUtils.getUserId());
        }
        // 如果用户名为空，则使用当前登录用户的用户名
        if (attendRecord.getUserName() == null) {
            attendRecord.setUserName(SecurityUtils.getUsername());
        }
        attendRecord.setCreateTime(DateUtils.getNowDate());
        return attendRecordMapper.insertAttendRecord(attendRecord);
    }

    /**
     * 修改考勤记录
     * 
     * @param attendRecord 考勤记录
     * @return 结果
     */
    @Override
    public int updateAttendRecord(AttendRecord attendRecord) {
        attendRecord.setUpdateTime(DateUtils.getNowDate());
        return attendRecordMapper.updateAttendRecord(attendRecord);
    }

    /**
     * 批量删除考勤记录
     * 
     * @param ids 需要删除的考勤记录主键
     * @return 结果
     */
    @Override
    public int deleteAttendRecordByIds(Long[] ids) {
        return attendRecordMapper.deleteAttendRecordByIds(ids);
    }

    /**
     * 删除考勤记录信息
     * 
     * @param id 考勤记录主键
     * @return 结果
     */
    @Override
    public int deleteAttendRecordById(Long id) {
        return attendRecordMapper.deleteAttendRecordById(id);
    }

    /**
     * 上班打卡
     */
    @Override
    public int clockIn(AttendRecord attendRecord) {
        // 检查今日是否已打卡
        AttendRecord todayRecord = getTodayAttendance(attendRecord.getUserId());
        if (todayRecord != null && todayRecord.getClockInTime() != null) {
            // 已经打过上班卡，不允许重复打卡
            return 0;
        }
        
        // 设置更新者
        attendRecord.setCreateBy(SecurityUtils.getUsername());
        attendRecord.setUpdateBy(SecurityUtils.getUsername());
        
        // 获取考勤规则
        AttendRule rule = attendRuleService.getActiveRule();
        if (rule != null) {
            // 检查是否迟到
            Date currentTime = attendRecord.getClockInTime();
            Date workStartTime = DateUtils.parseTime(DateUtils.parseDateToStr("yyyy-MM-dd", currentTime) + " " + 
                                                    DateUtils.parseDateToStr("HH:mm:ss", rule.getWorkStartTime()));
            
            // 计算迟到分钟数
            long diffInMillis = currentTime.getTime() - workStartTime.getTime();
            long diffInMinutes = diffInMillis / (60 * 1000);
            
            // 如果迟到超过阈值，则标记为异常
            if (diffInMinutes > rule.getLateMinutes()) {
                attendRecord.setStatus("1"); // 异常
                attendRecord.setExceptionInfo("迟到" + diffInMinutes + "分钟");
            } else {
                attendRecord.setStatus("0"); // 正常
            }
        }
        
        // 如果是新记录，则插入
        if (todayRecord == null) {
            return attendRecordMapper.insertAttendRecord(attendRecord);
        }
        
        // 否则更新已有记录
        attendRecord.setId(todayRecord.getId());
        return attendRecordMapper.updateAttendRecord(attendRecord);
    }

    /**
     * 下班打卡
     */
    @Override
    public int clockOut(AttendRecord attendRecord) {
        // 查询今日打卡记录
        AttendRecord todayRecord = getTodayAttendance(attendRecord.getUserId());
        
        // 检查是否已打上班卡
        if (todayRecord == null || todayRecord.getClockInTime() == null) {
            // 未打上班卡，不能打下班卡
            return 0;
        }
        
        // 检查是否已打下班卡
        if (todayRecord.getClockOutTime() != null) {
            // 已经打过下班卡，不允许重复打卡
            return 0;
        }
        
        // 设置更新者
        attendRecord.setUpdateBy(SecurityUtils.getUsername());
        
        // 设置ID和状态
        attendRecord.setId(todayRecord.getId());
        attendRecord.setStatus(todayRecord.getStatus()); // 保留上班打卡的状态
        attendRecord.setExceptionInfo(todayRecord.getExceptionInfo()); // 保留上班打卡的异常信息
        
        // 获取考勤规则
        AttendRule rule = attendRuleService.getActiveRule();
        if (rule != null) {
            // 检查是否早退
            Date currentTime = attendRecord.getClockOutTime();
            Date workEndTime = DateUtils.parseTime(DateUtils.parseDateToStr("yyyy-MM-dd", currentTime) + " " + 
                                                  DateUtils.parseDateToStr("HH:mm:ss", rule.getWorkEndTime()));
            
            // 计算早退分钟数
            long diffInMillis = workEndTime.getTime() - currentTime.getTime();
            long diffInMinutes = diffInMillis / (60 * 1000);
            
            // 如果早退超过阈值，则标记为异常
            if (diffInMinutes > rule.getEarlyLeaveMinutes()) {
                attendRecord.setStatus("1"); // 异常
                
                // 如果已有异常信息，则追加
                if (attendRecord.getExceptionInfo() != null && !attendRecord.getExceptionInfo().isEmpty()) {
                    attendRecord.setExceptionInfo(attendRecord.getExceptionInfo() + "，早退" + diffInMinutes + "分钟");
                } else {
                    attendRecord.setExceptionInfo("早退" + diffInMinutes + "分钟");
                }
            }
        }
        
        // 更新下班打卡时间
        return attendRecordMapper.updateAttendRecord(attendRecord);
    }

    /**
     * 获取用户今日打卡记录
     */
    @Override
    public AttendRecord getTodayAttendance(Long userId) {
        // 获取今日日期
        Date today = DateUtils.getNowDate();
        String todayStr = DateUtils.parseDateToStr("yyyy-MM-dd", today);
        
        // 构造查询条件
        AttendRecord query = new AttendRecord();
        query.setUserId(userId);
        query.setAttendDate(DateUtils.parseDate(todayStr));
        
        // 查询今日打卡记录
        List<AttendRecord> records = attendRecordMapper.selectAttendRecordList(query);
        
        // 返回结果
        return records.isEmpty() ? null : records.get(0);
    }

    /**
     * 根据用户名和日期范围查询考勤记录
     * 
     * @param userName 用户名
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @return 考勤记录集合
     */
    @Override
    public List<AttendRecord> selectAttendRecordByUserNameAndDateRange(String userName, String startDate, String endDate) {
        AttendRecord attendRecord = new AttendRecord();
        attendRecord.setUserName(userName);
        
        // 使用mapper查询该用户在指定日期范围内的考勤记录
        return attendRecordMapper.selectAttendRecordByUserNameAndDateRange(userName, startDate, endDate);
    }
} 