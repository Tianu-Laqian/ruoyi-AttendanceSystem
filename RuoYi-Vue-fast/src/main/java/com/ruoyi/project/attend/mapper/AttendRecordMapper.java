package com.ruoyi.project.attend.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.project.attend.domain.AttendRecord;

/**
 * 考勤记录Mapper接口
 */
public interface AttendRecordMapper {
    /**
     * 查询考勤记录
     * 
     * @param id 考勤记录主键
     * @return 考勤记录
     */
    public AttendRecord selectAttendRecordById(Long id);

    /**
     * 查询考勤记录列表
     * 
     * @param attendRecord 考勤记录
     * @return 考勤记录集合
     */
    public List<AttendRecord> selectAttendRecordList(AttendRecord attendRecord);

    /**
     * 新增考勤记录
     * 
     * @param attendRecord 考勤记录
     * @return 结果
     */
    public int insertAttendRecord(AttendRecord attendRecord);

    /**
     * 修改考勤记录
     * 
     * @param attendRecord 考勤记录
     * @return 结果
     */
    public int updateAttendRecord(AttendRecord attendRecord);

    /**
     * 删除考勤记录
     * 
     * @param id 考勤记录主键
     * @return 结果
     */
    public int deleteAttendRecordById(Long id);

    /**
     * 批量删除考勤记录
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAttendRecordByIds(Long[] ids);

    /**
     * 根据用户名和日期范围查询考勤记录
     * 
     * @param userName 用户名
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @return 考勤记录集合
     */
    public List<AttendRecord> selectAttendRecordByUserNameAndDateRange(@Param("userName") String userName, 
                                                                       @Param("startDate") String startDate, 
                                                                       @Param("endDate") String endDate);
} 