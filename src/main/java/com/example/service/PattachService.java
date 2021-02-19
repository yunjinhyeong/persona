package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.AttachVo;
import com.example.domain.PattachVo;
import com.example.mapper.PattachMapper;

@Service
@Transactional
public class PattachService {

	@Autowired
	private PattachMapper pattachMapper;
	
	public PattachVo getPattachById2(String id) {
		PattachVo pattachVo = pattachMapper.getPattachById2(id);
			return pattachVo;
	}

	public List<PattachVo>  getPattachById(String id) {
		List<PattachVo> pattachList = pattachMapper.getPattachById(id);
		return pattachList;
	}
	
	public void deleteById(String id) {
		pattachMapper.deleteById(id);
	}


}
