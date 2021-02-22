package com.example.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.CSNoticeVo;
import com.example.domain.EventImgVo;
import com.example.domain.MovieMImgVo;
import com.example.service.CSService;
import com.example.service.EventPosterService;
import com.example.service.EventService;
import com.example.service.MovieService;
import com.example.service.MySqlService;
import com.example.service.WatchMovieService;

import lombok.extern.java.Log;

@Log
@Controller // Ŭ���� �ȿ��� @GetMapping ���� �ֳ����̼��� ��� ����
//@RequestMapping("/")

public class HomeController  {


@Autowired
private MovieService movieService;
@Autowired
private MySqlService mySqlService;
@Autowired
private EventService eventService;
@Autowired
private CSService csService;
@Autowired
private WatchMovieService watchMovieService;


	@GetMapping("/index")
	public String home(
		@RequestParam(defaultValue = "1") int pageNum,
		Model model) {

		// ��ȭ ����
		int count = movieService.getCount();

		int pageSize = pageNum * 10;

		List<MovieMImgVo> movieList = null;



		if (count > 0) {
			movieList = movieService.getMoviesMImgForMain(0, pageSize);
			log.info("movieList : " + movieList);
		}
		for(int i=0; i<5; i++ ) {
			String mName = movieList.get(i).getMName();
			log.info(mName);

			//�� ���� ����
			double rcount1 = watchMovieService.getTotalCount();
			log.info("rcount1 : " + rcount1);

			log.info("movieName : " + mName);
			//������ ��ȭ ���� ����
			double scount1 = watchMovieService.getScount(mName);
			log.info("scount1 : " + scount1);

			double a = (scount1/rcount1)*100;
			log.info("a : " + a);

			double bookrate = (Math.round(a*100)/100);
			log.info("bookrate : " + bookrate);

			movieService.updateMrateByName(mName, bookrate);
		}
		movieList = movieService.getMoviesMImgForMain(0, pageSize);

		model.addAttribute("movieList", movieList);
		model.addAttribute("pageNum", pageNum);
		//��ȭ���� ����Ʈ

		//===============

		//���⼭���ʹ� �̺�Ʈ

		//int count = noticeService.getCountAll();
		int countMovie = eventService.getCountByMovie();
		int countPremiere = eventService.getCountByPremiere();
		int countHOT = eventService.getCountByHOT();
		int countDiscount = eventService.getCountByDiscount();


		List<EventImgVo> eventMovieList = null;
		List<EventImgVo> eventPremiereList = null;
		List<EventImgVo> eventHOTList = null;
		List<EventImgVo> eventDiscountList = null;

		if (countMovie > 0) {eventMovieList = eventService.getEventMovieImg();}
		if (countPremiere > 0) {eventPremiereList = eventService.getEventPremiereImg();}
		if (countHOT > 0) {eventHOTList = eventService.getEventHOTImg();}
		if (countDiscount > 0) {eventDiscountList = eventService.getEventDiscountImg();}

		model.addAttribute("eventMovieList", eventMovieList);
		model.addAttribute("eventPremiereList", eventPremiereList);
		model.addAttribute("eventHOTList", eventHOTList);
		model.addAttribute("eventDiscountList", eventDiscountList);
		//�̺�Ʈ ����Ʈ

		//================

		//�������� ����Ʈ
		int countNotice = csService.getCountByNotice();

		List<CSNoticeVo> onlyNoticeList = null;

		if (countNotice > 0) {onlyNoticeList = csService.getNoticesOnly();}

		model.addAttribute("onlyNoticeList", onlyNoticeList);
		log.info("onlyNoticeList: " + onlyNoticeList);



		return "/index";
		}

	@GetMapping("/")
	public String home1(
		@RequestParam(defaultValue = "1") int pageNum,
		Model model) {

		// ��ȭ ����
		int count = movieService.getCount();

		int pageSize = pageNum * 10;

		List<MovieMImgVo> movieList = null;

		if (count > 0) {
			movieList = movieService.getMoviesMImgForMain(0, pageSize);
			log.info("movieList : " + movieList);
		}
		for(int i=0; i<5; i++ ) {
			String mName = movieList.get(i).getMName();
			log.info(mName);

			//�� ���� ����
			double rcount1 = watchMovieService.getTotalCount();
			log.info("rcount1 : " + rcount1);

			log.info("movieName : " + mName);
			//������ ��ȭ ���� ����
			double scount1 = watchMovieService.getScount(mName);
			log.info("scount1 : " + scount1);

			double a = (scount1/rcount1)*100;
			log.info("a : " + a);

			double bookrate = (Math.round(a*100)/100);
			log.info("bookrate : " + bookrate);

			movieService.updateMrateByName(mName, bookrate);
		}

		model.addAttribute("movieList", movieList);
		//��ȭ���� ����Ʈ

		//===============

		//���⼭���ʹ� �̺�Ʈ

		//int count = noticeService.getCountAll();
		int countMovie = eventService.getCountByMovie();
		int countPremiere = eventService.getCountByPremiere();
		int countHOT = eventService.getCountByHOT();
		int countDiscount = eventService.getCountByDiscount();


		List<EventImgVo> eventMovieList = null;
		List<EventImgVo> eventPremiereList = null;
		List<EventImgVo> eventHOTList = null;
		List<EventImgVo> eventDiscountList = null;

		if (countMovie > 0) {eventMovieList = eventService.getEventMovieImg();}
		if (countPremiere > 0) {eventPremiereList = eventService.getEventPremiereImg();}
		if (countHOT > 0) {eventHOTList = eventService.getEventHOTImg();}
		if (countDiscount > 0) {eventDiscountList = eventService.getEventDiscountImg();}

		model.addAttribute("eventMovieList", eventMovieList);
		model.addAttribute("eventPremiereList", eventPremiereList);
		model.addAttribute("eventHOTList", eventHOTList);
		model.addAttribute("eventDiscountList", eventDiscountList);
		//�̺�Ʈ ����Ʈ

		//================

		//�������� ����Ʈ
		int countNotice = csService.getCountByNotice();

		List<CSNoticeVo> onlyNoticeList = null;

		if (countNotice > 0) {onlyNoticeList = csService.getNoticesOnly();}

		model.addAttribute("onlyNoticeList", onlyNoticeList);
		log.info("onlyNoticeList: " + onlyNoticeList);



		return "/index";
		}

	@GetMapping(value = "/ajax/chartDataMember", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	@ResponseBody // 리턴 객체를 JSON 문자열로 변환해서 응답을 줌
	public Map<String, List<Object>> ajaxChartDataMember(@RequestParam Map<String, Object> param) {
		String name = (String) param.get("name");
		log.info("name :" + name);
		Map<String, List<Object>> map = watchMovieService.getAjaxChartDataMember(name);
		log.info("map : " + map);
		return map;
	} // ajaxChartDataMember

}
