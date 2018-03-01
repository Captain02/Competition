package com.hanming.oa.controller;

import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.model.MyCollectionDisplay;
import com.hanming.oa.service.MyCollectionService;

@Controller
@RequestMapping("/admin/MyCollection")
public class MyCollectionController {

	@Autowired
	MyCollectionService myCollectionService;
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list(@RequestParam(value="name",defaultValue="名称") String name, @RequestParam(value="pn",defaultValue="0") Integer pn,
			@RequestParam(value="type",defaultValue="类型") String type,Model model) {
		Integer userId= (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		
		PageInfo<MyCollectionDisplay> pageInfo = null;
		PageHelper.startPage(pn, 12);
		List<MyCollectionDisplay> myCollectionDisplay = myCollectionService.list(name,type,userId);
		pageInfo = new PageInfo<>(myCollectionDisplay,5);
		model.addAttribute("pageInfo", pageInfo);

		return "personPage/myCollection";
	}
}
