package kr.or.ddit.sevenfs.mapper.mail;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.vo.mail.MailTemplateVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;

@Mapper
public interface MailTemplateMapper {

	int insertMailTemplate(MailTemplateVO mailTemplateVO);

	List<MailTemplateVO> getTemplateList(EmployeeVO employeeVO);

	int deleteTemplate(int emailAtmcCmpltNo);

	MailTemplateVO selectTemplate(int emailAtmcCmpltNo);

}
