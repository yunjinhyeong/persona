package com.example.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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

import com.example.domain.AttachVo;
import com.example.domain.EventImgVo;
import com.example.domain.EventPosterVo;
import com.example.domain.EventVo;
import com.example.domain.NoticeVo;
import com.example.domain.PageDto;
import com.example.service.AttachService;
import com.example.service.EventPosterService;
import com.example.service.EventService;
import com.example.service.MemberService;
import com.example.service.MovieService;
import com.example.service.MySqlService;
import com.example.service.NoticeService;
import com.example.service.StoreService;
import com.example.service.WatchMovieService;

import lombok.extern.java.Log;
import net.coobird.thumbnailator.Thumbnailator;

@Log
@Controller
@RequestMapping("/chart/*")
public class ChartController {

	@Autowired
	private WatchMovieService watchMovieService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private StoreService storeService;
	@Autowired
	private MovieService movieService;
	@Autowired
	private MySqlService mySqlService;


	@GetMapping("/")
	public String main() {
		log.info("main 호출됨");


		return "admin/chart";
	}

	@GetMapping(value = "/getNameTheatherCount", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	@ResponseBody // 리턴 객체를 JSON 문자열로 변환해서 응답을 줌
	public JSONArray getNameTheatherCount(Model model) {
		JSONArray jsonArray = new JSONArray();
		List<Map<String, Object>> getNameTheatherCount = watchMovieService.getNameTheatherCount();

		for (Map<String, Object> map : getNameTheatherCount) {
			String name = (String) map.get("name");
			long count = (long) map.get("count");

			JSONArray rowArray = new JSONArray();
			rowArray.add(0, name);
			rowArray.add(1, count);

			jsonArray.add(rowArray);
		} // for

		JSONArray titleArray = new JSONArray();
		titleArray.add("이름");
		titleArray.add("회원수");

		jsonArray.add(0, titleArray);

		return jsonArray;
	} // ajaxChartDataMember

	@GetMapping(value = "/ageRangePerCount", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	@ResponseBody // 리턴 객체를 JSON 문자열로 변환해서 응답을 줌
	public JSONArray ageRangePerCount(Model model) {
		JSONArray jsonArray = new JSONArray();
		List<Map<String, Object>> getAgeRangePerCount = memberService.getAgeRangePerCount();

		for (Map<String, Object> map : getAgeRangePerCount) {
			String age_range = (String) map.get("age_range");
			long count = (long) map.get("count");

			JSONArray rowArray = new JSONArray();
			rowArray.add(0, age_range);
			rowArray.add(1, count);

			jsonArray.add(rowArray);
		} // for

		JSONArray titleArray = new JSONArray();
		titleArray.add("나이대");
		titleArray.add("회원수");

		jsonArray.add(0, titleArray);

		return jsonArray;
	} // ajaxChartDataMember

	@GetMapping(value = "/getCountByArea", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	@ResponseBody // 리턴 객체를 JSON 문자열로 변환해서 응답을 줌
	public JSONArray getCountByArea(Model model) {
		JSONArray jsonArray = new JSONArray();
		List<Map<String, Object>> getCountByArea = watchMovieService.getCountByArea();

		for (Map<String, Object> map : getCountByArea) {
			String area = (String) map.get("area");
			long count = Integer.parseInt(String.valueOf(map.get("count")));

			JSONArray rowArray = new JSONArray();
			rowArray.add(0, area);
			rowArray.add(1, count);

			jsonArray.add(rowArray);
		} // for

		JSONArray titleArray = new JSONArray();
		titleArray.add("지역");
		titleArray.add("예매수");

		jsonArray.add(0, titleArray);

		return jsonArray;
	} // ajaxChartDataMember

	@GetMapping(value = "/getAreaDateTheaterByArea", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	@ResponseBody // 리턴 객체를 JSON 문자열로 변환해서 응답을 줌
	public JSONArray getAreaDateTheaterByArea(Model model) {
		JSONArray jsonArray = new JSONArray();
		List<Map<String, Object>> getAreaDateTheaterByArea = watchMovieService.getAreaDateTheaterByArea();

		for (Map<String, Object> map : getAreaDateTheaterByArea) {
			String area = (String) map.get("area");
			long count = (long) map.get("count");
			long date = (long) map.get("date");
			String theater = (String) map.get("theater");


			JSONArray rowArray = new JSONArray();
			rowArray.add(0, area);
			rowArray.add(1, count);
			rowArray.add(2, date);
			rowArray.add(3, theater);

			jsonArray.add(rowArray);
		} // for

		JSONArray titleArray = new JSONArray();
		titleArray.add("지역");
		titleArray.add("예매수");
		titleArray.add("날짜");
		titleArray.add("극장");

		jsonArray.add(0, titleArray);

		return jsonArray;
	} // ajaxChartDataMember

	@GetMapping(value = "/getSalesByDay", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	@ResponseBody // 리턴 객체를 JSON 문자열로 변환해서 응답을 줌
	public JSONArray getSalesByDay(Model model) {
		JSONArray jsonArray = new JSONArray();
		List<Map<String, Object>> getSalesByDay = storeService.getSalesByDay();

		for (Map<String, Object> map : getSalesByDay) {
			String day = (String) map.get("day");
			long total = Integer.parseInt(String.valueOf(map.get("total")));

			JSONArray rowArray = new JSONArray();
			rowArray.add(0, day);
			rowArray.add(1, total);

			jsonArray.add(rowArray);
		} // for

		JSONArray titleArray = new JSONArray();
		titleArray.add("날짜");
		titleArray.add("매출액");

		jsonArray.add(0, titleArray);

		return jsonArray;
	} // ajaxChartDataMember


	@GetMapping(value = "/getDateAtMovie", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	@ResponseBody // 리턴 객체를 JSON 문자열로 변환해서 응답을 줌
	public JSONArray getDateAtMovie(Model model) {
		JSONArray jsonArray = new JSONArray();
		List<Map<String, Object>> getDateAtMovie = movieService.getDateAtMovie();

		for (Map<String, Object> map : getDateAtMovie) {
			String title = (String) map.get("title");
			Double score = (Double) map.get("score");
			Double rate = (Double) map.get("rate");
			String genre = (String) map.get("genre");


			JSONArray rowArray = new JSONArray();
			rowArray.add(0, title);
			rowArray.add(1, score);
			rowArray.add(2, rate);
			rowArray.add(3, genre);

			jsonArray.add(rowArray);
		} // for

		JSONArray titleArray = new JSONArray();
		titleArray.add("지역");
		titleArray.add("평점");
		titleArray.add("예매율");
		titleArray.add("장르");

		jsonArray.add(0, titleArray);

		return jsonArray;
	} // ajaxChartDataMember

	@GetMapping(value = "/getCountByAreas", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	@ResponseBody // 리턴 객체를 JSON 문자열로 변환해서 응답을 줌
	public JSONArray getCountByAreas(Model model) {
		JSONArray jsonArray = new JSONArray();
		List<Map<String, Object>> getCountByArea = watchMovieService.getCountByArea();

		for (Map<String, Object> map : getCountByArea) {
			String area = (String) map.get("area");
			long count = Integer.parseInt(String.valueOf(map.get("count")));

			JSONArray rowArray = new JSONArray();
			rowArray.add(0, area);
			rowArray.add(1, count);

			jsonArray.add(rowArray);
		} // for

		JSONArray titleArray = new JSONArray();
		titleArray.add("지역");
		titleArray.add("영화예매수");

		jsonArray.add(0, titleArray);

		return jsonArray;
	} // ajaxChartDataMember
}





