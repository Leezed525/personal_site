package com.ruoyi.lee.domain.dataobject;

import java.time.LocalDateTime;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@Accessors(chain = true)
public class TaskDefinitionDO {

	private String id;

	private String name;

	private String description;

	private String taskType;

	private String scheduleType;

	private String cronExpression;

	private String executorType;

	/** JSON text */
	private String executorConfig;

	/** JSON text */
	private String preOpConfig;

	/** JSON text */
	private String postOpConfig;

	/** JSON text */
	private String exceptionHandlerConfig;

	/** JSON text */
	private String loggerConfig;

	/** JSON text */
	private String retryPolicy;

	private Integer timeoutSeconds;

	private String concurrencyMode;

	private Integer priority;

	/** Comma-separated tags */
	private String tags;
    
	private String createBy;

	private LocalDateTime createTime;

	private LocalDateTime updateTime;

	private String updateBy;

	private String remark;
    
    private String status;
}
