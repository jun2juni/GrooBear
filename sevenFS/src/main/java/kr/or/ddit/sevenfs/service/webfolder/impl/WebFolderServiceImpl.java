package kr.or.ddit.sevenfs.service.webfolder.impl;

import kr.or.ddit.sevenfs.mapper.webfolder.WebFolderMapper;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.webfolder.WebFolderService;
import kr.or.ddit.sevenfs.utils.AttachFile;
import kr.or.ddit.sevenfs.vo.webfolder.WebFolderFileVO;
import kr.or.ddit.sevenfs.vo.webfolder.WebFolderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WebFolderServiceImpl implements WebFolderService {
    @Autowired
    private WebFolderMapper webFolderMapper;
    @Autowired
    private AttachFile attachFile;

    @Override
    public WebFolderVO getFolder(int folderNo) {
        return webFolderMapper.getFolder(folderNo);
    }

    @Override
    public List<WebFolderFileVO> getFileList(String folderNo) {
        return webFolderMapper.getFileList(folderNo);
    }

    @Override
    public List<WebFolderVO> getFolderList(String upperFolderNo) {
        return webFolderMapper.getFolderList(upperFolderNo);
    }

    @Override
    public int inertFolder(WebFolderVO webFolderVO) {
        WebFolderVO upperFolder = getFolder(webFolderVO.getUpperFolderNo());
        webFolderVO.setFolderPath(upperFolder.getFolderPath() + "/" + webFolderVO.getFolderNm());
        // 임시 폴더 타입
        webFolderVO.setFolderTy("0");

        int result = webFolderMapper.insertFolder(webFolderVO);

        if (result == 1) {
            attachFile.folderMkdirs(webFolderVO.getFolderPath());
        }

        return result;
    }
}
