package kr.or.ddit.sevenfs.controller.webfolder;

import kr.or.ddit.sevenfs.service.webfolder.WebFolderService;
import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import kr.or.ddit.sevenfs.vo.webfolder.WebFolderFileVO;
import kr.or.ddit.sevenfs.vo.webfolder.WebFolderVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/webFolder")
public class WebFolderController {
    @Autowired
    private WebFolderService webFolderService;

    @GetMapping("/list")
    public Map<String, Object> getFolder(String upperFolderNo) {
        Map<String, Object> resultMap = new HashMap<>();

        // 파일 목록 가져오기
        log.debug("upperFolderNo: {}", upperFolderNo);
        List<WebFolderVO> folderVOList = webFolderService.getFolderList(upperFolderNo);
        List<WebFolderFileVO> fileListVOList = webFolderService.getFileList(upperFolderNo);

        resultMap.put("folder", folderVOList);
        resultMap.put("file", fileListVOList);

        return resultMap;
    }

    @PostMapping("/insertFolder")
    public WebFolderVO insertFolder(WebFolderVO webFolderVO) {
        log.debug("webFolderVO: {}", webFolderVO);
        webFolderService.inertFolder(webFolderVO);

        return webFolderVO;
    }

    @PostMapping("/insertFiles")
    public Map<String, Object> insertFiles(MultipartFile[] uploadFile,
                                           WebFolderVO webFolderVO) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String emplNo = authentication.getName();

        log.debug("emplNo: {}", emplNo);
        log.debug("uploadFile: {}", uploadFile);
        log.debug("webFolderVO: {}", webFolderVO);
        Map<String, Object> resultMap = new HashMap<>();
        int i = this.webFolderService.insertFiles(uploadFile, webFolderVO, emplNo);


        return resultMap;
    }
}
