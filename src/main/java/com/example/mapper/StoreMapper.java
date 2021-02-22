package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.domain.OrderStoreVo;
import com.example.domain.ProductImgVo;
import com.example.domain.ProductVo;

public interface StoreMapper {

	ProductVo getProductByName(String name);

	void addProduct(ProductVo productVo);

	void addOrderDate(OrderStoreVo orderStoreVo);

	OrderStoreVo getOrderDate(int num);

	@Select("SELECT COUNT(*) FROM bisp.product")
	int getCount();

	@Delete("DELETE FROM bisp.product WHERE name = #{name} ")
	void deleteByName(String name);

	@Delete("DELETE FROM orderstore WHERE num = #{num} ")
	void deleteByNum(int num);

	List<Map<String, Object>> getSalesByDay();

	List<OrderStoreVo> getOrderDateById(String id);

	List<ProductImgVo> getProductImg(int pageSize);

	ProductImgVo getOneProduct(int num);

	int getCountBySearch(
			@Param("category") String category,
			@Param("search") String search);

	List<ProductVo> getNoticesBySearch(
			@Param("startRow") int startRow,
			@Param("pageSize") int pageSize,
			@Param("category") String category,
			@Param("search") String search);


	void updateProduct(ProductVo productVo);


}
