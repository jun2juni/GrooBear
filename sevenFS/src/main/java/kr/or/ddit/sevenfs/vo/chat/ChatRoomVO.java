package kr.or.ddit.sevenfs.vo.chat;

import lombok.Data;

import java.util.Date;

@Data
public class ChatRoomVO {

    private int chttRoomNo;
    private String chttRoomNm;
    private Date chttCreatDt;
    private int lastMssageNo;
    private int readCount; // 안읽은 채팅 카운트
    private String lastMsg; // 마지막 메세지
    private String chttRoomTy;

    // 채팅방에 들어가 있는 사람들
    private int[] emplNo;
    private int chatLastRead;


}
