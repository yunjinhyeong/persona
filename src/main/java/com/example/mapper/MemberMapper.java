package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.MemberVo;
import com.example.domain.NoticeVo;

// ���̹�Ƽ������ Mapper �������̽��� ������ ������ ��!
public interface MemberMapper {

	// ������ �޼ҵ尡 �Ű������� 2�� �̻� ��������
	// @Param �ֳ����̼� ������ �̸��� �����ؾ� ��

	//@Select("SELECT * FROM member WHERE id = #{id}")
	MemberVo getMemberById(String id);
	
	int getMemberGender(String id);

	@Select("SELECT sum(price) from bookmovie where id = #{id}")
	String getTotalById(String id);


	@Select("SELECT gender FROM member WHERE id = #{id}")
	String getGender(String id);

	List<MemberVo> getMembersBySearch(
			@Param("startRow") int startRow,
			@Param("pageSize") int pageSize,
			@Param("category") String category,
			@Param("search") String search);

	//@Select("SELECT * FROM member ORDER BY id")
	List<MemberVo> getAllMembers();

	int getCountBySearch(
			@Param("category") String category,
			@Param("search") String search);

	void addMember(MemberVo memberVo);

	//@Select("SELECT passwd FROM member WHERE id = #{id}")
	String userCheck(String id);

	String findUserPasswd(String id, String name, String email);

	String findUserID(String name, String email);

	//@Select("SELECT COUNT(*) FROM member WHERE id = #{id}")
	int getCountById(String id);

	int getCountByEmail(String email);

	int userCheckPasswd(String id, String name, String email);

	int userCheckID(String name, String email);

	void update(MemberVo memberVo);



	//@Delete("DELETE FROM member WHERE id = #{id} ")
	void deleteById(String id);

	//@Delete("DELETE FROM member")
	void deleteAll();


//	@Select("SELECT gender, count(*) as cnt "
//			+ "FROM member "
//			+ "GROUP BY gender ")
	List<Map<String, Object>> getGenderPerCount();



	List<Map<String, Object>> getAgeRangePerCount();


}






