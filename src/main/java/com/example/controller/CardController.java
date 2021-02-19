package com.example.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.domain.CardCardInfoVo;
import com.example.domain.CardInfoVo;
import com.example.domain.CardVo;
import com.example.domain.MImgTrailerVo;
import com.example.domain.MovieVo;
import com.example.domain.PageDto;
import com.example.service.CardInfoService;
import com.example.service.CardService;
import com.example.service.MySqlService;

import lombok.extern.java.Log;
import net.coobird.thumbnailator.Thumbnailator;

@Log
@Controller
@RequestMapping("/saleNotice/*")
public class CardController {

	@Autowired
	private CardService cardService;
	@Autowired
	private CardInfoService cardInfoService;
	@Autowired
	private MySqlService mySqlService;


	@GetMapping("/list")
	public String list(
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "") String category,
			@RequestParam(defaultValue = "") String search,
			Model model) {

		//int count = noticeService.getCountAll();
		int count = cardService.getCountBySearch(category, search);

		int pageSize = 10;

		int startRow = (pageNum - 1) * pageSize;

		List<CardVo> cardList = null;
		if (count > 0) {
			//movieList = noticeService.getNotices(startRow, pageSize);
			cardList = cardService.getCardsBySearch(startRow, pageSize, category, search);
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


		model.addAttribute("cardList", cardList);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);

		return "admin/saleNotice";
	} // list


	@GetMapping("/saleList" )
	public String saleList(
			@RequestParam(defaultValue = "1") int pageNum,
			Model model) {

		// 총 영화 수
		int count = cardService.getCount();

		int pageSize = pageNum * 9;

		List<CardCardInfoVo> cardList = null;

		if (count > 0) {
			cardList = cardService.getCardCardInfo(0, pageSize);
			log.info("cardList : " + cardList);
		}

		model.addAttribute("cardList", cardList);

		return "sale/salePage";
	} // saleList


	@GetMapping("/write")
	public String write(@ModelAttribute("pageNum") String pageNum, Model model) {

//		model.addAttribute("pageNum", pageNum);

		return "admin/saleWriteForm";
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

	//주글쓰기
	@PostMapping("/write")
	public String write(HttpServletRequest request,
			@RequestParam("cImage") MultipartFile cImage,
			CardVo cardVo, String pageNum) throws IOException {

		//============ 게시글 MovieVo 준비하기 ==============
		
		// AUTO INCREMENT 다음번호 가져오기
		int cNum = mySqlService.getNextNum("card");
		cardVo.setCNum(cNum);

		//============ 게시글 MovieVo 준비완료 ==============


		//============ 파일 업로드를 위한 폴더 준비 ==============
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/");  // webapp 폴더의 실제경로
		log.info("realPath : " + realPath);

		String strDate = this.getFolder();

		File dir = new File(realPath + "/upload4", strDate);
		log.info("dir : " + dir.getPath());

		if (!dir.exists()) {
			dir.mkdirs();
		}


		//============ MultipartFile을 이용해 파일업로드 수행 ==============

		// MimgVo 첨부파일정보 담을 리스트 준비
		CardInfoVo cardInfoVo = new CardInfoVo();

		// 실제 업로드한 파일이름 구하기
		String filename = cImage.getOriginalFilename();

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
		cImage.transferTo(saveFile);


		//============ 첨부파일 CardInfoVo 준비하기 ==============
		// 게시판 글번호 설정
		cardInfoVo.setNoNum(cardVo.getCNum());
		cardInfoVo.setUuid(strUuid);
		cardInfoVo.setFilename(filename);
		cardInfoVo.setUploadpath(strDate);

		// NoticeVo와 AttachVo 여러개를 트랜잭션으로 insert하기
		cardService.addCardAndCardInfo(cardVo, cardInfoVo);

		// 자료실 게시판 상세보기로 리다이렉트
		return "redirect:/saleNotice/content?num=" + cardVo.getCNum() + "&pageNum=" + pageNum;
	} // POST - write


	@GetMapping("/content")
	public String content(int num, @ModelAttribute("pageNum") String pageNum, Model model) {

		// 담을 곳 준비
		CardVo cardVo = new CardVo();
		CardInfoVo cardInfoVo = new CardInfoVo();
		
		// 한번에 가져오기
		CardCardInfoVo cardCardInfoVo = cardService.getCardAndCardInfo(num);
		
		// 뽑아내서 나눠담기
		int cNum = cardCardInfoVo.getCNum();
		String cKinds = cardCardInfoVo.getCKinds();
		String cName = cardCardInfoVo.getCName();
		String cSale = cardCardInfoVo.getCSale();
		String cOnoff = cardCardInfoVo.getCOnoff();
		String cDiscount = cardCardInfoVo.getCDiscount();
		
		int nnum = cardCardInfoVo.getNum();
		String uuid = cardCardInfoVo.getUuid();
		String filename = cardCardInfoVo.getFilename();
		String uploadpath = cardCardInfoVo.getUploadpath();
		int noNum = cardCardInfoVo.getNoNum();
		
		cardVo.setCNum(cNum);
		cardVo.setCKinds(cKinds);
		cardVo.setCName(cName);
		cardVo.setCSale(cSale);
		cardVo.setCOnoff(cOnoff);
		cardVo.setCDiscount(cDiscount);
		
		cardInfoVo.setNum(nnum);
		cardInfoVo.setUuid(uuid);
		cardInfoVo.setFilename(filename);
		cardInfoVo.setUploadpath(uploadpath);
		cardInfoVo.setNoNum(noNum);
		
		model.addAttribute("cardVo", cardVo);
		model.addAttribute("cardInfoVo", cardInfoVo);

		return "admin/saleContent";
	} // content


//	@GetMapping("/detail")
//	public String detail(int num, @ModelAttribute("pageNum") String pageNum, Model model) {
//
//		// 방법1) 따로따로 select해서 가져오기
////		NoticeVo noticeVo = noticeService.getNoticeByNum(num);
////		List<AttachVo> attachList = attachService.getAttachesByNoNum(num);
//
//		// 방법2) 조인 쿼리로 한번에 가져오기
//		MovieVo movieVo = movieService.getMovieAndMImgTrailers(num);
//
//		model.addAttribute("movieVo", movieVo);
//		model.addAttribute("mImgTrailerList", movieVo.getMImgTrailerList());
//
//		return "movie/movieDetail";
//	} // content
//
	@GetMapping("delete")
	public String delete(int num, String pageNum, HttpServletRequest request) {
		// 게시글번호에 첨부된 첨부파일 리스트 가져오기
		CardInfoVo cardInfoVo = cardInfoService.getCardInfoByNoNum(num);

		// application 객체 참조 가져오기
		ServletContext application = request.getServletContext();
		// 업로드 기준경로
		String realPath = application.getRealPath("/"); // webapp

		// 첨부파일 삭제하기
		String dir = realPath + "/upload4/" + cardInfoVo.getUploadpath();
		String filename = cardInfoVo.getUuid() + "_" + cardInfoVo.getFilename();
		// 삭제할 파일을 File 타입 객체로 준비
		File file = new File(dir, filename);

		// 파일 존재 확인 후 삭제하기 ( 섬네일은 애초에 생성안함 )
		if (file.exists()) {
			file.delete();
		}

		// notice 게시글 한개와 attach 첨부파일 여러개를 트랜잭션으로 삭제하기
		cardService.deleteCardAndCardInfoByNum(num);

		// 글목록으로 리다이렉트 이동
		return "redirect:/saleNotice/list?pageNum=" + pageNum;
	} // delete

	@GetMapping("/modify")
	public String modify(int num, @ModelAttribute("pageNum") String pageNum, Model model) {
		// 글번호 num에 해당하는 글내용 VO로 가져오기
//		NoticeVo noticeVo = noticeService.getNoticeByNum(num);
//		List<AttachVo> attachList = attachService.getAttachesByNoNum(num);
		// 조인으로 한번에 가져오기
		CardCardInfoVo cardCardInfoVo = cardService.getCardAndCardInfo(num);
//		CardInfoVo cardInfoVo = new CardInfoVo();
				
//		int nnum = cardCardInfoVo.getNum();
//		String uuid = cardCardInfoVo.getUuid();
//		String filename = cardCardInfoVo.getFilename();
//		String uploadpath = cardCardInfoVo.getUploadpath();
//		int noNum = cardCardInfoVo.getNoNum();
//		
//		cardInfoVo.setNum(nnum);
//		cardInfoVo.setUuid(uuid);
//		cardInfoVo.setFilename(filename);
//		cardInfoVo.setUploadpath(uploadpath);
//		cardInfoVo.setNoNum(noNum);
		
		model.addAttribute("cardCardInfoVo", cardCardInfoVo);
//		model.addAttribute("cardInfoVo", cardInfoVo);

		return "admin/saleModifyForm";
	} // GET - modify


	@PostMapping("/modify")
	public String modify(HttpServletRequest request,
			@RequestParam(name = "filename", required = false) MultipartFile multipartFile,
			CardVo cardVo, String pageNum,
			@RequestParam(name = "delfile", required = false) Integer delFileNum,
			RedirectAttributes rttr) throws IOException {

		//============ 파일 업로드를 위한 폴더 준비 ==============
		
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/");  // webapp 폴더의 실제경로
		log.info("realPath : " + realPath);

		String strDate = this.getFolder();

		File dir = new File(realPath + "/upload4", strDate);
		log.info("dir : " + dir.getPath());

		if (!dir.exists()) {
			dir.mkdirs();
		}
		//============ MultipartFile을 이용해 신규파일 업로드 수행 ==============
		
		// AttachVo 첨부파일정보 담을 리스트 준비
		CardInfoVo cardInfoVo = new CardInfoVo();

		if (multipartFile != null) {
				// 파일입력상자에서 선택하지않은 요소는 건너뛰기
//				if (multipartFile.isEmpty()) {
//					continue;
//				}
				
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
				
				// 게시판 글번호 설정
				cardInfoVo.setUuid(strUuid);
				cardInfoVo.setFilename(filename);
				cardInfoVo.setUploadpath(strDate);
				cardInfoVo.setNoNum(cardVo.getCNum());
		}


		//============ delFileNums 로 첨부파일 삭제작업 수행 ==============

		if (delFileNum != null) {
				// 첨부파일 번호에 해당하는 첨부파일 정보 한개를 VO로 가져오기
				CardInfoVo cardInfoVo2 = cardInfoService.getCardInfoByNoNum(delFileNum);

				// 파일정보로 실제파일 존재여부 확인해서 삭제하기
				String path = realPath + "/upload4/" + cardInfoVo2.getUploadpath();
				String file = cardInfoVo2.getUuid() + "_" + cardInfoVo2.getFilename();

				File delFile = new File(path, file);
				if (delFile.exists()) {
					delFile.delete();
				}
		} //if

		log.info("cardInfoVo:"+cardInfoVo);

		// 트랜잭션 단위로 테이블 데이터 처리
		cardService.updateCardAndCardInfoAndDeleteCardInfo(cardVo, cardInfoVo, delFileNum);

		rttr.addAttribute("num", cardVo.getCNum());
		rttr.addAttribute("pageNum", pageNum);

		// 상세보기 화면으로 리다이렉트 이동
		return "redirect:/saleNotice/content";
	} // POST - modify

}