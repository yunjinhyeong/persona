package com.example.service;

import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.AttachVo;
import com.example.domain.EventImgVo;
import com.example.domain.EventPosterVo;
import com.example.domain.EventVo;
import com.example.domain.NoticeVo;
import com.example.mapper.AttachMapper;
import com.example.mapper.EventMapper;
import com.example.mapper.EventPosterMapper;
import com.example.mapper.NoticeMapper;

@Service
public class EventService {
	
	@Autowired
	private EventMapper eventMapper;
	@Autowired
	private EventPosterMapper eventPosterMapper;
	
	
	// 주글쓰기
	public void addEvent(EventVo eventVo) {
		eventMapper.addEvent(eventVo);
	}
	
	
	public NoticeVo getNoticeByNum(int num) {
		NoticeVo noticeVo = eventMapper.getNoticeByNum(num);
		return noticeVo;
	}
	
	public List<EventImgVo> getEventMovieImg() {
		List<EventImgVo> list = eventMapper.getEventMovieImg();
		return list;
	}
	public List<EventImgVo> getEventPremiereImg() {
		List<EventImgVo> list = eventMapper.getEventPremiereImg();
		return list;
	}
	public List<EventImgVo> getEventHOTImg() {
		List<EventImgVo> list = eventMapper.getEventHOTImg();
		return list;
	}
	public List<EventImgVo> getEventDiscountImg() {
		List<EventImgVo> list = eventMapper.getEventDiscountImg();
		return list;
	}
	
	
	public List<EventImgVo> getEventMovieImgAll() {
		List<EventImgVo> list = eventMapper.getEventMovieImgAll();
		return list;
	}
	public List<EventImgVo> getEventPremiereImgAll() {
		List<EventImgVo> list = eventMapper.getEventPremiereImgAll();
		return list;
	}
	public List<EventImgVo> getEventHOTImgAll() {
		List<EventImgVo> list = eventMapper.getEventHOTImgAll();
		return list;
	}
	public List<EventImgVo> getEventDiscountImgAll() {
		List<EventImgVo> list = eventMapper.getEventDiscountImgAll();
		return list;
	}
	
	
	public void updateReadcount(int num) {
		eventMapper.updateReadcount(num);
	}
	
	
	
	public int getCountAll() {
		int count = eventMapper.getCountAll();
		return count;
	}
	
	
	public List<NoticeVo> getNotices(int startRow, int pageSize) {
		List<NoticeVo> list = eventMapper.getNotices(startRow, pageSize);
		return list;
	}
	
	
	public void updateBoard(EventVo eventVo) {
		eventMapper.updateBoard(eventVo);
	}
	
	public void deleteEventByNum(int num) {
		eventMapper.deleteEventByNum(num);
	}
	
	@Transactional
	public void deleteEventAndEventPosters(int num) {
		eventMapper.deleteEventByNum(num);
		eventPosterMapper.deleteEventPostersByNoNum(num);
	}
	
	public void deleteAll() {
		eventMapper.deleteAll();
	}
	
	// 답글쓰기
//	@Transactional
//	public void updateAndAddReply(EventVo eventVo) {
//		// 답글을 쓰는 대상글과 같은 글그룹에서 
//		// 답글을 쓰는 대상글의 순번보다 큰 글의 순번을 1씩 증가시킴
//		eventMapper.updateReSeq(eventVo.getReRef(), eventVo.getReSeq());
//		
//		// insert할 답글정보로 수정
//		eventVo.setReLev(eventVo.getReLev() + 1);
//		eventVo.setReSeq(eventVo.getReSeq() + 1);
//		
//		// 답글 insert하기
//		eventMapper.addEvent(eventVo);
//	}
	
	
	public int getCountBySearch(String category, String search) {
		int count = eventMapper.getCountBySearch(category, search);
		return count;
	}
	
	public int getCountEvent() {
		int count = eventMapper.getCountEvent();
		return count;
	}
	public int getCountByMovie() {
		int count = eventMapper.getCountByMovie();
		return count;
	}
	public int getCountByPremiere() {
		int count = eventMapper.getCountByPremiere();
		return count;
	}
	public int getCountByHOT() {
		int count = eventMapper.getCountByHOT();
		return count;
	}
	public int getCountByDiscount() {
		int count = eventMapper.getCountByDiscount();
		return count;
	}
	
	public EventImgVo getEventByENum(int num) {
		return eventMapper.getEventByENum(num);
	}
	
	
	public List<EventVo> getEventsBySearch(int startRow, int pageSize, String category, String search) {
		return eventMapper.getEventsBySearch(startRow, pageSize, category, search);
	}
	
	public List<EventVo> getMovie() {
		return eventMapper.getMovie();
	}
	public List<EventVo> getPremiere() {
		return eventMapper.getPremiere();
	}
	public List<EventVo> getHOT() {
		return eventMapper.getHOT();
	}
	public List<EventVo> getDiscount() {
		return eventMapper.getDiscount();
	}
	
	
	public EventVo getEventAndEventPosters(int num) {
		return eventMapper.getEventAndEventPosters(num);
	}
	
	//public List<NoticeVo> getNoticesByNums(List<Integer> numList)
	public List<NoticeVo> getNoticesByNums(Integer... numArr) {
		
		List<Integer> numList = Arrays.asList(numArr);
		
		return eventMapper.getNoticesByNums(numList);
	}
	
	
	@Transactional
	public void addEventAndEventPosters(EventVo eventVo, List<EventPosterVo> eventPosterList) {
		// 게시글 등록
		eventMapper.addEvent(eventVo);
		
		// 첨부파일정보 등록
		for (EventPosterVo eventPosterVo : eventPosterList) {
			eventPosterMapper.insertEventPoster(eventPosterVo);
		}
	}
	
	// 자료실 게시판 답글쓰기
//		@Transactional
//		public void updateAndAddReplyAndAddAttaches(NoticeVo noticeVo, List<AttachVo> attachList) {
//			// 답글을 쓰는 대상글과 같은 글그룹에서 
//			// 답글을 쓰는 대상글의 순번보다 큰 글의 순번을 1씩 증가시킴
//			eventMapper.updateReSeq(noticeVo.getReRef(), noticeVo.getReSeq());
//			
//			// insert할 답글정보로 수정
//			noticeVo.setReLev(noticeVo.getReLev() + 1);
//			noticeVo.setReSeq(noticeVo.getReSeq() + 1);
//			
//			// 답글 insert하기
//			eventMapper.addEvent(noticeVo);
//			
//			
//			// 첨부파일 정보 insert
//			for (AttachVo attachVo : attachList) {
//				eventPosterMapper.insertEventPoster(attachVo);
//			}
//		}
	
	@Transactional
	public void updateEventAndAddEventPostersAndDeleteEventPosters(EventVo eventVo, List<EventPosterVo> eventPosterVos, List<Integer> delFileNums) {
		eventMapper.updateBoard(eventVo);
		
		for (EventPosterVo eventPosterVo : eventPosterVos) {
			eventPosterMapper.insertEventPoster(eventPosterVo);
		}
		
		if (delFileNums != null) {
			eventPosterMapper.deleteAttachesByNums(delFileNums);
		}
	}
	
}





