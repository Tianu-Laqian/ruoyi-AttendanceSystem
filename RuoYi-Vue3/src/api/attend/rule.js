import request from '@/utils/request'

// 查询考勤规则列表
export function listRule(query) {
  return request({
    url: '/attend/rule/list',
    method: 'get',
    params: query
  })
}

// 查询考勤规则详细
export function getRule(id) {
  return request({
    url: '/attend/rule/' + id,
    method: 'get'
  })
}

// 新增考勤规则
export function addRule(data) {
  return request({
    url: '/attend/rule',
    method: 'post',
    data: data
  })
}

// 修改考勤规则
export function updateRule(data) {
  return request({
    url: '/attend/rule',
    method: 'put',
    data: data
  })
}

// 删除考勤规则
export function delRule(id) {
  return request({
    url: '/attend/rule/' + id,
    method: 'delete'
  })
}

// 获取有效的考勤规则
export function getActiveRule() {
  return request({
    url: '/attend/rule/active',
    method: 'get'
  })
} 