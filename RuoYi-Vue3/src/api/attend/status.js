import request from '@/utils/request'

// 查询用户考勤状态列表
export function listStatus(query) {
  return request({
    url: '/attend/status/list',
    method: 'get',
    params: query
  })
}

// 查询用户考勤状态详细
export function getStatus(id) {
  return request({
    url: '/attend/status/' + id,
    method: 'get'
  })
}

// 新增用户考勤状态
export function addStatus(data) {
  return request({
    url: '/attend/status',
    method: 'post',
    data: data
  })
}

// 修改用户考勤状态
export function updateStatus(data) {
  return request({
    url: '/attend/status',
    method: 'put',
    data: data
  })
}

// 删除用户考勤状态
export function delStatus(id) {
  return request({
    url: '/attend/status/' + id,
    method: 'delete'
  })
}

// 检查用户在指定日期是否处于特殊状态
export function checkUserSpecialStatus(userId, date) {
  return request({
    url: '/attend/status/check/' + userId,
    method: 'get',
    params: { date: date }
  })
} 