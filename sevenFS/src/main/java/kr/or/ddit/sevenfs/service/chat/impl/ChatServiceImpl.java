package kr.or.ddit.sevenfs.service.chat.impl;

import kr.or.ddit.sevenfs.mapper.chat.ChatMapper;
import kr.or.ddit.sevenfs.service.chat.ChatService;
import kr.or.ddit.sevenfs.vo.chat.ChatRoomVO;
import kr.or.ddit.sevenfs.vo.chat.ChatVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Service
public class ChatServiceImpl implements ChatService {

    @Autowired
    ChatMapper chatMapper;

    // 내 채팅방 목록 불러오기
    public List<ChatRoomVO> chatList(Map<String, Object> param) {
        return this.chatMapper.chatList(param);
    };

    // 메세지 저장하기
    public int[] insertMessage(ChatVO chatRoomVO) {
        this.chatMapper.insertMessage(chatRoomVO);
        // 채팅방 마지막 메세지 순번 저장
        log.debug("chatRoomVO => {}", chatRoomVO);
        updateRecentMsg(chatRoomVO);

        // 내가 쓴경우도 CHAT테이블 메세지 순번 바꿔주기
        Map<String, Object> queryMap = new HashMap<>();
        queryMap.put("chttRoomNo", chatRoomVO.getChttRoomNo());
        queryMap.put("mssageSn", chatRoomVO.getMssageSn());
        queryMap.put("emplNo", chatRoomVO.getMssageWritngEmpno());
        readChatMsg(queryMap);

//        // 읽음 처리
//        readChatMsg(queryMap);

        return this.chatMapper.chatEmpNoList(chatRoomVO);
    }

    // 채팅방에 마지막 메세지 순번 저장
    public void updateRecentMsg(ChatVO chatRoomVO) {
        this.chatMapper.updateRecentMsg(chatRoomVO);
    }

    // 채팅방 메세지 불러오기
    public List<ChatVO> selectChatList(Map<String, Object> queryMap) {
        List<ChatVO> chatVOList = this.chatMapper.selectChatList(queryMap);
        if (!chatVOList.isEmpty()) {
            int mssageSn = chatVOList.getLast().getMssageSn();
            queryMap.put("mssageSn", mssageSn);

            // 전부 읽은걸로 표시 - 마지막 본 채팅 정보로 변경
            log.debug("queryMap" + queryMap);
            readChatMsg(queryMap);
        }
        return chatVOList;
    }

    // 실시간 읽음 확인 기능
    public void readChatMsg(Map<String, Object> queryMap) {
        this.chatMapper.readChatMsg(queryMap);
    }

    // 이미 있는 채팅방인지 확인하기
    public int invalidChatRoom(Map<String, Object> map) {
        Optional<Integer> invalidChatRoom = this.chatMapper.invalidChatRoom(map);
        // 채팅방이 없는 경우


        return invalidChatRoom.orElse(0);
    }

    // 채팅방 만들기
    public ChatRoomVO createChatRoom() {
        ChatRoomVO chatRoomVO = new ChatRoomVO();
        chatRoomVO.setChttRoomNm("채팅방구");
        chatRoomVO.setChttRoomTy("0");
        this.chatMapper.createChatRoom(chatRoomVO);


        return chatRoomVO;
    }

    @Override
    public void insertChatEmps(ChatRoomVO chatRoomVO) {
        this.chatMapper.insertChatEmps(chatRoomVO);
    }


}
