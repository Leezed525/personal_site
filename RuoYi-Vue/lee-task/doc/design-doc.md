# 定时任务系统 —— 详设代码设计表

---

## 一、概述

本系统基于 **Java** 语言与 **Quartz** 调度框架，实现定时任务的统一管理、调度与执行追踪。核心设计围绕「任务定义」与「任务实例」两大领域模型展开，支持复用任务（Cron
定时）与一次性简易任务的快速布置。

---

## 二、核心领域模型

### 2.1 领域实体关系概览

```
┌──────────────────────────────────────────────────────┐
│                  TaskDefinition（任务定义）            │
│  作用：任务模板，描述「做什么」和「怎么做」            │
└──────────┬───────────────────────────────────────────┘
           │ 1 : N
           ▼
┌──────────────────────────────────────────────────────┐
│                  TaskInstance（任务实例）              │
│  作用：一次具体运行记录，描述「哪次跑得怎么样」        │
└──────────────────────────────────────────────────────┘
```

### 2.2 TaskDefinition（任务定义）

| 字段                         | 类型            | 说明                                                          |
|----------------------------|---------------|-------------------------------------------------------------|
| `id`                       | String (UUID) | 主键，全局唯一标识                                                   |
| `name`                     | String        | 任务名称（用户友好）                                                  |
| `description`              | String        | 任务描述                                                        |
| `task_type`                | Enum          | `REUSABLE`（复用任务）/ `ONESHOT`（一次性任务）                          |
| `schedule_type`            | Enum          | `CRON` / `FIXED_RATE` / `FIXED_DELAY` / `NONE`（一次性任务选 NONE） |
| `cron_expression`          | String        | Cron 表达式（复用任务必填）                                            |
| `executor_type`            | Enum          | 执行方式：`HTTP_REQUEST` / `LOCAL_SCRIPT`                        |
| `executor_config`          | JSON/Text     | 执行配置（取决于 executor_type，见 §2.4）                              |
| `status`                   | Enum          | `ENABLED` / `DISABLED` / `ARCHIVED`                         |
| `pre_op_config`            | JSON/Text     | 前置操作配置（默认实现可覆盖）                                             |
| `post_op_config`           | JSON/Text     | 后置处理配置（默认实现可覆盖）                                             |
| `exception_handler_config` | JSON/Text     | 异常处理配置（默认实现可覆盖）                                             |
| `logger_config`            | JSON/Text     | 日志记录配置（默认实现可覆盖）                                             |
| `retry_policy`             | JSON/Text     | 重试策略：最大重试次数、退避策略等                                           |
| `timeout_seconds`          | Integer       | 单次执行超时时间（秒），0 或 null 表示不限制                                  |
| `concurrency_mode`         | Enum          | `ALLOW_CONCURRENT` / `DISALLOW_CONCURRENT`（防止重叠执行）          |
| `priority`                 | Integer       | 优先级（值越大越高）                                                  |
| `tags`                     | String (逗号分隔) | 标签，便于分组搜索                                                   |
| `create_by`                | String        | 创建者                                                         |
| `create_time`              | Datetime      | 创建时间                                                        |
| `update_by`                | String        | 更新者                                                         |
| `update_time`              | Datetime      | 最后更新时间                                                      |
| `remark`                   | String        | 备注信息                                                        |

### 2.3 TaskInstance（任务实例）

| 字段                | 类型            | 说明                                                                                                              |
|-------------------|---------------|-----------------------------------------------------------------------------------------------------------------|
| `id`              | String (UUID) | 主键，全局唯一标识                                                                                                       |
| `definition_id`   | String (FK)   | 所属任务定义 ID                                                                                                       |
| `trigger_type`    | Enum          | `SCHEDULED`（Quartz 触发）/ `MANUAL`（手动触发）/ `API`（API 触发）                                                           |
| `status`          | Enum          | `PENDING` → `PRE_PROCESSING` → `EXECUTING` → `POST_PROCESSING` → `SUCCESS` / `FAILED` / `TIMEOUT` / `CANCELLED` |
| `executor_result` | Text          | 执行结果摘要（JSON）                                                                                                    |
| `pre_op_result`   | Text          | 前置操作执行结果                                                                                                        |
| `post_op_result`  | Text          | 后置处理执行结果                                                                                                        |
| `exception_info`  | Text          | 异常堆栈/错误详情                                                                                                       |
| `retry_count`     | Integer       | 当前已重试次数                                                                                                         |
| `start_time`      | Datetime      | 开始执行时间                                                                                                          |
| `end_time`        | Datetime      | 结束时间                                                                                                            |
| `duration_ms`     | Long          | 执行耗时（毫秒）                                                                                                        |
| `triggered_by`    | String        | 触发者标识                                                                                                           |
| `log_file_path`   | String        | 日志文件路径                                                                                                          |
| `create_time`     | Datetime      | 记录创建时间                                                                                                          |

### 2.4 ExecutorConfig（执行器配置）

#### 2.4.1 HTTP_REQUEST 执行器配置

| 字段                     | 类型                 | 说明                                                      |
|------------------------|--------------------|---------------------------------------------------------|
| `http_method`          | Enum               | `GET` / `POST` / `PUT` / `DELETE` / `PATCH`             |
| `url`                  | String             | 请求 URL（支持占位符变量，运行时替换）                                   |
| `headers`              | Map<String,String> | 请求头                                                     |
| `body`                 | Text               | 请求体（POST/PUT 时使用，支持模板变量）                                |
| `connect_timeout_ms`   | Integer            | 连接超时（毫秒）                                                |
| `read_timeout_ms`      | Integer            | 读取超时（毫秒）                                                |
| `success_status_codes` | List<Integer>      | 判定成功的 HTTP 状态码，默认 [200, 201, 204]                       |
| `response_parser`      | String             | 响应解析器：`RAW` / `JSON_PATH` / `XPATH`                     |
| `auth_config`          | JSON               | 认证配置：`NONE` / `BASIC_AUTH` / `BEARER_TOKEN` / `API_KEY` |

#### 2.4.2 LOCAL_SCRIPT 执行器配置

| 字段                  | 类型                 | 说明                                           |
|---------------------|--------------------|----------------------------------------------|
| `script_type`       | Enum               | `SHELL` / `PYTHON` / `GROOVY` / `JAVA_CLASS` |
| `script_path`       | String             | 脚本文件路径（Groovy/Java 时为类全限定名）                  |
| `script_args`       | List<String>       | 脚本参数                                         |
| `working_dir`       | String             | 工作目录                                         |
| `environment_vars`  | Map<String,String> | 环境变量                                         |
| `capture_stdout`    | Boolean            | 是否捕获标准输出                                     |
| `capture_stderr`    | Boolean            | 是否捕获标准错误                                     |
| `exit_code_success` | List<Integer>      | 判定成功的退出码，默认 [0]                              |

---

## 三、任务执行流程（Pipeline 管道模型）

每个 TaskInstance 的执行遵循严格的管道流程：

```
┌──────────────┐
│ 1. PreOp     │  前置操作
│  (内置默认)  │  - 资源检查、环境就绪校验、依赖任务状态确认
└──────┬───────┘
       ▼
┌──────────────┐
│ 2. Execute   │  任务执行
│  (用户定义)  │  - HTTP 请求 / 本地脚本运行
└──────┬───────┘
       │ 失败 → ┌─────────────────┐
       │        │ 3. ExceptionHandler │  异常处理
       │        │   (内置默认+可覆盖) │  - 重试判定、降级、告警通知
       │        └────────┬────────┘
       │                 │ 不可恢复
       ▼                 ▼
┌──────────────┐
│ 4. PostOp     │  后置处理
│  (内置默认)   │  - 结果清理、状态同步、下游触发
└──────┬───────┘
       ▼
┌──────────────┐
│ 5. Logging    │  日志记录
│  (内置默认)   │  - 结构化日志落库、文件归档、关键指标采集
└──────────────┘
```

### 3.1 各阶段默认实现

| 阶段                   | 默认实现类                                         | 默认行为                                                    |
|----------------------|-----------------------------------------------|---------------------------------------------------------|
| **PreOp**            | `DefaultPreOperationHandler`                  | 校验 executor 配置完整性、记录开始时间戳                               |
| **Execute**          | `HttpRequestExecutor` / `LocalScriptExecutor` | 见 §2.4                                                  |
| **ExceptionHandler** | `DefaultExceptionHandler`                     | 根据 retry_policy 判重试；重试耗尽后写异常记录并标记 FAILED                |
| **PostOp**           | `DefaultPostOperationHandler`                 | 计算耗时、清理临时文件、更新实例状态                                      |
| **Logging**          | `DefaultLogRecorder`                          | 结构化 JSON 写入数据库 + 文件；采集 duration、status、executor_type 指标 |

所有默认实现均可通过 TaskDefinition 的 `*_config` 字段指定自定义 Handler 类全限定名来覆盖。

---

## 四、数据库表设计

### 4.1 `t_task_definition`（任务定义表）

| 列名                         | 类型           | 约束                            | 说明                                                   |
|----------------------------|--------------|-------------------------------|------------------------------------------------------|
| `id`                       | VARCHAR(64)  | PK                            | UUID                                                 |
| `name`                     | VARCHAR(256) | NOT NULL                      | 任务名称                                                 |
| `description`              | TEXT         |                               | 描述                                                   |
| `task_type`                | VARCHAR(32)  | NOT NULL                      | REUSABLE / ONESHOT                                   |
| `schedule_type`            | VARCHAR(32)  |                               | CRON / FIXED_RATE / FIXED_DELAY                      |
| `cron_expression`          | VARCHAR(128) |                               | Cron 表达式                                             |
| `executor_type`            | VARCHAR(32)  | NOT NULL                      | HTTP_REQUEST / LOCAL_SCRIPT                          |
| `executor_config`          | TEXT         | NOT NULL                      | JSON 配置                                              |
| `status`                   | VARCHAR(16)  | NOT NULL, DEFAULT 'ENABLED'   | ENABLED / DISABLED / ARCHIVED                        |
| `pre_op_config`            | TEXT         |                               | JSON 配置                                              |
| `post_op_config`           | TEXT         |                               | JSON 配置                                              |
| `exception_handler_config` | TEXT         |                               | JSON 配置                                              |
| `logger_config`            | TEXT         |                               | JSON 配置                                              |
| `retry_policy`             | TEXT         |                               | JSON：max_retries, backoff_strategy, backoff_delay_ms |
| `timeout_seconds`          | INT          | DEFAULT 0                     | 0 = 不限制                                              |
| `concurrency_mode`         | VARCHAR(32)  | DEFAULT 'DISALLOW_CONCURRENT' |                                                      |
| `priority`                 | INT          | DEFAULT 0                     |                                                      |
| `tags`                     | VARCHAR(512) |                               | 逗号分隔                                                 |
| `create_by`                | VARCHAR(128) |                               |                                                      |
| `create_time`              | DATETIME     | NOT NULL                      |                                                      |
| `update_by`                | VARCHAR(128) |                               |                                                      |
| `update_time`              | DATETIME     | NOT NULL                      |                                                      |
| `remark`                   | VARCHAR(500) |                               |                                                      |

**索引：**

- `idx_task_type_status` ON (`task_type`, `status`)
- `idx_name` ON (`name`)
- `idx_tags` FULLTEXT INDEX ON (`tags`)

---

### 4.2 `t_task_instance`（任务实例表）

| 列名                | 类型           | 约束                          | 说明                       |
|-------------------|--------------|-----------------------------|--------------------------|
| `id`              | VARCHAR(64)  | PK                          | UUID                     |
| `definition_id`   | VARCHAR(64)  | FK → t_task_definition.id   |                          |
| `trigger_type`    | VARCHAR(16)  | NOT NULL                    | SCHEDULED / MANUAL / API |
| `status`          | VARCHAR(32)  | NOT NULL, DEFAULT 'PENDING' | 枚举状态                     |
| `executor_result` | TEXT         |                             | JSON                     |
| `pre_op_result`   | TEXT         |                             | JSON                     |
| `post_op_result`  | TEXT         |                             | JSON                     |
| `exception_info`  | TEXT         |                             | 异常详情                     |
| `retry_count`     | INT          | DEFAULT 0                   |                          |
| `start_time`      | DATETIME     |                             |                          |
| `end_time`        | DATETIME     |                             |                          |
| `duration_ms`     | BIGINT       |                             |                          |
| `triggered_by`    | VARCHAR(128) |                             |                          |
| `log_file_path`   | VARCHAR(512) |                             |                          |
| `create_time`     | DATETIME     | NOT NULL                    |                          |

**索引：**

- `idx_definition_id_status` ON (`definition_id`, `status`)
- `idx_start_time` ON (`start_time`)
- `idx_status_create_time` ON (`status`, `create_time`)

---

### 4.3 `t_task_execution_log`（执行日志表）

| 列名            | 类型          | 约束                      | 说明                                     |
|---------------|-------------|-------------------------|----------------------------------------|
| `id`          | BIGINT      | PK AUTO_INCREMENT       |                                        |
| `instance_id` | VARCHAR(64) | FK → t_task_instance.id |                                        |
| `stage`       | VARCHAR(32) | NOT NULL                | PRE_OP / EXECUTE / EXCEPTION / POST_OP |
| `level`       | VARCHAR(16) | NOT NULL                | INFO / WARN / ERROR / DEBUG            |
| `message`     | TEXT        | NOT NULL                | 日志内容                                   |
| `detail`      | TEXT        |                         | 详细 JSON 数据                             |
| `logged_at`   | DATETIME    | NOT NULL                |                                        |

---

### 4.4 `t_task_statistics`（任务统计表，按天汇总）

| 列名                | 类型          | 约束                        | 说明    |
|-------------------|-------------|---------------------------|-------|
| `id`              | BIGINT      | PK AUTO_INCREMENT         |       |
| `definition_id`   | VARCHAR(64) | FK → t_task_definition.id |       |
| `stat_date`       | DATE        | NOT NULL                  | 统计日期  |
| `total_runs`      | INT         | DEFAULT 0                 | 总执行次数 |
| `success_runs`    | INT         | DEFAULT 0                 | 成功次数  |
| `failed_runs`     | INT         | DEFAULT 0                 | 失败次数  |
| `avg_duration_ms` | BIGINT      | DEFAULT 0                 | 平均耗时  |
| `max_duration_ms` | BIGINT      | DEFAULT 0                 | 最大耗时  |
| `min_duration_ms` | BIGINT      | DEFAULT 0                 | 最小耗时  |

**唯一约束：** UNIQUE (`definition_id`, `stat_date`)

---

## 五、Quartz 集成设计

### 5.1 Job 与 Trigger 映射

| Quartz 概念     | 系统映射                                                                             |
|---------------|----------------------------------------------------------------------------------|
| **JobDetail** | 每个 TaskDefinition（REUSABLE + ENABLED）对应一个 JobDetail，JobDataMap 传入 `definitionId` |
| **Trigger**   | 解析 `cron_expression` 构建 `CronTrigger`；一次性任务采用 `SimpleTrigger`（只触发一次）             |
| **Job Class** | 统一使用 `QuartzJobBridge`，内部根据 `definitionId` 加载定义、创建实例、执行管道                        |

### 5.2 调度生命周期

```
TaskDefinition 创建/启用 → registerJob(definitionId)   → Quartz Scheduler 接管
TaskDefinition 禁用     → pauseJob(definitionId)       → 暂停但不删除
TaskDefinition 归档     → deleteJob(definitionId)      → Quartz 移除
TaskDefinition 更新     → rescheduleJob(definitionId)  → 重新注册
```

### 5.3 防并发执行

复用 Quartz 的 `@DisallowConcurrentExecution` 注解，与 TaskDefinition 中的 `concurrency_mode = DISALLOW_CONCURRENT`
保持一致——同一 Job 的前一次未结束时，新触发排队或丢弃。

---

## 六、核心接口设计（Service 层）

### 6.1 TaskDefinitionService

| 方法                                   | 说明                                  |
|--------------------------------------|-------------------------------------|
| `createDefinition(CreateDefRequest)` | 创建任务定义，REUSABLE 类型自动注册到 Quartz      |
| `updateDefinition(UpdateDefRequest)` | 更新定义，若 Cron 变更则重新调度                 |
| `deleteDefinition(String id)`        | 归档式删除（status = ARCHIVED），不从 DB 物理删除 |
| `enableDefinition(String id)`        | 启用 → 注册 Quartz                      |
| `disableDefinition(String id)`       | 禁用 → Quartz 暂停                      |
| `getDefinition(String id)`           | 查询单个定义                              |
| `listDefinitions(DefQuery)`          | 分页查询，支持按 task_type、status、tags 过滤   |

### 6.2 TaskInstanceService

| 方法                                                    | 说明                     |
|-------------------------------------------------------|------------------------|
| `triggerNow(String definitionId, String triggeredBy)` | 手动立即触发一次               |
| `triggerOneShot(OneShotRequest)`                      | 一次性任务快速布置（创建定义 + 立即执行） |
| `getInstance(String id)`                              | 查询实例详情                 |
| `listInstances(InstanceQuery)`                        | 分页查询实例列表               |
| `cancelInstance(String id)`                           | 取消正在执行的实例（发送中断信号）      |
| `retryInstance(String id)`                            | 手动重试失败的实例              |

### 6.3 TaskPipelineService（内部服务）

| 方法                                                                  | 说明                                                  |
|---------------------------------------------------------------------|-----------------------------------------------------|
| `executePipeline(TaskInstance instance, TaskDefinition definition)` | 执行完整的 PreOp → Execute → Exception → PostOp → Log 管道 |

---

## 七、扩展点设计 —— SPI 机制

系统通过 **Java SPI（ServiceLoader）** 机制支持自定义组件扩展：

| 扩展点接口                  | 默认实现                                          | 扩展方式                                     |
|------------------------|-----------------------------------------------|------------------------------------------|
| `PreOperationHandler`  | `DefaultPreOperationHandler`                  | 实现接口 + `META-INF/services` 注册，在定义中引用全限定名 |
| `TaskExecutor`         | `HttpRequestExecutor` / `LocalScriptExecutor` | 新增执行器（如 gRPC、消息队列）                       |
| `ExceptionHandler`     | `DefaultExceptionHandler`                     | 自定义重试/降级/告警策略                            |
| `PostOperationHandler` | `DefaultPostOperationHandler`                 | 自定义后置清理逻辑                                |
| `LogRecorder`          | `DefaultLogRecorder`                          | 自定义日志输出目标（ES、Kafka 等）                    |

---

## 八、一次性任务快速布置流程

```
用户 API 请求
     │
     ▼
POST /api/tasks/oneshot
  {
    "name": "临时数据同步",
    "executor_type": "HTTP_REQUEST",
    "executor_config": { "method": "POST", "url": "https://..." },
    "execute_now": true
  }
     │
     ▼
TaskDefinitionService.createDefinition()  → 创建 ONESHOT 类型定义（不注册 Quartz）
     │
     ▼
TaskInstanceService.triggerNow()          → 创建实例 + 异步执行 Pipeline
     │
     ▼
返回 instanceId，客户端可轮询 /api/tasks/instances/{id}/status
```

---

## 九、复用任务调度流程

```
创建复用任务
     │
     ▼
POST /api/tasks/definitions
  {
    "task_type": "REUSABLE",
    "schedule_type": "CRON",
    "cron_expression": "0 0 2 * * ?",
    "executor_type": "LOCAL_SCRIPT",
    "executor_config": { "script_type": "PYTHON", "script_path": "/scripts/backup.py" }
  }
     │
     ▼
TaskDefinitionService.createDefinition()
     │  ├─ 写入 t_task_definition
     │  └─ QuartzSchedulerManager.registerJob(definitionId)
     │       ├─ 构建 JobDetail（jobClass = QuartzJobBridge）
     │       └─ 绑定 CronTrigger → scheduler.scheduleJob()
     ▼
Quartz 到达触发时间
     │
     ▼
QuartzJobBridge.execute(JobExecutionContext)
     │  ├─ 从 JobDataMap 获取 definitionId
     │  ├─ 创建 TaskInstance（status = PENDING）
     │  └─ pipelineService.executePipeline(instance, definition)
     │       ├─ preOpHandler.handle()
     │       ├─ executor.execute()       ← HTTP / Script
     │       ├─ (on error) exceptionHandler.handle()
     │       ├─ postOpHandler.handle()
     │       └─ logRecorder.record()
     ▼
实例状态更新为 SUCCESS / FAILED
```

---

## 十、状态机

### 10.1 TaskDefinition 状态

```
  ┌──────────┐    enable    ┌──────────┐
  │ DISABLED │ ───────────► │ ENABLED  │
  └──────────┘ ◄─────────── └──────────┘
        │        disable          │
        │                         │ archive
        ▼                         ▼
  ┌──────────┐             ┌──────────┐
  │ ARCHIVED │ ◄────────── │ ARCHIVED │
  └──────────┘             └──────────┘
```

### 10.2 TaskInstance 执行状态

```
PENDING
  │
  ▼
PRE_PROCESSING
  │
  ├─ 前置失败 ──► EXCEPTION_HANDLING ──► (可重试) PENDING
  │                                     └─ (不可重试) FAILED
  ▼
EXECUTING
  │
  ├─ 执行失败 ──► EXCEPTION_HANDLING ──► (可重试) PENDING
  │               (超时)              └─ (不可重试) FAILED
  │                                     └─ TIMEOUT
  ▼
POST_PROCESSING
  │
  ├─ 成功 ──► SUCCESS
  └─ 失败 ──► FAILED

任意非终态 ──► CANCELLED（手动取消）
```

**终态：** `SUCCESS`、`FAILED`、`TIMEOUT`、`CANCELLED`

---

## 十一、关键技术选型建议

| 层面       | 技术                                      | 说明                                  |
|----------|-----------------------------------------|-------------------------------------|
| 框架       | Spring Boot 2.7+ / 3.x                  | 主流企业级框架                             |
| 调度       | Quartz Scheduler 2.3+                   | 可通过 `spring-boot-starter-quartz` 集成 |
| 持久化      | Quartz JDBC JobStore + MySQL/PostgreSQL | 集群支持，任务不丢失                          |
| HTTP 客户端 | OkHttp / Apache HttpClient 5            | 支持连接池、超时、重定向                        |
| 脚本执行     | `ProcessBuilder`                        | JVM 原生进程调用                          |
| JSON     | Jackson / Gson                          | 序列化 executor_config 等               |
| 日志       | SLF4J + Logback                         | 结构化日志                               |
| 指标       | Micrometer + Prometheus                 | 采集执行次数、耗时分布                         |
| 重试       | Resilience4j-Retry                      | 内置退避策略                              |
| 集群       | Quartz Clustering（基于 DB 锁）              | 多节点高可用                              |

---

## 十二、REST API 概览

| 方法       | 路径                                     | 说明         |
|----------|----------------------------------------|------------|
| `POST`   | `/api/tasks/definitions`               | 创建任务定义     |
| `PUT`    | `/api/tasks/definitions/{id}`          | 更新任务定义     |
| `DELETE` | `/api/tasks/definitions/{id}`          | 删除（归档）任务定义 |
| `GET`    | `/api/tasks/definitions/{id}`          | 查询任务定义     |
| `GET`    | `/api/tasks/definitions`               | 分页查询任务定义列表 |
| `POST`   | `/api/tasks/definitions/{id}/enable`   | 启用任务       |
| `POST`   | `/api/tasks/definitions/{id}/disable`  | 禁用任务       |
| `POST`   | `/api/tasks/definitions/{id}/trigger`  | 手动触发一次     |
| `POST`   | `/api/tasks/oneshot`                   | 快速布置一次性任务  |
| `GET`    | `/api/tasks/instances/{id}`            | 查询任务实例     |
| `GET`    | `/api/tasks/instances`                 | 分页查询实例列表   |
| `POST`   | `/api/tasks/instances/{id}/cancel`     | 取消执行中实例    |
| `POST`   | `/api/tasks/instances/{id}/retry`      | 重试失败实例     |
| `GET`    | `/api/tasks/statistics/{definitionId}` | 查询统计       |

---

## 十三、Quartz 集群表（自动生成）

Quartz JDBC JobStore 使用以下内置表，部署时需预先创建：

| 表名                         | 说明        |
|----------------------------|-----------|
| `QRTZ_JOB_DETAILS`         | Job 定义信息  |
| `QRTZ_TRIGGERS`            | 触发器信息     |
| `QRTZ_CRON_TRIGGERS`       | Cron 触发器  |
| `QRTZ_SIMPLE_TRIGGERS`     | 简单触发器     |
| `QRTZ_SCHEDULER_STATE`     | 调度器状态（集群） |
| `QRTZ_FIRED_TRIGGERS`      | 正在执行的触发器  |
| `QRTZ_LOCKS`               | 集群悲观锁     |
| `QRTZ_PAUSED_TRIGGER_GRPS` | 暂停的触发器组   |
| `QRTZ_SIMPROP_TRIGGERS`    | 属性触发器     |
| `QRTZ_BLOB_TRIGGERS`       | Blob 触发器  |

---

*文档版本：v1.0 | 日期：2026-05-29*
"@ | Out-File -FilePath "C:\Users\Leezed\Documents\Codex\2026-05-29\java-quartz-1-2\docs\design-doc.md" -Encoding UTF8