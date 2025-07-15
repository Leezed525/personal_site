@[toc]

#更新日志

## 20250711
引入了前端，感谢 [https://github.com/acanyo/home-for-vue](https://github.com/acanyo/home-for-vue) 的开源，避免了我去写不喜欢写的前端


编辑了前端的效果 修改了名称

成功引入了后端，感谢 [https://gitee.com/ruoyi/RuoYi-Vue](https://gitee.com/ruoyi/RuoYi-Vue) 的开源

使用了环境变量的方式来配置applaication.yml ,避免了敏感数据泄露的问题

## 20250712

完成springboot后端中配置文件分割的工作

完成后端的mybatis 升级至 mybatis-plus 的工作

计划： 完成博客功能

1. 目前设计是打算将保存csdn博客的网址的功能，因为
   1. 目前的博客内容都是csdn的
   2. 我的服务器带宽只有1M/s，能省就省
   3. 采用保存网址的形式，前端只要打开对应的网站就好了，前端工作也不大
   4. 而且以网址方式的保存，方便后续oss的升级（现在不用是因为oss要钱）
2. 主要需求是：
   1. 后台需要有一个博客管理页面，负责管理前端展示的博客
   2. 前端需要有一个博客展示页面，负责展示博客内容
   3. 前端展示内容包括 博客标题，摘要，封面(可以没有) ,根据分类快速筛选
3. 数据库设计
   | 字段        | 类型         | 备注     | 可否为空 |
   | ----------- | ------------ | -------- | -------- |
   | id          | int          | 主键     | ❌        |
   | title       | varchar(255) | 博客标题 | ❌        |
   | url         | varchar(500) | 博客地址 | ❌        |
   | cover       | varchar(500) | 博客封面 | ✅        |
   | summary     | varchar(500) | 博客摘要 | ✅        |
   | category    | varchar(50)  | 分类     | ✅        |
   | create_by   | varchar(64)  | 创建人   | ❌        |
   | create_time | datetime     | 创建时间 | ❌        |
   | updater     | varchar(64)  | 更新人   | ✅        |
   | update_time | datetime     | 更新时间 | ✅        |
   | status      | int          | 状态     | ❌        |
   | remark      | varchar(500) | 备注     | ✅        |


## 20250713

添加了article的前端和后端代码

## 20250714

更换了redis的连接池从lettuce到jedis
原因：在长时间没有服务调用的时候lettuce莫名其妙会断，可以加入心跳机制，也可以换连接池，选择了换连接池

jedis 连接池的 采用阻塞式IO，在低并发的情况下表现良好，正好符合我目前的需求
lettuce 连接池的 采用非阻塞式IO，在高并发的情况下表现良好，但是我现在没有那么多并发需求


完成了文章状态枚举类
完成了mybatis-plus的更新和插入属性自动注入

## 20250715

配置了前台页面的请求方法
后端的允许跨域，和允许前台的无授权访问