package kr.or.ddit.sevenfs.service.impl;

import kr.or.ddit.sevenfs.mapper.AttachFileMapper;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.utils.AttachFile;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class AttachFileServiceImpl implements AttachFileService {

    @Autowired
    private AttachFile attachFile;

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
    public long insertFileList(String dir, MultipartFile[] files) {
        long atchFileNo = getAttachFileNo();
        List<AttachFileVO> attachFileVOList = attachFile.fileRealSave(dir, files, atchFileNo, 1);

        // 디비에 파일 저장 파일이 있는 경우만
        if (!attachFileVOList.isEmpty()) {
            attachFileMapper.insertFileList(attachFileVOList);
        }
        return atchFileNo;
    }

    @Override
    public int updateFileList(String dir, MultipartFile[] files, AttachFileVO attachFileVO) {
        // 파일 삭제 처리 (디비에서만)
        int[] removeFileId = attachFileVO.getRemoveFileId();
        if (removeFileId != null && removeFileId.length > 0) {
            attachFileMapper.removeFileList(attachFileVO);
        }

        // 파일 추가 처리
        long atchFileNo = attachFileVO.getAtchFileNo();
        int atchFileSn = getAttachFileSn(atchFileNo);
        List<AttachFileVO> attachFileVOList = attachFile.fileRealSave(dir, files, atchFileNo, atchFileSn);

        // 디비에 파일 저장 파일이 있는 경우만
        if (!attachFileVOList.isEmpty()) {
            return attachFileMapper.insertFileList(attachFileVOList);
        }

        return 0;
    }

    @Override
    public ResponseEntity<Resource> downloadFile(String fileName) {
        return attachFile.download(fileName);
    }
}
