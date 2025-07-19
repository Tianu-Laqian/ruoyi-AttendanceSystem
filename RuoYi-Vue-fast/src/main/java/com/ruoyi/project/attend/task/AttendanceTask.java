package com.ruoyi.project.attend.task;

import java.util.Date;
import java.util.List;
import java.util.Calendar;

import com.ruoyi.project.system.mapper.SysUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.project.attend.domain.AttendRecord;
import com.ruoyi.project.attend.domain.AttendRule;
import com.ruoyi.project.attend.domain.AttendUserStatus;
import com.ruoyi.project.attend.service.IAttendRecordService;
import com.ruoyi.project.attend.service.IAttendRuleService;
import com.ruoyi.project.attend.service.IAttendUserStatusService;
import com.ruoyi.project.system.domain.SysUser;
import com.ruoyi.project.system.service.ISysUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 考勤任务处理
 */
@Component("attendanceTask")
public class AttendanceTask {
    private static final Logger log = LoggerFactory.getLogger(AttendanceTask.class);

    @Autowired
    private IAttendRecordService attendRecordService;
    
    @Autowired
    private IAttendRuleService attendRuleService;
    
    @Autowired
    private IAttendUserStatusService attendUserStatusService;

    @Autowired
    private SysUserMapper userMapper;

    /**
     * 检查考勤异常并生成记录
     * 每天晚上23:00执行一次
     */
    @Scheduled(cron = "0/30 * * * * ? ")    //每30s检查一次
//    @Scheduled(cron = "0 0 23 * * ?")    //可以选择为每日23点执行
    public void checkAttendance() {
        log.info("考勤异常检查任务开始执行");
        
        // 获取当前日期
        Date today = DateUtils.getNowDate();
        
        // 判断是否是周末
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(today);
        int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
        
        // 如果是周六(7)或周日(1)，则不检查（先暂定周日）
        if (dayOfWeek == Calendar.SUNDAY) {
            log.info("今天是周末，不进行考勤检查");
            return;
        }
        
        // 获取考勤规则
        AttendRule rule = attendRuleService.getActiveRule();
        if (rule == null) {
            log.warn("未找到有效的考勤规则，无法进行考勤检查");
            return;
        }

        //查询当前时间是否在考勤规则下班时间之后
        Date currentTime = DateUtils.getNowDate();
        Date workEndTime = DateUtils.parseTime(DateUtils.parseDateToStr("yyyy-MM-dd", currentTime) + " " +
                                              DateUtils.parseDateToStr("HH:mm:ss", rule.getWorkEndTime()));
        if (!currentTime.after(workEndTime)) {
            log.info("当前时间未超过下班时间，不进行考勤检查");
            return;
        }
        
        // 获取所有正常状态的用户
        SysUser queryUser = new SysUser();
        queryUser.setStatus("0"); // 正常状态
        List<SysUser> userList = userMapper.selectUserList(queryUser);
        
        // 遍历用户检查考勤
        for (SysUser user : userList) {
            // 检查用户是否有特殊状态（请假或外勤）
            AttendUserStatus userStatus = attendUserStatusService.checkUserSpecialStatus(user.getUserId(), today);
            if (userStatus != null && ("1".equals(userStatus.getStatus()) || "2".equals(userStatus.getStatus()))) {
                log.info("用户 {} 处于请假或外勤状态，不进行考勤检查", user.getUserName());
                continue;
            }
            
            // 查询用户今日打卡记录
            AttendRecord todayRecord = attendRecordService.getTodayAttendance(user.getUserId());


            // 如果没有打卡记录，则创建一条异常记录
            if (todayRecord == null) {
                AttendRecord newRecord = new AttendRecord();
                newRecord.setUserId(user.getUserId());
                newRecord.setDeptId(user.getDeptId());
                newRecord.setUserName(user.getUserName());
                newRecord.setAttendDate(today);
                newRecord.setStatus("1"); // 异常
                newRecord.setExceptionInfo("未上班打卡");
                newRecord.setCreateBy("system");
                attendRecordService.insertAttendRecord(newRecord);
                log.info("用户 {} 未打卡，已生成异常记录", user.getUserName());
            } 
            // 如果有打卡记录但没有下班打卡，也标记为异常
            else if (todayRecord.getClockInTime() != null && todayRecord.getClockOutTime() == null) {
                todayRecord.setStatus("1"); // 异常
                todayRecord.setExceptionInfo(todayRecord.getExceptionInfo() == null ? 
                    "未下班打卡" : todayRecord.getExceptionInfo() + "；未下班打卡");
                todayRecord.setUpdateBy("system");
                attendRecordService.updateAttendRecord(todayRecord);
                log.info("用户 {} 未下班打卡，已更新为异常记录", user.getUserName());
            }
        }
        
        log.info("考勤异常检查任务执行完成");
    }
} 