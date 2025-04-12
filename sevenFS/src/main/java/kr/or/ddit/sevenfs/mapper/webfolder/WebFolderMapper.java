package kr.or.ddit.sevenfs.mapper.webfolder;

import kr.or.ddit.sevenfs.vo.webfolder.WebFolderFileVO;
import kr.or.ddit.sevenfs.vo.webfolder.WebFolderVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface WebFolderMapper {
    public int insertFiles(List<WebFolderFileVO> webFolderFileVOList);

    public List<WebFolderVO> getFolderList(String upperFolderNo);

    public List<WebFolderFileVO> getFileList(String folderNo);

    int insertFolder(WebFolderVO webFolderVO);

    WebFolderVO getFolder(int folderNo);

    List<WebFolderVO> getWebFolderList();

    int deleteFiles(long[] deleteFileIdList);

    int deleteFolder(int[] deleteFolderIdList);

    long getTotalVolume();

    int updateMoveFolderFile(WebFolderFileVO moveFile);

    int updateMoveFolder(WebFolderVO moveFolder);
}
