CREATE TABLE `lee_task_definition` (
                                     `id` VARCHAR(64) NOT NULL COMMENT '主键ID(UUID)',
                                     `name` VARCHAR(256) NOT NULL COMMENT '任务名称',
                                     `description` TEXT NULL COMMENT '任务描述',
                                     `task_type` VARCHAR(32) NOT NULL COMMENT '任务类型: REUSABLE/ONESHOT',
                                     `schedule_type` VARCHAR(32) NULL COMMENT '调度类型: CRON/FIXED_RATE/FIXED_DELAY/NONE',
                                     `cron_expression` VARCHAR(128) NULL COMMENT 'Cron表达式',
                                     `executor_type` VARCHAR(32) NOT NULL COMMENT '执行器类型: HTTP_REQUEST/LOCAL_SCRIPT',
                                     `executor_config` TEXT NOT NULL COMMENT '执行器配置(JSON)',
                                     `status` VARCHAR(16) NOT NULL DEFAULT 'ENABLED' COMMENT '状态: ENABLED/DISABLED/ARCHIVED',
                                     `pre_op_config` TEXT NULL COMMENT '前置操作配置(JSON)',
                                     `post_op_config` TEXT NULL COMMENT '后置处理配置(JSON)',
                                     `exception_handler_config` TEXT NULL COMMENT '异常处理配置(JSON)',
                                     `logger_config` TEXT NULL COMMENT '日志配置(JSON)',
                                     `retry_policy` TEXT NULL COMMENT '重试策略(JSON)',
                                     `timeout_seconds` INT NOT NULL DEFAULT 0 COMMENT '超时秒数, 0=不限制',
                                     `concurrency_mode` VARCHAR(32) NOT NULL DEFAULT 'DISALLOW_CONCURRENT' COMMENT '并发模式: ALLOW_CONCURRENT/DISALLOW_CONCURRENT',
                                     `priority` INT NOT NULL DEFAULT 0 COMMENT '优先级(越大越高)',
                                     `tags` VARCHAR(512) NULL COMMENT '标签(逗号分隔)',
                                     `create_by` VARCHAR(128) NULL COMMENT '创建者',
                                     `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                     `update_by` VARCHAR(128) NULL COMMENT '更新者',
                                     `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                     `remark` VARCHAR(500) NULL COMMENT '备注',
                                     PRIMARY KEY (`id`),
                                     KEY `idx_task_type_status` (`task_type`, `status`),
                                     KEY `idx_name` (`name`),
                                     FULLTEXT KEY `idx_tags` (`tags`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci
  COMMENT='任务定义表';