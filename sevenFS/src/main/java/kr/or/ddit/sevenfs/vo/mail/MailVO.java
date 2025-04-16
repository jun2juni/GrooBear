package kr.or.ddit.sevenfs.vo.mail;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class MailVO {
	/**
	 * <pre>
	 * 메일은 전송시 최소 2개가 입력된다.
	 * 
	 * == 메일 전송에 필요한 데이터 ==
	 * emailTrnsmisTy ( 참조시에 필요 => 이메일 리스트를 따로 받게 된다.)
	 * emailClTy (메일함 분류시 필요)
	 * trnsmitEmail (송신 이메일)
	 * recptnEmail	(수신 이메일)
	 * emailSj
	 * emailCn
	 * 
	 * 
	 * == 서버에서 처리(넣어줄) 데이터 ==
	 * emailNo (시퀀스로 자동 생성)
	 * atchFileNo
	 * (송수신 이메일은 보낸 사람의 이메일, 받는 사람의 이메일 처리시)
	 * trnsmitEmail (송신 이메일)
	 * recptnEmail	(수신 이메일)
	 * readngAt	(보낸 사람의 readngAt는 초기에 'y'로 넣어주고 받는 사람은 'n'으로 넣어준다.)
	 * 
	 * </pre>
	 * */
	// primary key
	private int emailNo;
	// 1회 송수신에 대한 groupNo
	private int emailGroupNo;
	
	// 접속자와 매핑될 사원번호 ( 해당 메일을 열람할 수 있는 사원 ) 
	private String emplNo;
	
	// 메일 라벨 번호
	private int lblNo;
	
	// 전송타입 0 참조x, 1 참조, 2 숨은 참조 ==
	private String emailTrnsmisTy;
	
	// 메일함 분류시 사용 0 보낸메일, 1 받은메일, 2 임시메일, 3 스팸함, 4 휴지통 ==
	private String emailClTy;
	
	// 송신 이메일 ( 해당 메일을 작성하여 보내는 사람의 이메일)
	private String trnsmitEmail;
	
	// 수신이메일 ( 해당 메일을 받는 사람의 이메일)(복수개 가능)
	private List<String> recptnEmailList;
	private String recptnEmail;
	
	// 메일 제목
	private String emailSj;
	
	// 매일 내용
	private String emailCn;
	
	// 첨부파일 번호
	private long atchFileNo;
	
	// 전송 날짜
	private String trnsmitDt;
	
	// 송수신 여부 (읽었는지 확인)
	private String readngAt;
	
	// 서버에서 처리시 refEmail존재여부,hiddenRefEmail 존재여부,둘다 없음 3가지로 분기처리된다.
	// 참조 이메일 리스트
	private List<String>  refEmailList;
	// 숨은 참조 이메일 리스트
	private List<String> hiddenRefEmailList;
	
	public MailVO() {}
	public MailVO(int emailNo) {
		this.emailNo = emailNo;
	}
	public MailVO(MailVO mailVO){
		this.emailNo = mailVO.getEmailNo();
		this.atchFileNo = mailVO.getAtchFileNo();
		this.emailClTy = mailVO.getEmailClTy();
		this.emailSj = mailVO.getEmailSj();
		this.emailCn = mailVO.getEmailCn();
		this.emailTrnsmisTy = mailVO.getEmailTrnsmisTy();
		this.emplNo = mailVO.getEmplNo();
		this.hiddenRefEmailList = mailVO.getHiddenRefEmailList();
		this.lblNo = mailVO.getLblNo();
		this.readngAt = mailVO.getReadngAt();
		this.recptnEmail = mailVO.getRecptnEmail();
		this.recptnEmailList = mailVO.getRecptnEmailList();
		this.refEmailList = mailVO.getRefEmailList();
		this.trnsmitDt = mailVO.getTrnsmitDt();
		this.trnsmitEmail = mailVO.getTrnsmitEmail();
		
	}
}
