package kr.or.ddit.sevenfs.service.mail.impl;

import java.util.concurrent.CompletableFuture;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import kr.or.ddit.sevenfs.service.mail.MailAsyncService;
import kr.or.ddit.sevenfs.vo.mail.MailVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MailAsyncServiceImpl implements MailAsyncService {
	// smtp 설정
	@Autowired
	private JavaMailSender mailSender;
	
	@Value("${spring.mail.username}")
	private String fromMail;
	
	@Value("${spring.mail.password}")
	private String password;
	
	
	@Override
	@Async
	public void sendMailAsync(MailVO mailVO) {
		log.info("{}.doSendMail start!", this, getClass().getName());
		int res = 1;
		
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,false, "UTF-8");

			messageHelper.setFrom(fromMail);
			messageHelper.setTo(mailVO.getRecptnEmail());
			messageHelper.setSubject(mailVO.getEmailSj());
			messageHelper.setText(mailVO.getEmailCn(),true);
			log.info(mailVO.getEmailCn());
			mailSender.send(message);
		} catch (Exception e) {
			res = 0;
			log.info("[error] doSendMail : {}", e);
		}
		log.info("{}.doSendMail end !", this.getClass().getName());
	}

}
