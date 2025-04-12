package kr.or.ddit.sevenfs.service.webfolder;

import kr.or.ddit.sevenfs.vo.webfolder.WebFolderFileVO;
import kr.or.ddit.sevenfs.vo.webfolder.WebFolderVO;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface WebFolderService {
    // 전체 용량 가져오기
    public long getTotalVolume();

    // 폴더 구조 가져오기
    public List<WebFolderVO> getWebFolderList();

    // 폴더 정보가져오기
    public WebFolderVO getFolder(int folderNo);

    // 파일 목록
    public List<WebFolderFileVO> getFileList(String folderNo);

    // 폴더 목록
    public List<WebFolderVO> getFolderList(String upperFolderNo);

    // 파일 업로드
    public int insertFiles(MultipartFile[] uploadFile, WebFolderVO webFolderVO, String emplNo);

    // 폴더 추가
    public int inertFolder(WebFolderVO webFolderVO);

    // 파일 삭제
    public int deleteFiles(List<WebFolderFileVO> webFolderVO);

    // 폴더 삭제
    public int deleteFolder(List<WebFolderVO> webFolderFileVO);

    // 파일 다운로드

    // 파일 이동
    public Map<String, String> updateMoveFolder(WebFolderVO targetFolder, WebFolderFileVO moveFile) throws IOException;

    // 폴더 이동
    public Map<String, String> updateMoveFolder(WebFolderVO targetFolder, WebFolderVO moveFolder) throws IOException;
}
