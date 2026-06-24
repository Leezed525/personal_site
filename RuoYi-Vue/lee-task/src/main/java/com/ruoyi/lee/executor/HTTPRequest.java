package com.ruoyi.lee.executor;

import com.ruoyi.common.enums.HttpMethod;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Data
public class HTTPRequest implements BaseExecutor {
    // 请求方法 （GET,POST,PUT,DELETE,PATCH）
    private HttpMethod httpMethod;

    // 请求地址
    private String url;

    // 请求头
    private Map<String, String> headers;

    // 请求体
    private String body;

    // 连接超时
    private Integer connectTimeoutMS = 1000;

    // 读取超时
    private Integer readTimeoutMS = 1000;

    //判定成功的 HTTP 状态码，默认 [200, 201, 204]
    private List<Integer> successStatusCodes = List.of(200, 201, 204);

    // 响应解析方式：Raw / JSON / XML，默认 Raw
    private String responseParser = "Raw";

    // 认证配置，例如 Basic Auth、Bearer Token 等
    private String authConfig;


    @Override
    public String execute() throws Exception {
        return "Success";
    }
}
