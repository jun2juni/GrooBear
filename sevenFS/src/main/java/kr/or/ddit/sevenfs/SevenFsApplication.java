package kr.or.ddit.sevenfs;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class SevenFsApplication {

    public static void main(String[] args) {
        SpringApplication.run(SevenFsApplication.class, args);
    }

}
