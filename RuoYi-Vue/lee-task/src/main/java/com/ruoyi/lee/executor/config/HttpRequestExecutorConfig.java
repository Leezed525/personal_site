package com.ruoyi.lee.executor.config;

import com.ruoyi.common.enums.HttpMethod;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import lombok.Data;

@Data
public class HttpRequestExecutorConfig implements ExecutorConfig {

    private HttpMethod httpMethod;

    private String url;

    private Map<String, String> headers = Collections.emptyMap();

    private String body;

    private Integer connectTimeoutMS = 1000;

    private Integer readTimeoutMS = 1000;

    private List<Integer> successStatusCodes = List.of(200, 201, 204);

    private String responseParser = "Raw";

    private String authConfig;

    public static HttpRequestExecutorConfig fromMap(Map<String, Object> rawConfig) {
        Map<String, Object> safeConfig = rawConfig == null ? Collections.emptyMap() : rawConfig;
        HttpRequestExecutorConfig config = new HttpRequestExecutorConfig();

        Object methodValue = safeConfig.get("http_method");
        if (methodValue != null) {
            config.setHttpMethod(HttpMethod.valueOf(methodValue.toString().trim().toUpperCase()));
        }

        Object urlValue = safeConfig.get("url");
        if (urlValue != null) {
            config.setUrl(urlValue.toString().trim());
        }

        Object bodyValue = safeConfig.get("body");
        if (bodyValue != null) {
            config.setBody(bodyValue.toString());
        }

        Object connectTimeoutValue = safeConfig.get("connect_timeout_ms");
        if (connectTimeoutValue != null) {
            config.setConnectTimeoutMS(Integer.parseInt(connectTimeoutValue.toString()));
        }

        Object readTimeoutValue = safeConfig.get("read_timeout_ms");
        if (readTimeoutValue != null) {
            config.setReadTimeoutMS(Integer.parseInt(readTimeoutValue.toString()));
        }

        Object responseParserValue = safeConfig.get("response_parser");
        if (responseParserValue != null) {
            config.setResponseParser(responseParserValue.toString());
        }

        Object authConfigValue = safeConfig.get("auth_config");
        if (authConfigValue != null) {
            config.setAuthConfig(authConfigValue.toString());
        }

        return config;
    }
}

