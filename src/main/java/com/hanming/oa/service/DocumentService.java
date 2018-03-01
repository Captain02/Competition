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

import com.hanming.oa.Tool.DateTool;
import com.hanming.oa.dao.DocumentMapper;
import com.hanming.oa.model.Document;
import com.hanming.oa.model.DocumentDetailed;
import com.hanming.oa.model.DocumentDisplay;

@Service
public class DocumentService {
	
	@Autowired
	DocumentMapper documentMapper;

	public List<DocumentDisplay> list(String type, String documentName, Integer projectId) {
		List<DocumentDisplay> list = documentMapper.list(type,documentName,projectId);
		return list;
	}

	@Transactional
	public void insert(Document document, MultipartFile file, HttpServletRequest request, Integer projectId, int i) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");

		document.setProjectId(projectId);
		document.setCreatePeople(userId);
		if (file != null) {
			String path = request.getSession().getServletContext().getRealPath("Document");
			String fileName = new Date().toString().replace(":", "-") + file.getOriginalFilename();
			document.setEnclosure(fileName);
			document.setFileName(file.getOriginalFilename());

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
		if (i == 0) {
			documentMapper.updateByPrimaryKeySelective(document);
		} else {
			documentMapper.insertSelective(document);
		}

	}

	public DocumentDetailed detailedById(Integer id) {
		DocumentDetailed detailedById = documentMapper.detailedById(id);
		return detailedById;
	}

	public void delete(Integer id) {
		documentMapper.deleteByPrimaryKey(id);
	}

	public Document select(Integer id) {
		Document document = documentMapper.selectByPrimaryKey(id);
		return document;
	}

}
