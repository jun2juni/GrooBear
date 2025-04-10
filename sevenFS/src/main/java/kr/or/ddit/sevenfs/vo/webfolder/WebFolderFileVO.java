package kr.or.ddit.sevenfs.vo.webfolder;

import kr.or.ddit.sevenfs.vo.AttachFileVO;
import lombok.Data;

import java.util.List;

@Data
public class WebFolderFileVO {
    private int folderNo;
    private long atchFileNo;
    private int fileDwldCo; // 파일 다운르도 카운트
    private String fileUploadEmpno;

    private AttachFileVO attachFileVO;
}
