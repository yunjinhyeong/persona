package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.AttachVo;
import com.example.domain.EventPosterVo;
import com.example.mapper.AttachMapper;
import com.example.mapper.EventPosterMapper;

@Service
@Transactional
public class EventPosterService {

	@Autowired
	private EventPosterMapper eventPosterMapper;
	
	public void insertEventPoster(EventPosterVo eventPosterVo) {
		eventPosterMapper.insertEventPoster(eventPosterVo);
	}
	
	public EventPosterVo getEventPosterByNum(int num) {
		EventPosterVo eventPosterVo = eventPosterMapper.getEventPosterByNum(num);
		return eventPosterVo;
	}
	
	public List<EventPosterVo> getEventPosterByNoNum(int noNum) {
		List<EventPosterVo> eventPosterList = eventPosterMapper.getEventPosterByNoNum(noNum);
		return eventPosterList;
	}
	
	public void deleteAttachByNum(int num) {
		eventPosterMapper.deleteAttachByNum(num);
	}
	
	public void deleteAttachesByNoNum(int noNum) {
		eventPosterMapper.deleteEventPostersByNoNum(noNum);
	}
	
	public void deleteAttachesByNums(List<Integer> numList) {
		eventPosterMapper.deleteAttachesByNums(numList);
	}
	
}
