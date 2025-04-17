package kr.or.ddit.sevenfs.mapper.mail;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.mail.MailVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;

@Mapper
public interface MailMapper {

	int sendMail(List<MailVO> mailVOList);
	int getEmailGroupNo();
	int[] getMailNos(int totalMailNoCnt);
	List<MailVO> getList(EmployeeVO employeeVO);
	List<MailVO> emailDetail(MailVO mailVO);
	List<AttachFileVO> getAtchFile(long atchFileNo);
	int getTotal(Map<String, Object> map);

}
