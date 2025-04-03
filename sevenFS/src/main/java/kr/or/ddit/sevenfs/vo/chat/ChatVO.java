package kr.or.ddit.sevenfs.vo.chat;

import lombok.Data;

import java.util.Date;

@Data
public class ChatVO {
    public enum MessageType {
        TALK, JOIN, FILE, IMAGE
    }

    private MessageType type; // 메시지 타입

    private int chttRoomNo;
    private int mssageSn;
    private String mssageWritngEmpno;
    private String mssageCn;
    private Date mssageCreatDt;

    private String emplNm; // 채팅을 작성자 이름
    private Date creatDe; // 채팅 발송 시간
    private String mssageTy = "0"; // 0: 채팅 | 1: 이미지 | 2 파일

    private Date partcptnDt;
    private Date outDt;
    private String useYn;

    private String proflPhotoUrl;

    // private String fileName; // 파일 저장 경로
    // private String fileData; // Base64 인코딩된 파일 데이터
    // private int targetEmpNo; // 받아야 하는 사람 정보

    public void setType(String type) {
        switch (type) {
            case "TALK" -> this.type = MessageType.TALK;
            case "JOIN" -> this.type = MessageType.JOIN;
            case "IMAGE" -> this.type = MessageType.IMAGE;
            case "FILE" -> this.type = MessageType.FILE;
        }

        if (this.type == MessageType.TALK) this.mssageTy = "0";
        if (this.type == MessageType.IMAGE) this.mssageTy = "1";
        if (this.type == MessageType.FILE) this.mssageTy = "2";
    }

    public void setMssageTy(String mssageTy) {
        if (mssageTy.equals("2")) {
            this.type = MessageType.FILE;
        } else if (mssageTy.equals("1")) {
            this.type = MessageType.IMAGE;
        }else {
            this.type = MessageType.TALK;
        }

        this.mssageTy = mssageTy;
    }
}
