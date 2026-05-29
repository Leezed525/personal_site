package com.ruoyi.lee.domain;

import com.ruoyi.lee.enums.ConcurrencyMode;
import com.ruoyi.lee.enums.DefinitionStatus;
import com.ruoyi.lee.enums.ExecutorType;
import com.ruoyi.lee.enums.ScheduleType;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@Accessors(chain = true)
public class TaskDefinition {

	private String id;

	private String name;

	private String description;

	/** REUSABLE / ONESHOT */
	private com.ruoyi.lee.enums.TaskType taskType;

	/** CRON / FIXED_RATE / FIXED_DELAY / NONE */
	private ScheduleType scheduleType;

	private String cronExpression;

	/** HTTP_REQUEST / LOCAL_SCRIPT */
	private ExecutorType executorType;

	/** Parsed runtime config for executor */
	private Map<String, Object> executorConfig;

	/** ENABLED / DISABLED / ARCHIVED */
	private DefinitionStatus status;

	private Map<String, Object> preOpConfig;

	private Map<String, Object> postOpConfig;

	private Map<String, Object> exceptionHandlerConfig;

	private Map<String, Object> loggerConfig;

	private Map<String, Object> retryPolicy;

	private Integer timeoutSeconds;

	private ConcurrencyMode concurrencyMode;

	private Integer priority;

	/** Parsed tags list, used by service-side filtering */
	private List<String> tags;

	private String createBy;

	private LocalDateTime createTime;

	private LocalDateTime updateTime;

	private String updateBy;

	private String remark;


}
