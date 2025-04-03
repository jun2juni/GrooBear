package kr.or.ddit.sevenfs.controller;

import jakarta.mail.Session;
import jakarta.servlet.http.HttpServletRequest;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;

import kr.or.ddit.sevenfs.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.annotation.SessionScope;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
public class HelloController {
	@Autowired
	private AttachFileService attachFileService;

	@GetMapping("/")
	public String index(Model model, HttpServletRequest request, @AuthenticationPrincipal CustomUser customUser) {


		return "home";
	}

	@GetMapping("/demo")
	public String demo(Model model, 
			@RequestParam(defaultValue = "1") int total,
			@RequestParam(defaultValue = "1") int currentPage, 
			@RequestParam(defaultValue = "10") int size) {
		ArticlePage<AttachFileVO> articlePage = new ArticlePage<>(total, currentPage, size);
		List<AttachFileVO> fileAttachList = attachFileService.getFileAttachList(1);

		model.addAttribute("fileAttachList", fileAttachList);

		AttachFileVO attachFileVO = new AttachFileVO();
		attachFileVO.setFileNm("파일이름");
		attachFileVO.setFileExtsn("파일확장자");
		attachFileVO.setFileStreNm("저장이름");
		articlePage.setSearchVo(attachFileVO);

		articlePage.setTotal(100);
		articlePage.setCurrentPage(currentPage);


		model.addAttribute("articlePage", articlePage);

		return "1demo/demo";
	}

	@GetMapping("/file/list")
	@ResponseBody
	public Map<String, Object> fileList() {
		Map<String, Object> resultMap = new HashMap<>();
		List<AttachFileVO> fileAttachList = attachFileService.getFileAttachList(1);

		resultMap.put("items", fileAttachList);

		return resultMap;
	}

	@GetMapping("/download")
	public ResponseEntity<Resource> download(@RequestParam String fileName) {
		return attachFileService.downloadFile(fileName);
	}

	@PostMapping("/fileUpload")
	public String fileUpload(MultipartFile[] uploadFile) {

		attachFileService.insertFileList("organization", uploadFile);

		return "redirect:/demo";
	}

	@PostMapping("/fileUpdate")
	public String fileUpdate(MultipartFile[] uploadFile, AttachFileVO attachFileVO) {

		attachFileService.updateFileList("test", uploadFile, attachFileVO);

		return "redirect:/demo";
	}

	@GetMapping("/validTest")
	public String validTest(Model model) {

		return "1demo/validTest";
	}
}
