package kr.or.ddit.sevenfs.vo.webfolder;

import kr.or.ddit.sevenfs.vo.AttachFileVO;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class WebFolderVO {
    private String folderPath;
    private String folderTy;
    private String deptCode;
    private Date folderCreatDt;
    private Date folderUpdtDt;
    private String folderDeleteYn;
    private String folderCreatEmpno; // 폴더 생성 사번
    private int folderNo;
    private int upperFolderNo;
    private String folderNm;

    private List<WebFolderFileVO> fileList;
}
