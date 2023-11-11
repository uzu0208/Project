package com.webconfig;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("css/**") // 요청 패턴
                .addResourceLocations("classpath:/WEB-INF/css/") // 실제 리소스 위치
                .setCachePeriod(0); // 캐시 기간 설정
    }
}
