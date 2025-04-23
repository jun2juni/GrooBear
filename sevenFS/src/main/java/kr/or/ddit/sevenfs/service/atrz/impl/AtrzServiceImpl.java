package kr.or.ddit.sevenfs.service.atrz.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.sevenfs.mapper.atrz.AtrzMapper;
import kr.or.ddit.sevenfs.service.atrz.AtrzService;
import kr.or.ddit.sevenfs.service.notification.NotificationService;
import kr.or.ddit.sevenfs.service.organization.DclztypeService;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.utils.CommonCode;
import kr.or.ddit.sevenfs.vo.atrz.AtrzLineVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.BankAccountVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;
import kr.or.ddit.sevenfs.vo.atrz.HolidayVO;
import kr.or.ddit.sevenfs.vo.atrz.SalaryVO;
import kr.or.ddit.sevenfs.vo.atrz.SpendingVO;
import kr.or.ddit.sevenfs.vo.notification.NotificationVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import kr.or.ddit.sevenfs.vo.organization.VacationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AtrzServiceImpl implements AtrzService {
	
	@Autowired
	AtrzMapper atrzMapper;
	
	// 사원 정보를 위해 가져온것
	@Autowired
	private OrganizationService organizationService;
	
	@Autowired
	private DclztypeService dclztypeService;
	
	//알림을 위한
	@Autowired
	private NotificationService notificationService;
	
	// home 결재대기문서목록
	@Override
	public List<AtrzVO> homeAtrzApprovalList(String emplNo) {
		List<AtrzVO> homeAtrzApprovalList = atrzMapper.homeAtrzApprovalList(emplNo);
		return homeAtrzApprovalList;
	}
	
	
	//결재 대기중인 문서리스트
	@Override
	public List<AtrzVO> atrzApprovalList(Map<String,Object> map) {
		List<AtrzVO> atrzApprovalList = atrzMapper.atrzApprovalList(map);
		return atrzApprovalList;
	}
	//기안진행문서 최신순 5개
	@Override
	public List<AtrzVO> atrzMinSubmitList(String emplNo) {
		List<AtrzVO> atrzMinSubmitList = atrzMapper.atrzMinSubmitList(emplNo);
		return atrzMinSubmitList;
	}
	
	//기안완료문서 최신순 5개
	@Override
	public List<AtrzVO> atrzMinCompltedList(String emplNo) {
		List<AtrzVO> atrzMinCompltedList = atrzMapper.atrzMinCompltedList(emplNo);
		return atrzMinCompltedList;
	}
	
	//기안중인 문서리스트
	@Override
	public List<AtrzVO> atrzSubmitList(String emplNo) {
		List<AtrzVO> atrzSubmitList = atrzMapper.atrzSubmitList(emplNo);
		return atrzSubmitList;
	}
	//기안완료된 문서리스트
	@Override
	public List<AtrzVO> atrzCompletedList(String emplNo) {
		List<AtrzVO> atrzCompletedList = atrzMapper.atrzCompletedList(emplNo);
		return atrzCompletedList;
	}
	
	//참조대기문서
	@Override
	public List<AtrzVO> atrzReferList(String emplNo) {
		List<AtrzVO> atrzReferList = atrzMapper.atrzReferList(emplNo);
		return atrzReferList;
	}
	//결재예정문서
	@Override
	public List<AtrzVO> atrzExpectedList(String emplNo) {
		List<AtrzVO> atrzExpectedList = atrzMapper.atrzExpectedList(emplNo);
		return atrzExpectedList;
	}
	
	//결재완료 문서함
	@Override
	public List<AtrzVO> atrzCompleteList(String emplNo) {
		List<AtrzVO> atrzCompleteList = atrzMapper.atrzCompleteList(emplNo);
		return atrzCompleteList;
	}
	
	//기안문서함
	@Override
	public List<AtrzVO> atrzAllSubmitList(String emplNo) {
		List<AtrzVO> atrzAllSubmitList = atrzMapper.atrzAllSubmitList(emplNo);
		return atrzAllSubmitList;
	}
	
	//임시저장 문서리스트
	@Override
	public List<AtrzVO> atrzStorageList(String emplNo) {
		List<AtrzVO> atrzStorageList = atrzMapper.atrzStorageList(emplNo);
		return atrzStorageList;
	}
	
	//결재문서함
	@Override
	public List<AtrzVO> atrzAllApprovalList(String emplNo) {
		List<AtrzVO> atrzAllApprovalList = atrzMapper.atrzAllApprovalList(emplNo);
		return atrzAllApprovalList;
		
	}
	
	//반려문서함
	@Override
	public List<AtrzVO> atrzCompanionList(String emplNo) {
		List<AtrzVO> atrzCompanionList = atrzMapper.atrzCompanionList(emplNo);
		return atrzCompanionList;
	}
	
	
	//전자결재테이블 등록
	@Override
	public int insertAtrz(AtrzVO atrzVO) {
		int result = this.atrzMapper.insertAtrz(atrzVO);
		//atrzVO에는 전자결재 문서 번호가 생성되어있음
		
		//2) 결재선들 등록
		List<AtrzLineVO> atrzLineVOList = atrzVO.getAtrzLineVOList();
		log.info("insertAtrzLine->atrzLineVOList(문서번호 생성 후) : " + atrzLineVOList);
		
		for (AtrzLineVO atrzLineVO : atrzLineVOList) {
			atrzLineVO.setAtrzDocNo(atrzVO.getAtrzDocNo());
			
			result += this.atrzMapper.insertAtrzLine(atrzLineVO);
		}
		
		return result;
	}
	//전자결재선 등록
	@Override
	public int insertAtrzLine(AtrzLineVO atrzLineVO) {
		return this.atrzMapper.insertAtrzLine(atrzLineVO);
	}
	
	@Transactional
	@Override
	public void deleteAtrzWriting(String atrzDocNo) {
		atrzMapper.deleteAtrzLineWriting(atrzDocNo);
		atrzMapper.deleteAtrzWriting(atrzDocNo);
	}
	
	
	
	//연차신청서 등록
	@Transactional
	@Override
	public int insertHoliday(HolidayVO documHolidayVO) {
		//알림 vo생성
		//알림에 넣을 정보를 셋팅해주기 위한 공간을 만든다.
		NotificationVO notificationVO = new NotificationVO();
		//여기서 제목 내용을 셋팅해줘야하는데 
		String atrzDocNo = documHolidayVO.getAtrzDocNo();
		log.info("insertHoliday->atrzDocNo :"+atrzDocNo);
		 
		//사번 리스트를 만들기 위한 List
		List<String> sanctnerEmpNoList = new ArrayList<>();
		String sanctnerEmpNo= "";
		// Step 1: 결재자들 중에서 가장 작은 순번 찾기
		int firstSanctnerSn = Integer.MAX_VALUE;
		
		AtrzVO atrzVO = atrzMapper.getAtrzStorage(atrzDocNo);
		List<AtrzLineVO> atrzLineVoList = atrzVO.getAtrzLineVOList();

		// Step 1: 결재자 중 가장 작은 순번 찾기
		for (AtrzLineVO atrzLineVO : atrzLineVoList) {
		    if ("1".equals(atrzLineVO.getAtrzTy()) && atrzLineVO.getAtrzLnSn() < firstSanctnerSn) {
		        firstSanctnerSn = atrzLineVO.getAtrzLnSn();
		    }
		}
		// Step 2: 그 순번을 가진 결재자만 추가
		for (AtrzLineVO atrzLineVO : atrzLineVoList) {
		    if ("1".equals(atrzLineVO.getAtrzTy()) && atrzLineVO.getAtrzLnSn() == firstSanctnerSn) {
		        sanctnerEmpNoList.add(atrzLineVO.getSanctnerEmpno());
		    }
		}
		
		//배열로 변환
		String[] sanctnerEmpNoArr =sanctnerEmpNoList.toArray(new String[0]);
		log.info("insertHoliday->sanctnerEmpNoArr :"+ Arrays.toString(sanctnerEmpNoArr));
		log.info("insertHoliday->atrzVO :"+atrzVO);
		
		
		//originPath 기능별 NO =? /board/detail?boardNo=1
		//skillCode  전자결재 코드 넘버
		//알림 받아야할 사원의 정보를 리스트로 받아서 넘겨준다.
		
		//넘버를 vo에 담아서 넣어준다.
		List<EmployeeVO> employeeVOList = new ArrayList<>();
		for(String empNo : sanctnerEmpNoArr) {
			EmployeeVO employeeVO = new EmployeeVO();
			employeeVO.setEmplNo(empNo);
			employeeVOList.add(employeeVO);
		}
		
		//알림 제목을 셋팅해준다 ntcnSj 제목
		//허성진씨 줄바꿈이 안먹히자나~~~~~
		notificationVO.setNtcnSj("[전자결재 알림]");
		//알림 내용을 셋팅해준다 ntcnCn	내용
		notificationVO.setNtcnCn(atrzVO.getDrafterEmpnm() +" 님이 결재기안을 요청하였습니다.");
		notificationVO.setOriginPath("/atrz/selectForm/atrzDetail?atrzDocNo="+atrzVO.getAtrzDocNo());
		notificationVO.setSkillCode("02");
		
		// 알림을 보낼 사번을 배열로 담아준다.
		notificationService.insertNotification(notificationVO, employeeVOList);
		return this.atrzMapper.insertHoliday(documHolidayVO);
	}
	
	//연차신청서 임시저장
	@Override
	@Transactional
	public int atrzHolidayStorage(AtrzVO atrzVO, List<AtrzLineVO> atrzLineList, HolidayVO documHolidayVO) {
		log.info("atrzHolidayStorage->임시저장 : "+atrzVO);
		
		 // 1. 날짜 합치기
	    try {
	        String holiStartStr = String.join(" ", documHolidayVO.getHoliStartArr()) + ":00";
	        String holiEndStr = String.join(" ", documHolidayVO.getHoliEndArr()) + ":00";

	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        documHolidayVO.setHoliStart(sdf.parse(holiStartStr));
	        documHolidayVO.setHoliEnd(sdf.parse(holiEndStr));
	    } catch (ParseException e) {
	        throw new RuntimeException("날짜 파싱 실패", e);
	    }
	    // 2. ATRZ 테이블 임시저장 상태로 업데이트 (예: sanctnProgrsSttusCode = '00')
	    atrzVO.setSanctnProgrsSttusCode("99"); // 임시저장 상태
	    
	    int updateCount=  atrzMapper.storageHolidayUpdate(atrzVO);
	    
	    // 3.ATRZ테이블에 insert처리
	    if(updateCount==0) {
	    	atrzMapper.atrzHolidayStorage(atrzVO);
	    }
	    
	    // 4. 연차 신청서 테이블에도 등록 (임시)
	    documHolidayVO.setAtrzDocNo(atrzVO.getAtrzDocNo());
	    atrzMapper.insertOrUpdateHoliday(documHolidayVO); // insert/update 구분해서
	    
	    
	    //결재선은 기본의 것을 삭제후 새로 저장하는 방식 권장(중복방지)
	    //여기서 새로 결재선 선택시 다시 업데이트 해줘야함
	    atrzMapper.deleteAtrzLineByDocNo(atrzVO.getAtrzDocNo()); // 새로 추가할 것
	    // 4. 결재선 정보도 같이 저장
	    for (AtrzLineVO atrzLineVO : atrzLineList) {
	    	atrzLineVO.setAtrzDocNo(atrzVO.getAtrzDocNo());
	    	atrzLineVO.setSanctnProgrsSttusCode("00"); // 대기중
	        atrzMapper.insertAtrzLine(atrzLineVO); // insert 로직
	    }
	    
	    // 연차정보 등록
	    log.info("atrzHolidayStorage->임시저장 완료 문서번호 : "+atrzVO.getAtrzDocNo());
		
	    return 1;  //성공여부 반환
	}

	
	
	
	//지출결의서 등록
	@Override
	public int insertSpending(SpendingVO spendingVO) {
		return this.atrzMapper.insertSpending(spendingVO);
	}
	//급여명세서 등록
	@Override
	public int insertSalary(SalaryVO salaryVO) {
		return this.atrzMapper.insertSalary(salaryVO);
	}
	//급여계좌변경신청서 등록
	@Override
	public int insertBankAccount(BankAccountVO bankAccountVO) {
		return this.atrzMapper.insertBankAccount(bankAccountVO);
	}
	
	//기안서 등록 
	@Override
	public int insertDraft(DraftVO draftVO) {
		return this.atrzMapper.insertDraft(draftVO);
	}
	
	//전자결재 상세보기
	@Override
	public AtrzVO getAtrzDetail(String atrzDocNo) {
		AtrzVO atrzVO = atrzMapper.selectAtrzDetail(atrzDocNo);
        if (atrzVO != null) {
            atrzVO.setAtrzLineVOList(atrzMapper.selectAtrzLineList(atrzDocNo));
        }
        return atrzVO;
	}
	
	//2) 결재선지정 후에 제목, 내용, 등록일자, 상태 update
	@Override
	public int insertUpdateAtrz(AtrzVO atrzVO) {
		return this.atrzMapper.insertUpdateAtrz(atrzVO);
	}
	//연차신청서 상세보기
	@Override
	public HolidayVO holidayDetail(String atrzDocNo) {
		return this.atrzMapper.holidayDetail(atrzDocNo);
	}
	
	//전자결재 상세 업데이트(승인시)
	@Transactional
	@Override
	public int atrzDetailAppUpdate(AtrzVO atrzVO) {
		String atrzDocNo = atrzVO.getAtrzDocNo();
		
		AtrzVO atrzVOApp = atrzMapper.selectAtrzDetail(atrzDocNo);
		
		String emplNo = atrzVO.getEmplNo();
		String atrzOption = atrzVO.getAtrzOpinion();
		log.info("atrzDetailAppUpdate->atrzVOApp : "+atrzVOApp);
		List<AtrzLineVO> atrzLineVOList = atrzVO.getAtrzLineVOList(); 
		/*
		atrzDetailAppUpdate->atrzVOApp : AtrzVO(atrzDocNo=H_20250421_00018, drafterEmpno=20250029, drafterClsf=05, drafterEmpnm=김계란
		, drafterDept=62, bkmkYn=N, atchFileNo=0, atrzSj=결재자인경우에만 알림 확인, atrzCn=결재자인경우에만 알림 확인
		, atrzOpinion=null, atrzTmprStreDt=null, atrzDrftDt=Mon Apr 21 12:39:20 KST 2025, atrzComptDt=null
		, atrzRtrvlDt=null, atrzSttusCode=00, eltsgnImage=null, docFormNo=1, atrzDeleteYn=N, schdulRegYn=null
		, docFormNm=null, emplNoArr=null, emplNo=null, emplNm=null, clsfCode=null, clsfCodeNm=null, deptCode=null
		, deptCodeNm=null, authorize=null, uploadFile=null, atrzLineVOList=[AtrzLineVO(atrzDocNo=H_20250421_00018
		, atrzLnSn=0, sanctnerEmpno=null, sanctnerClsfCode=null, contdEmpno=null, contdClsfCode=null, dcrbManEmpno=null
		, dcrbManClsfCode=null, atrzTy=null, sanctnProgrsSttusCode=null, dcrbAuthorYn=null, contdAuthorYn=null, sanctnOpinion=null
		, eltsgnImage=null, sanctnConfmDt=null, atrzLastLnSn=0, atrzLineList=null, sanctnerClsfNm=null, sanctnerEmpNm=null
		, befSanctnerEmpno=null, befSanctnProgrsSttusCode=null, aftSanctnerEmpno=null, aftSanctnProgrsSttusCode=null, maxAtrzLnSn=0)]
		, holidayVO=null, spendingVO=null, salaryVO=null, bankAccountVO=null, draftVO=null, emplDetailList=null, authorStatus=null
		, sanctnProgrsSttusCode=null))
		
		
		atrzDetailAppUpdate->atrzVOApp : AtrzVO(atrzDocNo=H_20250421_00001, drafterEmpno=20250004, drafterClsf=02, drafterEmpnm=길준희
		, drafterDept=91, bkmkYn=N, atchFileNo=0, atrzSj=연차신청서 알림 문구확인, atrzCn=연차신청서 알림 문구확인, atrzOpinion=null, atrzTmprStreDt=null
		, atrzDrftDt=Mon Apr 21 18:12:26 KST 2025, atrzComptDt=null, atrzRtrvlDt=null, atrzSttusCode=00, eltsgnImage=null, docFormNo=1
		, atrzDeleteYn=N, schdulRegYn=null, docFormNm=null, emplNoArr=null, emplNo=null, emplNm=null, clsfCode=null, clsfCodeNm=null
		, deptCode=null, deptCodeNm=null, authorize=null, uploadFile=null, atrzLineVOList=[AtrzLineVO(atrzDocNo=H_20250421_00001
		, atrzLnSn=0, sanctnerEmpno=null, sanctnerClsfCode=null, contdEmpno=null, contdClsfCode=null, dcrbManEmpno=null, dcrbManClsfCode=null
		, atrzTy=null, sanctnProgrsSttusCode=null, dcrbAuthorYn=null, contdAuthorYn=null, sanctnOpinion=null, eltsgnImage=null, sanctnConfmDt=null
		, atrzLastLnSn=0, atrzLineList=null, sanctnerClsfNm=null, sanctnerEmpNm=null, befSanctnerEmpno=null, befSanctnProgrsSttusCode=null
		, aftSanctnerEmpno=null, aftSanctnProgrsSttusCode=null, maxAtrzLnSn=0)], holidayVO=null, spendingVO=null, salaryVO=null
		, bankAccountVO=null, draftVO=null, emplDetailList=null, authorStatus=null, sanctnProgrsSttusCode=null)
		 */
		
		
		
		log.info("atrzDetailAppUpdate->atrzVO : "+atrzVO);
		log.info("atrzDetailAppUpdate->atrzDocNo : "+atrzDocNo);
		
		
		//현재 결재에서 결재한 사람 찾기

		//나의 전자결재선 상황(1행)
		AtrzLineVO emplAtrzLineInfo = this.atrzMapper.getAtrzLineInfo(atrzVO);
		atrzVO.setDrafterEmpno(atrzVOApp.getDrafterEmpno());
		/*
		 atrzDetailAppUpdate->emplAtrzLineInfo: AtrzLineVO(atrzDocNo=H_20250421_00021, atrzLnSn=3, sanctnerEmpno=20250025, sanctnerClsfCode=null
		 , contdEmpno=null, contdClsfCode=null, dcrbManEmpno=null, dcrbManClsfCode=null, atrzTy=null, sanctnProgrsSttusCode=00, dcrbAuthorYn=null
		 , contdAuthorYn=null, sanctnOpinion=null, eltsgnImage=null, sanctnConfmDt=null, atrzLastLnSn=0, atrzLineList=null, sanctnerClsfNm=null
		 , sanctnerEmpNm=null , befSanctnerEmpno=20250024, befSanctnProgrsSttusCode=10, aftSanctnerEmpno=20250001, aftSanctnProgrsSttusCode=00, maxAtrzLnSn=0)
		 */
		log.info("atrzDetailAppUpdate->emplAtrzLineInfo: "+emplAtrzLineInfo);
		// 다음 결재자의 사번 확인
		String nextEmpNo = emplAtrzLineInfo.getAftSanctnerEmpno();
		String sanctnSttusCode = emplAtrzLineInfo.getAftSanctnProgrsSttusCode();
		//나의 결재 순번 구하기
		int myStep = emplAtrzLineInfo.getAtrzLnSn();
		log.info("myStep = " + myStep + ", empNo = " + atrzVO.getEmplNo() + ", docNo = " + atrzVO.getAtrzDocNo());
		//H_20250411_00003 문서의 결재선 총 스탭수
		//0 : 마지막 결재자가 아님
		//0이 아닌 경우 : 마지막 결재자임
		int maxStep = atrzMapper.getMaxStep(atrzVO);
		log.info("atrzDetailAppUpdate-> maxStep : "+maxStep);
		log.info("atrzDetailAppUpdate-> 나의순번 : "+myStep + "최종순번 : "+maxStep);

		
		//I. ATRZ_LINE 결재 처리
		int result = atrzMapper.atrzDetailAppUpdate(atrzVO);
		//첫번째 결재자가 결재승인시 다음결재자에게 알림 보내기
		List<EmployeeVO> employeeVOList = new ArrayList<>();
		EmployeeVO employeeVO = new EmployeeVO();
		
		if(nextEmpNo != null && !"10".equals(sanctnSttusCode)) {
			employeeVO.setEmplNo(nextEmpNo);
		    employeeVOList.add(employeeVO);
		}
		//알림 보낼 것 구성
		NotificationVO notificationVO = new NotificationVO();
		notificationVO.setNtcnSj("[전자결재 알림]");
		AtrzVO notifiAtrzVO =atrzMapper.selectAtrzDetail(atrzVO.getAtrzDocNo());
		log.info("notificationVo-> notifiAtrzVO:"+notifiAtrzVO);
	    notificationVO.setNtcnCn(notifiAtrzVO.getDrafterEmpnm() + " 님이 결재기안을 요청하였습니다.");
	    notificationVO.setOriginPath("/atrz/selectForm/atrzDetail?atrzDocNo=" + atrzVO.getAtrzDocNo());
	    notificationVO.setSkillCode("02");
		
	    // 알림 전송
	    notificationService.insertNotification(notificationVO, employeeVOList);
	    
	    
		//1) maxStep : 마지막 결재자 순서번호
		//2) nextStep : 나 다음에 결재할 사람
		//3) meStep : 내 결재 순서번호
	    //지금여기서 진행이 안되는중 
	    
		//최종결재자인경우
		if(myStep==maxStep){
			//III. ATRZ의 완료 및 일시 처리
			atrzVO.setAtrzSttusCode("10");
			result += atrzMapper.atrzStatusFinalUpdate(atrzVO);
			//길주늬 여기서 시작해라
			 // 💡 결재 완료 → 근태 등록
	        HolidayVO holidayVO =  atrzMapper.selectHolidayByDocNo(atrzVOApp.getAtrzDocNo());
	        log.info("atrzDetailAppUpdate->holidayVO : "+holidayVO);
	        
			if(holidayVO!=null &&holidayVO.getAtrzVO() !=null) {
				String DrafterEmpNo = holidayVO.getAtrzVO().getDrafterEmpno(); //사원번호추출
				// 날짜 포맷 정의
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				// 날짜를 원하는 포맷의 문자열로 변환
				String dateStr = sdf.format(holidayVO.getHoliStart());
				
				DclzTypeVO dclzTypeVO = new DclzTypeVO();
				dclzTypeVO.setEmplNo(DrafterEmpNo);
				dclzTypeVO.setDclzNo(dateStr);   //여기에서 날짜만 20250416형태로 추출해서 넣어야 한다.
				dclzTypeVO.setDclzCode(holidayVO.getHoliCode());
				dclzTypeVO.setDclzBeginDt(holidayVO.getHoliStart());
				dclzTypeVO.setDclzEndDt(holidayVO.getHoliEnd());
				dclzTypeVO.setDclzReason(holidayVO.getAtrzVO().getAtrzCn());
				
				atrzMapper.holidayDclzUpdate(dclzTypeVO);
				log.info("atrzDetailAppUpdate->dclzTypeVO : "+dclzTypeVO);
				//연차신청서에서 연차 사용갯수를 가져온다.
				Double useDays = Double.parseDouble(holidayVO.getHoliUseDays());
				
				VacationVO vacationVO = new VacationVO();
				
				String draftEmpNo = holidayVO.getAtrzVO().getDrafterEmpno();
				log.info("draftEmpNo(기안자사원번호) :  "+draftEmpNo);
				vacationVO.setEmplNo(draftEmpNo);   //사원번호 추출 
				
				Double holiUseDays = Double.parseDouble(holidayVO.getHoliUseDays());
				log.info("holiUseDays(연차사용갯수) :  "+holiUseDays);
				vacationVO = atrzMapper.emplVacationCnt(draftEmpNo);
				log.info("vacationVO :  "+vacationVO);
				//사용가능 연차일수가져오기
				Double yrycUseDaycnt = vacationVO.getYrycUseDaycnt();
				log.info("holiUseDays(사용연차갯수) :  "+yrycUseDaycnt);
				//잔여갯수 가져오기
				Double yrycRemndrDaycnt = vacationVO.getYrycRemndrDaycnt();
				log.info("holiUseDays(잔여연차갯수) :  "+yrycRemndrDaycnt);
				vacationVO.setYrycUseDaycnt(yrycUseDaycnt+holiUseDays);   		//사용일수
				vacationVO.setYrycRemndrDaycnt(yrycRemndrDaycnt-holiUseDays);    //잔여일수
				log.info("vacationVO(셋팅후) :  "+vacationVO);
				
				// 연차 업데이트 처리
				atrzMapper.updateVacationUseDays(vacationVO);
				
				//최종결재자인경우 기안자에게 결재완료 알림전송
				EmployeeVO drafterVO = new EmployeeVO();
				drafterVO.setEmplNo(atrzVO.getDrafterEmpno());
				
				employeeVOList.add(drafterVO);
				//전자결재 유형별로 문구 변경하기 위한것
				String docNo = atrzVO.getAtrzDocNo();
				String docTypeNm = ""; // 문서 유형 이름
				
				if (docNo != null && !docNo.isEmpty()) {
				    char firstChar = docNo.charAt(0);

				    switch (firstChar) {
				        case 'H':
				            docTypeNm = "연차신청서";
				            break;
				        case 'S':
				            docTypeNm = "지출결의서";
				            break;
				        case 'D':
				            docTypeNm = "기안서";
				            break;
				        default:
				            docTypeNm = "전자결재 문서";
				            break;
				    }
				}

				// 알림 내용설정 
				NotificationVO notificationVOFinish = new NotificationVO();
				notificationVOFinish.setNtcnSj("[전자결재 알림]");
				notificationVOFinish.setNtcnCn(atrzVOApp.getDrafterEmpnm() +" 님 기안하신 " + docTypeNm +  " 가 최종 완료되었습니다.");
				notificationVOFinish.setOriginPath("/atrz/selectForm/atrzDetail?atrzDocNo=" + atrzVO.getAtrzDocNo());
				notificationVOFinish.setSkillCode("02");

				// 알림 전송
				notificationService.insertNotification(notificationVOFinish, employeeVOList);
			}
			
			//참조자의 경우에도 결재기안이 도착했다고 알림 표시해야한다.
			List<AtrzLineVO> atrzLineList =atrzMapper.selectAtrzLineList(atrzDocNo);
			log.info("atrzDetailAppUpdate->atrzLineList : "+atrzLineList);
			if(atrzLineList !=null && !atrzLineList.isEmpty()) {
				for(AtrzLineVO atrzLineVO : atrzLineList) {
					if(atrzLineVO.getBefSanctnerEmpno() !=null && "0".equals(atrzLineVO.getAtrzTy())) {
						//참조자인경우
						 EmployeeVO atrzTyEmp = new EmployeeVO();
						 atrzTyEmp.setEmplNo(atrzLineVO.getSanctnerEmpno());
						 
						 NotificationVO refNotification = new NotificationVO();
						 refNotification.setNtcnSj("[전자결재 알림]");
						 refNotification.setNtcnCn(atrzVOApp.getDrafterEmpnm() + " 님의 결재완료된 문서가 참조되었습니다.");
						 refNotification.setOriginPath("/atrz/selectForm/atrzDetail?atrzDocNo=" + atrzVO.getAtrzDocNo());
						 refNotification.setSkillCode("02");
						 
						 List<EmployeeVO> singleRefList = new ArrayList<>();
						 singleRefList.add(atrzTyEmp);
						 
						// 알림 전송
						notificationService.insertNotification(refNotification, employeeVOList);
					}
				}
			}
			
		}
		
		//여기서도 알림추가
		return result;
		
	}
	//전자결재 상세 업데이트(반려시)
	@Override
	public int atrzDetilCompUpdate(AtrzVO atrzVO) {
		/*
		 atrzDetilCompUpdate->atrzVO : AtrzVO(atrzDocNo=H_20250421_00003, drafterEmpno=null, drafterClsf=null, drafterEmpnm=null, drafterDept=null, bkmkYn=null, atchFileNo=0, atrzSj=null, atrzCn=null, atrzOpinion=null, atrzTmprStreDt=null, atrzDrftDt=null, atrzComptDt=null, atrzRtrvlDt=null, atrzSttusCode=null, eltsgnImage=null, docFormNo=0, atrzDeleteYn=null, schdulRegYn=null, docFormNm=null, emplNoArr=null, emplNo=20250025, emplNm=null, clsfCode=null, clsfCodeNm=null, deptCode=null, deptCodeNm=null, authorize=null, uploadFile=null, atrzLineVOList=[AtrzLineVO(atrzDocNo=null, atrzLnSn=0, sanctnerEmpno=null, sanctnerClsfCode=null, contdEmpno=null, contdClsfCode=null, dcrbManEmpno=null, dcrbManClsfCode=null, atrzTy=null, sanctnProgrsSttusCode=null, dcrbAuthorYn=null, contdAuthorYn=null, sanctnOpinion=반려알림 가나요?, eltsgnImage=null, sanctnConfmDt=null, atrzLastLnSn=0, atrzLineList=null, sanctnerClsfNm=null, sanctnerEmpNm=null, befSanctnerEmpno=null, befSanctnProgrsSttusCode=null, aftSanctnerEmpno=null, aftSanctnProgrsSttusCode=null, maxAtrzLnSn=0)], holidayVO=null, spendingVO=null, salaryVO=null, bankAccountVO=null, draftVO=null, emplDetailList=null, authorStatus=null, sanctnProgrsSttusCode=20)
		 */
		
		log.info("atrzDetilCompUpdate->atrzVO : "+atrzVO);
		
		//문서번호  
		String atrzDocNo = atrzVO.getAtrzDocNo();
		log.info("atrzDetilCompUpdate->atrzDocNo : "+atrzDocNo);
		//사원번호
		String emplNo = atrzVO.getEmplNo();
		//결재의견
		String atrzOption = atrzVO.getAtrzOpinion();
		
		
		//전자결재문서번호만 존재하기 때문에 상세 정보를 가져오기위한것
		AtrzVO atrzVOApp = atrzMapper.selectAtrzDetail(atrzDocNo);
		/*
		 atrzDetailAppUpdate-> atrzVOApp : AtrzVO(atrzDocNo=H_20250421_00003, drafterEmpno=20250004
		 , drafterClsf=02, drafterEmpnm=길준희, drafterDept=91, bkmkYn=N, atchFileNo=0, atrzSj=반려알림을 위한것
		 , atrzCn=반려알림을 위한것, atrzOpinion=null, atrzTmprStreDt=null, atrzDrftDt=Mon Apr 21 20:45:56 KST 2025
		 , atrzComptDt=null, atrzRtrvlDt=null, atrzSttusCode=00, eltsgnImage=null, docFormNo=1, atrzDeleteYn=N
		 , schdulRegYn=null, docFormNm=null, emplNoArr=null, emplNo=null, emplNm=null, clsfCode=null, clsfCodeNm=null
		 , deptCode=null, deptCodeNm=null, authorize=null, uploadFile=null, atrzLineVOList=[AtrzLineVO(atrzDocNo=H_20250421_00003
		 , atrzLnSn=0, sanctnerEmpno=null, sanctnerClsfCode=null, contdEmpno=null, contdClsfCode=null, dcrbManEmpno=null
		 , dcrbManClsfCode=null, atrzTy=null, sanctnProgrsSttusCode=null, dcrbAuthorYn=null, contdAuthorYn=null
		 , sanctnOpinion=null, eltsgnImage=null, sanctnConfmDt=null, atrzLastLnSn=0, atrzLineList=null, sanctnerClsfNm=null
		 , sanctnerEmpNm=null, befSanctnerEmpno=null, befSanctnProgrsSttusCode=null, aftSanctnerEmpno=null
		 , aftSanctnProgrsSttusCode=null, maxAtrzLnSn=0)], holidayVO=null, spendingVO=null, salaryVO=null
		 , bankAccountVO=null, draftVO=null, emplDetailList=null, authorStatus=null, sanctnProgrsSttusCode=null) 
		 */
		log.info("atrzDetailAppUpdate-> atrzVOApp : "+atrzVOApp);

//		//나의 전자결재선 상황(1행)
//		AtrzLineVO emplAtrzLineInfo = this.atrzMapper.getAtrzLineInfo(atrzVO);
//		log.info("atrzDetailAppUpdate-> emplAtrzLineInfo : "+emplAtrzLineInfo);
//		//H_20250411_00003 문서의 결재선 총 스탭수
//		//0 : 마지막 결재자가 아님
//		//0이 아닌 경우 : 마지막 결재자임
//		int maxStep = atrzMapper.getMaxStep(atrzVO);
//		log.info("atrzDetailAppUpdate-> maxStep : "+maxStep);

		//I. ATRZ_LINE 결재 처리
		int result = atrzMapper.atrzDetilCompUpdate(atrzVO);
		
		
		//반려시 기안자에게 반려확인 알림 
		EmployeeVO drafterVO = new EmployeeVO();
		drafterVO.setEmplNo(atrzVOApp.getDrafterEmpno());
		log.info("atrzDetailAppUpdate-> drafterVO : "+drafterVO);
		List<EmployeeVO> employeeVOList = new ArrayList<>();
		employeeVOList.add(drafterVO);
		/*
		 atrzDetailAppUpdate-> employeeVOList : [EmployeeVO(atchFileNo=0, anslry=0, telno=null
		 , retireDate=null, proflPhotoUrl=null, postNo=null, password=null, partclrMatter=null
		 , genderCode=null, genderCodeNm=null, enabled=null, emplSttusCode=null, emplNo=null
		 , emplNm=null, email=null, elctrnSignImageUrl=null, ecnyDate=null, detailAdres=null
		 , deptCode=null, deptCodeNm=null, contdEmpno=null, clsfCode=null, clsfCodeNm=null
		 , brthdy=null, bankNm=null, adres=null, acnutno=null, upperCmmnCode=null, deptNm=null
		 , posNm=null, empAuthVOList=null, notificationVOList=null, chatRoomVOList=null
		 , skillAuth=null)]
		  */
		log.info("atrzDetailAppUpdate-> employeeVOList : "+employeeVOList);
		

		//전자결재 유형별로 문구 변경하기 위한것
		String docNo = atrzVO.getAtrzDocNo();
		String docTypeNm = ""; // 문서 유형 이름
		
		if (docNo != null && !docNo.isEmpty()) {
		    char firstChar = docNo.charAt(0);

		    switch (firstChar) {
		        case 'H':
		            docTypeNm = "연차신청서";
		            break;
		        case 'S':
		            docTypeNm = "지출결의서";
		            break;
		        case 'D':
		            docTypeNm = "기안서";
		            break;
		        default:
		            docTypeNm = "전자결재 문서";
		            break;
		    }
		}
 
		atrzVOApp =  atrzMapper.selectAtrzDetail(atrzDocNo);
		
		// 알림 내용설정 
		NotificationVO notificationVOCompanion = new NotificationVO();
		notificationVOCompanion.setNtcnSj("[전자결재 알림]");
		notificationVOCompanion.setNtcnCn(atrzVOApp.getDrafterEmpnm() +" 님 기안하신 " + docTypeNm +  "가 반려되었습니다. (반려사유 : "+atrzVOApp.getAtrzOpinion()+")");
		notificationVOCompanion.setOriginPath("/atrz/selectForm/atrzDetail?atrzDocNo=" + atrzVO.getAtrzDocNo());
		notificationVOCompanion.setSkillCode("02");
		log.info("atrzDetailAppUpdate-> notificationVOFinish : "+notificationVOCompanion);

		// 알림 전송
		notificationService.insertNotification(notificationVOCompanion, employeeVOList);
		
		return 1;
	}
	
	//전자결재 기안취소
	@Override
	@Transactional    //오토커밋을 막는다.!(세트 중 하나라도 실패했을경우에 커밋을 하지않는다.)
	public int atrzCancelUpdate(AtrzVO atrzVO) {
		
		//문서번호  
		String atrzDocNo = atrzVO.getAtrzDocNo();
		//사원번호
		String emplNo = atrzVO.getEmplNo();
		
		log.info("atrzCancelUpdate->atrzVO : "+atrzVO);
		log.info("atrzCancelUpdate->atrzDocNo : "+atrzDocNo);
		List<AtrzLineVO> atrzLineVOList = atrzVO.getAtrzLineVOList(); 
		log.info("atrzCancelUpdate->atrzLineVOList : "+atrzLineVOList);
		String drafterEmpNo = atrzVO.getDrafterEmpno();
		int result = 0;
		//그 문서번호의 내가 기안자인경우에 삭제 로직이 활성화
		if(emplNo.equals(drafterEmpNo)) {
			result += atrzMapper.atrzLineCancelUpdate(atrzVO);
			result += atrzMapper.atrzCancelUpdate(atrzVO);
		}
		
		return result > 0 ? 1 : 0;
	}
	//연차신청서 임시저장후 get
	@Override
	public AtrzVO getAtrzStorage(String atrzDocNo) {
		AtrzVO atrzStorageVO = atrzMapper.getAtrzStorage(atrzDocNo);
//		if (atrzStorageVO == null || !"99".equals(atrzStorageVO.getAtrzSttusCode())) {
//			throw new IllegalArgumentException("임시저장된 문서가 아닙니다.");
//		}
		log.info("getAtrzStorage->atrzStorageVO : "+atrzStorageVO);
		List<AtrzLineVO> atrzStorageVOList = atrzStorageVO.getAtrzLineVOList();
		log.info("getAtrzStorage->atrzStorageVOList : "+atrzStorageVOList);
		
		atrzStorageVO.getAtrzLineVOList();
		for(AtrzLineVO atrzLineVO : atrzStorageVOList) {
			//결재자사번으로 이름 셋팅
			String sancterEmpNo = atrzLineVO.getSanctnerEmpno();
			EmployeeVO atrzStorageEmpDetail = organizationService.emplDetail(sancterEmpNo);
			atrzLineVO.setSanctnerEmpNm(atrzStorageEmpDetail.getEmplNm()); 
			
			//직급번호로 직급 셋팅
			String sanctClsfCd = atrzLineVO.getSanctnerClsfCode();
			String sanctClsfNm = CommonCode.PositionEnum.INTERN.getLabelByCode(sanctClsfCd);
			atrzLineVO.setSanctnerClsfNm(sanctClsfNm);
			
		}
	    //여기서 null임...
		
	    // 문서 폼별 서브 객체 추가
	    switch (atrzStorageVO.getAtrzDocNo().charAt(0)) {
	        case 'H' -> atrzStorageVO.setHolidayVO(atrzMapper.holidayDetail(atrzDocNo));
//	        case 'S' -> atrzVO.setSpendingVO(atrzMapper.spendingDetail(atrzDocNo));
	        case 'D' -> atrzStorageVO.setDraftVO(atrzMapper.draftDetail(atrzDocNo));
	        // 필요 시 다른 타입도 추가
	    }

	    return atrzStorageVO;
	}
	
	//임시저장후 연차신청서 인서트
	@Transactional
	@Override
	public void updateHoliday(AtrzVO atrzVO, List<AtrzLineVO> atrzLineList, HolidayVO documHolidayVO) throws Exception {
		
	    // 1. 사원 정보 보완
	    EmployeeVO emplDetail = organizationService.emplDetail(atrzVO.getEmplNo());
	    atrzVO.setClsfCode(emplDetail.getClsfCode());
	    atrzVO.setDeptCode(emplDetail.getDeptCode());
		
	    // 2. 연차 날짜 설정
	    String holiStartStr = documHolidayVO.getHoliStartArr()[0] + " " + documHolidayVO.getHoliStartArr()[1] + ":00";
	    String holiEndStr = documHolidayVO.getHoliEndArr()[0] + " " + documHolidayVO.getHoliEndArr()[1] + ":00";
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    documHolidayVO.setHoliStart(sdf.parse(holiStartStr));
	    documHolidayVO.setHoliEnd(sdf.parse(holiEndStr));
	    documHolidayVO.setAtrzDocNo(atrzVO.getAtrzDocNo());

	    // 3. 전자결재 테이블 업데이트
	    atrzMapper.updateHolidayAtrz(atrzVO); // 기존 insertUpdateAtrz 메서드 분리 권장

	    // 4. 연차 신청서 테이블 업데이트 (중복 여부 고려)
	    atrzMapper.updateOrInsertHoliday(documHolidayVO);

	    // 5. 결재선 목록 등록 (기존 삭제 후 재등록 방식 고려)
	    atrzMapper.deleteAtrzLineByDocNo(atrzVO.getAtrzDocNo()); // 기존 데이터 제거
	    for (AtrzLineVO atrzLineVO : atrzLineList) {
	    	atrzLineVO.setAtrzDocNo(atrzVO.getAtrzDocNo());
	        atrzMapper.updateAtrzLine(atrzLineVO);
	    }
	    
	    
	}
	//임시저장후 결재선 인서트(업데이트처럼 활용)
	@Override
	public void updateAtrzLine(AtrzLineVO atrzLineVO) {
		this.atrzMapper.updateAtrzLine(atrzLineVO);
		
	}
	//연차신청서 에서 남은 연차 갯수가져오기
	@Override
	public Double readHoCnt(String empNo) {
		return atrzMapper.readHoCnt(empNo);
	}
	//재기안 get
	@Override
	public AtrzVO selectDocumentReturn(String atrzDocNo) {
		
		AtrzVO atrzReturnVO = atrzMapper.selectDocumentReturn(atrzDocNo);
		log.info("selectDocumentReturn->atrzReturnVO : "+atrzReturnVO);
		List<AtrzLineVO> atrzStorageVOList = atrzReturnVO.getAtrzLineVOList();
		log.info("selectDocumentReturn->atrzReturnVO : "+atrzStorageVOList);
		
		atrzReturnVO.getAtrzLineVOList();
		for(AtrzLineVO atrzLineVO : atrzStorageVOList) {
			//결재자사번으로 이름 셋팅
			String sancterEmpNo = atrzLineVO.getSanctnerEmpno();
			EmployeeVO atrzStorageEmpDetail = organizationService.emplDetail(sancterEmpNo);
			atrzLineVO.setSanctnerEmpNm(atrzStorageEmpDetail.getEmplNm()); 
			
			//직급번호로 직급 셋팅
			String sanctClsfCd = atrzLineVO.getSanctnerClsfCode();
			String sanctClsfNm = CommonCode.PositionEnum.INTERN.getLabelByCode(sanctClsfCd);
			atrzLineVO.setSanctnerClsfNm(sanctClsfNm);
			
		}
	    //여기서 null임...
		
	    // 문서 폼별 서브 객체 추가
	    switch (atrzReturnVO.getAtrzDocNo().charAt(0)) {
	        case 'H' -> atrzReturnVO.setHolidayVO(atrzMapper.holidayDetail(atrzDocNo));
//	        case 'S' -> atrzVO.setSpendingVO(atrzMapper.spendingDetail(atrzDocNo));
	        case 'D' -> atrzReturnVO.setDraftVO(atrzMapper.draftDetail(atrzDocNo));
	        // 필요 시 다른 타입도 추가
	    }

	    return atrzReturnVO;
	}
	//기안서 상세
	@Override
	public DraftVO draftDetail(String draftNo) {
		return this.atrzMapper.draftDetail(draftNo);
		
	}
	
	//임시저장함 삭제(일괄삭제)
	@Transactional
	@Override
	public void storageListDelete(List<String> atrzDocNos) {
		log.info("storageListDelete->atrzDocNos :"+atrzDocNos);
		//문서번호 기준으로 하위 테이블 먼저 삭제(참조 무결성 고려)
		atrzMapper.deleteStorageAtrzLines(atrzDocNos);
		atrzMapper.deleteStorageDocumHoliday(atrzDocNos);
		atrzMapper.deleteStorageAtrz(atrzDocNos);
	}
	
	// 결재대기문서목록 행의 수
	@Override
	public int approvalTotal(Map<String,Object> map) {
		return atrzMapper.approvalTotal(map);
	}
	
	

	
	
}