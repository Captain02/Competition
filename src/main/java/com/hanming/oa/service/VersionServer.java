package com.hanming.oa.service;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.hanming.oa.dao.VersionsMapper;
import com.hanming.oa.model.ProjectHistory;
import com.hanming.oa.model.Versions;

@Service
public class VersionServer {
	
	@Autowired
	VersionsMapper versionsMapper;
	@Autowired
	ProjectHistoryService projectHistoryService;

	public List<Versions> list(String versionName, Integer projectId) {
		List<Versions> list = versionsMapper.list(versionName,projectId);
		return list;
	}

	public Versions detailedById(Integer id) {
		Versions version = versionsMapper.detailedById(id);
		return version;
	}

	@Transactional
	public void insert(Versions versions, MultipartFile file, HttpServletRequest request, Integer projectId, int i) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");

		versions.setProjectId(projectId);
		versions.setCreatePeople(userId);
		if (file != null) {
			versions.setLssuePackageName(file.getOriginalFilename());
			String path = request.getSession().getServletContext().getRealPath("Versions");
			String fileName = new Date().toString().replace(":", "-") + file.getOriginalFilename();
			versions.setEnclosure(fileName);
			versions.setFileName(file.getOriginalFilename());

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
		ProjectHistory projectHistory = new ProjectHistory();
		projectHistory.setOperationPeopleId(userId);
		projectHistory.setHistoryType("版本");
		if (i == 0) {
			versionsMapper.updateByPrimaryKeySelective(versions);
			projectHistory.setTypeId(versions.getId());
			projectHistory.setOperationType("修改了版本");
			projectHistoryService.insertSelective(projectHistory);
		} else {
			versionsMapper.insertSelective(versions);
			projectHistory.setTypeId(versions.getId());
			projectHistory.setOperationType("创建了版本");
			projectHistoryService.insertSelective(projectHistory);
		}
	}

	public void delete(Integer id) {
		versionsMapper.deleteByPrimaryKey(id);
	}

}
