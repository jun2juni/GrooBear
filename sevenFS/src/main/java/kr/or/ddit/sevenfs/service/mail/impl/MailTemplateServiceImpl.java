package kr.or.ddit.sevenfs.service.mail.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.mail.MailTemplateMapper;
import kr.or.ddit.sevenfs.service.mail.MailTemplateService;
import kr.or.ddit.sevenfs.vo.mail.MailTemplateVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MailTemplateServiceImpl implements MailTemplateService {
	
	@Autowired
	MailTemplateMapper mailTemplateMapper;
	
	@Override
	public int insertMailTemplate(MailTemplateVO templateVO) {
		int result = mailTemplateMapper.insertMailTemplate(templateVO);
		return result;
	}

	@Override
	public List<MailTemplateVO> getTemplateList(EmployeeVO employeeVO) {
		return mailTemplateMapper.getTemplateList(employeeVO);
	}

	@Override
	public int deleteTemplate(int emailAtmcCmpltNo) {
		return mailTemplateMapper.deleteTemplate(emailAtmcCmpltNo);
	}

	@Override
	public MailTemplateVO selectTemplate(int emailAtmcCmpltNo) {
		return mailTemplateMapper.selectTemplate(emailAtmcCmpltNo);
	}

}
