package com.example.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.example.domain.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.service.MemberService;
import com.example.service.MovieService;
import com.example.service.MySqlService;
import com.example.service.WatchMovieService;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/watchMovie/*")
public class WatchMovieController {

	@Autowired
	private WatchMovieService watchMovieService;
	@Autowired
	private MySqlService mySqlService;
	@Autowired
	private MovieService movieService;
	@Autowired
	private MemberService memberService;

	@GetMapping("/list")
	public String list(
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "") String category,
			@RequestParam(defaultValue = "") String search,
			Model model) {

		//int count = noticeService.getCountAll();
		int count = watchMovieService.getCountBySearch(category, search);

		int pageSize = 10;

		int startRow = (pageNum - 1) * pageSize;

		List<WatchMovieVo> watchMovieList = null;
		if (count > 0) {
			//noticeList = noticeService.getNotices(startRow, pageSize);
			watchMovieList = watchMovieService.getWatchMoviesBySearch(startRow, pageSize, category, search);
		}

		log.info("watchMovieList final : " + watchMovieList);

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


		model.addAttribute("watchMovieList", watchMovieList);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);

		return "admin/watchMovieNotice";
	} // list

//	@GetMapping("/main/list")
//	public String mainlist(Model model) {
//
//		//int count = noticeService.getCountAll();
//		int countMovie = eventService.getCountByMovie();
//		int countPremiere = eventService.getCountByPremiere();
//		int countHOT = eventService.getCountByHOT();
//		int countDiscount = eventService.getCountByDiscount();
//
//
//		List<EventImgVo> eventMovieList = null;
//		List<EventImgVo> eventPremiereList = null;
//		List<EventImgVo> eventHOTList = null;
//		List<EventImgVo> eventDiscountList = null;
//
//		if (countMovie > 0) {eventMovieList = eventService.getEventMovieImg();}
//		if (countPremiere > 0) {eventPremiereList = eventService.getEventPremiereImg();}
//		if (countHOT > 0) {eventHOTList = eventService.getEventHOTImg();}
//		if (countDiscount > 0) {eventDiscountList = eventService.getEventDiscountImg();}
//
//		model.addAttribute("eventMovieList", eventMovieList);
//		model.addAttribute("eventPremiereList", eventPremiereList);
//		model.addAttribute("eventHOTList", eventHOTList);
//		model.addAttribute("eventDiscountList", eventDiscountList);
//
//		return "event/eventMain";
//	} // mainlist

	@GetMapping("/selectMovie")
	public String selectMovie(String id, HttpSession session, Model model) {
		//String id1 = session.getId();
		log.info("id : " + id);

		model.addAttribute("id", id);



		return "watchMovie/selectMovie";
	} // mainone


	@GetMapping(value = "/getMovieName")
	@ResponseBody
	public List<String> getMovieName(String area, String rule, String id) {

		log.info("id : " + id);
		log.info(area);


		List<String> watchMovieVoList = watchMovieService.getMoviesName(area, rule);
		log.info("watchMovieVoList : " + watchMovieVoList);
		return watchMovieVoList;
	}

	@GetMapping(value = "/getMovieDate")
	@ResponseBody
	public List<WatchMovieVo> getMovieDate(String name,String area,String id) {
		log.info("name : " + name);
		log.info("id : " + id);

		List<WatchMovieVo> watchMovieVoList = watchMovieService.getMoviesDate(name,area);
		log.info("watchMovieVoList : " + watchMovieVoList);
		return watchMovieVoList;
	}

	@GetMapping("/goSeat")
	public String goSeat(String area, String name, String date, String theater, String id, Model model) {

		String area1 = area;
		log.info("area1 : " + area1);
		String date1 = date;
		log.info("date1 : " + date1);
		String id1 = id;
		log.info("id1 : " + id1);
		String theater1 = theater;
		log.info("theater1 : " + theater);

		if(date.contains(" AM ")) {
			date = date.replace(" AM ", "T");
			if(Integer.valueOf(date.substring(11,13))==12) {
				date = date.replace(date.substring(11,13),"00");
				log.info("dateAM : " + date);
			}
		}

		if(date.contains(" PM ")) {
			date = date.replace(" PM ", "T");
			System.out.println(date);
			int sum1 = Integer.valueOf(date.substring(11,13))+12;
			String sum2 = Integer.toString(sum1);
			date = date.replace(date.substring(11,13), sum2);
			log.info("datePM : " + date);
		}
		log.info("date final : " + date);
		int noNum = watchMovieService.getNoNum(area, name, date, theater);
		log.info("noNum final : " + noNum);

		model.addAttribute("noNum", noNum);
		model.addAttribute("name", name);
		model.addAttribute("area1",area1);
		model.addAttribute("date1",date1);
		model.addAttribute("id1", id1);
		model.addAttribute("theater1", theater1);
		return "watchMovie/selectSeat";
	}


	@GetMapping(value = "/createSeat" , produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public Map<Integer, Boolean> createSeat(int noNum, Model model) {
		Map<Integer, Boolean> seat = new HashMap<>();

		for(int id=0 ; id<50 ; id++) {
			String fid = String.valueOf(id);
			//log.info("돌아 : " + fid);
			int fcount = watchMovieService.getSeatAble(noNum, fid);
			if(fcount==1) {
				seat.put(id, false);
			} else if(fcount==0) {
				seat.put(id, true);
			}
			//log.info("돌아 : " + fcount);
		}

		log.info("seat final : " + seat);

		return seat;
	}

	@PostMapping("/kakaoPay")
	public String kakaoPay( @RequestParam("seatId") List<String> seatId, int noNum, String id, String name, int price, String date, String area, String theater, Model model) {

		log.info("POST seatId final : " + seatId);
		log.info("POST noNum final : " + noNum);
		log.info("POST id final : " + id);
		log.info("POST date final : " + date);
		log.info("POST area final : " + area);
		log.info("POST theater final : " + theater);

		String theater1=theater;

		//총 예매 갯수
		double rcount1 = watchMovieService.getTotalCount();
		log.info("rcount : " + rcount1);

		log.info("movieName : " + name);
		//선택한 영화 예매 갯수
		double scount = watchMovieService.getScount(name);
		log.info("scount : " + scount);

		double a = (scount/rcount1)*100;
		log.info("a : " + a);

		double bookrate = (Math.round(a*100)/100);
		log.info("bookrate : " + bookrate);


		model.addAttribute("seatId", seatId);
		model.addAttribute("id1", id);
		model.addAttribute("name", name);
		model.addAttribute("price", price);
		model.addAttribute("date", date);
		model.addAttribute("area", area);
		model.addAttribute("noNum", noNum);
		model.addAttribute("theater1", theater1);
		return "watchMovie/kakaoPay";
	} // POST - write

	@GetMapping("/kakaoPay")
	public String kakaoPayGet(MemberVo memberVo, MovieSeatVo movieSeatVo, BookMovieVo bookMovieVo, @RequestParam("seatId") List<String> seatId, String name, int noNum, String id, String area, String date, String price, String theater1, Model model) {
		log.info("GET seatId final : " + seatId);
		log.info("GET noNum final : " + noNum);
		log.info("GET id final : " + id);
		log.info("GET area final : " + area);
		log.info("GET date final : " + date);
		log.info("GET price final : " + price);
		log.info("GET theater1 final : " + theater1);

		int price1 = Integer.parseInt(price);

		String gender = memberService.getGender(id);
		log.info("gender : "+ gender);

		movieSeatVo.setRegDate(new Timestamp(System.currentTimeMillis()));
		movieSeatVo.setNoNum(noNum);
		movieSeatVo.setId(id);
		movieSeatVo.setName(name);
		movieSeatVo.setArea(area);
		movieSeatVo.setDate(date);
		movieSeatVo.setGender(gender);

		bookMovieVo.setId(id);
		bookMovieVo.setArea(area);
		bookMovieVo.setTheater(theater1);
		bookMovieVo.setDate(date);
		bookMovieVo.setName(name);
		bookMovieVo.setPrice(price1);

		log.info("bookMovieVo : " + bookMovieVo);

		//사용자가 예매한 내역 다 저장
		watchMovieService.addBookedMovie(bookMovieVo);


		for (String fseatId : seatId) {
			movieSeatVo.setSeat(fseatId);
			watchMovieService.addSeat(movieSeatVo);
		}
		//총 예매 갯수
		double rcount1 = watchMovieService.getTotalCount();
		log.info("rcount1 : " + rcount1);

		log.info("movieName : " + name);
		//선택한 영화 예매 갯수
		double scount1 = watchMovieService.getScount(name);
		log.info("scount1 : " + scount1);

		double a = (scount1/rcount1)*100;
		log.info("a : " + a);

		double bookrate = (Math.round(a*100)/100);
		log.info("bookrate : " + bookrate);

		movieService.updateMrateByName(name, bookrate);


		return "redirect:/watchMovie/selectMovie";
	} // POST - write


	@GetMapping("/write")
	public String write(@ModelAttribute("pageNum") String pageNum, Model model) {

//		model.addAttribute("pageNum", pageNum);

		return "admin/watchMovieWriteForm";
	} // GET - write


	// 주글쓰기
	@PostMapping("/write")
	public String write(HttpServletRequest request,
			WatchMovieVo watchMovieVo, String pageNum, String date) throws IOException {

		//============ 게시글 NoticeVo 준비하기 ==============
		// AUTO INCREMENT 다음번호 가져오기
		int num = mySqlService.getNextNum("watchmovie");
		watchMovieVo.setNum(num);
		watchMovieVo.setRegDate(new Timestamp(System.currentTimeMillis()));

		log.info("date :" + date);

		// NoticeVo 를 DB에 insert하기
		//noticeService.addNotice(noticeVo);

		// NoticeVo와 AttachVo 여러개를 트랜잭션으로 insert하기
		watchMovieService.addWatchMovie(watchMovieVo);

		// 자료실 게시판 상세보기로 리다이렉트
		return "redirect:/watchMovie/content?num=" + watchMovieVo.getNum() + "&pageNum=" + pageNum;
	} // POST - write


	@GetMapping("/content")
	public String content(int num, @ModelAttribute("pageNum") String pageNum, Model model) {

		WatchMovieVo watchMovieVo = watchMovieService.getWatchMovie(num);

		model.addAttribute("watchMovieVo", watchMovieVo);

		return "admin/watchMovieContent";
	} // content

	@GetMapping("delete")
	public String delete(int num, String name, String pageNum) {

		log.info("pageNum : " + pageNum);
		log.info("num : " + num);
		log.info("name : " + name);

		// notice 게시글 한개와 attach 첨부파일 여러개를 트랜잭션으로 삭제하기
		watchMovieService.deleteWatchMovie(num);

		watchMovieService.deleteMovieSeat(num);

		//총 예매 갯수
				double rcount1 = watchMovieService.getTotalCount();
				log.info("rcount1 : " + rcount1);

				log.info("movieName : " + name);
				//선택한 영화 예매 갯수
				double scount1 = watchMovieService.getScount(name);
				log.info("scount1 : " + scount1);

				double a = (scount1/rcount1)*100;
				log.info("a : " + a);

				double bookrate = (Math.round(a*100)/100);
				log.info("bookrate : " + bookrate);
				movieService.updateMrateByName(name, bookrate);



		// 글목록으로 리다이렉트 이동
		return "redirect:/watchMovie/list?pageNum=" + pageNum;
	} // delete

	@GetMapping("deleteSeat")
	public String deleteSeat(int num, String seat, String id) {
		log.info("num : " + num);
		// notice 게시글 한개와 attach 첨부파일 여러개를 트랜잭션으로 삭제하기
		watchMovieService.deleteSeat(num, seat);

		// 글목록으로 리다이렉트 이동
		return "redirect:/member/mypage?id="+id;
	} // delete


	@GetMapping("/modify")
	public String modify(int num, @ModelAttribute("pageNum") String pageNum, Model model) {
		WatchMovieVo watchMovieVo = watchMovieService.getWatchMovie(num);

		model.addAttribute("watchMovieVo", watchMovieVo);

		return "admin/watchMovieModifyForm";
	} // GET - modify


	@PostMapping("/modify")
	public String modify(HttpServletRequest request,
			WatchMovieVo watchMovieVo, String pageNum,
			RedirectAttributes rttr) throws IOException {

		// 트랜잭션 단위로 테이블 데이터 처리
		watchMovieService.updateWatchMovie(watchMovieVo);


		rttr.addAttribute("num", watchMovieVo.getNum());
		rttr.addAttribute("pageNum", pageNum);

		// 상세보기 화면으로 리다이렉트 이동
		return "redirect:/watchMovie/content";
	} // POST - modify

}





