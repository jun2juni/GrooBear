package kr.or.ddit.sevenfs.controller.mail;

import java.io.File;
import java.io.FileInputStream;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.mail.MailLabelService;
import kr.or.ddit.sevenfs.service.mail.MailService;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.mail.MailLabelVO;
import kr.or.ddit.sevenfs.vo.mail.MailVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/mail")
public class MailController {
	/** 
	 * 
	 * <pre>
	 * </pre>
	 * 
	 * */
	@Value("${file.save.abs.path}")
	private String saveDir;
	
	@Autowired
	MailService mailService;
	
	@Autowired
	MailLabelService mailLabelService;
	
	@Autowired
	OrganizationService organizationService;
	
	@Autowired
	AttachFileService attachFileService;
	
	@GetMapping("")
	public String mailHome(Model model,@ModelAttribute MailVO mailVO, @AuthenticationPrincipal CustomUser customUser,
			@RequestParam(defaultValue = "1", required = false) int currentPage,
			@RequestParam(defaultValue = "1", required = false) String emailClTy
			) {
		EmployeeVO employeeVO = customUser.getEmpVO();
		log.info("CustomUser -> employeeVO" + employeeVO);
		log.info("mailHome -> MailVO -> 검색을 위함 : " + mailVO);
		log.info("mailHome -> MailVO -> 페이지 : " + currentPage);
		log.info("mailHome -> MailVO -> 메일함 : " + emailClTy);
		model.addAttribute("title","메일함");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		mailVO.setEmailClTy(emailClTy);
		mailVO.setEmplNo(employeeVO.getEmplNo());
		
		map.put("emplNo", employeeVO.getEmplNo());
		map.put("mailVO", mailVO);
		map.put("currentPage", currentPage);
		map.put("size", 10);
		
		int total = mailService.getTotal(map);
		log.info("mailService.getTotal(map) -> total : "+total);
		ArticlePage<MailVO> articlePage = new ArticlePage<MailVO>(total, currentPage, 10);
		articlePage.setSearchVo(mailVO);
		List<MailVO> mailVOList = mailService.getList(articlePage);
		log.info("mailHome -> getList() -> mailVOList : "+mailVOList);
		
		List<MailLabelVO> mailLabelList = mailLabelService.getLabelList(employeeVO);
		log.info("mailHome -> getLabelList(employeeVO) -> mailLabelList" + mailLabelList);
		log.info("mailHome -> 응답전 mailVO : "+mailVO);
		
		model.addAttribute("mailVOList",mailVOList);
		model.addAttribute("articlePage", articlePage);
		model.addAttribute("searchVO", mailVO);
		model.addAttribute("emplNo", employeeVO.getEmplNo());
		model.addAttribute("mailLabelList", mailLabelList);
		
		return "mail/mailHome";
	}
	
	@GetMapping("/labeling")
	public String mailLabeling(Model model,
								@RequestParam(value = "lblNo")int lblNo,
								@RequestParam(defaultValue = "1", required = false) int currentPage,
								@AuthenticationPrincipal CustomUser customUser,
								@ModelAttribute MailVO mailVO){
		log.info("mailLabeling -> lblNo : "+lblNo);
		log.info("mailLabeling -> mailVO : "+mailVO);
		EmployeeVO employeeVO = customUser.getEmpVO();
		mailVO.setEmplNo(employeeVO.getEmplNo());
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("emplNo", employeeVO.getEmplNo());
		map.put("mailVO", mailVO);
		map.put("currentPage", currentPage);
		map.put("size", 10);
		
		int total = mailService.getTotal(map);
		log.info("mailService.getTotal(map) -> total : "+total);
		
		ArticlePage<MailVO> articlePage = new ArticlePage<MailVO>(total, currentPage, 10);
		articlePage.setSearchVo(mailVO);
		List<MailVO> mailVOList = mailService.getList(articlePage);
		log.info("mailHome -> getList() -> mailVOList : "+mailVOList);
		
//		List<MailVO> list = mailService.mailLabeling(lblNo);
//		log.info("mailLabeling -> mailService : "+list);
		
		List<MailLabelVO> mailLabelList = mailLabelService.getLabelList(employeeVO);
		model.addAttribute("mailVOList", mailVOList);
		model.addAttribute("articlePage", articlePage);
		model.addAttribute("searchVO", mailVO);
		model.addAttribute("emplNo", employeeVO.getEmplNo());
		model.addAttribute("labelingPage","true");
		model.addAttribute("mailLabelList", mailLabelList);
		return "mail/mailHome";
	}
	
	@GetMapping("/emailDetail")
	public String emailDetail(Model model ,@RequestParam(value = "emailNo") int emailNo, String fileName,
								@AuthenticationPrincipal CustomUser customUser) {
		log.info("emailDetail -> emailNo : "+emailNo);
		EmployeeVO employeeVO = customUser.getEmpVO();
		int result = mailService.readingAt(emailNo);
		List<MailLabelVO> mailLabelList = mailLabelService.getLabelList(employeeVO);
		MailVO mailVO = new MailVO(emailNo);
		log.info("emailDetail -> mailVO : "+mailVO);
		mailVO = mailService.emailDetail(mailVO);
		mailVO.setHiddenRefMapList(null);
		log.info("emailDetail -> mailService.emailDetail -> mailVO : "+mailVO);
		List<AttachFileVO> attachFileVOList = mailService.getAtchFile(mailVO.getAtchFileNo());
		attachFileService.downloadFile(fileName);
		model.addAttribute("mailVO",mailVO);
		model.addAttribute("attachFileVOList",attachFileVOList);
		model.addAttribute("mailLabelList", mailLabelList);
		
		return "mail/mailDetailLayout";
	}
	
	@GetMapping("/mailSend")
	public String mailSend(Model model, @RequestParam(value = "emplNm",required = false) String emplNm,
										@RequestParam(value = "email",required = false) String email,
										@RequestParam(value = "emplNo",required = false) String emplNo,
										@AuthenticationPrincipal CustomUser customUser) {
		EmployeeVO employeeVO = customUser.getEmpVO();
		List<MailLabelVO> mailLabelList = mailLabelService.getLabelList(employeeVO);
		model.addAttribute("mailLabelList",mailLabelList);
		model.addAttribute("title","메일함");
		model.addAttribute("myEmplNo",employeeVO.getEmplNo());
		model.addAttribute("emplNo",emplNo);
		model.addAttribute("emplNm",emplNm);
		model.addAttribute("recptnEmail",email);
		log.info("mailSend get요청 -> emplNm : "+emplNm);
		log.info("mailSend get요청 -> recptnEmail : "+email);
		log.info("mailSend get요청 -> emplNo : "+emplNo);
		return "mail/mailSend";
	}
	
	@GetMapping("/mailRepl")
	public String mailRepl(Model model, @RequestParam(value = "emailNo") int emailNo,
			@AuthenticationPrincipal CustomUser customUser) {
		// 답장
		log.info("mailRepl -> emailNo : "+emailNo);
		EmployeeVO employeeVO = customUser.getEmpVO();
		
		MailVO mailVO = new MailVO();
		mailVO.setEmailNo(emailNo);
		Map<String, Object> map = mailService.mailRepl(mailVO);
		log.info("map"+map);
		mailVO = (MailVO)map.get("mailVO");
		
		model.addAttribute("emplNm",(String)map.get("fromEmplNm"));
		model.addAttribute("emplNo",(String)map.get("fromEmplNo"));
		model.addAttribute("recptnEmail",mailVO.getTrnsmitEmail());
		model.addAttribute("mailVO",mailVO);
		log.info("emplNo : " + (String)map.get("fromEmplNo"));
		log.info("emplNm : " + map.get("fromEmplNm"));
		log.info("recptnEmail : " + mailVO.getTrnsmitEmail());
		return"mail/mailSend";
	}
	
	@GetMapping("/mailTrnsms")
	public String mailTrnsms(Model model, @RequestParam(value = "emailNo") int emailNo) {
		// 전달
		MailVO mailVO = new MailVO();
		mailVO.setEmailNo(emailNo);
		mailVO = mailService.mailTrnsms(mailVO);
		List<AttachFileVO> attachFileVOList = mailService.getAtchFile(mailVO.getAtchFileNo());
		
		model.addAttribute("mailVO",mailVO);
		model.addAttribute("attachFileVOList",attachFileVOList);
		return"mail/mailSend";
	}
	
	@PostMapping("/selEmail")
	@ResponseBody
	public Map<String,String> selEmail(@RequestBody EmployeeVO employeeVO) {
		log.info("selEmail -> employeeVO : "+employeeVO);
		employeeVO = organizationService.emplDetail(employeeVO.getEmplNo());
		String email = employeeVO.getEmail();
		String emplNm = employeeVO.getEmplNm();
		String emplNo = employeeVO.getEmplNo();
		log.info("selEmail -> emplDetail -> email : "+email);
		log.info("selEmail -> emplDetail -> emplNm : "+emplNm);
		log.info("selEmail -> emplDetail -> emplNo : "+emplNo);
		Map<String,String> map = new HashMap<>();
		map.put("email", email);
		map.put("emplNm", emplNm);
		map.put("emplNo", emplNo);
		return map;
	}
	
	@PostMapping("/sendMail")
	@ResponseBody
	public Map<String, Object> sendEmail(@ModelAttribute MailVO mailVO,
							@RequestParam(value = "uploadFile",required = false) MultipartFile[] uploadFile,
							@AuthenticationPrincipal CustomUser customUser ) {
		log.info("sendEmail");
		log.info("sendEmail -> mailVO 이전: " + mailVO);
		EmployeeVO employeeVO = customUser.getEmpVO();
		mailVO.setEmplNo(employeeVO.getEmplNo());
		mailVO.setEmplNm(employeeVO.getEmplNm());
		mailVO.setTrnsmitEmail(employeeVO.getEmail());
		log.info("sendEmail -> mailVO 이후: " + mailVO);
		if(uploadFile!=null) {
			log.info("sendEmail -> uploadFile : " + uploadFile);
			for(MultipartFile file : uploadFile) {
				log.info(file.getOriginalFilename());
			}
		}
		int result = mailService.sendMail(mailVO,uploadFile);
		Map<String, Object> response = new HashMap<>();
	    response.put("status", "success");
	    response.put("message", "메일이 발송되었습니다");
		return response;
	}
	
	@PostMapping("/tempStore")
	@ResponseBody
	public String tempStoreEmail(@ModelAttribute MailVO mailVO,
			@RequestParam(value = "uploadFile",required = false) MultipartFile[] uploadFile) {
		mailVO.setEmailClTy("2");
		log.info("tempStore -> mailVO : " + mailVO);
		if(uploadFile!=null) {
			log.info("tempStore -> uploadFile : " + uploadFile);
			for(MultipartFile file : uploadFile) {
				log.info(file.getOriginalFilename());
			}
		}
		
		int result = mailService.tempStoreEmail(mailVO,uploadFile);
		return "/mail";
	}
	@GetMapping("/emailTemp")
	public String emailTemp(Model model, @RequestParam(value = "emailNo") int emailNo,
			@AuthenticationPrincipal CustomUser customUser) {
		log.info("emailTemp -> emailNo : "+emailNo);
		EmployeeVO employeeVO = customUser.getEmpVO();
		List<MailLabelVO> mailLabelList = mailLabelService.getLabelList(employeeVO);
		MailVO mailVO = new MailVO();
		mailVO.setEmailNo(emailNo);
		mailVO = mailService.emailDetail(mailVO);
		log.info("emailDetail -> mailVO : "+mailVO);
//		List<AttachFileVO> attachFileVOList = mailService.getAtchFile(mailVO.getAtchFileNo());
		List<AttachFileVO> fileList = attachFileService.getFileAttachList(mailVO.getAtchFileNo());
		model.addAttribute("mailVO",mailVO);
		model.addAttribute("fileList",fileList);
		model.addAttribute("mailLabelList", mailLabelList);
		log.info("emailDetail -> mailService.emailDetail -> mailVO : "+mailVO);
		log.info("emailDetail -> attachFileService.getFileAttachList -> fileList : "+fileList);
		log.info("emailDetail -> mailLabelService.getLabelList -> mailLabelList : "+mailLabelList);
		
		return "mail/mailSend";
	}
	
	@PostMapping("/delete")
	@ResponseBody
	public String mailDelete(@RequestParam(value = "emailNoList") List<String> emailNoList) {
		for(String emailNo : emailNoList) {
			log.info("mailDelete -> emailNo : "+emailNo);
		}
		int result = mailService.mailDelete(emailNoList);
		return "/mail";
	}
	@PostMapping("/realDelete")
	@ResponseBody
	public String mailRealDelete(@RequestParam(value = "emailNoList") List<String> emailNoList) {
		for(String emailNo : emailNoList) {
			log.info("realDelete -> emailNo : "+emailNo);
		}
		int result = mailService.mailRealDelete(emailNoList);
		return "/mail";
	}
	@PostMapping("/restoration")
	@ResponseBody
	public String restoration(@RequestParam(value = "checkedList")List<String>checkedList) {
		log.info("restoration -> checkedList : "+checkedList);
		List<MailVO> mailVOList = mailService.emailDetails(checkedList);
		log.info("restoration -> emailDetails ->  mailVOList : "+mailVOList);
		int result = mailService.restoration(mailVOList);
		return "";
	}
	
	@PostMapping("/mailLblAdd")
	public String mailLblAdd(@ModelAttribute MailLabelVO labelVO, @AuthenticationPrincipal CustomUser customUser) {
		EmployeeVO employeeVO = customUser.getEmpVO(); 
		labelVO.setEmplNo(employeeVO.getEmplNo()); 
		log.info("mailLblAdd -> labelVO : "+labelVO);
		mailLabelService.mailLblAdd(labelVO);
		return "redirect:/mail";
	}
	@PostMapping("/starred")
	@ResponseBody
	public String mailStarred(@RequestParam(value = "emailNo") int emailNo,
								@RequestParam(value = "starred") String starred){
		log.info("mailStarred -> emailNo : "+emailNo);
		log.info("mailStarred -> starred : "+starred);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("emailNo", emailNo);
		map.put("starred", starred);
		int result = mailService.mailStarred(map);
		return "success";
	}
	
	@PostMapping("/deleteLbl")
	@ResponseBody
	public String deleteLbl(@RequestParam(value = "lblNo") int lblNo) {
		log.info("deleteLbl -> lblNo : "+lblNo);
		int result = mailService.delLblFromMail(lblNo);
		result += mailLabelService.deleteLbl(lblNo);
		return "success";
	}
	
	@PostMapping("/labelingUpt")
	@ResponseBody
	public String labelingUpt(@RequestParam(value = "lblNo")int lblNo,
							  @RequestParam(value = "checkedList")List<String>checkedList) {
		log.info("labelingUpt -> lblNo : "+lblNo);
		log.info("labelingUpt -> checkedList : "+checkedList);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("lblNo", lblNo);
		map.put("checkedList", checkedList);
		int result = mailService.labelingUpt(map);
		String col = "";
		if(lblNo != 0) {
			col = mailLabelService.getCol(lblNo);
		}
		return col;
	}
	
	@ResponseBody
	@PostMapping("/upload")
	public Map<String, Object> ckEditorImageUpload(MultipartHttpServletRequest request) throws Exception {
		log.info("ckEditor 이미지 업로드 실행");
		MultipartFile uploadFile = request.getFile("upload");
		log.info("ckEditorImageUpload -> uploadFile : " + uploadFile);
		
		// 파일의 오리지널 네임
		String originalFileName = uploadFile.getOriginalFilename();
      	log.info("image->originalFile : "+originalFileName);
      	
      	// 파일의 확장자
	    String ext = originalFileName.substring(originalFileName.indexOf("."));
	    log.info("image->ext : " + ext);
	    
	    // 서버에 저장될 때 중복된 파일 이름인 경우를 방지하기 위해 UUID에 확장자를 붙여 새로운 파일 이름을 생성
	    String newFileName = UUID.randomUUID() + ext;
	    log.info("newFileName : "+newFileName);
	    // 이미지를 현재 경로와 연관된 파일에 저장하기 위해 현재 경로를 알아냄
	    String url = request.getRequestURL().toString();
	    log.info("image -> url : " + url);
	    url = url.substring(0,url.indexOf("/",7));
	    
	    
	    String savePath = saveDir + "mail/" +newFileName;
	    String uploadPath = "/upload/mail/" + newFileName;
	    log.info("image -> uploadPath : " + uploadPath);
	    log.info("image -> savePath : " + savePath);
	    
	    // 저장 경로로 파일 객체 생성
	    File file = new File(savePath);
	    
	    // 파일 업로드
	    uploadFile.transferTo(file);
	    
	    // 파일 업로드 완료 후 base64이미지 처리
	    String base64Img = imageToBase64(savePath);
	    
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("uploaded", true);
		map.put("url", url + uploadPath);
		log.info("image -> map : "+map);
		return map;
	}
	
	public String imageToBase64(String savePath) throws Exception {
        String base64Img = "";
        
        log.info("imageToBase64->savePath : " + savePath);
        
        File f = new File(savePath);
        if (f.exists() && f.isFile() && f.length() > 0) {
              byte[] bt = new byte[(int) f.length()];
              try (FileInputStream fis = new FileInputStream(f)) {
                  fis.read(bt);
                  /*
                  자바 21 이상 버젼에서는 기본 api로 해결 가능해서 지금 문법에서 오류난다고합니다! 
                  외부라이브러리 base64로 안끌어와도된다고합니다 
                   */
                  // Using java.util.Base64
                  base64Img = Base64.getEncoder().encodeToString(bt);
                  System.out.println("Base64 Encoded Image: " + base64Img);
              } catch (Exception e) {
                  e.printStackTrace();
              }
          }

        return base64Img;
     }
}
