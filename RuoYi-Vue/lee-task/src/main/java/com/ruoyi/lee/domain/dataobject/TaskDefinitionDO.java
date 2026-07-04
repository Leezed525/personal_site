package com.ruoyi.lee.domain.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.time.LocalDateTime;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@Accessors(chain = true)
@TableName("lee_task_definition")
public class TaskDefinitionDO {

	@TableId(value = "id", type = IdType.INPUT)
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
