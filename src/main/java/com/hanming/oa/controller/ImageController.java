package com.hanming.oa.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hanming.oa.Tool.Msg;
import com.hanming.oa.service.UpDownFileService;

@Controller
@RequestMapping("admin/image")
public class ImageController {

	@Autowired
	UpDownFileService upDownFileService;
	
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
	public Msg UpImage(@RequestParam("uploadFiles")MultipartFile files[],HttpServletRequest request) {
		String path = request.getSession().getServletContext().getRealPath("myImage");
		for (MultipartFile file : files) {
			
			String fileName = new Date().toString().replace(":", "-") + file.getOriginalFilename();
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
		return Msg.success();
	}
}
