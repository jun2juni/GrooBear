package kr.or.ddit.sevenfs.service.mail;

import java.util.List;

import kr.or.ddit.sevenfs.vo.mail.MailTemplateVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;

public interface MailTemplateService {

	int insertMailTemplate(MailTemplateVO templateVO);
	List<MailTemplateVO> getTemplateList(EmployeeVO employeeVO);
	int deleteTemplate(int emailAtmcCmpltNo);
	MailTemplateVO selectTemplate(int emailAtmcCmpltNo);

}
