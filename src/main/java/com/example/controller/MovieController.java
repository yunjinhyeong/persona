package com.example.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.logging.Logger;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.domain.AttachVo;
import com.example.domain.MCommentVo;
import com.example.domain.MImgTrailerVo;
import com.example.domain.MovieMImgVo;
import com.example.domain.MovieVo;
import com.example.domain.NoticeVo;
import com.example.domain.PageDto;
import com.example.service.AttachService;
import com.example.service.CommentService;
import com.example.service.MCommentService;
import com.example.service.MImgTrailerService;
import com.example.service.MovieLikeService;
import com.example.service.MovieService;
import com.example.service.MySqlService;
import com.example.service.NoticeService;
import com.example.service.WatchMovieService;

import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Log
@Controller
@RequestMapping("/movieNotice/*")
public class MovieController {

	@Autowired
	private MovieService movieService;
	@Autowired
	private MImgTrailerService mImgTrailerService;
	@Autowired
	private MySqlService mySqlService;
	@Autowired
	private MovieLikeService movieLikeService;
	@Autowired
	private MCommentService mcommentService;
	@Autowired
	private WatchMovieService watchMovieService;

	@GetMapping("/list")
	public String list(
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "") String category,
			@RequestParam(defaultValue = "") String search,
			Model model) {

		//int count = noticeService.getCountAll();
		int count = movieService.getCountBySearch(category, search);

		int pageSize = 10;

		int startRow = (pageNum - 1) * pageSize;

		List<MovieVo> movieList = null;
		if (count > 0) {
			//movieList = noticeService.getNotices(startRow, pageSize);
			movieList = movieService.getMoviesBySearch(startRow, pageSize, category, search);
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


		model.addAttribute("movieList", movieList);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);

		return "admin/movieNotice";
	} // list


	@GetMapping("/nowList" )
	public String nowList(
			@RequestParam(defaultValue = "1") int pageNum,
			Model model) {

		log.info("GET nowList 호출됨");

		// 총 영화 수
		int count = movieService.getCount();

		int pageSize = pageNum * 15;

		List<MovieMImgVo> movieList = null;



		if (count > 0) {
			movieList = movieService.getMoviesMImg(0, pageSize);
			log.info("movieList : " + movieList);
		}
		for(int i=0; i<count; i++ ) {
			String mName = movieList.get(i).getMName();
			log.info(mName);

			//총 예매 갯수
			double rcount1 = watchMovieService.getTotalCount();
			log.info("rcount1 : " + rcount1);

			log.info("movieName : " + mName);
			//선택한 영화 예매 갯수
			double scount1 = watchMovieService.getScount(mName);
			log.info("scount1 : " + scount1);

			double a = (scount1/rcount1)*100;
			log.info("a : " + a);

			double bookrate = (Math.round(a*100)/100);
			log.info("bookrate : " + bookrate);

			movieService.updateMrateByName(mName, bookrate);
		}
		movieList = movieService.getMoviesMImg(0, pageSize);

		model.addAttribute("movieList", movieList);
		model.addAttribute("pageNum", pageNum);

		return "movie/movieNowList";
	} // nowList


	@GetMapping("/write")
	public String write(@ModelAttribute("pageNum") String pageNum, Model model) {

//		model.addAttribute("pageNum", pageNum);

		return "admin/movieWriteForm";
	} // GET - write

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

	// 주글쓰기
	@PostMapping("/write")
	public String write(HttpServletRequest request,
			@RequestParam("poster") MultipartFile poster,
			@RequestParam("mImgTrailer") List<MultipartFile> mImgTrailers,
			MovieVo movieVo, String pageNum) throws IOException {

		//============ 게시글 MovieVo 준비하기 ==============
		// AUTO INCREMENT 다음번호 가져오기
		int mNum = mySqlService.getNextNum("movie");
		movieVo.setMNum(mNum);

		//ip  regDate  readcount
		movieVo.setRegDate(new Timestamp(System.currentTimeMillis()));
		movieVo.setMLike(0);

		//============ 게시글 MovieVo 준비완료 ==============



		//============ 파일 업로드를 위한 폴더 준비 ==============
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/");  // webapp 폴더의 실제경로
		log.info("realPath : " + realPath);

		String strDate = this.getFolder();

		File dir = new File(realPath + "/upload", strDate);
		log.info("dir : " + dir.getPath());

		if (!dir.exists()) {
			dir.mkdirs();
		}


		//============ MultipartFile을 이용해 파일업로드 수행 ==============

		List<MImgTrailerVo> mimgtrailerList = new ArrayList<>();

		for (MultipartFile multipartFile : mImgTrailers) {
			// 파일입력상자에서 선택하지않은 요소는 건너뛰기
			if (multipartFile.isEmpty()) {
				continue;
			}

			// 실제 업로드한 파일이름 구하기
			String filename = multipartFile.getOriginalFilename();

			// 익스플로러는 파일이름에 경로가 포함되어 있으므로
			// 순수 파일이름만 부분문자열로 가져오기
			int beginIndex = filename.lastIndexOf("\\") + 1;
			filename = filename.substring(beginIndex);

			// 파일명 중복을 피하기 위해서 파일이름 앞에 붙일 UUID 문자열 구하기
			UUID uuid = UUID.randomUUID();
			String strUuid = uuid.toString();

			// 업로드(생성)할 파일이름
			String uploadFilename = strUuid + "_" + filename;

			// 생성할 파일정보를 File 객체로 준비
			File saveFile = new File(dir, uploadFilename);

			// 임시업로드된 파일을 지정경로의 파일명으로 생성(복사)
			multipartFile.transferTo(saveFile);


			//============ 첨부파일 AttachVo 준비하기 ==============
			MImgTrailerVo mImgTrailerVo = new MImgTrailerVo();
			// 게시판 글번호 설정
			mImgTrailerVo.setNoNum(movieVo.getMNum());

			mImgTrailerVo.setUuid(strUuid);
			mImgTrailerVo.setFilename(filename);
			mImgTrailerVo.setUploadpath(strDate);

			if (isImage(filename)) { // 이미지인가? -> 포스터인가?
				mImgTrailerVo.setImage("T");

				// 생성할 썸네일 이미지 파일 경로와 이름을 준비
				File thumbnailFile = new File(dir, "s_" + uploadFilename);
				// 썸네일 이미지 파일 생성하기
				try (FileOutputStream fos = new FileOutputStream(thumbnailFile)) {
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), fos, 100, 100);
				}
			} else {
				mImgTrailerVo.setImage("N");
			}

			// AttachVo 를 DB에 insert하기
			//attachService.insertAttach(attachVo);

			mimgtrailerList.add(mImgTrailerVo);
		} // for

		//============ MultipartFile을 이용해 파일업로드 수행 ==============

		// MimgVo 첨부파일정보 담을 리스트 준비
		MImgTrailerVo posterVo = new MImgTrailerVo();

		// 실제 업로드한 파일이름 구하기
		String filename = poster.getOriginalFilename();

		// 익스플로러는 파일이름에 경로가 포함되어 있으므로
		// 순수 파일이름만 부분문자열로 가져오기
		int beginIndex = filename.lastIndexOf("\\") + 1;
		filename = filename.substring(beginIndex);

		// 파일명 중복을 피하기 위해서 파일이름 앞에 붙일 UUID 문자열 구하기
		UUID uuid = UUID.randomUUID();
		String strUuid = uuid.toString();

		// 업로드(생성)할 파일이름
		String uploadFilename = strUuid + "_" + filename;

		// 생성할 파일정보를 File 객체로 준비
		File saveFile = new File(dir, uploadFilename);

		// 임시업로드된 파일을 지정경로의 파일명으로 생성(복사)
		poster.transferTo(saveFile);


		//============ 첨부파일 AttachVo 준비하기 ==============
		// 게시판 글번호 설정
		posterVo.setNoNum(movieVo.getMNum());

		posterVo.setUuid(strUuid);
		posterVo.setFilename(filename);
		posterVo.setUploadpath(strDate);

		if (isImage(filename)) { // 이미지인가? -> 포스터인가?
			posterVo.setImage("P");

			// 생성할 썸네일 이미지 파일 경로와 이름을 준비
			File thumbnailFile = new File(dir, "s_" + uploadFilename);
			// 썸네일 이미지 파일 생성하기
			try (FileOutputStream fos = new FileOutputStream(thumbnailFile)) {
				Thumbnailator.createThumbnail(poster.getInputStream(), fos, 100, 100);
			}
		} else {
			posterVo.setImage("N");
		}

		// AttachVo 를 DB에 insert하기
		//attachService.insertAttach(attachVo);

		mimgtrailerList.add(posterVo);



		// AttachVo 를 DB에 insert하기
		//attachService.insertAttach(attachVo);

//		posterService.insertPoster(posterVo);


		// NoticeVo 를 DB에 insert하기
		//noticeService.addNotice(noticeVo);

		// NoticeVo와 AttachVo 여러개를 트랜잭션으로 insert하기
		movieService.addMovieAndMImgTrailer(movieVo, mimgtrailerList);

		// 자료실 게시판 상세보기로 리다이렉트
		return "redirect:/movieNotice/content?num=" + movieVo.getMNum() + "&pageNum=" + pageNum;
	} // POST - write


	@GetMapping("/content")
	public String content(int num, @ModelAttribute("pageNum") String pageNum, Model model) {

		// 방법1) 따로따로 select해서 가져오기
//		NoticeVo noticeVo = noticeService.getNoticeByNum(num);
//		List<AttachVo> attachList = attachService.getAttachesByNoNum(num);

		// 방법2) 조인 쿼리로 한번에 가져오기
		MovieVo movieVo = movieService.getMovieAndMImgTrailers(num);

		model.addAttribute("movieVo", movieVo);
		model.addAttribute("mImgTrailerList", movieVo.getMImgTrailerList());

		return "admin/movieContent";
	} // content


	@GetMapping("/detail")
	public String detail(int num, @ModelAttribute("pageNum") String pageNum, String movieName, Model model, HttpSession session) {

		// 방법1) 따로따로 select해서 가져오기
//		NoticeVo noticeVo = noticeService.getNoticeByNum(num);
//		List<AttachVo> attachList = attachService.getAttachesByNoNum(num);

		// 방법2) 조인 쿼리로 한번에 가져오기
		MovieVo movieVo = movieService.getMovieAndMImgTrailers(num);

		String id = (String) session.getAttribute("id");
		int MovieNum = movieVo.getMNum();

		//총 댓글 갯수
		double count = mcommentService.getTotalCountByMno(MovieNum);

		//총 예매 갯수
		double rcount = watchMovieService.getTotalCount();
		log.info("rcount : " + rcount);

		log.info("movieName : " + movieName);
		//선택한 영화 예매 갯수
		double scount = watchMovieService.getScount(movieName);
		log.info("scount : " + scount);

		double a = (scount/rcount)*100;
		log.info("a : " + a);

		double bookrate = (Math.round(a*100)/100);
		log.info("bookrate : " + bookrate);


		if(count>0) {
			double scoreSum = mcommentService.getTotalScoreByMno(MovieNum);
			if(scoreSum>0) {
				double result= (Math.round((scoreSum / count)* 100)/100.0);
				movieService.updateScoreByMnum(result, MovieNum);
			}


		}
//scoreSum / count => 4.333333 * 100 = 433.333333 / 100.0 = 4.33



		int likeStatus = 0; // 0: 처음, 1: 좋아요를 누른상태 , 2: 좋아요를 눌렀다가 취소한상태


		if (movieLikeService.getCountByNumAndId(MovieNum, id) == 0) { // 없을때
			likeStatus = 0;
		} else { // 있을때
			if (movieLikeService.getIsLikeByNumAndId(MovieNum, id) == 1) {
				likeStatus = 1;
			} else {
				likeStatus = 2;
			}
		}
		log.info("likeStatus : " + likeStatus);


		model.addAttribute("movieVo", movieVo);
		model.addAttribute("likeStatus", likeStatus);
		model.addAttribute("mImgTrailerList", movieVo.getMImgTrailerList());
		model.addAttribute("bookrate", bookrate);

		return "movie/movieDetail";
	} // content

	@GetMapping("delete")
	public String delete(int num, String pageNum, HttpServletRequest request) {
		// 게시글번호에 첨부된 첨부파일 리스트 가져오기
		List<MImgTrailerVo> imgTrailerList = mImgTrailerService.getImgTrailersByNoNum(num);

		// application 객체 참조 가져오기
		ServletContext application = request.getServletContext();
		// 업로드 기준경로
		String realPath = application.getRealPath("/"); // webapp

		// 첨부파일 삭제하기
		for (MImgTrailerVo mImgTrailerVo : imgTrailerList) {
			String dir = realPath + "/upload/" + mImgTrailerVo.getUploadpath();
			String filename = mImgTrailerVo.getUuid() + "_" + mImgTrailerVo.getFilename();
			// 삭제할 파일을 File 타입 객체로 준비
			File file = new File(dir, filename);

			// 파일 존재 확인 후 삭제하기
			if (file.exists()) {
				file.delete();
			}

			// 이미지 파일이면
			if (isImage(mImgTrailerVo.getFilename())) {
				// 섬네일 이미지 존재여부 확인 후 삭제하기
				File thumbnailFile = new File(dir, "s_" + filename);
				if (thumbnailFile.exists()) {
					thumbnailFile.delete();
				}
			}
		} // for


		// attach 첨부파일내용 삭제하기
//		attachService.deleteAttachesByNoNum(num);
		// notice 게시글 삭제하기
//		noticeService.deleteNoticeByNum(num);

		// notice 게시글 한개와 attach 첨부파일 여러개를 트랜잭션으로 삭제하기
		movieService.deleteMovieAndMImgTrailer(num);
		mcommentService.deleteByMno(num);

		// 글목록으로 리다이렉트 이동
		return "redirect:/movieNotice/list?pageNum=" + pageNum;
	} // delete

	@GetMapping("/modify")
	public String modify(int num, @ModelAttribute("pageNum") String pageNum, Model model) {
		// 글번호 num에 해당하는 글내용 VO로 가져오기
//		NoticeVo noticeVo = noticeService.getNoticeByNum(num);
//		List<AttachVo> attachList = attachService.getAttachesByNoNum(num);
		// 조인으로 한번에 가져오기
		MovieVo movieVo = movieService.getMovieAndMImgTrailers(num);
		List<MImgTrailerVo> mImgTrailerList = movieVo.getMImgTrailerList();
		int fileCount = mImgTrailerList.size();

		model.addAttribute("movieVo", movieVo);
		model.addAttribute("mImgTrailerList", mImgTrailerList);
		model.addAttribute("fileCount", fileCount);

		return "admin/movieModifyForm";
	} // GET - modify


	@PostMapping("/modify")
	public String modify(HttpServletRequest request,
			@RequestParam(name = "filename", required = false) List<MultipartFile> multipartFiles,
			MovieVo movieVo, String pageNum,
			@RequestParam(name = "delfile", required = false) List<Integer> delFileNums,
			RedirectAttributes rttr) throws IOException {

		//============ 파일 업로드를 위한 폴더 준비 ==============
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/");  // webapp 폴더의 실제경로
		log.info("realPath : " + realPath);

		String strDate = this.getFolder();

		File dir = new File(realPath + "/upload", strDate);
		log.info("dir : " + dir.getPath());

		if (!dir.exists()) {
			dir.mkdirs();
		}



		//============ MultipartFile을 이용해 신규파일 업로드 수행 ==============

		// AttachVo 첨부파일정보 담을 리스트 준비
		List<MImgTrailerVo> addMImgTrailers = new ArrayList<>();

		if (multipartFiles != null) {
			for (MultipartFile multipartFile : multipartFiles) {
				// 파일입력상자에서 선택하지않은 요소는 건너뛰기
				if (multipartFile.isEmpty()) {
					continue;
				}

				// 실제 업로드한 파일이름 구하기
				String filename = multipartFile.getOriginalFilename();

				// 익스플로러는 파일이름에 경로가 포함되어 있으므로
				// 순수 파일이름만 부분문자열로 가져오기
				int beginIndex = filename.lastIndexOf("\\") + 1;
				filename = filename.substring(beginIndex);

				// 파일명 중복을 피하기 위해서 파일이름 앞에 붙일 UUID 문자열 구하기
				UUID uuid = UUID.randomUUID();
				String strUuid = uuid.toString();

				// 업로드(생성)할 파일이름
				String uploadFilename = strUuid + "_" + filename;

				// 생성할 파일정보를 File 객체로 준비
				File saveFile = new File(dir, uploadFilename);

				// 임시업로드된 파일을 지정경로의 파일명으로 생성(복사)
				multipartFile.transferTo(saveFile);


				//============ 첨부파일 AttachVo 준비하기 ==============
				MImgTrailerVo mImgTrailerVo = new MImgTrailerVo();
				// 게시판 글번호 설정
				mImgTrailerVo.setNoNum(movieVo.getMNum());
				mImgTrailerVo.setUuid(strUuid);
				mImgTrailerVo.setFilename(filename);
				mImgTrailerVo.setUploadpath(strDate);

				if (isImage(filename)) {
					mImgTrailerVo.setImage("P");

					// 생성할 썸네일 이미지 파일 경로와 이름을 준비
					File thumbnailFile = new File(dir, "s_" + uploadFilename);
					// 썸네일 이미지 파일 생성하기
					try (FileOutputStream fos = new FileOutputStream(thumbnailFile)) {
						Thumbnailator.createThumbnail(multipartFile.getInputStream(), fos, 100, 100);
					}
				} else {
					mImgTrailerVo.setImage("N");
				}

				// AttachVo 를 DB에 insert하기
				//attachService.insertAttach(attachVo);

				// 트랜잭션 처리를 위해 attachVo를 리스트에 추가해서 모으기
				addMImgTrailers.add(mImgTrailerVo);
			} // for
		}


		//============ delFileNums 로 첨부파일 삭제작업 수행 ==============

		if (delFileNums != null) {
			for (int num : delFileNums) {
				// 첨부파일 번호에 해당하는 첨부파일 정보 한개를 VO로 가져오기
				MImgTrailerVo mImgTrailerVo = mImgTrailerService.getImgTrailerByNum(num);

				// 파일정보로 실제파일 존재여부 확인해서 삭제하기
				String path = realPath + "/upload/" + mImgTrailerVo.getUploadpath();
				String file = mImgTrailerVo.getUuid() + "_" + mImgTrailerVo.getFilename();

				File delFile = new File(path, file);
				if (delFile.exists()) {
					delFile.delete();
				}

				if (isImage(mImgTrailerVo.getFilename())) {
					File thumbnailFile = new File(path, "s_" + file);
					if (thumbnailFile.exists()) {
						thumbnailFile.delete();
					}
				}

				// 첨부파일 DB테이블에 첨부파일번호에 해당하는 레코드 한개 삭제하기
				//attachService.deleteAttachByNum(num);
			} // for
		} //if


		// 첨부파일번호들에 해당하는 첨부파일 레코드들 일괄 삭제하기
		//attachService.deleteAttachesByNums(delFileNums);


		// 게시판 테이블 글 update하기
		//noticeService.updateBoard(noticeVo);

		// 트랜잭션 단위로 테이블 데이터 처리
		movieService.updateMovieAndAddMImgTrailersAndDeleteMImgTrailers(movieVo, addMImgTrailers, delFileNums);


		rttr.addAttribute("num", movieVo.getMNum());
		rttr.addAttribute("pageNum", pageNum);

		// 상세보기 화면으로 리다이렉트 이동
		return "redirect:/movieNotice/content";
	} // POST - modify


	@RequestMapping(value="/like", method=RequestMethod.POST)
	@ResponseBody
	public void like(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpSession session){
		System.out.println(param);

		int likeStatus = Integer.parseInt((String) param.get("likeStatus"));
		int movieNum = Integer.parseInt((String) param.get("movieNum"));
		String userId = (String) param.get("userId");

		//1 해당 게시판 컬럼의 likes를 증가시키거나 차감시킨다 likeStatus 에따라
		//2 좋아요를 누른 유저의 정보를담은 notice_like 테이블의 is_like 컬럼을 0 또는 1로 수정한다

		if(likeStatus == 0) {
			movieService.plusLikesByNum(movieNum);
			movieLikeService.addMovieLike(userId,movieNum,1);
		} else if (likeStatus == 1) {
			movieService.minusLikesByNum(movieNum);
			movieLikeService.minusMovieLike(movieNum, userId);
		} else if (likeStatus == 2) {
			movieService.plusLikesByNum(movieNum);
			movieLikeService.plusMovieLike(movieNum, userId);
		}
	 }

	@RequestMapping(value="/score", method=RequestMethod.POST)
	@ResponseBody
	public void score(@RequestParam Map<String, Object> param, HttpServletRequest request){


		String score = (String) param.get("score");

		HttpSession session = request.getSession();
		session.setAttribute("score", score);
	 }




}





