package com.hanming.oa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hanming.oa.service.BugService;

@Controller
@RequestMapping
public class BugController {

	@Autowired
	BugService BugService;
}
