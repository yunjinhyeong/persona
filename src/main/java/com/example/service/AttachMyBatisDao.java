package com.example.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.example.domain.AttachVo;
import com.example.mapper.AttachMapper;

public final class AttachMyBatisDao {

	private static AttachMyBatisDao instance = new AttachMyBatisDao();
	
	public static AttachMyBatisDao getInstance() {
		return instance;
	}
	
	/////////////////////////////////////////////////
	
	private SqlSessionFactory sqlSessionFactory;

	private AttachMyBatisDao() {
		sqlSessionFactory = MyBatisUtils.getSqlSessionFactory();
	}
	
	
	public void insertAttach(AttachVo attachVo) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			AttachMapper mapper = sqlSession.getMapper(AttachMapper.class);
			mapper.insertAttach(attachVo);
		}
	}
	
	
	public AttachVo getAttachByNum(int num) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			AttachMapper mapper = sqlSession.getMapper(AttachMapper.class);
			AttachVo attachVo = mapper.getAttachByNum(num);
			return attachVo;
		}
	}
	
	
	public List<AttachVo> getAttachesByNoNum(int noNum) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			AttachMapper mapper = sqlSession.getMapper(AttachMapper.class);
			List<AttachVo> attachList = mapper.getAttachesByNoNum(noNum);
			return attachList;
		}
	}
	
	
	public void deleteAttachByNum(int num) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			AttachMapper mapper = sqlSession.getMapper(AttachMapper.class);
			mapper.deleteAttachByNum(num);
		}
	}
	
	
	public void deleteAttachesByNoNum(int noNum) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			AttachMapper mapper = sqlSession.getMapper(AttachMapper.class);
			mapper.deleteAttachesByNoNum(noNum);
		}
	}
	
	
	public void deleteAttachesByNums(List<Integer> numList) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			AttachMapper mapper = sqlSession.getMapper(AttachMapper.class);
			mapper.deleteAttachesByNums(numList);
		}
	}
	
}



