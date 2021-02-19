package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.domain.CardCardInfoVo;
import com.example.domain.MovieMImgVo;
import com.example.service.CardService;
import com.example.service.MovieService;

import lombok.extern.java.Log;
/*
  REST 컨트롤러의 HTTP method 매핑 방식
   POST   - Create (SQL Insert문)
   GET    - Read   (SQL Select문)
   PUT    - Update (SQL Update문)
   DELETE - Delete (SQL Delete문)
 */
@RestController // 이 컨트롤러의 모든 메소드의 리턴값이 JSON 또는 XML 응답으로 동작함
@RequestMapping("/cardSort/*")
@Log
public class CardRestController2 {

	@Autowired
	private CardService cardService;
	
	@GetMapping("/items/{cKinds}/{cardStart}/{cardCnt}") // 총갯수		// 총갯수시작 ~9개의 목록 불러옴
	public ResponseEntity<Map<String,Object>> get9k
	(@PathVariable("cKinds") String cKinds,
	 @PathVariable("cardStart") int cardStart,
	 @PathVariable("cardCnt") int cardCnt) {
		
		List<CardCardInfoVo> resultList = cardService.getCardCardInfoByCKinds(cardStart, cardCnt, cKinds);
		log.info("resultList : " + resultList);
		
		// 화면에 추가된 총 갯수
		int resultCnt = cardService.countCardCardInfoByCKinds(cardStart, cardCnt, cKinds); // 추가된 갯수
		log.info("resultCnt : " + resultCnt);
		
		Map<String, Object> map = new HashMap<>();
		map.put("resultList", resultList);
		map.put("resultCnt", resultCnt);
		
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	} // get9
}