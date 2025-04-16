package kr.or.ddit.sevenfs.mapper.mail;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.vo.mail.MailVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;

@Mapper
public interface MailMapper {

	int sendMail(List<MailVO> mailVOList);
	int getEmailGroupNo();
	int[] getMailNos(int totalMailNoCnt);
	List<MailVO> getList(EmployeeVO employeeVO);
	MailVO emailDetail(MailVO mailVO);

}
