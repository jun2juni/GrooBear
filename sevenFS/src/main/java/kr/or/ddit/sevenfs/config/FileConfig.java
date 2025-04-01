package kr.or.ddit.sevenfs.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
public class FileConfig implements WebMvcConfigurer {
    @Value("${file.save.abs.path}")
    private String absPath;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        log.debug("fileConfig 실행되었는지 check?");

        registry.addResourceHandler("/upload/**") // 웹 접근 경로
                .addResourceLocations("file:///C:/SJupload/");  // 서버내 실제 경로
    }
}
