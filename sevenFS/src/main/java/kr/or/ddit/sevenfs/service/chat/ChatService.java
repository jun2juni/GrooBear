package kr.or.ddit.sevenfs.service.chat;

import kr.or.ddit.sevenfs.vo.chat.ChatRoomVO;
import kr.or.ddit.sevenfs.vo.chat.ChatVO;

import java.util.List;
import java.util.Map;

public interface ChatService {
    // 내 채팅방 목록 불러오기
    public List<ChatRoomVO> chatList(Map<String, Object> param);

    // 메세지 저장하기
    public int[] insertMessage(ChatVO chatRoomVO);

    // 채팅방에 마지막 메세지 순번 저장
    public void updateRecentMsg(ChatVO chatRoomVO);

    // 채팅방 메세지 불러오기
    public List<ChatVO> selectChatList(Map<String, Object> queryMap);

    // 실시간 읽음 확인 기능
    public void readChatMsg(Map<String, Object> queryMap);

    // 이미 있는 채팅방인지 확인하기
    public int invalidChatRoom(Map<String, Object> map);

    // 채팅방 만들기
    public ChatRoomVO createChatRoom();

    // 채팅방 사원 추가
    public void insertChatEmps(ChatRoomVO chatRoomVO);

}
