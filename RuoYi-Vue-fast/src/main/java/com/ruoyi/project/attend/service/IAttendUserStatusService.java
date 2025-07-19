package com.ruoyi.project.attend.service;

import java.util.List;
import java.util.Date;
import com.ruoyi.project.attend.domain.AttendUserStatus;

/**
 * 用户考勤状态Service接口
 */
public interface IAttendUserStatusService {
    /**
     * 查询用户考勤状态
     * 
     * @param id 用户考勤状态主键
     * @return 用户考勤状态
     */
    public AttendUserStatus selectAttendUserStatusById(Long id);

    /**
     * 查询用户考勤状态列表
     * 
     * @param attendUserStatus 用户考勤状态
     * @return 用户考勤状态集合
     */
    public List<AttendUserStatus> selectAttendUserStatusList(AttendUserStatus attendUserStatus);

    /**
     * 新增用户考勤状态
     * 
     * @param attendUserStatus 用户考勤状态
     * @return 结果
     */
    public int insertAttendUserStatus(AttendUserStatus attendUserStatus);

    /**
     * 修改用户考勤状态
     * 
     * @param attendUserStatus 用户考勤状态
     * @return 结果
     */
    public int updateAttendUserStatus(AttendUserStatus attendUserStatus);

    /**
     * 批量删除用户考勤状态
     * 
     * @param ids 需要删除的用户考勤状态主键集合
     * @return 结果
     */
    public int deleteAttendUserStatusByIds(Long[] ids);

    /**
     * 删除用户考勤状态信息
     * 
     * @param id 用户考勤状态主键
     * @return 结果
     */
    public int deleteAttendUserStatusById(Long id);
    
    /**
     * 检查用户在指定日期是否处于特殊状态
     * 
     * @param userId 用户ID
     * @param date 日期
     * @return 用户考勤状态
     */
    public AttendUserStatus checkUserSpecialStatus(Long userId, Date date);
} 