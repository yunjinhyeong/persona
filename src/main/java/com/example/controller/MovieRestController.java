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

import com.example.domain.MovieMImgVo;
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
@RequestMapping("/movieList/*")
@Log
public class MovieRestController {

	@Autowired
	private MovieService movieService;
	
	@GetMapping("/items/{movieCnt}")								// 총갯수
	public ResponseEntity<Map<String,Object>> get15s(@PathVariable("movieCnt") int movieCnt) {
																	// 총갯수시작 ~15개의 목록 불러옴
		List<MovieMImgVo> resultList = movieService.getMoviesMImg(movieCnt, 15);
		log.info("resultList : " + resultList);
		
		int addCnt = movieService.countMoviesMImg(movieCnt, 15); // 추가된 갯수
		log.info("addCnt : " + addCnt);
		
		int resultCnt = movieCnt + addCnt; // 화면에 보이는 총갯수
		log.info("resultCnt : " + resultCnt);
		
		Map<String, Object> map = new HashMap<>();
		map.put("resultList", resultList);
		map.put("resultCnt", resultCnt);
		map.put("addCnt", addCnt);
		
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	} // get15
	
}