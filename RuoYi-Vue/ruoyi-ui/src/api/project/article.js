import request from '@/utils/request'

// 查询站点博客列列表
export function listArticle(query) {
  return request({
    url: '/LeeSite/article/list',
    method: 'get',
    params: query
  })
}

// 查询站点博客列详细
export function getArticle(id) {
  return request({
    url: '/LeeSite/article/' + id,
    method: 'get'
  })
}

// 新增站点博客列
export function addArticle(data) {
  return request({
    url: '/LeeSite/article',
    method: 'post',
    data: data
  })
}

// 修改站点博客列
export function updateArticle(data) {
  return request({
    url: '/LeeSite/article',
    method: 'put',
    data: data
  })
}

// 删除站点博客列
export function delArticle(id) {
  return request({
    url: '/LeeSite/article/' + id,
    method: 'delete'
  })
}
