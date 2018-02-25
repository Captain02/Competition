package com.hanming.oa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.model.DocumentDisplay;
import com.hanming.oa.service.DocumentService;

@Controller
@RequestMapping("/admin/document")
public class DocumentController {

	@Autowired
	DocumentService documentService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "0") Integer pn,
			@RequestParam(value = "type", defaultValue = "类型") String type,
			@RequestParam(value = "documentName", defaultValue = "文档名") String documentName, Model model,
			HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		
		PageInfo<DocumentDisplay> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<DocumentDisplay> list = documentService.list(type, documentName,projectId);
		pageInfo = new PageInfo<>(list);

		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("type", type);
		model.addAttribute("documentName", documentName);

		return "projectDocument/document";
	}
}
