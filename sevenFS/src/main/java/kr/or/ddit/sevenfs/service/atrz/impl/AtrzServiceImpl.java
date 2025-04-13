package kr.or.ddit.sevenfs.service.atrz.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.atrz.AtrzMapper;
import kr.or.ddit.sevenfs.service.atrz.AtrzService;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
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
			if(employeeVO != null) {
				atrzVO.setClsfCodeNm(employeeVO.getPosNm());
				atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
				log.info("atrzReferList-> atrzReferList : "+atrzReferList);
				
			}
			
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
		
		//H_20250411_00003 문서의 결재선 총 스탭수
		//0 : 마지막 결재자가 아님
		//0이 아닌 경우 : 마지막 결재자임
		int maxStep = atrzMapper.getMaxStep(atrzVO);
		log.info("atrzDetailAppUpdate-> maxStep : "+maxStep);

		//I. ATRZ_LINE 결재 처리
		int result = atrzMapper.atrzDetailAppUpdate(atrzVO);
		
		//1) maxStep : 마지막 결재자 순서번호
		//2) nextStep : 나 다음에 결재할 사람
		//3) meStep : 내 결재 순서번호
		//최종결재자인경우
		if(maxStep!=0){
			//III. ATRZ의 완료 및 일시 처리
			atrzVO.setAtrzSttusCode("20");
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

	
	
	
}
