package kr.or.ddit.sevenfs.service;

import kr.or.ddit.sevenfs.vo.AttachFileVO;

import java.util.List;

public interface AttachFileService {
    // 파일 넘버 가져오기
    public long getAttachFileNo();

    // 파일 순번 가져오기
    public int getAttachFileSn(long attachFileNo);

    // 파일 목록 가져오가
    public List<AttachFileVO> getFileAttachList(long attachFileNo);

    // 파일 디비 저장
    public int insertFileList(List<AttachFileVO> attachFileVOList);

    // 파일 삭제 처리
    public int removeFileList(AttachFileVO attachFileVO);

}
