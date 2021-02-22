package com.example.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.NoticeVo;
import com.example.domain.OrderStoreVo;
import com.example.domain.ProductImgVo;
import com.example.domain.ProductVo;
import com.example.domain.SattachVo;
import com.example.mapper.SattachMapper;
import com.example.mapper.StoreMapper;

import lombok.extern.java.Log;

@Log
@Service
public class StoreService {

	@Autowired
	private StoreMapper storeMapper;
	@Autowired
	private SattachMapper sattachMapper;

	public void addOrderDate(OrderStoreVo orderStoreVo) {
		storeMapper.addOrderDate(orderStoreVo);
	}
	public OrderStoreVo getOrderDate(int num) {
		OrderStoreVo orderStoreVo = storeMapper.getOrderDate(num);
		return orderStoreVo;
	}
	public List<OrderStoreVo> getOrderDateById(String id) {
		List<OrderStoreVo> list = storeMapper.getOrderDateById(id);
		return list;
	}
	public List<Map<String, Object>> getSalesByDay() {
		List<Map<String, Object>> list = storeMapper.getSalesByDay();
		return list;
	}
	public int getCountBySearch(String category, String search) {
		int count = storeMapper.getCountBySearch(category, search);
		return count;
	}

	public int getCount() {
		int count = storeMapper.getCount();
		return count;
	}

	public List<ProductVo> getNoticesBySearch(int startRow, int pageSize, String category, String search){
		return storeMapper.getNoticesBySearch(startRow, pageSize, category, search);
	}

	public ProductVo getProductByName(String name) {
		ProductVo productVo = storeMapper.getProductByName(name);
		return productVo;
	}

	public void deleteByName(String name) {
		storeMapper.deleteByName(name);
	}
	public void deleteByNum(int num) {
		storeMapper.deleteByNum(num);
	}

	public List<ProductImgVo> getProductImg(int pageSize){
		List<ProductImgVo> list = storeMapper.getProductImg(pageSize);

		return list;
	}

	public ProductImgVo getOneProduct(int num) {
		ProductImgVo one = storeMapper.getOneProduct(num);
		return one;
	}

	@Transactional
	public void addNoticeAndAttaches(ProductVo productVo, List<SattachVo> sattachList) {
		//게시글 등록
		storeMapper.addProduct(productVo);

		//첨부파일 정보 등록
		for(SattachVo sattachVo : sattachList) {
			sattachMapper.insertSattach(sattachVo);
		}
	}

	@Transactional
	public void updateProductAndAddImg(ProductVo productVo, List<SattachVo> sattachList,List<Integer> delFileNums) {

		log.info("ProductVotrans : " + productVo);
		log.info("delFIleNums: " + delFileNums);

		storeMapper.updateProduct(productVo);

		for(SattachVo sattachVo : sattachList) {
			sattachMapper.insertSattach(sattachVo);
		}

		if (delFileNums != null) {
			sattachMapper.deleteByNums(delFileNums);
		}


	}
}