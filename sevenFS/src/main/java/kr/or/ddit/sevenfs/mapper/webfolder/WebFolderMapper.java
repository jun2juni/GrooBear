package kr.or.ddit.sevenfs.mapper.webfolder;

import kr.or.ddit.sevenfs.vo.webfolder.WebFolderFileVO;
import kr.or.ddit.sevenfs.vo.webfolder.WebFolderVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface WebFolderMapper {
    public int insertFiles(List<WebFolderFileVO> webFolderFileVOList);

    public List<WebFolderVO> getFolderList(
            @Param(value = "upperFolderNo") String upperFolderNo,
            @Param(value = "folderTy") String folderTy,
            @Param(value = "deptCode") String deptCode
    );

    public List<WebFolderFileVO> getFileList(String folderNo);

    int insertFolder(WebFolderVO webFolderVO);

    WebFolderVO getFolder(int folderNo);

    List<WebFolderVO> getWebFolderList(@Param(value = "folderTy") String folderTy,
                                       @Param(value = "deptCode") String deptCode);

    int deleteFiles(long[] deleteFileIdList);

    int deleteFolder(int[] deleteFolderIdList);

    long getTotalVolume();

    int updateMoveFolderFile(WebFolderFileVO moveFile);

    int updateMoveFolder(WebFolderVO moveFolder);
}
