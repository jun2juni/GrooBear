package kr.or.ddit.sevenfs.service.mail;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.mail.MailLabelVO;
import kr.or.ddit.sevenfs.vo.mail.MailVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;

public interface MailService {
	int sendMail(MailVO mailVO, MultipartFile[] uploadFile);

	List<MailVO> getList(ArticlePage<MailVO> articlePage);

	MailVO emailDetail(MailVO mailVO);

	List<AttachFileVO> getAtchFile(long atchFileNo);

	void downloadFile(String fileName);

	int getTotal(Map<String, Object> map);

	int mailDelete(List<String> emailNoList);

	int labelingUpt(Map<String, Object> map);

	List<MailVO> mailLabeling(int lblNo);


	int tempStoreEmail(MailVO mailVO, MultipartFile[] uploadFile);

	Map<String, Object> mailRepl(MailVO mailVO);

	MailVO mailTrnsms(MailVO mailVO);

	int restoration(List<MailVO> checkedList);

	List<MailVO> emailDetails(List<String> checkedList);

	int mailStarred(Map<String, Object> map);

	int readingAt(int emailNo);

	int delLblFromMail(int lblNo);



}
