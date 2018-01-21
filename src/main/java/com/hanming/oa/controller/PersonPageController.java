package com.hanming.oa.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Base64;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.PersonHead;
import com.hanming.oa.model.User;
import com.hanming.oa.service.PersonHeadService;
import com.hanming.oa.service.UserService;

@Controller
@RequestMapping("/admin/personPage")
public class PersonPageController {

	@Autowired
	UserService userService;
	@Autowired
	PersonHeadService personHeadService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {
		String username = (String) SecurityUtils.getSubject().getSession().getAttribute("username");
		User user = userService.selectByUsername(username);

		model.addAttribute("user", user);
		return "personPage/personPage";
	}

	@RequestMapping(value = "/personHeadPage", method = RequestMethod.GET)
	public String personHeadPage() {

		return "personPage/personHead";
	}

	@ResponseBody
	@RequestMapping(value = "/upPersonHeadFile", method = RequestMethod.POST)
	public Msg upPersonHeadFile(@RequestParam(value = "imgData") String dataURL, HttpServletRequest request) {
		FileOutputStream write = null;
		PersonHead personHead = new PersonHead();

		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		
		//处理字符串
		String replaceAll = dataURL.replaceAll(" ", "+").substring(dataURL.indexOf(",") + 1);
		byte[] decoderBytes = Base64.getDecoder().decode(replaceAll);

		File file = new File(request.getSession().getServletContext().getRealPath("personHeadFile"));
		if (!file.exists()) {
			file.mkdirs();
		}
		try {
			write = new FileOutputStream(
					new File(request.getSession().getServletContext().getRealPath("personHeadFile"),userId + ".png"));
			write.write(decoderBytes);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {

			try {
				write.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		
		personHeadService.insertPersonHead();
		

		return Msg.success();
	}

}
