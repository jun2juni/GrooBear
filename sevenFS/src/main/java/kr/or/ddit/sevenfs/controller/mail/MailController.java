package kr.or.ddit.sevenfs.controller.mail;

import java.io.File;
import java.io.FileInputStream;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import kr.or.ddit.sevenfs.service.mail.MailService;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.vo.mail.MailVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/mail")
public class MailController {
	
	@Value("${file.save.abs.path}")
	private String saveDir;
	
	@Autowired
	MailService mailService;
	
	@Autowired
	OrganizationService organizationService;
	
	@Autowired
	AttachFileService attachFileService;

	@GetMapping("")
	public String mailHome(Model model) {
		model.addAttribute("title","메일함");
		return "mail/mailHome";
	}
	
	@GetMapping("/mailSend")
	public String mailSend(Model model) {
		model.addAttribute("title","메일함");
		return "mail/mailSend";
	}
	
	@PostMapping("/selEmail")
	@ResponseBody
	public Map<String,String> selEmail(@RequestBody EmployeeVO employeeVO) {
		log.info("selEmail -> employeeVO : "+employeeVO);
		employeeVO = organizationService.emplDetail(employeeVO.getEmplNo());
		String email = employeeVO.getEmail();
		String emplNm = employeeVO.getEmplNm();
		log.info("selEmail -> emplDetail -> email : "+email);
		log.info("selEmail -> emplDetail -> emplNm : "+emplNm);
		Map<String,String> map = new HashMap<>();
		map.put("email", email);
		map.put("emplNm", emplNm);
		return map;
	}
	@PostMapping("/sendMail")
	@ResponseBody
	public String sendEmail(@ModelAttribute MailVO mailVO,
							@RequestParam(value = "uploadFile",required = false) MultipartFile[] uploadFile) {
		log.info("sendEmail");
		log.info("sendEmail -> mailVO : " + mailVO);
		log.info("sendEmail -> uploadFile : " + uploadFile);
		for(MultipartFile file : uploadFile) {
			log.info(file.getOriginalFilename());
		}
//		attachFileService.insertFile("test", uploadFile);
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
