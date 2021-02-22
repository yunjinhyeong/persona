package com.example.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.domain.CSMtmVo;
import com.example.domain.CSNoticeVo;
import com.example.domain.PageDto;
import com.example.service.CSService;
import com.example.service.MySqlService;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/CS/*")
public class CSController {

	@Autowired
	private CSService csService;
	@Autowired
	private MySqlService mySqlService;

	@GetMapping("/CustomerService")
	public String CS() {
		log.info("CS() �몄���");
		return "CustomerService/CustomerService";
	}

	@GetMapping("/CustomerNotice")
	public String CN(@RequestParam(defaultValue = "1") int pageNum, @RequestParam(defaultValue = "") String category,
			@RequestParam(defaultValue = "") String search, Model model) {
		log.info("CN() �몄���");

		int count = csService.getCountBySearch(category, search);

		int pageSize = 10;

		int startRow = (pageNum - 1) * pageSize;

		List<CSNoticeVo> noticeList = null;
		if (count > 0) {
			noticeList = csService.getNoticesBySearch(startRow, pageSize, category, search);
			log.info("noticeList : " + noticeList);
		}

		PageDto pageDto = new PageDto();

		if (count > 0) {
			int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
			// int pageCount = (int) Math.ceil((double) count / pageSize);

			int pageBlock = 5;

			// 1~5 6~10 11~15 16~20 ...
			// 1~5 => 1 6~10 => 6 11~15 => 11 16~20 => 16
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

		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);

		return "CustomerService/CustomerNotice";
	} // CN

	@GetMapping("/NoticeById")//개인 계정일 때
	public String mtmNotice(@RequestParam(defaultValue = "1") int pageNum,
							@RequestParam(defaultValue = "") String category, 
							@RequestParam(defaultValue = "") String search,
							@RequestParam(defaultValue = "") String id,
							@RequestParam(defaultValue = "1") int reRef,
							Model model) {
		log.info("MN() 호출됨");

		int count = csService.mtmgetCountBySearch(category, search, id, reRef);

		int pageSize = 10;

		int startRow = (pageNum - 1) * pageSize;

		List<CSMtmVo> mtmnoticeList = null;
		if (count > 0) {
			// noticeList = noticeService.getNotices(startRow, pageSize);
			mtmnoticeList = csService.mtmgetNoticesBySearch(startRow, pageSize, category, search, id, reRef);
			log.info("mtmnoticeList : " + mtmnoticeList);
		}

		PageDto pageDto = new PageDto();

		if (count > 0) {
			int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
			// int pageCount = (int) Math.ceil((double) count / pageSize);

			int pageBlock = 5;

			// 1~5 6~10 11~15 16~20 ...
			// 1~5 => 1 6~10 => 6 11~15 => 11 16~20 => 16
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

		model.addAttribute("mtmnoticeList", mtmnoticeList);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);

		return "CustomerService/CSmtmNotice";
	} // CN

	@GetMapping("/mtmNotice")//관리자 계정일 때
	public String NoticeById(@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "") String category, @RequestParam(defaultValue = "") String search,
			@RequestParam(defaultValue = "") String id, Model model) {
		log.info("NBI() 호출됨");

		int count = csService.NoticeCountById(category, search, id);

		int pageSize = 10;

		int startRow = (pageNum - 1) * pageSize;

		List<CSMtmVo> mtmnoticeListByid = null;
		if (count > 0) {
			// noticeList = noticeService.getNotices(startRow, pageSize);
			mtmnoticeListByid = csService.NoticeById(startRow, pageSize, category, search);
			log.info("mtmnoticeListByid : " + mtmnoticeListByid);
		}

		PageDto pageDto = new PageDto();

		if (count > 0) {
			int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
			// int pageCount = (int) Math.ceil((double) count / pageSize);

			int pageBlock = 5;

			// 1~5 6~10 11~15 16~20 ...
			// 1~5 => 1 6~10 => 6 11~15 => 11 16~20 => 16
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

		model.addAttribute("mtmnoticeListByid", mtmnoticeListByid);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);

		return "CustomerService/CSmtmNotice";
	} // NBI

	@GetMapping("/CSmtm")
	public String CSFO() {

		return "CustomerService/CSmtmWrite";
	}

	@PostMapping("/mtmWrite")
	public String mtmWrite(String pageNum, CSMtmVo csMtmVo, HttpSession session, HttpServletRequest request) {

		// �깅���吏� �ㅼ��
		csMtmVo.setRegDate(new Timestamp(System.currentTimeMillis()));

		int num = mySqlService.getNextNum("csmtm");
		csMtmVo.setMnum(num);
		
		//re_ref  re_lev  re_seq
		csMtmVo.setReRef(num);
		csMtmVo.setReLev(0);
		csMtmVo.setReSeq(0);

		// 二쇨��곌린
		csService.MtmaddNotice(csMtmVo);
		log.info("csMtmVo: " + csMtmVo);

		return "redirect:/CS/mtmContents?num=" + num + "&pageNum=" + pageNum;
	} // Post - mtmWrite

	@GetMapping("/write")
	public String write(@ModelAttribute("pageNum") String pageNum, Model model) {

		log.info("get write �몄���");
		return "CustomerService/fileWriteForm";
	} // GET - write

	@PostMapping("/write")
	public String write(String pageNum, CSNoticeVo csNoticeVo, HttpSession session, HttpServletRequest request) {

		// �깅���吏� �ㅼ��
		csNoticeVo.setRegDate(new Timestamp(System.currentTimeMillis()));

		int num = mySqlService.getNextNum("csnotice");

		// 二쇨��곌린
		csService.addNotice(csNoticeVo);
		log.info("post write �몄���");
		log.info("csNoticeVo: " + csNoticeVo);

		return "redirect:/CS/contents?num=" + num + "&pageNum=" + pageNum;
	} // Post - write

	@GetMapping("/contents")
	public String content(int num, @ModelAttribute("pageNum") String pageNum, Model model) {
		CSNoticeVo csNoticeVo = csService.getNoticeByNum(num);

		model.addAttribute("csNoticeVo", csNoticeVo);

		log.info("contents �몄���");
		log.info("csNoticeVo1 : " + csNoticeVo);

		return "CustomerService/CustomerContent";
	} // contents

	// ---------------------------------------------------------

	@GetMapping("/mtmContents")
	public String mtmContents(@ModelAttribute("num") int num, @ModelAttribute("pageNum") String pageNum, Model model) {
		CSMtmVo csMtmVo = csService.mtmgetNoticeByNum(num);

		model.addAttribute("csMtmVo", csMtmVo);
		log.info("csMtmVo : " + csMtmVo);

		return "CustomerService/csMtmContent";
	} // contents

	// ------------------------------------------------
	@GetMapping("/CSModify")
	public String CSModify(int num, @ModelAttribute("pageNum") String pageNum, Model model) {
		// 글번호 num에 해당하는 글내용 VO로 가져오기
		CSNoticeVo csNoticeVo = csService.getNoticeByNum(num);
//		List<AttachVo> attachList = attachService.getAttachesByNoNum(num);
		// 조인으로 한번에 가져오기
//		NoticeVo noticeVo = csService.getNoticeAndAttaches(num);
//		List<AttachVo> attachList = noticeVo.getAttachList();
//		int fileCount = attachList.size();

		model.addAttribute("csNoticeVo", csNoticeVo);
//		model.addAttribute("attachList", attachList);
//		model.addAttribute("fileCount", fileCount);
		log.info("csNoticeVo: " + csNoticeVo);

		return "CustomerService/CustomerModifyForm";
	} // GET - modify

	@PostMapping("/CSModify")
	public String CustomerModify(HttpServletRequest request, CSNoticeVo csNoticeVo, String pageNum,
			RedirectAttributes rttr) throws IOException {

//		 게시판 테이블 글 update하기
		csService.updateBoard(csNoticeVo);

		rttr.addAttribute("num", csNoticeVo.getNum());
		rttr.addAttribute("pageNum", pageNum);

		// 상세보기 화면으로 리다이렉트 이동
		return "redirect:/CS/contents";
	} // POST - modify

	@GetMapping("delete")
	public String delete(int num, String pageNum, HttpServletRequest request) {
		// notice 게시글 삭제하기
		csService.delete(num);
		return "redirect:/CS/CustomerNotice";
	}

	@GetMapping("CSmtmDelete")
	public String CSmtmDelete(int num, String pageNum, int reRef, HttpServletRequest request) {
		// notice 게시글 삭제하기
		csService.CSmtmDelete(num, reRef);
		return "redirect:/CS/CSmtm";
	}

	@GetMapping("/mtmReplyWrite")
	public String replyWrite(@ModelAttribute("num") int num, @ModelAttribute("reRef") String reRef, @ModelAttribute("reLev") String reLev,
			@ModelAttribute("reSeq") String reSeq, @ModelAttribute("pageNum") String pageNum, Model model) {
		log.info("GET-replyWrite() 호출됨");

		CSMtmVo csMtmVo = csService.mtmgetNoticeByNum(num);

		model.addAttribute("csMtmVo", csMtmVo);
		log.info("csMtmVo : " + csMtmVo);

		return "CustomerService/mtmReplyWriteForm";
	} // GET - replyWrite

	@PostMapping("/replyWrite")
	public String replyWrite(CSMtmVo csMtmVo, String pageNum, HttpServletRequest request, RedirectAttributes rttr)
			throws IOException {
		// reRef, reLev, reSeq 는 동일한 NoticeVo객체에 저장되지만
		// 답글 자체의 정보가 아니고 답글을 다는 대상글에 대한 정보임에 주의!!

		// insert될 글번호 가져오기
		int num = mySqlService.getNextNum("csmtm");
		csMtmVo.setMnum(num);
		log.info("num: " + num);

		// regDate 값 저장
		csMtmVo.setRegDate(new Timestamp(System.currentTimeMillis()));

		// 답글 insert하기
		csService.updateAndAddReply(csMtmVo);
//		attachService.insertAttaches(attachList);

		// 트랜잭션 단위로 처리 : 답글 insert와 첨부파일 insert
//		noticeService.updateAndAddReplyAndAddAttaches(noticeVo, attachList);

		// 리다이렉트용 속성값을 설정
		rttr.addAttribute("num", csMtmVo.getMnum());
		rttr.addAttribute("pageNum", pageNum);
		// 글내용 상세보기 화면으로 리다이렉트 이동
		return "redirect:/CS/mtmContents";
	} // POST - replyWrite

}
