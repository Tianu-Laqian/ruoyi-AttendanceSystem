package com.ruoyi.project.attend.controller;

import java.util.List;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.project.attend.domain.AttendRule;
import com.ruoyi.project.attend.service.IAttendRuleService;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.framework.web.page.TableDataInfo;

/**
 * 考勤规则Controller
 */
@RestController
@RequestMapping("/attend/rule")
public class AttendRuleController extends BaseController {
    @Autowired
    private IAttendRuleService attendRuleService;

    /**
     * 查询考勤规则列表
     */
    @PreAuthorize("@ss.hasPermi('attend:rule:list')")
    @GetMapping("/list")
    public TableDataInfo list(AttendRule attendRule) {
        startPage();
        List<AttendRule> list = attendRuleService.selectAttendRuleList(attendRule);
        return getDataTable(list);
    }

    /**
     * 导出考勤规则列表
     */
    @PreAuthorize("@ss.hasPermi('attend:rule:export')")
    @Log(title = "考勤规则", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(AttendRule attendRule) {
        List<AttendRule> list = attendRuleService.selectAttendRuleList(attendRule);
        ExcelUtil<AttendRule> util = new ExcelUtil<AttendRule>(AttendRule.class);
        return util.exportExcel(list, "考勤规则数据");
    }

    /**
     * 获取考勤规则详细信息
     */
    @PreAuthorize("@ss.hasPermi('attend:rule:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return success(attendRuleService.selectAttendRuleById(id));
    }

    /**
     * 新增考勤规则
     */
    @PreAuthorize("@ss.hasPermi('attend:rule:add')")
    @Log(title = "考勤规则", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AttendRule attendRule) {
        return toAjax(attendRuleService.insertAttendRule(attendRule));
    }

    /**
     * 修改考勤规则
     */
    @PreAuthorize("@ss.hasPermi('attend:rule:edit')")
    @Log(title = "考勤规则", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AttendRule attendRule) {
        return toAjax(attendRuleService.updateAttendRule(attendRule));
    }

    /**
     * 删除考勤规则
     */
    @PreAuthorize("@ss.hasPermi('attend:rule:remove')")
    @Log(title = "考勤规则", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(attendRuleService.deleteAttendRuleByIds(ids));
    }
    
    /**
     * 获取有效的考勤规则
     */
    @GetMapping("/active")
    public AjaxResult getActiveRule() {
        return success(attendRuleService.getActiveRule());
    }
} 