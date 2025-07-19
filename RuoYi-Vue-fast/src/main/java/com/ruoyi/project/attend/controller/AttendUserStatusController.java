package com.ruoyi.project.attend.controller;

import java.util.List;
import java.util.Date;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.project.attend.domain.AttendUserStatus;
import com.ruoyi.project.attend.service.IAttendUserStatusService;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.framework.web.page.TableDataInfo;
import com.ruoyi.common.utils.DateUtils;

/**
 * 用户考勤状态Controller
 */
@RestController
@RequestMapping("/attend/status")
public class AttendUserStatusController extends BaseController {
    @Autowired
    private IAttendUserStatusService attendUserStatusService;

    /**
     * 查询用户考勤状态列表
     */
    @PreAuthorize("@ss.hasPermi('attend:status:list')")
    @GetMapping("/list")
    public TableDataInfo list(AttendUserStatus attendUserStatus) {
        startPage();
        List<AttendUserStatus> list = attendUserStatusService.selectAttendUserStatusList(attendUserStatus);
        return getDataTable(list);
    }

    /**
     * 导出用户考勤状态列表
     */
    @PreAuthorize("@ss.hasPermi('attend:status:export')")
    @Log(title = "用户考勤状态", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(AttendUserStatus attendUserStatus) {
        List<AttendUserStatus> list = attendUserStatusService.selectAttendUserStatusList(attendUserStatus);
        ExcelUtil<AttendUserStatus> util = new ExcelUtil<AttendUserStatus>(AttendUserStatus.class);
        return util.exportExcel(list, "用户考勤状态数据");
    }

    /**
     * 获取用户考勤状态详细信息
     */
    @PreAuthorize("@ss.hasPermi('attend:status:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return success(attendUserStatusService.selectAttendUserStatusById(id));
    }

    /**
     * 新增用户考勤状态
     */
    @PreAuthorize("@ss.hasPermi('attend:status:add')")
    @Log(title = "用户考勤状态", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AttendUserStatus attendUserStatus) {
        return toAjax(attendUserStatusService.insertAttendUserStatus(attendUserStatus));
    }

    /**
     * 修改用户考勤状态
     */
    @PreAuthorize("@ss.hasPermi('attend:status:edit')")
    @Log(title = "用户考勤状态", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AttendUserStatus attendUserStatus) {
        return toAjax(attendUserStatusService.updateAttendUserStatus(attendUserStatus));
    }

    /**
     * 删除用户考勤状态
     */
    @PreAuthorize("@ss.hasPermi('attend:status:remove')")
    @Log(title = "用户考勤状态", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(attendUserStatusService.deleteAttendUserStatusByIds(ids));
    }
    
    /**
     * 检查用户在指定日期是否处于特殊状态
     */
    @GetMapping("/check/{userId}")
    public AjaxResult checkUserSpecialStatus(@PathVariable("userId") Long userId, @RequestParam(value = "date", required = false) String dateStr) {
        Date date = dateStr != null ? DateUtils.parseDate(dateStr) : DateUtils.getNowDate();
        return success(attendUserStatusService.checkUserSpecialStatus(userId, date));
    }
} 