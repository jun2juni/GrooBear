package kr.or.ddit.sevenfs.config;



import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.TaskExecutor;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolExecutorFactoryBean;

import lombok.extern.slf4j.Slf4j;

@Configuration
@EnableAsync
@Slf4j
public class AsyncConfig {

	@Bean
	public ThreadPoolExecutorFactoryBean taskExecutor() {
		log.info("비동기처리 실행 ! ");
		ThreadPoolExecutorFactoryBean factory = new ThreadPoolExecutorFactoryBean();
		factory.setCorePoolSize(5);
		factory.setMaxPoolSize(10);
		factory.setQueueCapacity(25);
		factory.setThreadNamePrefix("MailAsync-");
		
		return factory;
		
	}
}
