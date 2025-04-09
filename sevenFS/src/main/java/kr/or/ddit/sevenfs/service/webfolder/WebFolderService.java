package kr.or.ddit.sevenfs.service.webfolder;

import kr.or.ddit.sevenfs.vo.webfolder.WebFolderFileVO;
import kr.or.ddit.sevenfs.vo.webfolder.WebFolderVO;

import java.util.List;

public interface WebFolderService {
    // 폴더 정보가져오기
    public WebFolderVO getFolder(int folderNo);

    // 파일 목록
    public List<WebFolderFileVO> getFileList(String folderNo);

    // 폴더 목록
    public List<WebFolderVO> getFolderList(String upperFolderNo);

    // 파일 업로드

    // 폴더 추가
    public int inertFolder(WebFolderVO webFolderVO);

    // 파일 삭제

    // 파일 다운로드

    // 파일
}
