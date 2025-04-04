package kr.or.ddit.sevenfs.mapper.chat;

import kr.or.ddit.sevenfs.vo.chat.ChatRoomVO;
import kr.or.ddit.sevenfs.vo.chat.ChatVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Mapper
public interface ChatMapper {
    // 내 채팅방 목록 불러오기
    public List<ChatRoomVO> chatList(Map<String, Object> param);

    int insertMessage(ChatVO chatRoomVO);

    List<ChatVO> selectChatList(Map<String, Object> queryMap);

    int readChatMsg(Map<String, Object> queryMap);

    void updateRecentMsg(ChatVO chatRoomVO);

    // 채팅창 들어가 있는 사람들 리스트
    int[] chatEmpNoList(ChatVO chatRoomVO);

    Optional<Integer> invalidChatRoom(Map<String, Object> map);

    void createChatRoom(ChatRoomVO chatRoomVO);

    void insertChatEmps(ChatRoomVO chatRoomVO);
}
