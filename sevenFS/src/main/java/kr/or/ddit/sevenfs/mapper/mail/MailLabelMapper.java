package kr.or.ddit.sevenfs.mapper.mail;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.vo.mail.MailLabelVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;

@Mapper
public interface MailLabelMapper {

	int mailLblAdd(MailLabelVO labelVO);

	List<MailLabelVO> getLabelList(EmployeeVO employeeVO);


}
