package kr.or.ddit.sevenfs.controller.bbs;

import java.io.File;
import java.io.FileInputStream;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.bbs.BbsService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.utils.AttachFile;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.bbs.BbsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/bbs")
public class BbsController {
	@Value("${file.save.abs.path}")
	private String saveDir;
	
	@Autowired
	AttachFileService attachFileService;
	
	@Autowired
    BbsService bbsService;
	
	@Autowired
	AttachFile attachFile;
	
	
    @GetMapping("/bbs")
    public String bbs() {
    	
    	return "bbs/bbs";
    }
    
    @GetMapping("/bbsList")
    public String bbsList(Model model, BbsVO bbsVO,
    		@RequestParam(defaultValue = "1") int total,
			@RequestParam(defaultValue = "1") int currentPage, 
			@RequestParam(defaultValue = "5") int size) {
    	
    	ArticlePage<AttachFileVO> articlePage = new ArticlePage<>(total, currentPage, size);
    	
    	List<AttachFileVO> fileAttachList = attachFileService.getFileAttachList(1);

		model.addAttribute("fileAttachList", fileAttachList);

		AttachFileVO attachFileVO = new AttachFileVO();
		attachFileVO.setFileNm("파일이름");
		attachFileVO.setFileExtsn("파일확장자");
		attachFileVO.setFileStreNm("저장이름");
		articlePage.setSearchVo(attachFileVO);

		articlePage.setTotal(total);
		articlePage.setCurrentPage(currentPage);

		log.info("페이지" + articlePage);

		model.addAttribute("articlePage", articlePage);
    	
    	List<BbsVO> bbsList = bbsService.bbsList(articlePage);
    	log.info("리스트 출력 : " + bbsList);
    	
    	model.addAttribute("bbsList", bbsList);
    	
    	return "bbs/bbsList";
    }
    
    
    /**
     * 게시글 작성 폼
     */
    @GetMapping("/bbsInsert")
    public String bbsInsertForm() {
        return "bbs/bbsInsert";
    }

    /**
     * 게시글 작성 처리
     */
    @PostMapping("/bbsInsert")
    public String bbsInsert(@ModelAttribute BbsVO bbsVO, Model model, MultipartFile[] uploadFile, @RequestParam("uploadFile") MultipartFile file) {
        log.info("게시글 등록 요청");

        long attachFileNm = attachFileService.insertFileList("insertFile", uploadFile);
        bbsVO.setAtchFileNo(attachFileNm);
        
        // 게시글 저장
        int result = bbsService.bbsInsert(bbsVO);
        int bbsSn = bbsVO.getBbsSn(); // INSERT 후 bbsSn 가져오기
        log.info("게시글 등록 결과 -> " + result);
        log.info("생성된 게시글 ID: " + bbsSn);

        if (bbsSn == 0) {
            log.error("게시글 ID(bbsSn)가 0입니다. INSERT 후에도 값이 설정되지 않았습니다.");
            return "redirect:/bbs/bbsList"; // 파일 업로드 진행하지 않음
        }
        
        String fileName = file.getOriginalFilename();
        log.info("파일이름 : " + fileName);
        
        
        
        return "redirect:/bbs/bbsList";
    }


    /**
     * 게시글 상세 조회
     */
    @GetMapping("/bbsDetail")
    public String bbsDetail(Model model, @RequestParam("bbsSn") int bbsSn) {
        log.info("게시글 상세 조회: " + bbsSn);

		
        BbsVO bbsVO = bbsService.bbsDetail(bbsSn);
        List<AttachFileVO> FileList = attachFileService.getFileAttachList(bbsVO.getAtchFileNo());
        model.addAttribute("bbsVO", bbsVO);
        model.addAttribute("fileList", FileList);

        return "bbs/bbsDetail";
    }

    /**
     * 게시글 수정 폼
     */
    @GetMapping("/bbsUpdate")
    public String bbsUpdateForm(Model model, @RequestParam("bbsSn") int bbsSn) {
        log.info("게시글 수정 폼: " + bbsSn);

        BbsVO bbsVO = bbsService.bbsDetail(bbsSn);
        model.addAttribute("bbsVO", bbsVO);

        return "bbs/bbsUpdate";
    }

    /**
     * 게시글 수정 처리
     */
    @PostMapping("/bbsUpdate")
    public String bbsUpdate(@ModelAttribute BbsVO bbsVO, MultipartFile[] uploadFile, AttachFileVO attachFileVO) {
        log.info("게시글 수정 요청: " + bbsVO);
        
        long attachFileNm = attachFileService.updateFileList("updateFile", uploadFile, attachFileVO);
        bbsVO.setAtchFileNo(attachFileNm);
        
        int bbsSn = bbsVO.getBbsSn(); // update 후 bbsSn 가져오기
        log.info("생성된 게시글 ID: " + bbsSn);
        
        log.info("파일이름" + attachFileNm);

        int update = bbsService.bbsUpdate(bbsVO);
        log.info("업데이트 : " + update);
        
        return "redirect:/bbs/bbsDetail?bbsSn=" + bbsVO.getBbsSn();
    }

    
    
 // CKEditor 이미지 업로드
	   // HttpServletRequest request : 파일업로드가 없을 때
	   // MultipartHttpServletRequest : 파일업로드가 있을 때
	   @ResponseBody
	   @PostMapping("/upload")
	   public Map<String, Object> image(MultipartHttpServletRequest request) throws Exception {
	      // ckeditor는 이미지 업로드 후 이미지 표시하기 위해 uploaded 와 url을 json 형식으로 받아야 함
	      // modelandview를 사용하여 json 형식으로 보내기위해 모델앤뷰 생성자 매개변수로 jsonView 라고 써줌
	      // jsonView 라고 쓴다고 무조건 json 형식으로 가는건 아니고 @Configuration 어노테이션을 단
	      // WebConfig 파일에 MappingJackson2JsonView 객체를 리턴하는 jsonView 매서드를 만들어서 bean으로 등록해야
	      // 함
	      log.info("씨케이에디터");
//	      ModelAndView mav = new ModelAndView("jsonView");   //=> 지금은 필요없는듯
	      
	      // ckeditor 에서 파일을 보낼 때 upload : [파일] 형식으로 해서 넘어오기 때문에 upload라는 키의 밸류를 받아서
	      // request{upload=파일객체}
	      // uploadFile에 저장함
	      MultipartFile uploadFile = request.getFile("upload");
	      log.info("image->uploadFile : " + uploadFile);
	      
	      // 파일의 오리지널 네임
	      String originalFileName = uploadFile.getOriginalFilename();
	      log.info("image->originalFile : "+originalFileName);

	      // 파일의 확장자
	      String ext = originalFileName.substring(originalFileName.indexOf("."));
	      log.info("image->ext : " + ext);

	      // 서버에 저장될 때 중복된 파일 이름인 경우를 방지하기 위해 UUID에 확장자를 붙여 새로운 파일 이름을 생성
	      String newFileName = UUID.randomUUID() + ext;
	      
	      // 이미지를 현재 경로와 연관된 파일에 저장하기 위해 현재 경로를 알아냄
//	      String realPath = request.getServletContext().getRealPath("/");
	      String url = request.getRequestURL().toString();
	      log.info("image -> url : " + url);
	      // https://localhost
	      url = url.substring(0,url.indexOf("/",7));

	      // 현재경로/upload/파일명이 저장 경로
	      // D:\\springboot\\upload
	      String savePath = saveDir + "" +newFileName;
	      
	      // 브라우저에서 이미지 불러올 때 절대 경로로 불러오면 보안의 위험 있어 상대경로를 쓰거나
	      // 이미지 불러오는 jsp 또는 클래스 파일을 만들어
	      // 가져오는 식으로 우회해야 함
	      // 때문에 savePath와 별개로 상대 경로인 uploadPath 만들어줌
	      // FileConfig -> addResourceHandlers에서 설정한 대로
	      String uploadPath = "/upload/" + newFileName;
	      log.info("image -> uploadPath : " + uploadPath);
	      log.info("image -> savePath : " + savePath);
	      
	      // 저장 경로로 파일 객체 생성
	      File file = new File(savePath);
	      
	      // 파일 업로드
	      uploadFile.transferTo(file);
	      
	      // 파일 업로드 완료 후 base64이미지 처리
	      String base64Img = imageToBase64(savePath);
	      // uploaded, url 값을 modelandview를 통해 보냄
//	         mav.addObject("uploaded", true); // 업로드 완료
//	         mav.addObject("url", uploadPath); // 업로드 파일의 경로
	      
	      Map<String,Object> map = new HashMap<String,Object>();
	        map.put("uploaded", true);
	        // DB에 이미지 자체가 저장되므로 DB 용량을 많이 차지하게 됨.
	        //map.put("url", "data:image/jpeg;base64,"+base64Img);
	        
	      //url + uploadPath : http://localhost:8090 + /upload/asdfasdlk.jpg
	        //DB에 경로가 저장되므로 DB가 가벼워짐(추천!)
	        map.put("url", url + uploadPath);

	      // 1) <img src="/resources/upload/개동이.jpg">
//	         map.put("url", url + uploadPath);
	      // 2) <img src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABoHC...생략...">
	        log.info("image -> map : "+map);
	        
	      // map : {uploaded=true,
	      // url=/resources/upload/b8baefc3-34c0-44c8-af3b-4a9464a61e7c.jpg}
	        
	      return map;
	   }
    
	   
	   /**
	       * 이미지를 Base64로 변환하기 서버에 저장되어있는 이미지를 웹화면에 뿌려주어야할 때 base64로 변환하여 표현하는 방법을 사용한다
	       * <img src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABoHC...생략..."> 이 값을
	       * 만들기 위해 필요한 로직을 알아보자 가. Parameter : 1. 파일의 경로 filePath, 2. 파일명 fileName 나.
	       * Return : 1. base64 문자열 base64Img
	       * 
	       * @throws Exception
	       */
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
