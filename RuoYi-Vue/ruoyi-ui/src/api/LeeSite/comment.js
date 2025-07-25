import request from '@/utils/request'

// 查询留言板列表
export function listComment(query) {
  return request({
    url: '/LeeSite/comment/list',
    method: 'get',
    params: query
  })
}

// 查询留言板列表
export function listChildComment(query) {
  return request({
    url: '/LeeSite/comment/listChildComment',
    method: 'get',
    params: query
  })
}

// 查询留言板详细
export function getComment(id) {
  return request({
    url: '/LeeSite/comment/' + id,
    method: 'get'
  })
}

// 新增留言板
export function addComment(data) {
  return request({
    url: '/LeeSite/comment',
    method: 'post',
    data: data
  })
}

// 修改留言板
export function updateComment(data) {
  return request({
    url: '/LeeSite/comment',
    method: 'put',
    data: data
  })
}

// 审核通过
export function auditCommentSuccess(data) {
  return request({
    url: '/LeeSite/comment/audit/success',
    method: 'put',
    data: data
  })
}

// 审核不通过
export function auditCommentFail(data) {
  return request({
    url: '/LeeSite/comment/audit/fail',
    method: 'put',
    data: data
  })
}

// 删除留言板
export function delComment(id) {
  return request({
    url: '/LeeSite/comment/' + id,
    method: 'delete'
  })
}

