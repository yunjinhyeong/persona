package com.example.service;

import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.example.domain.NoticeVo;
import com.example.mapper.NoticeMapper;

public final class NoticeMyBatisDao {

	private static NoticeMyBatisDao instance = new NoticeMyBatisDao();
	
	public static NoticeMyBatisDao getInstance() {
		return instance;
	}
	
	/////////////////////////////////////////////////
	
	private SqlSessionFactory sqlSessionFactory;

	private NoticeMyBatisDao() {
		sqlSessionFactory = MyBatisUtils.getSqlSessionFactory();
	}
	
	
	// �ֱ۾��� �޼���
	public void addNotice(NoticeVo noticeVo) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			NoticeMapper mapper = sqlSession.getMapper(NoticeMapper.class);
			mapper.addNotice(noticeVo);
		}
	}
	
	
	public NoticeVo getNoticeByNum(int num) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			NoticeMapper mapper = sqlSession.getMapper(NoticeMapper.class);
			NoticeVo noticeVo = mapper.getNoticeByNum(num);
			return noticeVo;
		}
	}
	
	
	
	public void updateReadcount(int num) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			NoticeMapper mapper = sqlSession.getMapper(NoticeMapper.class);
			mapper.updateReadcount(num);
		}
	}
	
	
	
	// ��ü�۰��� ��������
	public int getCountAll() {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			NoticeMapper mapper = sqlSession.getMapper(NoticeMapper.class);
			int count = mapper.getCountAll();
			return count;
		}
	}
	
	
	public List<NoticeVo> getNotices(int startRow, int pageSize) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			NoticeMapper mapper = sqlSession.getMapper(NoticeMapper.class);
			List<NoticeVo> list = mapper.getNotices(startRow, pageSize);
			return list;
		}
	}
	
	
	public void updateBoard(NoticeVo noticeVo) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			NoticeMapper mapper = sqlSession.getMapper(NoticeMapper.class);
			mapper.updateBoard(noticeVo);
		}
	}
	
	public void deleteNoticeByNum(int num) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			NoticeMapper mapper = sqlSession.getMapper(NoticeMapper.class);
			mapper.deleteNoticeByNum(num);
		}
	}
	
	public void deleteAll() {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			NoticeMapper mapper = sqlSession.getMapper(NoticeMapper.class);
			mapper.deleteAll();
		}
	}
	
	// ��۾��� �޼���
	public boolean updateAndAddReply(NoticeVo noticeVo) {
		SqlSession sqlSession = null;
		try {
			// Ʈ����� ������ ó���ϱ� ���ؼ� ����Ŀ������ ������
			sqlSession = sqlSessionFactory.openSession(false); // false�� ����Ŀ��
			NoticeMapper mapper = sqlSession.getMapper(NoticeMapper.class);
			
			// ��� insert �ϱ� ���� ���� �۱׷� ���� ���� �����ϱ�
			mapper.updateReSeq(noticeVo.getReRef(), noticeVo.getReSeq());
			
			// ��ۿ� �˸��� ������ VO�� ����
			noticeVo.setReLev(noticeVo.getReLev() + 1);
			noticeVo.setReSeq(noticeVo.getReSeq() + 1);
			
			// ��� insert �ϱ�
			mapper.addNotice(noticeVo);
			
			sqlSession.commit(); // Ŀ���ϱ�
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			sqlSession.rollback(); // �ѹ��ϱ�
			return false;
		} finally {
			sqlSession.close(); // sqlSession �ݱ�
		}
	}
	
	
	// �˻�� ������ �۰��� ��������
	public int getCountBySearch(String category, String search) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			NoticeMapper mapper = sqlSession.getMapper(NoticeMapper.class);
			return mapper.getCountBySearch(category, search);
		}
	}
	
	
	public List<NoticeVo> getNoticesBySearch(int startRow, int pageSize, String category, String search) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			NoticeMapper mapper = sqlSession.getMapper(NoticeMapper.class);
			return mapper.getNoticesBySearch(startRow, pageSize, category, search);
		}
	}
	
	
	// notice ���̺�� attach ���̺� ���� �ܺ������ؼ� ��������
	public NoticeVo getNoticeAndAttaches(int num) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			NoticeMapper mapper = sqlSession.getMapper(NoticeMapper.class);
			return mapper.getNoticeAndAttaches(num);
		}
	}
	
	//public List<NoticeVo> getNoticesByNums(List<Integer> numList)
	public List<NoticeVo> getNoticesByNums(Integer... numArr) {
		List<Integer> numList = Arrays.asList(numArr);
		
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
			NoticeMapper mapper = sqlSession.getMapper(NoticeMapper.class);
			return mapper.getNoticesByNums(numList);
		}
	}
	
	
	public static void main(String[] args) {
//		NoticeMyBatisDao dao = NoticeMyBatisDao.getInstance();
		
//		List<Integer> numList = new ArrayList<>();
//		numList.add(1014);
//		numList.add(1013);
//		numList.add(1010);
		
		//List<NoticeVo> noticeList = dao.getNoticesByNums(numList);
//		List<NoticeVo> noticeList = dao.getNoticesByNums(1014, 1013, 1010);
//		for (NoticeVo noticeVo : noticeList) {
//			System.out.println(noticeVo);
//		}
		
	}
	
}



