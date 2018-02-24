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
import com.hanming.oa.dao.DemandMapper;
import com.hanming.oa.model.Demand;
import com.hanming.oa.model.DemandDetailed;
import com.hanming.oa.model.DemandDisplay;

@Service
public class DemandService {

	@Autowired
	DemandMapper demandMapper;

	public List<DemandDisplay> list(String state, String demandName, Integer projectId) {

		List<DemandDisplay> list = demandMapper.list(state, demandName, projectId);
		return list;
	}

	public DemandDetailed detaileById(Integer demandId) {
		DemandDetailed detaileById = demandMapper.detaileById(demandId);
		return detaileById;
	}

	@Transactional
	public void insert(Demand demand, MultipartFile file, HttpServletRequest request, Integer projectId,
			Integer isInsert) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");

		demand.setCreateTime(DateTool.dateToString(new Date()));
		demand.setProjectId(projectId);
		demand.setCreatePeopele(userId);
		demand.setState("激活");
		if (file != null) {
			String path = request.getSession().getServletContext().getRealPath("Demand");
			String fileName = new Date().toString().replace(":", "-") + file.getOriginalFilename();
			demand.setEnclosure(fileName);
			demand.setFileName(file.getOriginalFilename());

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
		if (isInsert == 0) {
			demandMapper.updateByPrimaryKeySelective(demand);
		} else {
			demandMapper.insertSelective(demand);
		}

	}

}
