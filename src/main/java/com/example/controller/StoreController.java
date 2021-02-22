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

import com.example.domain.AttachVo;
import com.example.domain.MImgTrailerVo;
import com.example.domain.MemberVo;
import com.example.domain.MovieVo;
import com.example.domain.NoticeVo;
import com.example.domain.OrderStoreVo;
import com.example.domain.PageDto;
import com.example.domain.PattachVo;
import com.example.domain.ProductImgVo;
import com.example.domain.ProductVo;
import com.example.domain.SattachVo;
import com.example.service.MemberService;
import com.example.service.MySqlService;
import com.example.service.SattachService;
import com.example.service.StoreService;

import lombok.extern.java.Log;
import net.coobird.thumbnailator.Thumbnailator;

@Log
@Controller
@RequestMapping("/store/*")
public class StoreController {

	@Autowired
	private StoreService storeService;

	@Autowired
	private SattachService sattachService;

	@Autowired
	private MySqlService mySqlService;

	@Autowired
	private MemberService memberService;

	@GetMapping("/list")
	public String list(@RequestParam(defaultValue = "1") int pageNum, @RequestParam(defaultValue = "") String category,
			@RequestParam(defaultValue = "") String search, Model model) {

		log.info("get store/list 호출됨");

		int count = storeService.getCountBySearch(category, search);

		int pageSize = 10;

		int startRow = (pageNum - 1) * pageSize;

		List<ProductVo> storeList = null;
		if (count > 0) {
			storeList = storeService.getNoticesBySearch(startRow, pageSize, category, search);
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

		model.addAttribute("storeList", storeList);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);

		return "store/productlist";
	}

	//상품등록 하는 양식 불러오기
	@GetMapping("/write")
	public String write(@ModelAttribute("pageNum") String pageNum, Model model) {
		log.info("get write 호출됨");

		return "store/productWriteForm";
	}//GET - write

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

	//상품등록하기
	@PostMapping("/write")
	public String write(HttpServletRequest request,
			@RequestParam("filename") List<MultipartFile> multipartFiles,
			ProductVo productVo, String pageNum) throws IOException {

//		int num = mySqlService.getNextNum("product");
//		productVo.setNum(num);
//		productVo.setRegDate(new Timestamp(System.currentTimeMillis()));


		//============ 파일 업로드를 위한 폴더 준비 ==============
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/");  // webapp 폴더의 실제경로
		log.info("realPath : " + realPath);

		String strDate = this.getFolder();

		File dir = new File(realPath + "/upload3", strDate);
		log.info("dir : " + dir.getPath());

		if (!dir.exists()) {
			dir.mkdirs();
		}

		// AttachVo 첨부파일정보 담을 리스트 준비
		List<SattachVo> sattachList = new ArrayList<>();

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
			SattachVo sattachVo = new SattachVo();
			// 게시판 글번호 설정
			sattachVo.setPname(productVo.getName());

			sattachVo.setUuid(strUuid);
			sattachVo.setFilename(filename);
			sattachVo.setUploadpath(strDate);

			if (isImage(filename)) {
				sattachVo.setImage("I");

				// 생성할 썸네일 이미지 파일 경로와 이름을 준비
				File thumbnailFile = new File(dir, "s_" + uploadFilename);
				// 썸네일 이미지 파일 생성하기
				try (FileOutputStream fos = new FileOutputStream(thumbnailFile)) {
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), fos, 100, 100);
				}
			} else {
				sattachVo.setImage("O");
			}

			// AttachVo 를 DB에 insert하기
			//attachService.insertAttach(attachVo);

			sattachList.add(sattachVo);

		} // for

		storeService.addNoticeAndAttaches(productVo, sattachList);

		log.info("post Write 호출됨");

		return "redirect:/store/list";
	} // POST - write

	@GetMapping("/modify")
	public String modify(String id, String pname, @ModelAttribute("pageNum") String pageNum, Model model) {
		log.info("get modify ");
		MemberVo memberVo = memberService.getMemberById(id);
		SattachVo sattachVo = sattachService.getSattachByPname(pname);
		ProductVo productVo = storeService.getProductByName(pname);

		//List<SattachVo> sattachList =
		//SattachVo sattachVo = (SattachVo) sattachService.getSattachByName(pname);


		log.info("memberVo : " + memberVo);
		log.info("sattachVo :"+ sattachVo);
		log.info("productVo : "+ productVo);
		//log.info("sattachVo"+ sattachVo);

		model.addAttribute("memberVo", memberVo);
		model.addAttribute("sattachVo", sattachVo);
		model.addAttribute("productVo", productVo);
		return "store/productModifyForm";
	}

	@PostMapping("/modify")
	public String modify(HttpServletRequest request,
			@RequestParam(name = "filename", required = false) List<MultipartFile> multipartFiles,
			ProductVo productVo, String pageNum,
			@RequestParam(name = "delfile", required = false) List<Integer> delFileNums,
			RedirectAttributes rttr) throws IOException {

		log.info("productVo : " + productVo);

		//============ 파일 업로드를 위한 폴더 준비 ==============
				ServletContext application = request.getServletContext();
				String realPath = application.getRealPath("/");  // webapp 폴더의 실제경로
				log.info("realPath : " + realPath);

				String strDate = this.getFolder();

				File dir = new File(realPath + "/upload3", strDate);
				log.info("dir : " + dir.getPath());

				if (!dir.exists()) {
					dir.mkdirs();
				}

				// AttachVo 첨부파일정보 담을 리스트 준비
				List<SattachVo> sattachList = new ArrayList<>();

				if(multipartFiles != null) {
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
					SattachVo sattachVo = new SattachVo();
					// 게시판 글번호 설정
					sattachVo.setPname(productVo.getName());

					sattachVo.setUuid(strUuid);
					sattachVo.setFilename(filename);
					sattachVo.setUploadpath(strDate);

					if (isImage(filename)) {
						sattachVo.setImage("I");

						// 생성할 썸네일 이미지 파일 경로와 이름을 준비
						File thumbnailFile = new File(dir, "s_" + uploadFilename);
						// 썸네일 이미지 파일 생성하기
						try (FileOutputStream fos = new FileOutputStream(thumbnailFile)) {
							Thumbnailator.createThumbnail(multipartFile.getInputStream(), fos, 100, 100);
						}
					} else {
						sattachVo.setImage("O");
					}

					// AttachVo 를 DB에 insert하기
					//attachService.insertAttach(attachVo);

					sattachList.add(sattachVo);

				} // for
				}

				//============ delFileNums �� ÷������ �����۾� ���� ==============

				if (delFileNums != null) {
					for (int num : delFileNums) {
						// ÷������ ��ȣ�� �ش��ϴ� ÷������ ���� �Ѱ��� VO�� ��������
						SattachVo sattachVo = sattachService.getSattachByNum(num);

						// ���������� �������� ���翩�� Ȯ���ؼ� �����ϱ�
						String path = realPath + "/upload3/" + sattachVo.getUploadpath();
						String file = sattachVo.getUuid() + "_" + sattachVo.getFilename();

						File delFile = new File(path, file);
						if (delFile.exists()) {
							delFile.delete();
						}

						if (isImage(sattachVo.getFilename())) {
							File thumbnailFile = new File(path, "s_" + file);
							if (thumbnailFile.exists()) {
								thumbnailFile.delete();
							}
						}

						// ÷������ DB���̺� ÷�����Ϲ�ȣ�� �ش��ϴ� ���ڵ� �Ѱ� �����ϱ�
						//attachService.deleteAttachByNum(num);
					} // for
				} //if

		log.info("productVo2 : " + productVo);
				//storeService.addNoticeAndAttaches(productVo, sattachList);
				storeService.updateProductAndAddImg(productVo, sattachList, delFileNums);

				log.info("post modify 호출됨");

		// �󼼺��� ȭ������ �����̷�Ʈ �̵�
		return "redirect:/store/list";
	} // POST - modify


	@PostMapping("/kakaoPay")
	public String kakaoPay(OrderStoreVo orderStoreVo, Model model, String id){
		MemberVo memberVo = memberService.getMemberById(id);
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("orderStoreVo", orderStoreVo);
		return "/store/kakaoPay";
	} // POST - kakaoPay

	@GetMapping("/kakaoPay")
	public String kakaoPayGet(OrderStoreVo orderStoreVo, Model model, String id){
		orderStoreVo.setRegDate(new Timestamp(System.currentTimeMillis()));
		orderStoreVo.setNum(mySqlService.getNextNum("orderstore"));
		storeService.addOrderDate(orderStoreVo);
		return "redirect:/store/productPage";
	} // POST - write

	@GetMapping("content")
	public String content(String name, @ModelAttribute("pageNum") String pageNum, Model model) {

		ProductVo productVo = storeService.getProductByName(name);
		List<SattachVo> sattachList = sattachService.getSattachByName(name);

		log.info("sattachList : " + sattachList);

		model.addAttribute("productVo", productVo);
		model.addAttribute("sattachList",sattachList);


		return "store/productContent";
	}

	@GetMapping("buyItem")
	public String buyItem(@RequestParam int num, Model model) {

		ProductImgVo getProduct = storeService.getOneProduct(num);

		model.addAttribute("getProduct", getProduct);

		return "store/productDetail";
	}

	@GetMapping("/delete")
	public String delete(ProductVo productVo, String pageNum, HttpServletRequest request) {

		storeService.deleteByName(productVo.getName());
		sattachService.deleteByName(productVo.getName());


		return "redirect:/store/list?pageNum=" + pageNum;
	}

	@GetMapping("/deleteProduct")
	public String delete(int num, String id) {
		storeService.deleteByNum(num);
		return "redirect:/member/mypage?id="+id;
	}



	@GetMapping("/productPage")
	public String productPage(@RequestParam(defaultValue = "1") int pageNum, @RequestParam(defaultValue = "") String category,
			@RequestParam(defaultValue = "") String search,
			Model model) {

		int count = storeService.getCount();

		int pageSize = pageNum * 15;

		List<ProductImgVo> productList = null;

		if(count > 0) {
			productList=storeService.getProductImg(pageSize);
			log.info("productList : " + productList);
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

			pageDto.setCount(count);
			pageDto.setPageCount(pageCount);
			pageDto.setPageBlock(pageBlock);
			pageDto.setStartPage(startPage);
			pageDto.setEndPage(endPage);
		} // if

		model.addAttribute("productList", productList);

		log.info("get productPage 호출됨");




		return "store/products";
	}
}
