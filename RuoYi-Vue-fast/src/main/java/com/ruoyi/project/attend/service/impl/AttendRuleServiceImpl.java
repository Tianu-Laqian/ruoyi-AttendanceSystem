package com.ruoyi.project.attend.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.project.attend.mapper.AttendRuleMapper;
import com.ruoyi.project.attend.domain.AttendRule;
import com.ruoyi.project.attend.service.IAttendRuleService;

import javax.annotation.Resource;

/**
 * 考勤规则Service业务层处理
 */
@Service
public class AttendRuleServiceImpl implements IAttendRuleService {
    @Resource
    private AttendRuleMapper attendRuleMapper;

    /**
     * 查询考勤规则
     * 
     * @param id 考勤规则主键
     * @return 考勤规则
     */
    @Override
    public AttendRule selectAttendRuleById(Long id) {
        return attendRuleMapper.selectAttendRuleById(id);
    }

    /**
     * 查询考勤规则列表
     * 
     * @param attendRule 考勤规则
     * @return 考勤规则
     */
    @Override
    public List<AttendRule> selectAttendRuleList(AttendRule attendRule) {
        return attendRuleMapper.selectAttendRuleList(attendRule);
    }

    /**
     * 新增考勤规则
     * 
     * @param attendRule 考勤规则
     * @return 结果
     */
    @Override
    public int insertAttendRule(AttendRule attendRule) {
        attendRule.setCreateTime(DateUtils.getNowDate());
        attendRule.setCreateBy(SecurityUtils.getUsername());
        return attendRuleMapper.insertAttendRule(attendRule);
    }

    /**
     * 修改考勤规则
     * 
     * @param attendRule 考勤规则
     * @return 结果
     */
    @Override
    public int updateAttendRule(AttendRule attendRule) {
        attendRule.setUpdateTime(DateUtils.getNowDate());
        attendRule.setUpdateBy(SecurityUtils.getUsername());
        return attendRuleMapper.updateAttendRule(attendRule);
    }

    /**
     * 批量删除考勤规则
     * 
     * @param ids 需要删除的考勤规则主键
     * @return 结果
     */
    @Override
    public int deleteAttendRuleByIds(Long[] ids) {
        return attendRuleMapper.deleteAttendRuleByIds(ids);
    }

    /**
     * 删除考勤规则信息
     * 
     * @param id 考勤规则主键
     * @return 结果
     */
    @Override
    public int deleteAttendRuleById(Long id) {
        return attendRuleMapper.deleteAttendRuleById(id);
    }
    
    /**
     * 获取有效的考勤规则
     * 
     * @return 考勤规则
     */
    @Override
    public AttendRule getActiveRule() {
        return attendRuleMapper.getActiveRule();
    }
} 