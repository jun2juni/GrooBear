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
	// bum bum be-dum bum bum be-dum bum
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
			@RequestParam(defaultValue = "1", required = false) String emailClTy) {
		EmployeeVO employeeVO = customUser.getEmpVO();
		mailVO.setEmailClTy(emailClTy);
		mailVO.setEmplNo(employeeVO.getEmplNo());
		log.info("CustomUser -> employeeVO" + employeeVO);
		log.info("mailHome -> MailVO -> 검색을 위함 : " + mailVO);
		log.info("mailHome -> MailVO -> 페이지 : " + currentPage);
		log.info("mailHome -> MailVO -> 메일함 : " + emailClTy);
		model.addAttribute("title","메일함");
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
		
		List<MailLabelVO> mailLabelList = mailLabelService.getLabelList(employeeVO);
		log.info("mailHome -> getLabelList(employeeVO) -> mailVOList" + mailLabelList);
		
		model.addAttribute("mailVOList",mailVOList);
		model.addAttribute("articlePage", articlePage);
		model.addAttribute("searchVO", mailVO);
		model.addAttribute("emplNo", employeeVO.getEmplNo());
		model.addAttribute("mailLabelList", mailLabelList);
		
		return "mail/mailHome";
	}
	
	@GetMapping("/emailDetail")
	public String emailDetail(Model model ,@RequestParam(value = "emailNo") int emailNo, String fileName) {
		log.info("emailDetail -> emailNo : "+emailNo);
		MailVO mailVO = new MailVO(emailNo);
		log.info("emailDetail -> mailVO : "+mailVO);
		mailVO = mailService.emailDetail(mailVO);
		log.info("emailDetail -> mailService.emailDetail -> mailVO : "+mailVO);
		List<AttachFileVO> attachFileVOList = mailService.getAtchFile(mailVO.getAtchFileNo());
		attachFileService.downloadFile(fileName);
		model.addAttribute("mailVO",mailVO);
		model.addAttribute("attachFileVOList",attachFileVOList);
		return "mail/mailDetailLayout";
	}
	
	@GetMapping("/mailSend")
	public String mailSend(Model model, @RequestParam(value = "emplNm",required = false) String emplNm,
										@RequestParam(value = "email",required = false) String email,
										@AuthenticationPrincipal CustomUser customUser) {
		EmployeeVO employeeVO = customUser.getEmpVO();
		model.addAttribute("title","메일함");
		model.addAttribute("emplNo",employeeVO.getEmplNo());
		model.addAttribute("emplNm",emplNm);
		model.addAttribute("email",email);
		log.info("mailSend get요청 -> emplNm : "+emplNm);
		log.info("mailSend get요청 -> email : "+email);
		return "mail/mailSend";
	}
	@GetMapping("/mailRepl")
	public String mailRepl(@RequestParam(value = "emailNo") String emailNo) {
		log.info("mailRepl -> emailNo : "+emailNo);
		
		return"";
	}
	@GetMapping("/mailTrnsms")
	public String mailTrnsms(@RequestParam(value = "emailNo") String emailNo) {
		log.info("mailTrnsms -> emailNo : "+emailNo);
		
		return"";
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
	public String sendEmail(@ModelAttribute MailVO mailVO,
							@RequestParam(value = "uploadFile",required = false) MultipartFile[] uploadFile) {
		log.info("sendEmail");
		log.info("sendEmail -> mailVO : " + mailVO);
		if(uploadFile!=null) {
			log.info("sendEmail -> uploadFile : " + uploadFile);
			for(MultipartFile file : uploadFile) {
				log.info(file.getOriginalFilename());
			}
		}
		int result = mailService.sendMail(mailVO,uploadFile);
		return "mail";
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
	
	@PostMapping("/mailLblAdd")
	public String mailLblAdd(@ModelAttribute MailLabelVO labelVO) {
		log.info("mailLblAdd -> labelVO : "+labelVO);
		mailLabelService.mailLblAdd(labelVO);
		return "redirect:/mail";
	}
	@PostMapping("/starred")
	@ResponseBody
	public String mailStarred(@ModelAttribute MailVO mailVO){
		log.info("mailStarred -> mailVO : "+mailVO);
		return "success";
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
