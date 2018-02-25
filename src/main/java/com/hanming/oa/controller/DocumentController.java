package com.hanming.oa.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
			@RequestParam(value = "documentName") String documentName) {
		
		List<DocumentDisplay> list = documentService.list(type,documentName);

		return "projectDocument/document";
	}
}
