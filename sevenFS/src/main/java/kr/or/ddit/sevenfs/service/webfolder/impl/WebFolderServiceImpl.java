package kr.or.ddit.sevenfs.service.webfolder.impl;

import kr.or.ddit.sevenfs.mapper.webfolder.WebFolderMapper;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.webfolder.WebFolderService;
import kr.or.ddit.sevenfs.utils.AttachFile;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.webfolder.WebFolderFileVO;
import kr.or.ddit.sevenfs.vo.webfolder.WebFolderVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
public class WebFolderServiceImpl implements WebFolderService {
    @Autowired
    private WebFolderMapper webFolderMapper;
    @Autowired
    private AttachFile attachFile;
    @Autowired
    private AttachFileService attachFileService;


    @Override
    public List<WebFolderVO> getWebFolderList() {
        return webFolderMapper.getWebFolderList();
    }

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
    public int insertFiles(MultipartFile[] uploadFile, WebFolderVO webFolderVO, String emplNo) {
        // 파일 업로드
        List<WebFolderFileVO> webFolderFileVOList = new ArrayList<>();
        for (MultipartFile file : uploadFile) {
            AttachFileVO attachFileVO = attachFileService.insertFile(webFolderVO.getFolderPath(), file);
            if (attachFileVO != null) {
                log.debug("attachFileVO {}", attachFileVO);
                WebFolderFileVO webFolderFileVO = new WebFolderFileVO();
                webFolderFileVO.setFolderNo(webFolderVO.getFolderNo());
                webFolderFileVO.setAtchFileNo(attachFileVO.getAtchFileNo());
                webFolderFileVO.setFileUploadEmpno(emplNo);
                webFolderFileVOList.add(webFolderFileVO);
            }
        }


        log.debug("webFolderFileVOList {}", webFolderFileVOList);
        int result = webFolderMapper.insertFiles(webFolderFileVOList);

        // 해당 정보 가지고
        return result;
    }

    @Override
    public int inertFolder(WebFolderVO webFolderVO) {
        WebFolderVO upperFolder = getFolder(webFolderVO.getUpperFolderNo());
        // ROOT 폴더인 경우 / 안들어가게하기
        webFolderVO.setFolderPath(upperFolder.getFolderPath() + "/" + webFolderVO.getFolderNm());
        // 임시 폴더 타입
        webFolderVO.setFolderTy("0");

        int result = webFolderMapper.insertFolder(webFolderVO);

        if (result == 1) {
            attachFile.folderMkdirs(webFolderVO.getFolderPath());
        }

        return result;
    }

    @Override
    public int deleteFiles(List<WebFolderFileVO> webFolderFileVO) {
        long[] deleteFileIdList = webFolderFileVO.stream()
                .mapToLong(WebFolderFileVO::getAtchFileNo)
                .toArray();

        return this.webFolderMapper.deleteFiles(deleteFileIdList);
    }

    @Override
    public int deleteFolder(List<WebFolderVO> webFolderVO) {
        int[] deleteFolderIdList = webFolderVO.stream()
                .mapToInt(WebFolderVO::getFolderNo)
                .toArray();

        return this.webFolderMapper.deleteFolder(deleteFolderIdList);
    }
}
