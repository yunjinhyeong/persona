package com.example.service;

import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.AttachVo;
import com.example.domain.CSMtmVo;
import com.example.domain.CSNoticeVo;
import com.example.domain.NoticeVo;
import com.example.mapper.CSMapper;

import lombok.extern.java.Log;

@Log
@Service
public class CSService {

	@Autowired
	private CSMapper csMapper;


	// 주글쓰기
	public void addNotice(CSNoticeVo csNoticeVo) {
		csMapper.addNotice(csNoticeVo);
	}

	public void MtmaddNotice(CSMtmVo csMtmVo) {
		csMapper.MtmaddNotice(csMtmVo);
	}

	public CSNoticeVo getNoticeByNum(int num) {
		CSNoticeVo csNoticeVo = csMapper.getNoticeByNum(num);
		return csNoticeVo;
	}

	public CSMtmVo mtmgetNoticeByNum(int num) {
		CSMtmVo csMtmVo = csMapper.mtmgetNoticeByNum(num);
		return csMtmVo;
	}

	public int getCountByNotice() {
		int count = csMapper.getCountOfNotice();
		return count;
	}

	public void updateReadcount(int num) {
		csMapper.updateReadcount(num);
	}



	public int getCountAll() {
		int count = csMapper.getCountAll();
		return count;
	}


	public List<CSNoticeVo> getNotices(int startRow, int pageSize) {
		List<CSNoticeVo> list = csMapper.getNotices(startRow, pageSize);
		return list;
	}

	public List<CSNoticeVo> getNoticesOnly() {
		List<CSNoticeVo> list = csMapper.getNoticesOnly();
		return list;
	}

	public void updateBoard(CSNoticeVo csNoticeVo) {
		csMapper.updateBoard(csNoticeVo);
	}

	public void deleteNoticeByNum(int num) {
		csMapper.deleteNoticeByNum(num);
	}

	@Transactional
	public void deleteNoticeAndAttaches(int num) {
		csMapper.deleteNoticeByNum(num);
	}

	public void deleteAll() {
		csMapper.deleteAll();
	}

	public void delete(int num) {
		csMapper.delete(num);
	}

	public void CSmtmDelete(int num, int reRef) {
		csMapper.CSmtmDelete(num, reRef);
	}


	public int getCountBySearch(String category, String search) {
		int count = csMapper.getCountBySearch(category, search);
		return count;
	}

	public int mtmgetCountBySearch(String category, String search,String id, int reRef) {
		int count = csMapper.mtmgetCountBySearch(category, search, id, reRef);
		return count;
	}

	public int NoticeCountById(String category, String search, String id) {
		int count = csMapper.NoticeCountById(category, search, id);
		return count;
	}


	public List<CSNoticeVo> getNoticesBySearch(int startRow, int pageSize, String category, String search) {

		List<CSNoticeVo> noticeList = null;
		noticeList = csMapper.getNoticesBySearch(startRow, pageSize, category, search);
		log.info("noticeListInService : " + noticeList);
		return csMapper.getNoticesBySearch(startRow, pageSize, category, search);
	}

	public List<CSMtmVo> mtmgetNoticesBySearch(int startRow, int pageSize, String category, String search, String id, int reRef) {

		List<CSMtmVo> mtmnoticeList = null;
		mtmnoticeList = csMapper.mtmgetNoticesBySearch(startRow, pageSize, category, search, id, reRef);
		return csMapper.mtmgetNoticesBySearch(startRow, pageSize, category, search, id, reRef);
	}

	public List<CSMtmVo> NoticeById(int startRow, int pageSize, String category, String search) {

		List<CSMtmVo> mtmnoticeListByid = null;
		mtmnoticeListByid = csMapper.NoticeById(startRow, pageSize, category, search);
		return csMapper.NoticeById(startRow, pageSize, category, search);
	}


	public CSNoticeVo getNoticeAndAttaches(int num) {
		return csMapper.getNoticeAndAttaches(num);
	}

	//public List<NoticeVo> getNoticesByNums(List<Integer> numList)
	public List<CSNoticeVo> getNoticesByNums(Integer... numArr) {

		List<Integer> numList = Arrays.asList(numArr);

		return csMapper.getNoticesByNums(numList);
	}
	
	// 답글쓰기
		@Transactional
		public void updateAndAddReply(CSMtmVo csMtmVo) {
			// 답글을 쓰는 대상글과 같은 글그룹에서 
			// 답글을 쓰는 대상글의 순번보다 큰 글의 순번을 1씩 증가시킴
			csMapper.updateReSeq(csMtmVo.getReRef(), csMtmVo.getReSeq());
			
			// insert할 답글정보로 수정
			csMtmVo.setReLev(csMtmVo.getReLev() + 1);
			csMtmVo.setReSeq(csMtmVo.getReSeq() + 1);
			
			// 답글 insert하기
			csMapper.MtmaddNotice(csMtmVo);
		}


	@Transactional
	public void addNoticeAndAttaches(CSNoticeVo csNoticeVo, List<AttachVo> attachList) {
		// 게시글 등록
		csMapper.addNotice(csNoticeVo);

	}

	@Transactional
	public void updateNoticeAndAddAttachesAndDeleteAttaches(CSNoticeVo noticeVo, List<AttachVo> attaches, List<Integer> delFileNums) {
		csMapper.updateBoard(noticeVo);

	}

}





