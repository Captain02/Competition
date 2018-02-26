package com.hanming.oa.service;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.hanming.oa.dao.DustyMapper;
import com.hanming.oa.model.Dusty;
import com.hanming.oa.model.DustyDetailed;
import com.hanming.oa.model.DustyDisplay;

@Service
public class DustyService {

	@Autowired
	DustyMapper dustyMapper;
	
	public List<DustyDisplay> list(String type, String state, String dustyName, Integer herfPage, Integer projectId, Integer userId) {
		List<DustyDisplay> list = dustyMapper.list(type,state,dustyName,herfPage,projectId,userId);
		return list;
	}

	public DustyDetailed detailedById(Integer id) {
		DustyDetailed detailedById = dustyMapper.detailedById(id);
		return detailedById;
	}

	public void update(Dusty dusty) {
		dustyMapper.updateByPrimaryKeySelective(dusty);
	}

	public void deleteById(Integer id) {
		dustyMapper.deleteByPrimaryKey(id);
	}

	public void insert(Dusty dusty, MultipartFile file, Set<Integer> idInt, int i, HttpServletRequest request) {
		if (file != null) {
			String path = request.getSession().getServletContext().getRealPath("Dusty");
			String fileName = new Date().toString().replace(":", "-") + file.getOriginalFilename();
			dusty.setEnclosure(fileName);
			dusty.setFileName(file.getOriginalFilename());

			File dir = new File(path, fileName);
			if (!dir.exists()) {
				dir.mkdirs();
			}

			// MultipartFile自带的解析方法
			try {
				file.transferTo(dir);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		if (i==1) {
			for (Integer integer : idInt) {
				dusty.setAssignor(integer);
				dustyMapper.insertSelective(dusty);
			}
		}else {
			for (Integer integer : idInt) {
				dustyMapper.updateByPrimaryKeySelective(dusty);
			}
		}
	}

}
