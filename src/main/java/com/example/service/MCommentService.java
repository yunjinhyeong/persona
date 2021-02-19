package com.example.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.CommentVo;
import com.example.domain.Criteria;
import com.example.domain.MCommentVo;
import com.example.domain.MCriteria;
import com.example.mapper.CommentMapper;
import com.example.mapper.MCommentMapper;

import lombok.extern.java.Log;

@Service
@Log
public class MCommentService {

	@Autowired
	private MCommentMapper mcommentMapper;


	public int getTotalCountByMno(int mno) {
		int count = mcommentMapper.getTotalCountByMno(mno);
		return count;
	}

	public int getTotalScoreByMno(int mno) {
		int sum = mcommentMapper.getTotalScoreByMno(mno);
		return sum;
	}

	// 주댓글 쓰기
	public int addComment(MCommentVo mcommentVo) {
//		System.out.println(commentVo);
		log.info(mcommentVo.toString());

		int count = mcommentMapper.insert(mcommentVo);
		return count;
	}

	public MCommentVo getCommentByCno(int cno) {
		MCommentVo mcommentVo = mcommentMapper.getCommentByCno(cno);
		return mcommentVo;
	}

	public int deleteByCno(int cno) {
		int count = mcommentMapper.deleteByCno(cno);
		return count;
	}

	public void deleteByMno(int num) {
		mcommentMapper.deleteByMno(num);
	}

	public void update(MCommentVo mcommentVo) {
		mcommentMapper.update(mcommentVo);
	}

	public List<MCommentVo> getComments(int mno) {
		List<MCommentVo> list = mcommentMapper.getComments(mno);
		return list;
	}


	public List<MCommentVo> getCommentsWithPaging(int mno, MCriteria mcri) {
		List<MCommentVo> list = mcommentMapper.getCommentsWithPaging(mno, mcri);
		return list;
	}

	// 답댓글 쓰기
	@Transactional
	public void addReplyComment(MCommentVo mcommentVo) {

		mcommentMapper.updateReSeq(mcommentVo.getReRef(), mcommentVo.getReSeq());

		mcommentVo.setReLev(mcommentVo.getReLev() + 1);
		mcommentVo.setReSeq(mcommentVo.getReSeq() + 1);

		mcommentMapper.insert(mcommentVo);
	}

}
