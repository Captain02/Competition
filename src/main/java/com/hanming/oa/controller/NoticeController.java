package com.hanming.oa.controller;

import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.DateTool;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.Notice;
import com.hanming.oa.model.NoticeDisplay;
import com.hanming.oa.service.NoticeService;

@Controller
@RequestMapping("admin/notice")
public class NoticeController {

	@Autowired
	NoticeService noticeService;

	// 公告列表
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "isByMyId", defaultValue = "0") Integer isByMyId, Model model) {
		
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		
		PageInfo<NoticeDisplay> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<NoticeDisplay> Notices = noticeService.list(isByMyId);
		pageInfo = new PageInfo<NoticeDisplay>(Notices, 5);
		
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("isByMyId", isByMyId);
		model.addAttribute("userId", userId);

		return "notice/notice";
	}

	// 跳转添加页
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addPage() {
		return "notice/add";
	}

	// 跳修改加页
	@RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
	public String updatePage(@PathVariable("id") Integer id, Model model) {
		Notice notice = noticeService.selectByPrimaryKey(id);
		model.addAttribute("notice", notice);
		return "notice/editor";
	}

	// 添加公告
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg add(Notice notice) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		notice.setUserid(userId);
		noticeService.insert(notice);

		return Msg.success();
	}

	// 修改公告
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public Msg update(Notice notice) {

		String dateString = DateTool.dateToString(new Date());
		
		notice.setDate(dateString);

		noticeService.update(notice);

		return Msg.success();
	}

	// 删除公告
	@ResponseBody
	@RequestMapping(value="/dele",method=RequestMethod.POST)
	public Msg dele(@RequestParam("noticeId") Integer noticeId) {

		noticeService.dele(noticeId);

		return Msg.success();
	}

}
