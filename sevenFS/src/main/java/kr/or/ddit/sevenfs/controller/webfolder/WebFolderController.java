package kr.or.ddit.sevenfs.controller.webfolder;

import kr.or.ddit.sevenfs.service.webfolder.WebFolderService;
import kr.or.ddit.sevenfs.vo.webfolder.WebFolderFileVO;
import kr.or.ddit.sevenfs.vo.webfolder.WebFolderVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
