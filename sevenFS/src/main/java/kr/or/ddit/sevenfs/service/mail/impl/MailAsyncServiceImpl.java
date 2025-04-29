package kr.or.ddit.sevenfs.service.mail.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import kr.or.ddit.sevenfs.mapper.AttachFileMapper;
import kr.or.ddit.sevenfs.mapper.mail.MailMapper;
import kr.or.ddit.sevenfs.service.mail.MailAsyncService;
import kr.or.ddit.sevenfs.service.mail.MailService;
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
	
	@Value("${file.save.abs.path}")
	private String saveDir;
	
	@Autowired
	MailMapper mailMapper;
//	private List<String> filePaths; // 첨부파일 경로 목록
	
	@Override
	@Async
	public void sendMailAsync(MailVO mailVO) {
		List<String> filePaths = mailMapper.getAtchFileStreList(mailVO.getAtchFileNo());
		log.info("filePaths -> filePaths : " + filePaths);
		log.info("{}.doSendMail start!", this, getClass().getName());
		int res = 1;
		
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true, "UTF-8");

			messageHelper.setFrom(fromMail);
			messageHelper.setTo(mailVO.getRecptnEmail());
			messageHelper.setSubject(mailVO.getEmailSj());
			messageHelper.setText(mailVO.getEmailCn(),true);
			log.info(mailVO.getEmailCn());
			
			
			// 첨부할 파일 목록
	        // List<String> filePaths = mailVO.getFilePaths(); // MailVO에 파일 목록 필드를 추가해야 함

	        if (filePaths != null && !filePaths.isEmpty()) {
	            for (String filePath : filePaths) {
	            	filePath = saveDir+filePath;
	                File file = new File(filePath);
	                if (file.exists()) {
	                    messageHelper.addAttachment(file.getName(), file);
	                } else {
	                    log.warn("File not found: {}", filePath);
	                }
	            }
	        }
	        mailSender.send(message);
		} catch (Exception e) {
			res = 0;
			log.info("[error] doSendMail : {}", e);
		}
		log.info("{}.doSendMail end !", this.getClass().getName());
	}

}
