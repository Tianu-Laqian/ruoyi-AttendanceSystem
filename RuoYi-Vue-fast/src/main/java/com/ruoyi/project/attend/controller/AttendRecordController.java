package com.ruoyi.project.attend.controller;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Calendar;
import java.util.Date;
import java.text.SimpleDateFormat;
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
import com.ruoyi.project.attend.domain.AttendRecord;
import com.ruoyi.project.attend.service.IAttendRecordService;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.framework.web.page.TableDataInfo;

import javax.servlet.http.HttpServletResponse;

/**
 * 考勤记录Controller
 */
@RestController
@RequestMapping("/attend/record")
public class AttendRecordController extends BaseController {
    @Autowired
    private IAttendRecordService attendRecordService;

    /**
     * 查询考勤记录列表
     */
    @PreAuthorize("@ss.hasPermi('attend:record:list')")
    @GetMapping("/list")
    public TableDataInfo list(AttendRecord attendRecord) {
        startPage();
        List<AttendRecord> list = attendRecordService.selectAttendRecordList(attendRecord);
        return getDataTable(list);
    }

    /**
     * 导出考勤记录列表
     */
    @PreAuthorize("@ss.hasPermi('attend:record:export')")
    @Log(title = "考勤记录", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public void export(AttendRecord attendRecord, HttpServletResponse response) {
        List<AttendRecord> list = attendRecordService.selectAttendRecordList(attendRecord);
        ExcelUtil<AttendRecord> util = new ExcelUtil<AttendRecord>(AttendRecord.class);
        util.exportExcel(response, list, "考勤数据");
    }

    /**
     * 获取考勤记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('attend:record:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return success(attendRecordService.selectAttendRecordById(id));
    }

    /**
     * 新增考勤记录
     */
    @PreAuthorize("@ss.hasPermi('attend:record:add')")
    @Log(title = "考勤记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AttendRecord attendRecord) {
        return toAjax(attendRecordService.insertAttendRecord(attendRecord));
    }

    /**
     * 修改考勤记录
     */
    @PreAuthorize("@ss.hasPermi('attend:record:edit')")
    @Log(title = "考勤记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AttendRecord attendRecord) {
        return toAjax(attendRecordService.updateAttendRecord(attendRecord));
    }

    /**
     * 删除考勤记录
     */
    @PreAuthorize("@ss.hasPermi('attend:record:remove')")
    @Log(title = "考勤记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(attendRecordService.deleteAttendRecordByIds(ids));
    }

    /**
     * 上班打卡
     */
//    @PreAuthorize("@ss.hasPermi('attend:record:clockIn')")
    @Log(title = "上班打卡", businessType = BusinessType.INSERT)
    @PostMapping("/clockIn")
    public AjaxResult clockIn(@RequestBody AttendRecord attendRecord) {
        return toAjax(attendRecordService.clockIn(attendRecord));
    }

    /**
     * 下班打卡
     */
//    @PreAuthorize("@ss.hasPermi('attend:record:clockOut')")
    @Log(title = "下班打卡", businessType = BusinessType.UPDATE)
    @PutMapping("/clockOut")
    public AjaxResult clockOut(@RequestBody AttendRecord attendRecord) {
        return toAjax(attendRecordService.clockOut(attendRecord));
    }

    /**
     * 获取用户今日打卡记录
     */
    @GetMapping("/today/{userId}")
    public AjaxResult getTodayAttendance(@PathVariable("userId") Long userId) {
        return AjaxResult.success(attendRecordService.getTodayAttendance(userId));
    }

    /**
     * 获取用户某月的考勤记录
     */
//    @PreAuthorize("@ss.hasPermi('attend:record:list')")
    @GetMapping("/calendar/monthly")
    public AjaxResult getMonthlyCalendar(@RequestParam String userName, @RequestParam String yearMonth) {
        try {
            // 解析年月
            SimpleDateFormat yearMonthFormat = new SimpleDateFormat("yyyy-MM");
            Date date = yearMonthFormat.parse(yearMonth);
            
            // 创建日历实例
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);
            
            // 获取该月的第一天和最后一天
            calendar.set(Calendar.DAY_OF_MONTH, 1);
            Date startDate = calendar.getTime();
            
            calendar.add(Calendar.MONTH, 1);
            calendar.add(Calendar.DAY_OF_MONTH, -1);
            Date endDate = calendar.getTime();
            
            // 查询该用户在该月范围内的所有考勤记录
            AttendRecord query = new AttendRecord();
            query.setUserName(userName);
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String startDateStr = dateFormat.format(startDate);
            String endDateStr = dateFormat.format(endDate);
            
            // 查询该用户在该时间范围内的所有考勤记录
            List<AttendRecord> records = attendRecordService.selectAttendRecordByUserNameAndDateRange(userName, startDateStr, endDateStr);
            
            // 构建日历数据
            Map<String, Object> calendarData = buildCalendarData(records, yearMonth);
            
            return AjaxResult.success(calendarData);
        } catch (Exception e) {
            return AjaxResult.error("获取月度考勤记录失败: " + e.getMessage());
        }
    }
    
    /**
     * 构建日历数据
     */
    private Map<String, Object> buildCalendarData(List<AttendRecord> records, String yearMonth) throws Exception {
        Map<String, Object> result = new HashMap<>();
        Map<String, Map<String, Object>> daysData = new HashMap<>();
        
        // 解析年月
        SimpleDateFormat yearMonthFormat = new SimpleDateFormat("yyyy-MM");
        Date date = yearMonthFormat.parse(yearMonth);
        
        // 创建日历实例
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        
        // 获取该月的天数
        int daysInMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        
        // 初始化日历数据
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        for (int day = 1; day <= daysInMonth; day++) {
            calendar.set(Calendar.DAY_OF_MONTH, day);
            String dayStr = dateFormat.format(calendar.getTime());
            
            Map<String, Object> dayData = new HashMap<>();
            dayData.put("date", dayStr);
            dayData.put("hasRecord", false);
            dayData.put("clockInTime", null);
            dayData.put("clockOutTime", null);
            dayData.put("status", null);
            
            daysData.put(dayStr, dayData);
        }
        
        // 填充考勤记录数据
        for (AttendRecord record : records) {
            String recordDate = dateFormat.format(record.getAttendDate());
            if (daysData.containsKey(recordDate)) {
                Map<String, Object> dayData = daysData.get(recordDate);
                dayData.put("hasRecord", true);
                dayData.put("clockInTime", record.getClockInTime() != null ? record.getClockInTime() : null);
                dayData.put("clockOutTime", record.getClockOutTime() != null ? record.getClockOutTime() : null);
                dayData.put("status", record.getStatus());
            }
        }
        
        result.put("yearMonth", yearMonth);
        result.put("days", daysData);
        
        return result;
    }
} 