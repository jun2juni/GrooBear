package kr.or.ddit.sevenfs.vo.webfolder;

import lombok.Data;

@Data
public class WebMoveVO {
    WebFolderVO targetFolder;
    WebFolderFileVO moveFile;
    WebFolderVO moveFolder;
}
