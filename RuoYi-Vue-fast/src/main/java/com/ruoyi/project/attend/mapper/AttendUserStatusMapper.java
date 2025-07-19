package com.ruoyi.project.attend.mapper;

import java.util.List;
import java.util.Date;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.project.attend.domain.AttendUserStatus;

/**
 * 用户考勤状态Mapper接口
 */
public interface AttendUserStatusMapper {
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
     * 删除用户考勤状态
     * 
     * @param id 用户考勤状态主键
     * @return 结果
     */
    public int deleteAttendUserStatusById(Long id);

    /**
     * 批量删除用户考勤状态
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAttendUserStatusByIds(Long[] ids);
    
    /**
     * 检查用户在指定日期是否处于特殊状态
     * 
     * @param userId 用户ID
     * @param date 日期
     * @return 用户考勤状态
     */
    public AttendUserStatus checkUserSpecialStatus(@Param("userId") Long userId, @Param("date") Date date);
} 