package com.example.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.ServletContext;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.domain.MImgTrailerVo;
import com.example.domain.MemberVo;
import com.example.domain.MovieVo;
import com.example.domain.NoticeVo;
import com.example.domain.OrderStoreVo;
import com.example.domain.PageDto;
import com.example.domain.PattachVo;
import com.example.domain.ReservationSeatVo;
import com.example.service.CommentService;
import com.example.service.MemberService;
import com.example.service.MovieLikeService;
import com.example.service.MovieService;
import com.example.service.PattachService;
import com.example.service.StoreService;
import com.example.service.WatchMovieService;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;

import lombok.extern.java.Log;
import net.coobird.thumbnailator.Thumbnailator;

@Log
@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private JavaMailSender javaMailSender;

	@Autowired
	private PattachService pattachService;

	@Autowired
	private WatchMovieService watchMovieService;

	@Autowired
	private StoreService storeService;

	@Autowired
	private MovieLikeService movieLikeService;

	@Autowired
	private MovieService movieService;


//
//	public void setMemberService(MemberService memberService) {
//		this.memberService = memberService;
//	}


	@GetMapping("/list")
	public String list(
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "") String category,
			@RequestParam(defaultValue = "") String search,
			Model model) {

		//int count = noticeService.getCountAll();
		int count = memberService.getCountBySearch(category, search);

		int pageSize = 10;

		int startRow = (pageNum - 1) * pageSize;

		List<MemberVo> memberList = null;
		if (count > 0) {
			//noticeList = noticeService.getNotices(startRow, pageSize);
			memberList = memberService.getMembersBySearch(startRow, pageSize, category, search);
		}


		PageDto pageDto = new PageDto();

		if (count > 0) {
			int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
			//int pageCount = (int) Math.ceil((double) count / pageSize);

			int pageBlock = 5;

			// 1~5          6~10          11~15          16~20       ...
			// 1~5 => 1     6~10 => 6     11~15 => 11    16~20 => 16
			int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;

			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount) {
				endPage = pageCount;
			}

			pageDto.setCategory(category);
			pageDto.setSearch(search);
			pageDto.setCount(count);
			pageDto.setPageCount(pageCount);
			pageDto.setPageBlock(pageBlock);
			pageDto.setStartPage(startPage);
			pageDto.setEndPage(endPage);
		} // if


		model.addAttribute("memberList", memberList);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);

		return "admin/memberNotice";
	} // list


	@GetMapping("/kalogin")
    public String home(@RequestParam(value = "code", required = false) String code, HttpSession session) throws Exception{
		System.out.println("#########" + code);
        String access_Token = memberService.getAccessToken(code);
        System.out.println("#########" + access_Token);
        HashMap<String, Object> userInfo = memberService.getUserInfo(access_Token);        
        session.setAttribute("id", userInfo.get("name"));
        
        return "index";
    }


	//	@RequestMapping(value = "/join", method = RequestMethod.GET)
	@GetMapping("/loginjoin")
	public void join() {
		log.info("GET - join() 호출됨");
//		return "member/join";   // 메소드 리턴타입이 String일 경우
	}


	@PostMapping("/join")
	public String join(MemberVo memberVo, @RequestParam String email) {
		log.info("POST - join() 호출됨");

		// 회원가입 날짜 설정
		memberVo.setRegDate(new Timestamp(System.currentTimeMillis()));
		log.info("memberVo : " + memberVo);

		// 회원가입 처리
		memberService.addMember(memberVo);

		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(email);
		message.setSubject("PERSONA에 오신걸 환영합니다.~");
		message.setText("PERSONA에서 영화도 관람하고 좋은 추억 만드세요~");
		log.info("message : " + message);
		javaMailSender.send(message);

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


	@GetMapping("delete")
	public String delete(String id, String pageNum, HttpServletRequest request) {
		log.info("delete id : " + id);

		// notice 게시글 한개와 attach 첨부파일 여러개를 트랜잭션으로 삭제하기
		memberService.deleteById(id);

		// 글목록으로 리다이렉트 이동
		return "redirect:/member/list?pageNum=" + pageNum;
	} // delete


	@GetMapping("/logout")
	public String logout(HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response) {


			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=null;
			try {
				out = response.getWriter();
				out.println("<script>");
				out.println("document.cookie = 'token=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';");
				out.println("localStorage.removeItem('token');");
				out.println("localStorage.removeItem('access_token');");
				out.println("sessionStorage.removeItem('token');");
				out.println("sessionStorage.removeItem('access_token');");
				out.println("ctx.cookies.set('access_token');");
				out.println("</script>");

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

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

	@GetMapping("/mypage")
	public String mypage(String id, Model model, HttpServletResponse response) {
		log.info("id : " + id);
		int isMember = memberService.getMemberGender(id);
		boolean soMember;
		if(isMember==0) {
			soMember = false;
		} else {
			soMember = true;
		}
		log.info("soMember : " + soMember);
		log.info("isMember : " + isMember);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (!soMember) {
			out.println("<script>alert('PERSONA에 공식적으로 가입하셔야됩니다.'); history.back();</script>");
			out.flush();
			
		} else {}
		
		MemberVo memberVo = memberService.getMemberById(id);

		List<PattachVo> pattachList = pattachService.getPattachById(id);

		List<ReservationSeatVo> rSeatList = watchMovieService.getReservationSeats(id);

		List<OrderStoreVo> orderList = storeService.getOrderDateById(id);

		log.info("memberVo : " + memberVo);
		log.info("pattachList"+ pattachList);

		String total = memberService.getTotalById(id);

		log.info(total);

		if(total == null){
			total = "0";
			int to = Integer.parseInt(total);
			log.info("total : " + total);
			log.info("to : " + to);

			int totalsum = to;
			log.info("totalsum : " + totalsum);

			//total에 56000들어옴
			if(totalsum >= 0 && totalsum<50000){
				memberVo.setGrade("bronze");
			} else if( totalsum >= 50000 && totalsum < 100000){
				memberVo.setGrade("silver");
			} else if(totalsum >= 100000 && totalsum <150000) {
				memberVo.setGrade("gold");
			} else {
				memberVo.setGrade("vip");
			}
		}

		int to = Integer.parseInt(total);
		log.info("total : " + total);
		log.info("to : " + to);

		int totalsum = to;
		log.info("totalsum : " + totalsum);


		//total에 56000들어옴
		if(totalsum >= 0 && totalsum<50000){
			memberVo.setGrade("bronze");
		} else if( totalsum >= 50000 && totalsum < 100000){
			memberVo.setGrade("silver");
		} else if(totalsum >= 100000 && totalsum <150000) {
			memberVo.setGrade("gold");
		} else {
			memberVo.setGrade("vip");
		}

		memberService.update(memberVo);

		List<MovieVo> mlist = movieService.getMovies(0, 100);
		List<MovieVo> likedMovieList = new ArrayList();

		log.info("mlist : " + mlist);
		for(MovieVo mVo : mlist)
		{
			int movieNum = mVo.getMNum();
			int count = movieLikeService.getCountByNumAndId(movieNum, id);
			if(count == 1) {
				int isLike = movieLikeService.getIsLikeByNumAndId(movieNum, id);
			    if(isLike == 1) {
			    	likedMovieList.add(mVo);
			    }
			}
		}

		model.addAttribute("likedMovieList", likedMovieList);
		model.addAttribute("orderList", orderList);
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("pattachList", pattachList);
		model.addAttribute("rSeatList", rSeatList);
		//model.addAttribute("fileCount", fileCount);


		return "member/mypage";
	}


	@GetMapping("/addProfile")
	public String addProfile(String id, Model model) {
		log.info("get addProfile호출됨");

		MemberVo memberVo = memberService.getMemberById(id);
		model.addAttribute("memberVo", memberVo);


		return "member/addProfile";
	}

	// 오늘 날짜 형식의 폴더 문자열 가져오기
	private String getFolder() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		String strDate = sdf.format(date); // "2020/11/11"
		return strDate;
	}

	private boolean isImage(String filename) {
		boolean result = false;

		// aaaa.bbb.ccc.ddd
		int index = filename.lastIndexOf(".");
		String ext = filename.substring(index + 1);

		if (ext.equalsIgnoreCase("jpg")
				|| ext.equalsIgnoreCase("jpeg")
				|| ext.equalsIgnoreCase("gif")
				|| ext.equalsIgnoreCase("png")) {
			result = true;
		}
		return result;
	}


	@PostMapping("/addProfile")
	public String addProfile(HttpServletRequest request, @RequestParam("filename") List<MultipartFile> multipartFiles, MemberVo memberVo) throws IOException{



		//============ 파일 업로드를 위한 폴더 준비 ==============
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/");  // webapp 폴더의 실제경로
		log.info("realPath : " + realPath);

		String strDate = this.getFolder();

		File dir = new File(realPath + "/upload2", strDate);
		log.info("dir : " + dir.getPath());

		if (!dir.exists()) {
			dir.mkdirs();
		}



		//============ MultipartFile을 이용해 파일업로드 수행 ==============
		List<PattachVo> pattachList = new ArrayList<>();

		for(MultipartFile multipartFile : multipartFiles) {
			if(multipartFile.isEmpty()) {
				continue;
			}
			//실제 업로드한 파일이름 구하기
			String filename = multipartFile.getOriginalFilename();

			//익스플로러는 파일이름에 경로가 포함되어 있으므로
			//순수 파일이름만 부분 문자열로 가져오기
			int beginIndex = filename.lastIndexOf("\\")+1;
			filename = filename.substring(beginIndex);

			//파일명 중복을 피하기 위해서 파일이름 앞에 붙일 UUID 문자열 구하기
			UUID uuid = UUID.randomUUID();
			String strUuid = uuid.toString();

			//업로드(생성)할 파일이름
			String uploadFilename = strUuid + "_" + filename;

			// 생성할 파일정보를 File 객체로 준비
			File saveFile = new File(dir, uploadFilename);

			// 임시업로드된 파일을 지정경로의 파일명으로 생성(복사)
			multipartFile.transferTo(saveFile);

			//============ 첨부파일 PattachVo 준비하기 ==============
			PattachVo pattachVo = new PattachVo();
			pattachVo.setId(memberVo.getId());

			pattachVo.setUuid(strUuid);
			pattachVo.setFilename(filename);
			pattachVo.setUploadpath(strDate);

			log.info("pattachVo : " + pattachVo);

			if(isImage(filename)) {
				pattachVo.setImage("I");

				File thumbnailFile = new File(dir, "s_"+ uploadFilename);
				//썸네일 이미지 파일 생성하기
				try (FileOutputStream fos = new FileOutputStream(thumbnailFile)){
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), fos, 100, 100);
				}
			}else {
					pattachVo.setImage("O");
				}

			pattachList.add(pattachVo);
			}//for

		memberService.addPattaches(pattachList);

		log.info("post addProfile 호출됨");


		return "redirect:/member/mypage";
	}

	@GetMapping("/modify")
	public String modify(String id, Model model) {
		log.info("get modify ");
		MemberVo memberVo = memberService.getMemberById(id);
		List<PattachVo> pattachList = pattachService.getPattachById(id);

		log.info("memberVo : " + memberVo);
		log.info("pattachList"+ pattachList);

		model.addAttribute("memberVo", memberVo);
		model.addAttribute("pattachList", pattachList);
		log.info("get modify memberVo : " + memberVo);

		return "member/modifyForm";
	}


	@PostMapping("/modify")
	public String modify(HttpServletRequest request,
			@RequestParam(name = "filename", required = false) List<MultipartFile> multipartFiles,
			MemberVo memberVo, String id,
			@RequestParam(name = "delfile",required = false) List<Integer> delFileNums,
			RedirectAttributes rttr) throws IOException {

		//============ 파일 업로드를 위한 폴더 준비 ==============
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/");  // webapp 폴더의 실제경로
		log.info("realPath : " + realPath);

		String strDate = this.getFolder();

		File dir = new File(realPath + "/upload2", strDate);
		log.info("dir : " + dir.getPath());

		if (!dir.exists()) {
			dir.mkdirs();
		}


		//============ MultipartFile을 이용해 파일업로드 수행 ==============
				List<PattachVo> pattachList = new ArrayList<>();

				if(multipartFiles != null) {
					for(MultipartFile multipartFile : multipartFiles) {
						if(multipartFile.isEmpty()) {
							continue;
						}
						//실제 업로드한 파일이름 구하기
						String filename = multipartFile.getOriginalFilename();

						//익스플로러는 파일이름에 경로가 포함되어 있으므로
						//순수 파일이름만 부분 문자열로 가져오기
						int beginIndex = filename.lastIndexOf("\\")+1;
						filename = filename.substring(beginIndex);

						//파일명 중복을 피하기 위해서 파일이름 앞에 붙일 UUID 문자열 구하기
						UUID uuid = UUID.randomUUID();
						String strUuid = uuid.toString();

						//업로드(생성)할 파일이름
						String uploadFilename = strUuid + "_" + filename;

						// 생성할 파일정보를 File 객체로 준비
						File saveFile = new File(dir, uploadFilename);

						// 임시업로드된 파일을 지정경로의 파일명으로 생성(복사)
						multipartFile.transferTo(saveFile);

						//============ 첨부파일 PattachVo 준비하기 ==============
						PattachVo pattachVo = new PattachVo();
						pattachVo.setId(memberVo.getId());

						pattachVo.setUuid(strUuid);
						pattachVo.setFilename(filename);
						pattachVo.setUploadpath(strDate);

						log.info("pattachVo : " + pattachVo);

						if(isImage(filename)) {
							pattachVo.setImage("I");

							File thumbnailFile = new File(dir, "s_"+ uploadFilename);
							//썸네일 이미지 파일 생성하기
							try (FileOutputStream fos = new FileOutputStream(thumbnailFile)){
								Thumbnailator.createThumbnail(multipartFile.getInputStream(), fos, 100, 100);
							}
						}else {
								pattachVo.setImage("O");
							}

						pattachList.add(pattachVo);
						}//for
				}


				//============ delFileNums 로 첨부파일 삭제작업 수행 ==============

				if(delFileNums != null) {
					for(int num : delFileNums) {
						//첨부파일 아이디에 해당하는 첨부파일 정보 한개를 VO로 가져오기
						PattachVo pattachVo = pattachService.getPattachById2(id);

						//파일정보로 실제파일 존재여뷰 확인해서 삭제하기
						String path = realPath + "/upload2/" + pattachVo.getUploadpath();
						String file = pattachVo.getUuid() + "_" + pattachVo.getFilename();

						File delFile = new File(path, file);
						if(delFile.exists()) {
							delFile.delete();
						}

						if(isImage(pattachVo.getFilename())) {
							File thumbnailFile = new File(path, "s_" + file);
							if(thumbnailFile.exists()) {
								thumbnailFile.delete();
							}
						}


					}//for
				}


				memberService.updateMemberAneAddPattachedAndDeletePattaches(memberVo, pattachList, delFileNums);


		log.info("post modify");
		log.info("memberVo : " + memberVo);
		log.info(memberVo.getId());

		rttr.addAttribute("id", memberVo.getId());


		return "redirect:/member/mypage";
	}

	@PostMapping("/delete")
	public String delete(MemberVo memberVo,HttpServletRequest request) {

		memberService.deleteById(memberVo.getId());
		pattachService.deleteById(memberVo.getId());

		HttpSession session = request.getSession();
		session.invalidate();



		return "redirect:/";
	}

	@RequestMapping(value="/like", method=RequestMethod.POST)
	@ResponseBody
	public void like(@RequestParam Map<String, Object> param, HttpServletRequest request, Model model){
		System.out.println(param);

		int movieNum = Integer.parseInt((String) param.get("movieNum"));
		String userId = (String) param.get("userId");

		movieLikeService.minusMovieLike(movieNum, userId);
		movieService.minusLikesByNum(movieNum);

	 }
}









