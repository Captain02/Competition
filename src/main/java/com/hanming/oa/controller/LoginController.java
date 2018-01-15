package com.hanming.oa.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hanming.oa.model.User;

@RequestMapping(value = "/")
@Controller
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String LoginGet() {
		return "login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(User user, Model model) {
		String username = user.getUsername();
		String password = user.getPassword();
		UsernamePasswordToken token = new UsernamePasswordToken(username, password);
		Subject subject = SecurityUtils.getSubject();
		String msg = null;
		try {
			subject.login(token);
		} catch (UnknownAccountException e) {
			e.printStackTrace();
			msg = "账号不存在";
		} catch (IncorrectCredentialsException e) {
			e.printStackTrace();
			msg = "用户名和密码的组合不正确";
		} catch (LockedAccountException e) {
			e.printStackTrace();
			msg = "账号被锁定";
		}
		if (msg == null) {
			logger.info(username+"---登陆成功");
			return "weclome";
		}

		model.addAttribute("msg", msg);
		System.out.println(msg.toString());
		return "login";
	}

	//没有权限
	@RequestMapping(value = "/unAuthorization",method=RequestMethod.GET)
	public String unAuthorization() {
		return "unAuthorization";
	}
	//退出
	@RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String logout(Model model){
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        model.addAttribute("msg","您已经退出登录");
        return "login";
    }
}
