package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.domain.CommentVo;
import com.example.domain.Criteria;
import com.example.domain.MCommentVo;
import com.example.domain.MCriteria;
import com.example.service.CommentService;
import com.example.service.MCommentService;
import com.example.service.MovieService;
import com.example.service.MySqlService;
import com.example.service.NoticeService;

import lombok.extern.java.Log;

/*
  REST 컨트롤러의 HTTP method 매핑 방식
   POST   - Create (SQL Insert문)
   GET    - Read   (SQL Select문)
   PUT    - Update (SQL Update문)
   DELETE - Delete (SQL Delete문)
 */
@RestController // 이 컨트롤러의 모든 메소드의 리턴값이 JSON 또는 XML 응답으로 동작함
@RequestMapping("/mcomment/*")
@Log
public class MCommentRestController {

	@Autowired
	private MCommentService mcommentService;
	@Autowired
	private MySqlService mySqlService;

	@Autowired
	private MovieService movieService;

	@GetMapping("/one/{cno}")
	public ResponseEntity<MCommentVo> getOne(@PathVariable("cno") int cno) {

		MCommentVo mcommentVo = mcommentService.getCommentByCno(cno);

		ResponseEntity<MCommentVo> entity = new ResponseEntity<MCommentVo>(mcommentVo, HttpStatus.OK);
		return entity;
	} // getComment

	@GetMapping("/pages/{mno}")
	public ResponseEntity<List<MCommentVo>> getList(@PathVariable("mno") int mno) {
		List<MCommentVo> commentList = mcommentService.getComments(mno);
		return new ResponseEntity<List<MCommentVo>>(commentList, HttpStatus.OK);
	}

	@GetMapping("/pages/{mno}/{pageNum}/{numOfRows}")
	public ResponseEntity<Map<String, Object>> getListWithPage(@PathVariable("mno") int mno,
			@PathVariable("pageNum") int pageNum,
			@PathVariable("numOfRows") int numOfRows) {

		MCriteria mcri = new MCriteria(pageNum, numOfRows);

		List<MCommentVo> commentList = mcommentService.getCommentsWithPaging(mno, mcri);

		int totalCount = mcommentService.getTotalCountByMno(mno);
		int totalScore = mcommentService.getTotalScoreByMno(mno);



		movieService.addTotalReplyCount(totalCount, mno);

		Map<String, Object> map = new HashMap<>();
		map.put("commentList", commentList);
		map.put("totalCount", totalCount);


		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}



	// 주댓글 쓰기
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<MCommentVo> createMain(@RequestBody MCommentVo mcommentVo,
			HttpSession session) {
		String id = (String) session.getAttribute("id");
		int score = Integer.parseInt( (String) session.getAttribute("score"));

		int cno = mySqlService.getNextNum("mcomment");
		mcommentVo.setCno(cno);
		mcommentVo.setReRef(cno);
		mcommentVo.setReLev(0);
		mcommentVo.setReSeq(0);
		mcommentVo.setId(id);
		mcommentVo.setScore(score);
		log.info("mcommentVo : " + mcommentVo);

		mcommentService.addComment(mcommentVo);

		mcommentVo = mcommentService.getCommentByCno(cno);

		return new ResponseEntity<MCommentVo>(mcommentVo, HttpStatus.OK);
	} // createMain


	// 답댓글 쓰기
	@PostMapping(value = "/new/reply")
	public ResponseEntity<MCommentVo> createReply(@RequestBody MCommentVo mcommentVo,
			HttpSession session) {
		String id = (String) session.getAttribute("id");

		int cno = mySqlService.getNextNum("comment");
		mcommentVo.setCno(cno);
		mcommentVo.setId(id);
		log.info("답댓글 : " + mcommentVo.toString());

		mcommentService.addReplyComment(mcommentVo);

		mcommentVo = mcommentService.getCommentByCno(cno);

		return new ResponseEntity<MCommentVo>(mcommentVo, HttpStatus.OK);
	} // createReply


	@DeleteMapping(value = "/{cno}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("cno") int cno) {
		int count = mcommentService.deleteByCno(cno);

		return (count > 0)
				? new ResponseEntity<String>("success", HttpStatus.OK)
					: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	} // remove


	@PutMapping("/modify")
	public ResponseEntity<MCommentVo> modify(@RequestBody MCommentVo mcommentVo) {
		log.info("mcommentVo : " + mcommentVo);

		mcommentService.update(mcommentVo);

		MCommentVo mcommentVoGet = mcommentService.getCommentByCno(mcommentVo.getCno());

		return new ResponseEntity<MCommentVo>(mcommentVoGet, HttpStatus.OK);
	} // modify

}





