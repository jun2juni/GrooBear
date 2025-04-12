package kr.or.ddit.sevenfs.controller.webfolder;

import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.webfolder.WebFolderService;

import kr.or.ddit.sevenfs.utils.AttachFile;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.webfolder.WebFolderFileVO;
import kr.or.ddit.sevenfs.vo.webfolder.WebFolderVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Slf4j
@RestController
@RequestMapping("/api/webFolder")
public class WebFolderController {
    @Value("${file.save.abs.path}")
    String dir;
    @Autowired
    private WebFolderService webFolderService;
    @Autowired
    private AttachFileService attachFileService;

    @GetMapping("/list")
    public Map<String, Object> getFolder(String upperFolderNo) {
        Map<String, Object> resultMap = new HashMap<>();

        // 파일 목록 가져오기
        log.debug("upperFolderNo: {}", upperFolderNo);
        long totalVolume = webFolderService.getTotalVolume();
        List<WebFolderVO> folderVOList = webFolderService.getFolderList(upperFolderNo);
        List<WebFolderFileVO> fileListVOList = webFolderService.getFileList(upperFolderNo);

        resultMap.put("totalVolume", totalVolume);
        resultMap.put("folder", folderVOList);
        resultMap.put("file", fileListVOList);

        return resultMap;
    }

    @GetMapping("/folderList")
    public Map<String, Object> getFolderList() {
        Map<String, Object> resultMap = new HashMap<>();

        // 파일 목록 가져오기
        List<WebFolderVO> webFolderList = this.webFolderService.getWebFolderList();
        resultMap.put("folderList", webFolderList);

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

    @PostMapping("/deleteFiles")
    public Map<String, Object> deleteFiles(@RequestBody List<WebFolderFileVO> webFolderFiles) {
        log.debug("webFolderFiles: {}", webFolderFiles);
        int result = this.webFolderService.deleteFiles(webFolderFiles);

        return Map.of("result", result != 0);
    }

    @PostMapping("/deleteFolders")
    public Map<String, Object> deleteFolders(@RequestBody List<WebFolderVO> webFolders) {
        log.debug("webFolderFiles: {}", webFolders);
        int result = this.webFolderService.deleteFolder(webFolders);

        return Map.of("result", result != 0);
    }

    @GetMapping("/download-folder")
    public void downloadZip(String folderNo, String folderName, HttpServletResponse response) throws IOException {
        response.setContentType("application/zip");
        response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(folderName, StandardCharsets.UTF_8) + ".zip");

        List<AttachFileVO> attachFileVOList = this.webFolderService.getFileList(folderNo).stream()
                .map((item) -> {
                    return item.getAttachFileVO();
                }).toList();

        attachFileService.downloadZip(attachFileVOList, folderName, response);
    }

    @GetMapping("/download-file")
    public void downloadFile(Long[] fileNoList, String folderName, HttpServletResponse response) throws IOException {
        // 권한 확인하는거 추가 하기

        response.setContentType("application/zip");
        response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(folderName, StandardCharsets.UTF_8) + ".zip");
        List<Long> list = Stream.of(fileNoList).toList();
        log.debug("list: {}", list);
        List<AttachFileVO> attachFileVOList = this.attachFileService.getFileAttachList(list);

        attachFileService.downloadZip(attachFileVOList, folderName, response);
    }

    @PostMapping("/file-move")
    public Map<String, String> fileMove(@RequestPart WebFolderVO targetFolder, @RequestPart WebFolderFileVO moveFile) throws IOException {
        log.debug("targetFolder: {}", targetFolder);
        log.debug("moveFile: {}", moveFile);
        Map<String, String> stringStringMap = this.webFolderService.updateMoveFolder(targetFolder, moveFile);

        return stringStringMap;
    }

    @PostMapping("/folder-move")
    public Map<String, String> folderMove(@RequestPart WebFolderVO targetFolder, @RequestPart WebFolderVO moveFolder) throws IOException {
        log.debug("targetFolder: {}", targetFolder);
        log.debug("moveFolder: {}", moveFolder);
        Map<String, String> stringStringMap = this.webFolderService.updateMoveFolder(targetFolder, moveFolder);

        return stringStringMap;
    }


}
