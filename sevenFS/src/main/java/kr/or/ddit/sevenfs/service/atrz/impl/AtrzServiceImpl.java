package kr.or.ddit.sevenfs.service.atrz.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.sevenfs.mapper.atrz.AtrzMapper;
import kr.or.ddit.sevenfs.service.atrz.AtrzService;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.utils.CommonCode;
import kr.or.ddit.sevenfs.vo.atrz.AtrzLineVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.BankAccountVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;
import kr.or.ddit.sevenfs.vo.atrz.HolidayVO;
import kr.or.ddit.sevenfs.vo.atrz.SalaryVO;
import kr.or.ddit.sevenfs.vo.atrz.SpendingVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AtrzServiceImpl implements AtrzService {
	
	@Autowired
	AtrzMapper atrzMapper;
	
	// 사원 정보를 위해 가져온것
	@Autowired
	private OrganizationService organizationService;
	
	//결재 대기중인 문서리스트
	@Override
	public List<AtrzVO> atrzApprovalList(String emplNo) {
		
		List<AtrzVO> atrzApprovalList = atrzMapper.atrzApprovalList(emplNo);
		for (AtrzVO atrzVO : atrzApprovalList) {
			String drafterEmpNo = atrzVO.getDrafterEmpno();
			EmployeeVO employeeVO = organizationService.emplDetail(drafterEmpNo);
			atrzVO.setClsfCodeNm(employeeVO.getClsfCodeNm());
			atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
		}
		
		return atrzApprovalList;
	}
	//기안진행문서 최신순 5개
	@Override
	public List<AtrzVO> atrzMinSubmitList(String emplNo) {
		List<AtrzVO> atrzMinSubmitList = atrzMapper.atrzMinSubmitList(emplNo);
		for (AtrzVO atrzVO : atrzMinSubmitList) {
			String drafterEmpNo = atrzVO.getDrafterEmpno();
			EmployeeVO employeeVO = organizationService.emplDetail(drafterEmpNo);
			atrzVO.setClsfCodeNm(employeeVO.getClsfCodeNm());
			atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
		}
		
		return atrzMinSubmitList;
	}
	
	//기안완료문서 최신순 5개
	@Override
	public List<AtrzVO> atrzMinCompltedList(String emplNo) {
		List<AtrzVO> atrzMinCompltedList = atrzMapper.atrzMinCompltedList(emplNo);
		for (AtrzVO atrzVO : atrzMinCompltedList) {
			String drafterEmpNo = atrzVO.getDrafterEmpno();
			EmployeeVO employeeVO = organizationService.emplDetail(drafterEmpNo);
			atrzVO.setClsfCodeNm(employeeVO.getClsfCodeNm());
			atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
		}
		
		return atrzMinCompltedList;
	}
	
	
	
	
	
	//기안중인 문서리스트
	@Override
	public List<AtrzVO> atrzSubmitList(String emplNo) {
		
		List<AtrzVO> atrzSubmitList = atrzMapper.atrzSubmitList(emplNo);
		
		for (AtrzVO atrzVO : atrzSubmitList) {
			String drafterEmpNo = atrzVO.getDrafterEmpno();
			EmployeeVO employeeVO = organizationService.emplDetail(drafterEmpNo);
			atrzVO.setClsfCodeNm(employeeVO.getClsfCodeNm());
			atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
		}
		
		return atrzSubmitList;
	}
	//기안완료된 문서리스트
	@Override
	public List<AtrzVO> atrzCompletedList(String emplNo) {
		
		List<AtrzVO> atrzCompletedList = atrzMapper.atrzCompletedList(emplNo);
		
		for (AtrzVO atrzVO : atrzCompletedList) {
			String drafterEmpNo = atrzVO.getDrafterEmpno();
			EmployeeVO employeeVO = organizationService.emplDetail(drafterEmpNo);
			atrzVO.setClsfCodeNm(employeeVO.getClsfCodeNm());
			atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
		}
		return atrzCompletedList;
	}
	
	//참조대기문서
	@Override
	public List<AtrzVO> atrzReferList(String emplNo) {
		List<AtrzVO> atrzReferList = atrzMapper.atrzReferList(emplNo);
		
		for (AtrzVO atrzVO : atrzReferList) {
			EmployeeVO employeeVO = organizationService.emplDetail(atrzVO.getDrafterEmpno());
		
				atrzVO.setClsfCodeNm(employeeVO.getPosNm());
				atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
				log.info("atrzReferList-> atrzReferList : "+atrzReferList);
				
		}
		
		return atrzReferList;
	}
	//결재예정문서
	@Override
	public List<AtrzVO> atrzExpectedList(String emplNo) {
		List<AtrzVO> atrzExpectedList = atrzMapper.atrzExpectedList(emplNo);
		
		for (AtrzVO atrzVO : atrzExpectedList) {
			EmployeeVO employeeVO = organizationService.emplDetail(atrzVO.getDrafterEmpno());
			if(employeeVO != null) {
				atrzVO.setClsfCodeNm(employeeVO.getPosNm());
				atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
				log.info("atrzExpectedList-> atrzExpectedList : "+atrzExpectedList);
				
			}
			
		}
		return atrzExpectedList;
	}
	
	//기안문서함
	@Override
	public List<AtrzVO> atrzAllSubmitList(String emplNo) {
		List<AtrzVO> atrzAllSubmitList = atrzMapper.atrzAllSubmitList(emplNo);
				
		for (AtrzVO atrzVO : atrzAllSubmitList) {
			EmployeeVO employeeVO = organizationService.emplDetail(atrzVO.getDrafterEmpno());
			if(employeeVO != null) {
				atrzVO.setClsfCodeNm(employeeVO.getPosNm());
				atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
				log.info("atrzAllSubmitList-> atrzAllSubmitList : "+atrzAllSubmitList);
				
			}
			
		}
		
		return atrzAllSubmitList;
	}
	
	//임시저장 문서리스트
	@Override
	public List<AtrzVO> atrzStorageList(String emplNo) {
		List<AtrzVO> atrzStorageList = atrzMapper.atrzStorageList(emplNo);
		
		for (AtrzVO atrzVO : atrzStorageList) {
			EmployeeVO employeeVO = organizationService.emplDetail(atrzVO.getDrafterEmpno());
			if(employeeVO != null) {
				atrzVO.setClsfCodeNm(employeeVO.getPosNm());
				atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
				log.info("atrzStorageList-> atrzStorageList : "+atrzStorageList);
				
			}
			
		}
		
		return atrzStorageList;
	}
	
	//결재문서함
	@Override
	public List<AtrzVO> atrzAllApprovalList(String emplNo) {
		List<AtrzVO> atrzAllApprovalList = atrzMapper.atrzAllApprovalList(emplNo);
		
		for (AtrzVO atrzVO : atrzAllApprovalList) {
			EmployeeVO employeeVO = organizationService.emplDetail(atrzVO.getDrafterEmpno());
			if(employeeVO != null) {
				atrzVO.setClsfCodeNm(employeeVO.getPosNm());
				atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
				log.info("atrzAllApprovalList-> atrzAllApprovalList : "+atrzAllApprovalList);
				
			}
		}
		return atrzAllApprovalList;
		
	}
	
	//반려문서함
	@Override
	public List<AtrzVO> atrzCompanionList(String emplNo) {
		List<AtrzVO> atrzCompanionList = atrzMapper.atrzCompanionList(emplNo);
		for (AtrzVO atrzVO : atrzCompanionList) {
			EmployeeVO employeeVO = organizationService.emplDetail(atrzVO.getDrafterEmpno());
			if(employeeVO != null) {
				atrzVO.setClsfCodeNm(employeeVO.getPosNm());
				atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
				log.info("atrzCompanionList-> atrzCompanionList : "+atrzCompanionList);
				
			}
		}
		return atrzCompanionList;
	}
	
	
	//기안서 상세
	@Override
	public DraftVO draftDetail(String draftNo) {
		return this.atrzMapper.draftDetail(draftNo);
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
	//연차신청서 등록
	@Override
	public int insertHoliday(HolidayVO documHolidayVO) {
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
	@Override
	public int atrzDetailAppUpdate(AtrzVO atrzVO) {
		String atrzDocNo = atrzVO.getAtrzDocNo();
		
		String emplNo = atrzVO.getEmplNo();
		String atrzOption = atrzVO.getAtrzOpinion();
		
		List<AtrzLineVO> atrzLineVOList = atrzVO.getAtrzLineVOList(); 
		
		log.info("atrzDetailAppUpdate->atrzVO : "+atrzVO);
		log.info("atrzDetailAppUpdate->atrzDocNo : "+atrzDocNo);
		
		
		//현재 결재에서 결재한 사람 찾기
		AtrzLineVO currentLine = null;
		log.info("atrzDetailAppUpdate->currentLine: "+currentLine);

		//나의 전자결재선 상황(1행)
		AtrzLineVO emplAtrzLineInfo = this.atrzMapper.getAtrzLineInfo(atrzVO);
		
		//나의 결재 순번 구하기
		int myStep = emplAtrzLineInfo.getAtrzLnSn();
		
		
		
		//H_20250411_00003 문서의 결재선 총 스탭수
		//0 : 마지막 결재자가 아님
		//0이 아닌 경우 : 마지막 결재자임
		int maxStep = atrzMapper.getMaxStep(atrzVO);
		log.info("atrzDetailAppUpdate-> maxStep : "+maxStep);
		log.info("atrzDetailAppUpdate-> 나의순번 : "+myStep + "최종순번 : "+maxStep);

		//I. ATRZ_LINE 결재 처리
		int result = atrzMapper.atrzDetailAppUpdate(atrzVO);
		
		//1) maxStep : 마지막 결재자 순서번호
		//2) nextStep : 나 다음에 결재할 사람
		//3) meStep : 내 결재 순서번호
		//최종결재자인경우
		if(myStep==maxStep){
			//III. ATRZ의 완료 및 일시 처리
			atrzVO.setAtrzSttusCode("10");
			result += atrzMapper.atrzStatusFinalUpdate(atrzVO);
		}
		
		return 1;
		
	}
	//전자결재 상세 업데이트(반려시)
	@Override
	public int atrzDetilCompUpdate(AtrzVO atrzVO) {
		//문서번호  
		String atrzDocNo = atrzVO.getAtrzDocNo();
		
		//사원번호
		String emplNo = atrzVO.getEmplNo();
		//결재의견
		String atrzOption = atrzVO.getAtrzOpinion();
		
		
		log.info("atrzDetilCompUpdate->atrzVO : "+atrzVO);
		log.info("atrzDetilCompUpdate->atrzDocNo : "+atrzDocNo);
		
		
		//현재 결재에서 결재한 사람 찾기
		AtrzLineVO currentLine = null;
		log.info("atrzDetilCompUpdate->currentLine: "+currentLine);

		//나의 전자결재선 상황(1행)
		AtrzLineVO emplAtrzLineInfo = this.atrzMapper.getAtrzLineInfo(atrzVO);
		
		//H_20250411_00003 문서의 결재선 총 스탭수
		//0 : 마지막 결재자가 아님
		//0이 아닌 경우 : 마지막 결재자임
		int maxStep = atrzMapper.getMaxStep(atrzVO);
		log.info("atrzDetailAppUpdate-> maxStep : "+maxStep);

		//I. ATRZ_LINE 결재 처리
		int result = atrzMapper.atrzDetilCompUpdate(atrzVO);
		
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
		
		log.info("atrzDetilCompUpdate->atrzVO : "+atrzVO);
		log.info("atrzDetilCompUpdate->atrzDocNo : "+atrzDocNo);
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
		AtrzVO atrzVO = atrzMapper.getAtrzStorage(atrzDocNo);
		
		if (atrzVO == null || !"99".equals(atrzVO.getAtrzSttusCode())) {
	        throw new IllegalArgumentException("임시저장된 문서가 아닙니다.");
	    }
		
		// 기안자 정보 추가
	    EmployeeVO drafter = organizationService.emplDetail(atrzVO.getDrafterEmpno());
	    atrzVO.setDrafterEmpnm(drafter.getEmplNm());
	    atrzVO.setDrafterDept(drafter.getDeptNm());
	    
	    //결재자 정보추가
	    List<AtrzLineVO> atrzLineVOList = atrzVO.getAtrzLineVOList();
	    List<EmployeeVO> sanEmplVOList = new ArrayList<>();
	    
	    for(AtrzLineVO atrzLineVO : atrzLineVOList) {
	    	
	    	EmployeeVO sanctner = organizationService.emplDetail(atrzLineVO.getAftSanctnerEmpno());
	    	atrzLineVO.setSanctnerEmpNm(sanctner.getEmplNm()); 
	    	//나길준희 여기서부터 시작이다. 4월 15일 끝
	    	//결재자 이름 / 직급 셋팅
			String sancterEmpNo = atrzLineVO.getSanctnerEmpno();
			EmployeeVO sanEmplVO =organizationService.emplDetail(sancterEmpNo);
			sanEmplVOList.add(sanEmplVO);
			
			//직급명 이름 설정
			String sanctClsfCd = atrzLineVO.getSanctnerClsfCode();
			String sanctClsfNm = CommonCode.PositionEnum.INTERN.getLabelByCode(sanctClsfCd);
			atrzLineVO.setSanctnerClsfNm(sanctClsfNm);
			//결재자의 이름 담기
			atrzLineVO.setSanctnerEmpNm(sanEmplVO.getEmplNm());
			
			log.info("getAtrzStorage->sanctClsfNm : "+sanctClsfNm);
			//여기서 하나하나 담긴애들을 리스트로 보내야한다.
			
			log.info("getAtrzStorage->sanEmplVO : "+sanEmplVO);
			log.info("getAtrzStorage->sancterEmpNo : "+sancterEmpNo);
	    }
	    
	    // 문서 폼별 서브 객체 추가
	    switch (atrzVO.getAtrzDocNo().charAt(0)) {
	        case 'H' -> atrzVO.setHolidayVO(atrzMapper.holidayDetail(atrzDocNo));
//	        case 'S' -> atrzVO.setSpendingVO(atrzMapper.spendingDetail(atrzDocNo));
	        case 'D' -> atrzVO.setDraftVO(atrzMapper.draftDetail(atrzDocNo));
	        // 필요 시 다른 타입도 추가
	    }

	    return atrzVO;
	}
	
	


	
	
	
}
