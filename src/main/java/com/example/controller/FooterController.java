package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/footer/*")
public class FooterController {
	
	@GetMapping("/membershipagreement")
	public String membershipagreement() {
		log.info("membershipagreement 호출되었습니다. ");
		
		return "footer/membershipagreement";
	}
	
	@GetMapping("/privacypolicy")
	public String privacypolicy() {
		log.info("privacypolicy 호출되었습니다. ");
		
		return "footer/privacypolicy";
	}
	
	@GetMapping("/mailpolicy")
	public String mailpolicy() {
		log.info("mailpolicy 호출되었습니다. ");
		
		return "footer/mailpolicy";
	}
	
	@GetMapping("/imageinformationprocessingpolicy")
	public String imageinformationprocessingpolicy() {
		log.info("imageinformationprocessingpolicy 호출되었습니다. ");
		
		return "footer/imageinformationprocessingpolicy";
	}
}
