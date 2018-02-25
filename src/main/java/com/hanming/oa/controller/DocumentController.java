package com.hanming.oa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.Document;
import com.hanming.oa.model.DocumentDetailed;
import com.hanming.oa.model.DocumentDisplay;
import com.hanming.oa.service.DocumentService;

@Controller
@RequestMapping("/admin/document")
public class DocumentController {

	@Autowired
	DocumentService documentService;

	// 列表
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "0") Integer pn,
			@RequestParam(value = "type", defaultValue = "类型") String type,
			@RequestParam(value = "documentName", defaultValue = "文档名") String documentName, Model model,
			HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");

		PageInfo<DocumentDisplay> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<DocumentDisplay> list = documentService.list(type, documentName, projectId);
		pageInfo = new PageInfo<>(list);

		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("type", type);
		model.addAttribute("documentName", documentName);

		return "projectDocument/document";
	}

	// 跳转添加页
	@RequestMapping(value = "/addPage", method = RequestMethod.GET)
	public String addPage() {

		return "projectDocument/add";
	}

	// 添加
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String add(Document document, MultipartFile file, HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		documentService.insert(document, file, request, projectId, 1);
		return "projectDocument/add";
	}

	// 详情
	@RequestMapping(value = "/detailed", method = RequestMethod.GET)
	public String documentDetailed(@RequestParam(value = "id") Integer id, Model model) {
		DocumentDetailed documentDetailed = documentService.detailedById(id);
		model.addAttribute("documentDetailed", documentDetailed);
		return "projectDocument/documentDetails";
	}

	// 编辑页
	@RequestMapping(value = "/editor", method = RequestMethod.GET)
	public String editor(@RequestParam(value = "id") Integer id, Model model) {
		DocumentDetailed documentDetailed = documentService.detailedById(id);
		model.addAttribute("documentDetailed", documentDetailed);
		return "projectDocument/editor";
	}

	// 编辑
	@ResponseBody
	@RequestMapping(value = "/editor", method = RequestMethod.POST)
	public Msg editor(Document document, MultipartFile file, HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		documentService.insert(document, file, request, projectId, 0);
		return Msg.success();
	}

	// 删除
	@ResponseBody
	@RequestMapping(value = "/dele", method = RequestMethod.POST)
	public Msg dele(@RequestParam("id") Integer id) {
		documentService.delete(id);
		return Msg.success();
	}
}
