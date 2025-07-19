import request from '@/utils/request'

// 查询考勤记录列表
export function listRecord(query) {
  return request({
    url: '/attend/record/list',
    method: 'get',
    params: query
  })
}

// 查询考勤记录详细
export function getRecord(id) {
  return request({
    url: '/attend/record/' + id,
    method: 'get'
  })
}

// 新增考勤记录
export function addRecord(data) {
  return request({
    url: '/attend/record',
    method: 'post',
    data: data
  })
}

// 修改考勤记录
export function updateRecord(data) {
  return request({
    url: '/attend/record',
    method: 'put',
    data: data
  })
}

// 删除考勤记录
export function delRecord(id) {
  return request({
    url: '/attend/record/' + id,
    method: 'delete'
  })
}

// 上班打卡
export function clockIn(data) {
  return request({
    url: '/attend/record/clockIn',
    method: 'post',
    data: data
  })
}

// 下班打卡
export function clockOut(data) {
  return request({
    url: '/attend/record/clockOut',
    method: 'put',
    data: data
  })
}

// 获取用户今日打卡记录
export function getTodayAttendance(userId) {
  return request({
    url: '/attend/record/today/' + userId,
    method: 'get'
  })
}

// 获取用户月度考勤日历
export function getMonthlyCalendar(userName, yearMonth) {
  return request({
    url: '/attend/record/calendar/monthly',
    method: 'get',
    params: {
      userName: userName,
      yearMonth: yearMonth
    }
  })
} 