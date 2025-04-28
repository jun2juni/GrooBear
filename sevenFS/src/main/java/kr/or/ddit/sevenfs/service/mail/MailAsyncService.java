package kr.or.ddit.sevenfs.service.mail;

import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.vo.mail.MailVO;

public interface MailAsyncService {
	void sendMailAsync(MailVO mailVO);
}
