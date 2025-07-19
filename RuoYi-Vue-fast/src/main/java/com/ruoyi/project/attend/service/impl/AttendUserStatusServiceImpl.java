package com.ruoyi.project.attend.service.impl;

import java.util.List;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.project.attend.mapper.AttendUserStatusMapper;
import com.ruoyi.project.attend.domain.AttendUserStatus;
import com.ruoyi.project.attend.service.IAttendUserStatusService;

import javax.annotation.Resource;

/**
 * 用户考勤状态Service业务层处理
 */
@Service
public class AttendUserStatusServiceImpl implements IAttendUserStatusService {
    @Resource
    private AttendUserStatusMapper attendUserStatusMapper;

    /**
     * 查询用户考勤状态
     * 
     * @param id 用户考勤状态主键
     * @return 用户考勤状态
     */
    @Override
    public AttendUserStatus selectAttendUserStatusById(Long id) {
        return attendUserStatusMapper.selectAttendUserStatusById(id);
    }

    /**
     * 查询用户考勤状态列表
     * 
     * @param attendUserStatus 用户考勤状态
     * @return 用户考勤状态
     */
    @Override
    public List<AttendUserStatus> selectAttendUserStatusList(AttendUserStatus attendUserStatus) {
        return attendUserStatusMapper.selectAttendUserStatusList(attendUserStatus);
    }

    /**
     * 新增用户考勤状态
     * 
     * @param attendUserStatus 用户考勤状态
     * @return 结果
     */
    @Override
    public int insertAttendUserStatus(AttendUserStatus attendUserStatus) {
        attendUserStatus.setCreateTime(DateUtils.getNowDate());
        attendUserStatus.setCreateBy(SecurityUtils.getUsername());
        return attendUserStatusMapper.insertAttendUserStatus(attendUserStatus);
    }

    /**
     * 修改用户考勤状态
     * 
     * @param attendUserStatus 用户考勤状态
     * @return 结果
     */
    @Override
    public int updateAttendUserStatus(AttendUserStatus attendUserStatus) {
        attendUserStatus.setUpdateTime(DateUtils.getNowDate());
        attendUserStatus.setUpdateBy(SecurityUtils.getUsername());
        return attendUserStatusMapper.updateAttendUserStatus(attendUserStatus);
    }

    /**
     * 批量删除用户考勤状态
     * 
     * @param ids 需要删除的用户考勤状态主键
     * @return 结果
     */
    @Override
    public int deleteAttendUserStatusByIds(Long[] ids) {
        return attendUserStatusMapper.deleteAttendUserStatusByIds(ids);
    }

    /**
     * 删除用户考勤状态信息
     * 
     * @param id 用户考勤状态主键
     * @return 结果
     */
    @Override
    public int deleteAttendUserStatusById(Long id) {
        return attendUserStatusMapper.deleteAttendUserStatusById(id);
    }
    
    /**
     * 检查用户在指定日期是否处于特殊状态
     * 
     * @param userId 用户ID
     * @param date 日期
     * @return 用户考勤状态
     */
    @Override
    public AttendUserStatus checkUserSpecialStatus(Long userId, Date date) {
        return attendUserStatusMapper.checkUserSpecialStatus(userId, date);
    }
} 