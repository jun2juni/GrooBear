package kr.or.ddit.sevenfs.controller.chat;

import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.chat.ChatService;
import kr.or.ddit.sevenfs.vo.*;
import kr.or.ddit.sevenfs.vo.chat.ChatRoomVO;
import kr.or.ddit.sevenfs.vo.chat.ChatVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
public class ChatController {
    @Autowired
    private ChatService chatService;
    @Autowired
    private AttachFileService attachFileService;
    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @GetMapping("/chat/list")
    public String chatList(Model model,
                           @AuthenticationPrincipal CustomUser customUser) {
        EmployeeVO empVO = customUser.getEmpVO();
        log.debug("empVO: {}", empVO.getEmplNo());
        // 채팅방 목록 불러오기
        Map<String, Object> param = new HashMap<>();
        param.put("emplNo", empVO.getEmplNo());
        List<ChatRoomVO> chatRoomVOList = chatService.chatList(param);
        log.debug("chatRoomVOList: {}", chatRoomVOList);

        model.addAttribute("chatRoomVOList", chatRoomVOList);

        return "chat/index";
    }

    // 채팅방 있으면 불러오기 없으면 생성'
    @Transactional
    @ResponseBody
    @GetMapping("/chat/roomInsert")
    public Map<String, Object> chatRoomInsert(@RequestParam String targetEmplNo,
                                              @AuthenticationPrincipal CustomUser customUser) {
        Map<String, Object> resultMap = new HashMap<>();
        EmployeeVO empVO = customUser.getEmpVO();
        Map<String, Object> queryMap = new HashMap<>();
        queryMap.put("myEmplNo", empVO.getEmplNo());
        queryMap.put("targetEmplNo", targetEmplNo);
        log.debug("queryMap {}", queryMap);

        int invalidChatRoom = this.chatService.invalidChatRoom(queryMap);
        log.debug("invalidChatRoom: {}", invalidChatRoom);

        if (invalidChatRoom == 0) {
            // 채팅방 만들기
            ChatRoomVO chatRoom = this.chatService.createChatRoom();
            String[] emplNoList = {targetEmplNo, empVO.getEmplNo()};
            chatRoom.setEmplNoList(emplNoList);
            log.debug("chatRoom: {}", chatRoom);
            // 채팅방에 사원들 추가
            this.chatService.insertChatEmps(chatRoom);
            Map<String, Object> param = new HashMap<>();
            param.put("emplNo", empVO.getEmplNo());
            param.put("chttRoomNo", chatRoom.getChttRoomNo());
            log.debug("param: {}", param);
            List<ChatRoomVO> chatRoomVOList = this.chatService.chatList(param);

            resultMap.put("chatRoom", chatRoomVOList.getFirst());
        }


        resultMap.put("invalidChatRoom", invalidChatRoom);
        return resultMap;
    }

    // 채팅 메시지 수신 및 저장
    @MessageMapping("/chat/message")
    public ResponseEntity<String> receiveMessage(@Payload ChatVO message) {
        if (ChatVO.MessageType.JOIN.equals(message.getType())) {
            message.setMssageCn(message.getEmplNm() + "님이 입장하셨습니다.");
        }

        log.debug("message => {}", message);
        int[] empNoList = chatService.insertMessage(message); // 메시지를 받을때마다 데이터베이스에 저장

        // 채팅 알림 보내기
        log.debug("empNoList = {}", Arrays.toString(empNoList));
        for (int emplNo : empNoList) {
            log.debug("emplNo = {}", emplNo);
            messagingTemplate.convertAndSend("/sub/alert/room/" + emplNo, message);
        }

        // 메시지를 해당 채팅방 구독자들에게 전송
        // 채팅방 들어온 사람들 모음
        messagingTemplate.convertAndSend("/sub/chat/room/" + message.getChttRoomNo(), message);

        return ResponseEntity.ok("메시지 전송 완료");
    }

    // 채팅방 파일 추가
    @ResponseBody
    @PostMapping("/message/file")
    public Map<String, Object> sendFile(MultipartFile[] uploadFiles) {
        log.debug("uploadFiles => {}", Arrays.toString(uploadFiles));
        Map<String, Object> resultMap = new HashMap<>();
        AttachFileVO attachFileVO = null;

        // 파일 업로드
        if (uploadFiles != null && uploadFiles.length > 0) {
            attachFileVO = attachFileService.insertFile("chat", uploadFiles);
        }

        resultMap.put("attachFileVO", attachFileVO);

        return resultMap;
    }

    @ResponseBody
    @GetMapping("/chat/messageList")
    public List<ChatVO> chat(
            @RequestParam(required = true) int chttRoomNo,
            @RequestParam(required = true) int emplNo) {
        Map<String, Object> queryMap = new HashMap<>();
        queryMap.put("chttRoomNo", chttRoomNo);
        queryMap.put("emplNo", emplNo);

        List<ChatVO> chatVOList = this.chatService.selectChatList(queryMap);

        return chatVOList;
    }

    // Post로 메세지 보내기 기능
    @ResponseBody
    @PostMapping("/message")
    public String sendMessage(@RequestBody ChatVO message) {
        log.debug("message => {}", message);
        messagingTemplate.convertAndSend("/sub/chat/room/" + message.getChttRoomNo(), message);
        return "success";
    }
}
