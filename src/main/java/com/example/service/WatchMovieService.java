package com.example.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.AttachVo;
import com.example.domain.BookMovieVo;
import com.example.domain.EventImgVo;
import com.example.domain.EventPosterVo;
import com.example.domain.EventVo;
import com.example.domain.MovieSeatVo;
import com.example.domain.NoticeVo;
import com.example.domain.ReservationSeatVo;
import com.example.domain.WatchMovieVo;
import com.example.mapper.AttachMapper;
import com.example.mapper.EventMapper;
import com.example.mapper.EventPosterMapper;
import com.example.mapper.NoticeMapper;
import com.example.mapper.WatchMovieMapper;

import lombok.extern.java.Log;

@Service
@Log
public class WatchMovieService {

	@Autowired
	private WatchMovieMapper watchMovieMapper;


	public int getTotalCount() {
		int count = watchMovieMapper.getTotalCount();
		return count;
	}

	public int getScount(String movieName) {
		int scount = watchMovieMapper.getScount(movieName);
		return scount;
	}

	public List<ReservationSeatVo> getReservationSeats(String id) {
		List<ReservationSeatVo> list = watchMovieMapper.getReservationSeats(id);
		return list;
	}

	// 주글쓰기
	public void addWatchMovie(WatchMovieVo watchMovieVo) {
		watchMovieMapper.addWatchMovie(watchMovieVo);
	}

	public List<String> getMoviesName(String area, String rule) {
		List<String> names = watchMovieMapper.getMoviesName(area, rule);
		return names;
	}

	public List<WatchMovieVo> getMoviesDate(String name, String area) {
		List<WatchMovieVo> dates = watchMovieMapper.getMoviesDate(name, area);
		return dates;
	}

	public int getNoNum(String area, String name, String date, String theater) {
		int noNum = watchMovieMapper.getNoNum(area, name, date, theater);
		return noNum;
	}

	public int getSeatAble(int noNum, String seat) {
		return watchMovieMapper.getSeatAble(noNum, seat);
	}

	public void addSeat(MovieSeatVo movieSeatVo) {
		watchMovieMapper.addSeat(movieSeatVo);
	}

	public void addBookedMovie(BookMovieVo bookMovieVo){
		watchMovieMapper.addBookedMovie(bookMovieVo);
	}

	public void deleteWatchMovie(int num) {
		watchMovieMapper.deleteWatchMovie(num);
	}

	public void deleteMovieSeat(int num) {
		watchMovieMapper.deleteMovieSeat(num);
	}
	public void deleteSeat(int num, String seat) {
		watchMovieMapper.deleteSeat(num, seat);
	}

	public int getCountBySearch(String category, String search) {
		int count = watchMovieMapper.getCountBySearch(category, search);
		return count;
	}

	public List<Map<String, Object>> getNameTheatherCount() {
		List<Map<String, Object>> list = watchMovieMapper.getNameTheatherCount();
		return list;
	}

	public List<Map<String, Object>> getCountByArea() {
		List<Map<String, Object>> list = watchMovieMapper.getCountByArea();
		return list;
	}

	public List<Map<String, Object>> getAreaDateTheaterByArea() {
		List<Map<String, Object>> list = watchMovieMapper.getAreaDateTheaterByArea();
		return list;
	}

	public List<WatchMovieVo> getWatchMoviesBySearch(int startRow, int pageSize, String category, String search) {
		return watchMovieMapper.getWatchMoviesBySearch(startRow, pageSize, category, search);
	}

	public WatchMovieVo getWatchMovie(int num) {
		return watchMovieMapper.getWatchMovie(num);
	}

	public void updateWatchMovie(WatchMovieVo watchMovieVo) {
		watchMovieMapper.updateWatchMovie(watchMovieVo);
	}

	public Map<String, List<Object>> getAjaxChartDataMember(String name){
		Map<String, List<Object>> allDataMap = new HashMap<>();

		//=====================성별 회원수 구하기================
		List<Object> genderPerCountList = new ArrayList<>();

		List<String> titleList1 = new ArrayList<>();
		titleList1.add("성별");
		titleList1.add("회원수");

		genderPerCountList.add(titleList1);

	//log.info("name : " + name);

		List<Map<String, Object>> dbList1 = watchMovieMapper.getGenderPerCount(name);

		for(Map<String, Object> rowMap : dbList1) {
			String gender = (String) rowMap.get("gender");
			long cnt = (long) rowMap.get("cnt");

			List<Object> rowList = new ArrayList<>();
			rowList.add(gender);
			rowList.add(cnt);

			genderPerCountList.add(rowList);
		}	// for

		allDataMap.put("genderPerCountList", genderPerCountList);
		return allDataMap;
	} // getAjaxChartDataMember

}





