package kr.or.ddit.sevenfs.service.impl;

import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.sevenfs.mapper.AttachFileMapper;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.utils.AttachFile;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Service
public class AttachFileServiceImpl implements AttachFileService {
     @Value("${file.save.abs.path}")
    String dir;
    @Autowired
    private AttachFile attachFile;

    @Autowired
    private AttachFileMapper attachFileMapper;

    @Override
    public long getAttachFileNo() {
        return attachFileMapper.getAttachFileNo();
    }

    @Override
    public int getAttachFileSn(long attachFileNo) {
        return attachFileMapper.getAttachFileSn(attachFileNo);
    }

    @Override
    public List<AttachFileVO> getFileAttachList(long attachFileNo) {
        return attachFileMapper.getFileAttachList(attachFileNo);
    }

    @Override
    public List<AttachFileVO> getFileAttachList(List<Long> attachFileNoList) {
        return attachFileMapper.getFileAttachListToDownload(attachFileNoList);
    }

    @Override
    public long insertFileList(String dir, MultipartFile[] files) {
        long atchFileNo = getAttachFileNo();
        List<AttachFileVO> attachFileVOList = attachFile.fileRealSave(dir, files, atchFileNo, 1);

        // 디비에 파일 저장 파일이 있는 경우만
        if (!attachFileVOList.isEmpty()) {
            attachFileMapper.insertFileList(attachFileVOList);
        }
        return atchFileNo;
    }

    @Override
    public int updateFileList(String dir, MultipartFile[] files, AttachFileVO attachFileVO) {
        // 파일 삭제 처리 (디비에서만)
        int[] removeFileId = attachFileVO.getRemoveFileId();
        if (removeFileId != null && removeFileId.length > 0) {
            attachFileMapper.removeFileList(attachFileVO);
        }

        // 파일 추가 처리
        // 파일 넘버가 없는 경우가 있을 수 있음 - 성진 0331
        long atchFileNo = attachFileVO.getAtchFileNo() == 0 ? getAttachFileNo() : attachFileVO.getAtchFileNo();
        int atchFileSn = getAttachFileSn(atchFileNo);
        List<AttachFileVO> attachFileVOList = attachFile.fileRealSave(dir, files, atchFileNo, atchFileSn);

        // 디비에 파일 저장 파일이 있는 경우만
        if (!attachFileVOList.isEmpty()) {
            return attachFileMapper.insertFileList(attachFileVOList);
        }

        return 0;
    }

    @Override
    public ResponseEntity<Resource> downloadFile(String fileName) {
        return attachFile.download(fileName);
    }

    @Override
    public AttachFileVO insertFile(String dir, MultipartFile[] files) {
        long atchFileNo = getAttachFileNo();
        List<AttachFileVO> attachFileVOList = attachFile.fileRealSave(dir, files, atchFileNo, 1);

        if (!attachFileVOList.isEmpty()) {
            attachFileMapper.insertFileList(attachFileVOList);
            return attachFileVOList.getFirst();
        }

        return null;
    }

    @Override
    public AttachFileVO insertFile(String dir, MultipartFile file) {
        long atchFileNo = getAttachFileNo();
        MultipartFile[] files = new MultipartFile[]{file};
        List<AttachFileVO> attachFileVOList = attachFile.fileRealSave(dir, files, atchFileNo, 1);

        if (!attachFileVOList.isEmpty()) {
            attachFileMapper.insertFileList(attachFileVOList);
            return attachFileVOList.getFirst();
        }

        return null;
    }


    @Override
    public void downloadZip(List<AttachFileVO> attachFileVOList, String folderName, HttpServletResponse response) throws IOException {
        try (ZipOutputStream zipOut = new ZipOutputStream(response.getOutputStream())) {
            for (AttachFileVO attachFileVO : attachFileVOList) {
                String fileStrePath = attachFileVO.getFileStrePath();
                System.out.println(fileStrePath);

                File file = new File( dir + fileStrePath);
                if (file.exists()) {
                    try (FileInputStream fileInputStream = new FileInputStream(file)) {
                        ZipEntry zipEntry = new ZipEntry(file.getName()); // 진짜 파일 zip 파일에 추가
                        zipOut.putNextEntry(zipEntry);

                        byte[] bytes = new byte[1024];
                        int len;
                        while ((len = fileInputStream.read(bytes)) != -1) {
                            zipOut.write(bytes, 0, len);
                        }

                        zipOut.closeEntry();
                    }
                }
            }
            zipOut.finish();
        }
    }

}
