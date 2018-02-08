package com.hanming.oa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.MyImageDispaly;
import com.hanming.oa.service.BBSTopicService;
import com.hanming.oa.service.ImageService;
import com.hanming.oa.service.UpDownFileService;

@Controller
@RequestMapping("admin/image")
public class ImageController {

	@Autowired
	UpDownFileService upDownFileService;
	@Autowired
	BBSTopicService bbsTopicService;
	@Autowired
	ImageService imageService;
	//遍历集合
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list(@RequestParam(value="isByMy",defaultValue="0")Integer isByMy,Model model) {
		if (isByMy!=0) {
			isByMy = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		}
		List<MyImageDispaly> list = imageService.selectList(isByMy);
		model.addAttribute("MyImageDispaly", list);
		model.addAttribute("isByMy", isByMy);
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
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		String path = request.getSession().getServletContext().getRealPath("myImage");
		imageService.addMyImage(files, userId, path,request);
		return Msg.success();
	}
	
	@ResponseBody
	@RequestMapping(value="/dele",method=RequestMethod.POST)
	public Msg dele(@RequestParam("topicId")Integer topicId) {
		imageService.deleByTopicId(topicId);
		return Msg.success();
	}
	
}
