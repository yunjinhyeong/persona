package com.example.service;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.example.mapper.MySqlMapper;

public final class MySqlMyBatisDao {

	private static MySqlMyBatisDao instance = new MySqlMyBatisDao();
	
	public static MySqlMyBatisDao getInstance() {
		return instance;
	}
	
	/////////////////////////////////////////////////
	
	private SqlSessionFactory sqlSessionFactory;

	private MySqlMyBatisDao() {
		sqlSessionFactory = MyBatisUtils.getSqlSessionFactory();
	}
	
	
	public int getNextNum(String tableName) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			MySqlMapper mapper = sqlSession.getMapper(MySqlMapper.class);
			int num = mapper.getNextNum(tableName);
			return num;
		}
	}
	
}



