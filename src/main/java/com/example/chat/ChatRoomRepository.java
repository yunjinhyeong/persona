package com.example.chat;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public class ChatRoomRepository { // DAO 역할
	
	// DB 테이블 역할
	private Map<String, ChatRoom> chatRoomMap = new LinkedHashMap<>(); // 입력된 키의 순서가 보장됨.
	
	
	public List<ChatRoom> getAllRooms() {
		List<ChatRoom> chatRooms = new ArrayList<>(chatRoomMap.values());
		Collections.reverse(chatRooms);
		return chatRooms;
	}
	
	public ChatRoom getRoomById(String id) {
		ChatRoom chatRoom = chatRoomMap.get(id);
		return chatRoom;
	}
	
	public ChatRoom removeRoomById(String id) {
		ChatRoom chatRoom = chatRoomMap.remove(id);
		return chatRoom;
	}
	
	// 채팅방 생성하고 chatRoomMap에 추가
	public ChatRoom createChatRoom(String title) {
		ChatRoom chatRoom = new ChatRoom(title);
		chatRoomMap.put(chatRoom.getRoomId(), chatRoom);
		return chatRoom;
	}
}
