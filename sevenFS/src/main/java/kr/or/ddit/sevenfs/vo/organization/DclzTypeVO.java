package kr.or.ddit.sevenfs.vo.organization;

import java.util.Date;

import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import lombok.Data;

// 근태 유형 VO
@Data
public class DclzTypeVO {

	private String emplNo;
	private String dclzNo;
	private String dclzCode;
	private Date dclzBeginDt;
	private Date dclzEndDt;
	
	// 공통코드
	private DclzTypeVO cmmnCodeList; 
	
	// 사원
	//private EmployeeVO emplList;
}
