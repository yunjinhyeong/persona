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

		log.info("GET nowList ȣ���");

		// �� ��ȭ ��
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

	// ���� ��¥ ������ ���� ���ڿ� ��������
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

	// �ֱ۾���
	@PostMapping("/write")
	public String write(HttpServletRequest request,
			@RequestParam("poster") MultipartFile poster,
			@RequestParam("mImgTrailer") List<MultipartFile> mImgTrailers,
			MovieVo movieVo, String pageNum) throws IOException {

		//============ �Խñ� MovieVo �غ��ϱ� ==============
		// AUTO INCREMENT ������ȣ ��������
		int mNum = mySqlService.getNextNum("movie");
		movieVo.setMNum(mNum);

		//ip  regDate  readcount
		movieVo.setRegDate(new Timestamp(System.currentTimeMillis()));
		movieVo.setMLike(0);

		//============ �Խñ� MovieVo �غ�Ϸ� ==============



		//============ ���� ���ε带 ���� ���� �غ� ==============
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/");  // webapp ������ �������
		log.info("realPath : " + realPath);

		String strDate = this.getFolder();

		File dir = new File(realPath + "/upload", strDate);
		log.info("dir : " + dir.getPath());

		if (!dir.exists()) {
			dir.mkdirs();
		}


		//============ MultipartFile�� �̿��� ���Ͼ��ε� ���� ==============

		List<MImgTrailerVo> mimgtrailerList = new ArrayList<>();

		for (MultipartFile multipartFile : mImgTrailers) {
			// �����Է»��ڿ��� ������������ ��Ҵ� �ǳʶٱ�
			if (multipartFile.isEmpty()) {
				continue;
			}

			// ���� ���ε��� �����̸� ���ϱ�
			String filename = multipartFile.getOriginalFilename();

			// �ͽ��÷η��� �����̸��� ��ΰ� ���ԵǾ� �����Ƿ�
			// ���� �����̸��� �κй��ڿ��� ��������
			int beginIndex = filename.lastIndexOf("\\") + 1;
			filename = filename.substring(beginIndex);

			// ���ϸ� �ߺ��� ���ϱ� ���ؼ� �����̸� �տ� ���� UUID ���ڿ� ���ϱ�
			UUID uuid = UUID.randomUUID();
			String strUuid = uuid.toString();

			// ���ε�(����)�� �����̸�
			String uploadFilename = strUuid + "_" + filename;

			// ������ ���������� File ��ü�� �غ�
			File saveFile = new File(dir, uploadFilename);

			// �ӽþ��ε�� ������ ��������� ���ϸ����� ����(����)
			multipartFile.transferTo(saveFile);


			//============ ÷������ AttachVo �غ��ϱ� ==============
			MImgTrailerVo mImgTrailerVo = new MImgTrailerVo();
			// �Խ��� �۹�ȣ ����
			mImgTrailerVo.setNoNum(movieVo.getMNum());

			mImgTrailerVo.setUuid(strUuid);
			mImgTrailerVo.setFilename(filename);
			mImgTrailerVo.setUploadpath(strDate);

			if (isImage(filename)) { // �̹����ΰ�? -> �������ΰ�?
				mImgTrailerVo.setImage("T");

				// ������ ����� �̹��� ���� ��ο� �̸��� �غ�
				File thumbnailFile = new File(dir, "s_" + uploadFilename);
				// ����� �̹��� ���� �����ϱ�
				try (FileOutputStream fos = new FileOutputStream(thumbnailFile)) {
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), fos, 100, 100);
				}
			} else {
				mImgTrailerVo.setImage("N");
			}

			// AttachVo �� DB�� insert�ϱ�
			//attachService.insertAttach(attachVo);

			mimgtrailerList.add(mImgTrailerVo);
		} // for

		//============ MultipartFile�� �̿��� ���Ͼ��ε� ���� ==============

		// MimgVo ÷���������� ���� ����Ʈ �غ�
		MImgTrailerVo posterVo = new MImgTrailerVo();

		// ���� ���ε��� �����̸� ���ϱ�
		String filename = poster.getOriginalFilename();

		// �ͽ��÷η��� �����̸��� ��ΰ� ���ԵǾ� �����Ƿ�
		// ���� �����̸��� �κй��ڿ��� ��������
		int beginIndex = filename.lastIndexOf("\\") + 1;
		filename = filename.substring(beginIndex);

		// ���ϸ� �ߺ��� ���ϱ� ���ؼ� �����̸� �տ� ���� UUID ���ڿ� ���ϱ�
		UUID uuid = UUID.randomUUID();
		String strUuid = uuid.toString();

		// ���ε�(����)�� �����̸�
		String uploadFilename = strUuid + "_" + filename;

		// ������ ���������� File ��ü�� �غ�
		File saveFile = new File(dir, uploadFilename);

		// �ӽþ��ε�� ������ ��������� ���ϸ����� ����(����)
		poster.transferTo(saveFile);


		//============ ÷������ AttachVo �غ��ϱ� ==============
		// �Խ��� �۹�ȣ ����
		posterVo.setNoNum(movieVo.getMNum());

		posterVo.setUuid(strUuid);
		posterVo.setFilename(filename);
		posterVo.setUploadpath(strDate);

		if (isImage(filename)) { // �̹����ΰ�? -> �������ΰ�?
			posterVo.setImage("P");

			// ������ ����� �̹��� ���� ��ο� �̸��� �غ�
			File thumbnailFile = new File(dir, "s_" + uploadFilename);
			// ����� �̹��� ���� �����ϱ�
			try (FileOutputStream fos = new FileOutputStream(thumbnailFile)) {
				Thumbnailator.createThumbnail(poster.getInputStream(), fos, 100, 100);
			}
		} else {
			posterVo.setImage("N");
		}

		// AttachVo �� DB�� insert�ϱ�
		//attachService.insertAttach(attachVo);

		mimgtrailerList.add(posterVo);



		// AttachVo �� DB�� insert�ϱ�
		//attachService.insertAttach(attachVo);

//		posterService.insertPoster(posterVo);


		// NoticeVo �� DB�� insert�ϱ�
		//noticeService.addNotice(noticeVo);

		// NoticeVo�� AttachVo �������� Ʈ��������� insert�ϱ�
		movieService.addMovieAndMImgTrailer(movieVo, mimgtrailerList);

		// �ڷ�� �Խ��� �󼼺���� �����̷�Ʈ
		return "redirect:/movieNotice/content?num=" + movieVo.getMNum() + "&pageNum=" + pageNum;
	} // POST - write


	@GetMapping("/content")
	public String content(int num, @ModelAttribute("pageNum") String pageNum, Model model) {

		// ���1) ���ε��� select�ؼ� ��������
//		NoticeVo noticeVo = noticeService.getNoticeByNum(num);
//		List<AttachVo> attachList = attachService.getAttachesByNoNum(num);

		// ���2) ���� ������ �ѹ��� ��������
		MovieVo movieVo = movieService.getMovieAndMImgTrailers(num);

		model.addAttribute("movieVo", movieVo);
		model.addAttribute("mImgTrailerList", movieVo.getMImgTrailerList());

		return "admin/movieContent";
	} // content


	@GetMapping("/detail")
	public String detail(int num, @ModelAttribute("pageNum") String pageNum, String movieName, Model model, HttpSession session) {

		// ���1) ���ε��� select�ؼ� ��������
//		NoticeVo noticeVo = noticeService.getNoticeByNum(num);
//		List<AttachVo> attachList = attachService.getAttachesByNoNum(num);

		// ���2) ���� ������ �ѹ��� ��������
		MovieVo movieVo = movieService.getMovieAndMImgTrailers(num);

		String id = (String) session.getAttribute("id");
		int MovieNum = movieVo.getMNum();

		//�� ��� ����
		double count = mcommentService.getTotalCountByMno(MovieNum);

		//�� ���� ����
		double rcount = watchMovieService.getTotalCount();
		log.info("rcount : " + rcount);

		log.info("movieName : " + movieName);
		//������ ��ȭ ���� ����
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



		int likeStatus = 0; // 0: ó��, 1: ���ƿ並 �������� , 2: ���ƿ並 �����ٰ� ����ѻ���


		if (movieLikeService.getCountByNumAndId(MovieNum, id) == 0) { // ������
			likeStatus = 0;
		} else { // ������
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
		// �Խñ۹�ȣ�� ÷�ε� ÷������ ����Ʈ ��������
		List<MImgTrailerVo> imgTrailerList = mImgTrailerService.getImgTrailersByNoNum(num);

		// application ��ü ���� ��������
		ServletContext application = request.getServletContext();
		// ���ε� ���ذ��
		String realPath = application.getRealPath("/"); // webapp

		// ÷������ �����ϱ�
		for (MImgTrailerVo mImgTrailerVo : imgTrailerList) {
			String dir = realPath + "/upload/" + mImgTrailerVo.getUploadpath();
			String filename = mImgTrailerVo.getUuid() + "_" + mImgTrailerVo.getFilename();
			// ������ ������ File Ÿ�� ��ü�� �غ�
			File file = new File(dir, filename);

			// ���� ���� Ȯ�� �� �����ϱ�
			if (file.exists()) {
				file.delete();
			}

			// �̹��� �����̸�
			if (isImage(mImgTrailerVo.getFilename())) {
				// ������ �̹��� ���翩�� Ȯ�� �� �����ϱ�
				File thumbnailFile = new File(dir, "s_" + filename);
				if (thumbnailFile.exists()) {
					thumbnailFile.delete();
				}
			}
		} // for


		// attach ÷�����ϳ��� �����ϱ�
//		attachService.deleteAttachesByNoNum(num);
		// notice �Խñ� �����ϱ�
//		noticeService.deleteNoticeByNum(num);

		// notice �Խñ� �Ѱ��� attach ÷������ �������� Ʈ��������� �����ϱ�
		movieService.deleteMovieAndMImgTrailer(num);
		mcommentService.deleteByMno(num);

		// �۸������ �����̷�Ʈ �̵�
		return "redirect:/movieNotice/list?pageNum=" + pageNum;
	} // delete

	@GetMapping("/modify")
	public String modify(int num, @ModelAttribute("pageNum") String pageNum, Model model) {
		// �۹�ȣ num�� �ش��ϴ� �۳��� VO�� ��������
//		NoticeVo noticeVo = noticeService.getNoticeByNum(num);
//		List<AttachVo> attachList = attachService.getAttachesByNoNum(num);
		// �������� �ѹ��� ��������
		MovieVo movieVo = movieService.getMovieAndMImgTrailers(num);
		List<MImgTrailerVo> mImgTrailerList = movieVo.getMImgTrailerList();
		//mImgTrailerList.
		int fileCount = mImgTrailerList.size();
		log.info("mImgTrailerList : " + mImgTrailerList);

		log.info("movieVo : " + movieVo);
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
		log.info("MovieVo : " + movieVo);

		//============ ���� ���ε带 ���� ���� �غ� ==============
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/");  // webapp ������ �������
		log.info("realPath : " + realPath);

		String strDate = this.getFolder();

		File dir = new File(realPath + "/upload", strDate);
		log.info("dir : " + dir.getPath());

		if (!dir.exists()) {
			dir.mkdirs();
		}



		//============ MultipartFile�� �̿��� �ű����� ���ε� ���� ==============

		// AttachVo ÷���������� ���� ����Ʈ �غ�
		List<MImgTrailerVo> addMImgTrailers = new ArrayList<>();

		if (multipartFiles != null) {
			for (MultipartFile multipartFile : multipartFiles) {
				// �����Է»��ڿ��� ������������ ��Ҵ� �ǳʶٱ�
				if (multipartFile.isEmpty()) {
					continue;
				}

				// ���� ���ε��� �����̸� ���ϱ�
				String filename = multipartFile.getOriginalFilename();

				// �ͽ��÷η��� �����̸��� ��ΰ� ���ԵǾ� �����Ƿ�
				// ���� �����̸��� �κй��ڿ��� ��������
				int beginIndex = filename.lastIndexOf("\\") + 1;
				filename = filename.substring(beginIndex);

				// ���ϸ� �ߺ��� ���ϱ� ���ؼ� �����̸� �տ� ���� UUID ���ڿ� ���ϱ�
				UUID uuid = UUID.randomUUID();
				String strUuid = uuid.toString();

				// ���ε�(����)�� �����̸�
				String uploadFilename = strUuid + "_" + filename;

				// ������ ���������� File ��ü�� �غ�
				File saveFile = new File(dir, uploadFilename);

				// �ӽþ��ε�� ������ ��������� ���ϸ����� ����(����)
				multipartFile.transferTo(saveFile);


				//============ ÷������ AttachVo �غ��ϱ� ==============
				MImgTrailerVo mImgTrailerVo = new MImgTrailerVo();
				// �Խ��� �۹�ȣ ����
				mImgTrailerVo.setNoNum(movieVo.getMNum());
				mImgTrailerVo.setUuid(strUuid);
				mImgTrailerVo.setFilename(filename);
				mImgTrailerVo.setUploadpath(strDate);

				if (isImage(filename)) {
					mImgTrailerVo.setImage("P");

					// ������ ����� �̹��� ���� ��ο� �̸��� �غ�
					File thumbnailFile = new File(dir, "s_" + uploadFilename);
					// ����� �̹��� ���� �����ϱ�
					try (FileOutputStream fos = new FileOutputStream(thumbnailFile)) {
						Thumbnailator.createThumbnail(multipartFile.getInputStream(), fos, 100, 100);
					}
				} else {
					mImgTrailerVo.setImage("N");
				}

				// AttachVo �� DB�� insert�ϱ�
				//attachService.insertAttach(attachVo);

				// Ʈ����� ó���� ���� attachVo�� ����Ʈ�� �߰��ؼ� ������
				addMImgTrailers.add(mImgTrailerVo);
			} // for
		}


		//============ delFileNums �� ÷������ �����۾� ���� ==============

		if (delFileNums != null) {
			for (int num : delFileNums) {
				// ÷������ ��ȣ�� �ش��ϴ� ÷������ ���� �Ѱ��� VO�� ��������
				MImgTrailerVo mImgTrailerVo = mImgTrailerService.getImgTrailerByNum(num);

				// ���������� �������� ���翩�� Ȯ���ؼ� �����ϱ�
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

				// ÷������ DB���̺� ÷�����Ϲ�ȣ�� �ش��ϴ� ���ڵ� �Ѱ� �����ϱ�
				//attachService.deleteAttachByNum(num);
			} // for
		} //if


		// ÷�����Ϲ�ȣ�鿡 �ش��ϴ� ÷������ ���ڵ�� �ϰ� �����ϱ�
		//attachService.deleteAttachesByNums(delFileNums);


		// �Խ��� ���̺� �� update�ϱ�
		//noticeService.updateBoard(noticeVo);

		// Ʈ����� ������ ���̺� ������ ó��
		movieService.updateMovieAndAddMImgTrailersAndDeleteMImgTrailers(movieVo, addMImgTrailers, delFileNums);


		rttr.addAttribute("num", movieVo.getMNum());
		rttr.addAttribute("pageNum", pageNum);

		// �󼼺��� ȭ������ �����̷�Ʈ �̵�
		return "redirect:/movieNotice/content";
	} // POST - modify


	@RequestMapping(value="/like", method=RequestMethod.POST)
	@ResponseBody
	public void like(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpSession session){
		System.out.println(param);

		int likeStatus = Integer.parseInt((String) param.get("likeStatus"));
		int movieNum = Integer.parseInt((String) param.get("movieNum"));
		String userId = (String) param.get("userId");

		//1 �ش� �Խ��� �÷��� likes�� ������Ű�ų� ������Ų�� likeStatus ������
		//2 ���ƿ並 ���� ������ ���������� notice_like ���̺��� is_like �÷��� 0 �Ǵ� 1�� �����Ѵ�

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





