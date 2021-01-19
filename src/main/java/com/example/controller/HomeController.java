package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.java.Log;

@Controller // 클래스 안에서 @GetMapping 등의 애노테이션을 사용 가능
@Log
public class HomeController  {

	@GetMapping("/")
	public String index() {
		log.info("index() 호출됨");
		return "index";
	}
	
}
