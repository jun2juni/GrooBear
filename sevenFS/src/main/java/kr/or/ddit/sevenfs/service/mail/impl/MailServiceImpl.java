package kr.or.ddit.sevenfs.service.mail.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.mail.MailMapper;
import kr.or.ddit.sevenfs.service.mail.MailService;

@Service
public class MailServiceImpl implements MailService{
	
	@Autowired
	MailMapper mailMapper;
}
