package com.hanming.oa.service;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.hanming.oa.dao.ProjectBugMapper;
import com.hanming.oa.model.BugDetailed;
import com.hanming.oa.model.BugDisplay;
import com.hanming.oa.model.ProjectBug;


@Service
public class BugService {

	@Autowired
	ProjectBugMapper projectBugMapper;

	public List<BugDisplay> list(String state, String name, Integer hrefPage, Integer projectId, Integer userId) {
		List<BugDisplay> list = projectBugMapper.list(state,name,hrefPage,projectId,userId);
		return list;
	}

	public BugDetailed detailedById(Integer id) {
		BugDetailed bugDetailed = projectBugMapper.detailedById(id);
		return bugDetailed;
	}

	@Transactional
	public void insert(ProjectBug projectBug, MultipartFile file, Set<Integer> idInt, int i,
			HttpServletRequest request) {
		if (file != null) {
			String path = request.getSession().getServletContext().getRealPath("ProjectBug");
			String fileName = new Date().toString().replace(":", "-") + file.getOriginalFilename();
			projectBug.setEnclosure(fileName);
			projectBug.setFileName(file.getOriginalFilename());

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
		if (i == 1) {
			for (Integer integer : idInt) {
				projectBug.setAssginor(integer);
				projectBugMapper.insertSelective(projectBug);
			}
		} else {
			projectBugMapper.updateByPrimaryKeySelective(projectBug);
		}
	}

	public void update(ProjectBug projectBug) {
		projectBugMapper.updateByPrimaryKeySelective(projectBug);
	}

}
