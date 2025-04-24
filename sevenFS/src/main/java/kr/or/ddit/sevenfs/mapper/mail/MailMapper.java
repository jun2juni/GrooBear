package kr.or.ddit.sevenfs.mapper.mail;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.mail.MailVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;

@Mapper
public interface MailMapper {

	int sendMail(List<MailVO> mailVOList);
	int getEmailGroupNo();
	int[] getMailNos(int totalMailNoCnt);
	List<MailVO> getList(ArticlePage<MailVO> articlePage);
	List<MailVO> emailDetail(MailVO mailVO);
	List<AttachFileVO> getAtchFile(long atchFileNo);
	int getTotal(Map<String, Object> map);
	int mailDelete(List<String> emailNoList);
	int labelingUpt(Map<String, Object> map);
	List<MailVO> mailLabeling(int lblNo);
	MailVO mailRepl(MailVO mailVO);
	int tempStoreEmail(List<MailVO> mailVOList);
	Map<String, Object> findEmplByEmail(String trnsmitEmail);
	int restoration(List<MailVO> mailVOList);
	List<MailVO> emailDetails(List<String> checkedList);
	int mailStarred(Map<String, Object> map);
	int readingAt(int emailNo);
	int delLblFromMail(int lblNo);

}
