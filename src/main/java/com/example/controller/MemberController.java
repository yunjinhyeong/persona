package com.example.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.social.google.api.Google;
import org.springframework.social.google.api.impl.GoogleTemplate;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.google.connect.GoogleOAuth2Template;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.example.domain.MemberVo;
import com.example.service.MemberService;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private JavaMailSender javaMailSender;
	

	
//	
//	public void setMemberService(MemberService memberService) {
//		this.memberService = memberService;
//	}

	

	//	@RequestMapping(value = "/join", method = RequestMethod.GET)
	@GetMapping("/loginjoin")
	public void join() {
		log.info("GET - join() 호출됨");
//		return "member/join";   // 메소드 리턴타입이 String일 경우
	}
	
	
	@PostMapping("/join")
	public String join(MemberVo memberVo) {
		log.info("POST - join() 호출됨");
		
		// 회원가입 날짜 설정
		memberVo.setRegDate(new Timestamp(System.currentTimeMillis()));
		log.info("memberVo : " + memberVo);
		
		// 회원가입 처리
		memberService.addMember(memberVo);
		
		return "redirect:/member/loginjoin";
	}
	
		
	@PostMapping(value = "/CheckMail" , produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public Map<String, String> SendMail(String mail) {
		Map<String, String> map = new HashMap<>();
		Random random = new Random();
		String key = "";

		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(mail); // 스크립트에서 보낸 메일을 받을 사용자 이메일 주소
		// 입력 키를 위한 코드
		for (int i = 0; i < 3; i++) {
			int index = random.nextInt(25) + 65; // A~Z까지 랜덤 알파벳 생성
			key += (char) index;
		}
		int numIndex = random.nextInt(8999) + 1000; // 4자리 정수를 생성
		key += numIndex;
		message.setSubject("인증번호 입력을 위한 메일 전송");
		message.setText("인증 번호 : " + key);
		log.info("message : " + message);
		javaMailSender.send(message);
		map.put("key", key);
		
		return map;
	}

	
	@GetMapping("/joinIdDupCheck")
	public String joinIdDupCheck(String id, Model model) {
		log.info("id : " + id);
		
		int count = memberService.getCountById(id);
		
		// Model 타입 객체에 뷰(JSP)에서 사용할 데이터를 저장하기
		model.addAttribute("id", id);
		model.addAttribute("count", count);
		
		return "member/joinIdDupCheck";
	} // joinIdDupCheck
	
	
	@GetMapping(value = "/ajax/joinIdDupChk")
	@ResponseBody // 리턴 객체를 JSON 문자열로 변환해서 응답을 줌
	public Map<String, Boolean> ajaxJoinIdDupChk(String id) {
		
		int count = memberService.getCountById(id);

		Map<String, Boolean> map = new HashMap<>();
		if (count == 0) {
			map.put("isIdDup", false);
		} else { // count == 1
			map.put("isIdDup", true);
		}
		
		return map;
	}
	
	@GetMapping(value = "/ajax/joinEmailDupChk", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	@ResponseBody // 리턴 객체를 JSON 문자열로 변환해서 응답을 줌
	public Map<String, Boolean> ajaxEmailDupChk(String email) {
		
		int count = memberService.getCountByEmail(email);

		Map<String, Boolean> map = new HashMap<>();
		if (count == 0) {
			map.put("isEmailDup", false);
		} else { // count == 1
			map.put("isEmailDup", true);
		}
		
		return map;
	}
	
	@GetMapping("/login")
	public void login() {
//		return "member/login";
	}

	
	@PostMapping("/login")
	public ResponseEntity<String> login(String id, String passwd, 
			@RequestParam(defaultValue = "false") boolean keepLogin,
			HttpSession session,
			HttpServletResponse response) {
		
		int check = memberService.userCheck(id, passwd);
		
		// 로그인 실패시
		if (check != 1) {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			
			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
			sb.append("  alert('아이디 또는 패스워드가 일치하지 않습니다.');");
			sb.append("  history.back();");
			sb.append("</script>");
			
			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
		}
		
		// 로그인 성공시
		// 세션에 아이디 저장(로그인 인증)
		session.setAttribute("id", id);
		
		if (keepLogin) { // keepLogin == true
			Cookie cookie = new Cookie("id", id);
			cookie.setMaxAge(60 * 10);  // 쿠키 유효시간 10분
			cookie.setPath("/");

			response.addCookie(cookie);
		}
		
//		return "redirect:/";
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Location", "/"); // 리다이렉트 경로를 Location으로 설정
		// 리다이렉트일 경우는 HttpStatus.FOUND 를 지정해야 함
		return new ResponseEntity<String>(headers, HttpStatus.FOUND);
	} // login
	
	

	
	@GetMapping("/logout")
	public String logout(HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response) {
		
		// 세션 초기화
		session.invalidate();
		
		// 로그인 상태유지용 쿠키가 존재하면 삭제
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("id")) {
					cookie.setMaxAge(0); // 유효시간 0
					cookie.setPath("/"); // 경로는 생성할때와 동일하게 설정해야 삭제됨
					
					response.addCookie(cookie); // 삭제할 쿠키정보를 추가
				}
			}
		}
		
		return "redirect:/";
	} // logout
	
	@GetMapping("/findPW")
	public void findPW() {
		log.info("GET - findPW() 호출됨");
//		return "member/join";   // 메소드 리턴타입이 String일 경우
	}
	
	@GetMapping("/findID")
	public void findID() {
		log.info("GET - findID() 호출됨");
//		return "member/join";   // 메소드 리턴타입이 String일 경우
	}
	
	@PostMapping("/findPW")
	public void findPW(@RequestParam("id") String id,
			@RequestParam("name") String name,
			@RequestParam("email") String email,
			HttpServletResponse response) {
		
		log.info("id = "+ id);
		log.info("name = "+ name);
		log.info("email = "+ email);
		String passwd = memberService.getUserPW(id, name, email);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		if (passwd == null) {
			out.println("<script>alert('입력하신 정보가 틀립니다.'); history.back();</script>");			
		} else {
			SimpleMailMessage message = new SimpleMailMessage();
			message.setTo(email); // 스크립트에서 보낸 메일을 받을 사용자 이메일 주소		
			message.setSubject("패스워드 전송");
			message.setText("패스워드 : " + passwd);
			javaMailSender.send(message);
			out.println("<script>alert('"+email+"로 비밀번호가 전송 되었습니다.'); window.open('about:blank','_self').self.close();</script>");
		}
		
	}
	
	@PostMapping("/findID")
	public void findID(@RequestParam("name") String name,
			@RequestParam("email") String email,
			HttpServletResponse response) {
		
		log.info("name = "+ name);
		log.info("email = "+ email);
		
		String findId = memberService.getUserID(name, email);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		if (findId == null) {
			out.println("<script>alert('입력하신 정보가 틀립니다.'); history.back();</script>");			
		} else {
			
			out.println("<script>alert('당신의 아이디는 "+ findId +" 입니다.'); window.open('about:blank','_self').self.close();</script>");
		}
		
	}
}









