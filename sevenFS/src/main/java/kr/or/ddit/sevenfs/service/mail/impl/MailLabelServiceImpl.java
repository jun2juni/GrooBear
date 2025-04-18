package kr.or.ddit.sevenfs.service.mail.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.sevenfs.mapper.mail.MailLabelMapper;
import kr.or.ddit.sevenfs.service.mail.MailLabelService;
import kr.or.ddit.sevenfs.service.mail.MailService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.mail.MailLabelVO;
import kr.or.ddit.sevenfs.vo.mail.MailVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;

@Service
public class MailLabelServiceImpl implements MailLabelService {
	@Autowired
	MailLabelMapper labelMapper;
	
	@Override
	public int mailLblAdd(MailLabelVO labelVO) {
		return labelMapper.mailLblAdd(labelVO);
	}

	@Override
	public List<MailLabelVO> getLabelList(EmployeeVO employeeVO) {
		return labelMapper.getLabelList(employeeVO);
	}


}
