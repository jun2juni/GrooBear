package kr.or.ddit.sevenfs.service;

import kr.or.ddit.sevenfs.vo.AttachFileVO;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface AttachFileService {
    // 파일 넘버 가져오기
    public long getAttachFileNo();

    // 파일 순번 가져오기
    public int getAttachFileSn(long attachFileNo);

    // 파일 목록 가져오가
    public List<AttachFileVO> getFileAttachList(long attachFileNo);

    // 파일 디비 저장
    public long insertFileList(String dir, MultipartFile[] files);

    // 파일 수정 처리
    public int updateFileList(String dir, MultipartFile[] files, AttachFileVO attachFileVO);

    // 파일 다운로드
    public ResponseEntity<Resource> downloadFile(String fileName);

}
