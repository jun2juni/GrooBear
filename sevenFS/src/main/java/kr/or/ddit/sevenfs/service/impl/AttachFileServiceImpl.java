package kr.or.ddit.sevenfs.service.impl;

import kr.or.ddit.sevenfs.mapper.AttachFileMapper;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AttachFileServiceImpl implements AttachFileService {

    @Autowired
    private AttachFileMapper attachFileMapper;

    @Override
    public long getAttachFileNo() {
        return attachFileMapper.getAttachFileNo();
    }

    @Override
    public int getAttachFileSn(long attachFileNo) {
        return attachFileMapper.getAttachFileSn(attachFileNo);
    }

    @Override
    public List<AttachFileVO> getFileAttachList(long attachFileNo) {
        return attachFileMapper.getFileAttachList(attachFileNo);
    }

    @Override
    public int insertFileList(List<AttachFileVO> attachFileVOList) {
        return attachFileMapper.insertFileList(attachFileVOList);
    }

    @Override
    public int removeFileList(AttachFileVO attachFileVO) {
        return attachFileMapper.removeFileList(attachFileVO);
    }
}
