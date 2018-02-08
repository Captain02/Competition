package com.hanming.oa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hanming.oa.Tool.Msg;

@Controller
@RequestMapping("admin/image")
public class ImageController {

	//遍历集合
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list() {
		return "myimg/img";
	}
	
	//跳转页面
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add() {
		return "myimg/add";
	}
	
	//上传
	@ResponseBody
	@RequestMapping(value="/upImage",method=RequestMethod.POST)
	public Msg UpImage(@RequestParam MultipartFile file[]) {
		for (MultipartFile iterable_element : file) {
			System.out.println(iterable_element.getOriginalFilename());
		}
		return Msg.success();
	}
}
