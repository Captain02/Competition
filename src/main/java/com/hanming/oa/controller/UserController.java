package com.hanming.oa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.validation.Valid;

import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.Encryption;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.User;
import com.hanming.oa.service.DepartmentService;
import com.hanming.oa.service.DepartmentUserService;
import com.hanming.oa.service.RoleService;
import com.hanming.oa.service.UserRoleService;
import com.hanming.oa.service.UserService;

@Controller
@RequestMapping("/admin/user")
public class UserController {

	@Autowired
	UserService userService;
	@Autowired
	RoleService roleService;
	@Autowired
	DepartmentService departmentService;
	@Autowired
	DepartmentUserService departmentUserService;
	@Autowired
	UserRoleService userRoleService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "name", defaultValue = "") String name,
			@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

		PageInfo<User> pageInfo = null;
		List<User> list = null;
		// 分页查询
		// 调用之前传入页码和每个页的大小
		PageHelper.startPage(pn, 8);
		if ("".equals(name)) {
			list = userService.list();
			// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
			// 封装了详细的分页信息，包括我们查询出来的数据，传入连续显示的页数
		} else {
			list = userService.selectLikeUsername(name);
		}
		pageInfo = new PageInfo<User>(list, 5);

		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("name", name);
		return "user/user";
	}

	// 用户添加跳转页面
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String userAddPage(Model model) {
		model.addAttribute("user", new User());
		model.addAttribute("role", roleService.list());
		model.addAttribute("department", departmentService.list());
		return "user/add";
	}

	// 查重
	@ResponseBody
	@RequestMapping(value = "/duplicateChecking", method = RequestMethod.POST)
	public Msg duplicateChecking(@RequestParam(value = "username") String username) {
		System.out.println(username);
		User user = userService.selectByUsername(username);
		if (user == null) {
			return Msg.success();
		}
		return Msg.fail();
	}

	// 保存用户功能
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg add(@RequestParam(value = "departmentId") String departmentId,
			@RequestParam(value = "roleId") String roleId, @Valid User user, BindingResult result) {
		if (result.hasErrors()) {
			// 校验失败
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		} else if (userService.add(departmentId, roleId, user) == 1) {
			return Msg.success();
		} else {
			return Msg.fail();
		}
	}

	// 跳转修改跳转页面
	@RequestMapping(value = "/update/{id}/{pn}", method = RequestMethod.GET)
	public String userUpdatePage(@PathVariable("pn") Integer pn, @PathVariable("id") Integer id, Model model,
			User user) {
		User selectUser = userService.selectByPrimaryKeyWithDeptAndRole(id);

		model.addAttribute("user", selectUser);
		model.addAttribute("userDepartment", (selectUser.getDepartment() == null ? "" : selectUser.getDepartment()));
		model.addAttribute("userRole", selectUser.getRole() == null ? "" : selectUser.getRole());

		// 列表的部门和角色
		model.addAttribute("pn", pn);
		model.addAttribute("role", roleService.list());
		model.addAttribute("department", departmentService.list());
		return "user/add";
	}

	// 修改
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public Msg Update(@RequestParam(value = "departmentId") String departmentId,
			@RequestParam(value = "roleId") String roleId, @Valid User user, BindingResult result) {
		if (result.hasErrors()) {
			// 校验失败
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}
		if (userService.Update(departmentId, roleId, user) == 1) {
			return Msg.success();
		}
		return Msg.fail();
	}

	// 人员删除
	@ResponseBody
	@RequestMapping(value = "/dele/{id}", method = RequestMethod.DELETE)
	public Msg dele(@PathVariable("id") String userId) {
		if (userService.dele(userId) == 1) {
			return Msg.success();
		}
		return Msg.fail();

	}

	// 跳转修改密码页面
	@RequestMapping(value = "/changePassword/{id}", method = RequestMethod.GET)
	public String changePasswordPage(@PathVariable("id") Integer id, Model model) {
		model.addAttribute("id", id);
		return "user/changePassword";
	}

	// 修改密码
	@ResponseBody
	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	public Msg changePassword(@RequestParam("id") String id, @RequestParam("newPassword") String newPassword,
			@RequestParam("truePassword") String truePassowrd) {
		Map<String, Object> map = new HashMap<>();
		if (!truePassowrd.equals(newPassword)) {
			map.put("truePassowrd", "确认密码不一致");
			return Msg.fail().add("errorFields", map);
		}
		if (!isNotChinese(newPassword)) {
			map.put("truePassowrd", "密码不能有中文");
			return Msg.fail().add("errorFields", map);
		}
		if ("".equals(newPassword.trim())) {
			map.put("newPassword", "密码不为空");
			return Msg.fail().add("errorFields", map);
		} else {
			User user = userService.selectByPrimaryKeyWithDeptAndRole(Integer.parseInt(id));
			String encryptionPassword = Encryption.md5(newPassword, user.getUsername());
			if (encryptionPassword.equals(user.getPassword())) {
				return Msg.success();
			} else {
				user.setPassword(encryptionPassword);
				userService.updateByPrimaryKeySelective(user);
			}
		}
		return Msg.success();
	}

	// 正则表达式验证确认密码
	public static boolean isNotChinese(String str) {
		Pattern pattern = Pattern.compile("^[a-zA-Z0-9_-]{1,100}$");
		return pattern.matcher(str).matches();
	}

}
