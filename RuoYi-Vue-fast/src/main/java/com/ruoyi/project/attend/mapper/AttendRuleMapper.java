package com.ruoyi.project.attend.mapper;

import java.util.List;
import com.ruoyi.project.attend.domain.AttendRule;

/**
 * 考勤规则Mapper接口
 */
public interface AttendRuleMapper {
    /**
     * 查询考勤规则
     * 
     * @param id 考勤规则主键
     * @return 考勤规则
     */
    public AttendRule selectAttendRuleById(Long id);

    /**
     * 查询考勤规则列表
     * 
     * @param attendRule 考勤规则
     * @return 考勤规则集合
     */
    public List<AttendRule> selectAttendRuleList(AttendRule attendRule);

    /**
     * 新增考勤规则
     * 
     * @param attendRule 考勤规则
     * @return 结果
     */
    public int insertAttendRule(AttendRule attendRule);

    /**
     * 修改考勤规则
     * 
     * @param attendRule 考勤规则
     * @return 结果
     */
    public int updateAttendRule(AttendRule attendRule);

    /**
     * 删除考勤规则
     * 
     * @param id 考勤规则主键
     * @return 结果
     */
    public int deleteAttendRuleById(Long id);

    /**
     * 批量删除考勤规则
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAttendRuleByIds(Long[] ids);
    
    /**
     * 获取有效的考勤规则
     * 
     * @return 考勤规则
     */
    public AttendRule getActiveRule();
} 