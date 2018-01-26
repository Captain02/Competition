package com.hanming.oa.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.BBSDetailedTopic;
import com.hanming.oa.model.BBSDisplayTopic;
import com.hanming.oa.model.BBSLabel;
import com.hanming.oa.model.BBSLabelTopic;
import com.hanming.oa.model.BBSTopic;
import com.hanming.oa.model.Comments;
import com.hanming.oa.service.BBSLabelService;
import com.hanming.oa.service.BBSLabelTopicService;
import com.hanming.oa.service.BBSTopicService;

@Controller
@RequestMapping("/admin/KnowledgeSharing")
public class KnowledgeSharingController {

	@Autowired
	BBSTopicService bbsTopicService;
	@Autowired
	BBSLabelService bbsLabelService;
	@Autowired
	BBSLabelTopicService bbsLabelTopicService;

	// 遍历贴
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "labelId", defaultValue = "0") Integer labelId,
			@RequestParam(value = "isByMyId", defaultValue = "0") Integer isByMyId, Model model) {

		Integer id = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");

		if (isByMyId != 0) {
			isByMyId = id;
		}
		
		PageInfo<BBSDisplayTopic> pageInfo = null;
		PageHelper.startPage(pn, 10);
		List<BBSDisplayTopic> list = bbsTopicService.selectDisplayTopic(labelId, isByMyId);
		Collections.reverse(list);
		pageInfo = new PageInfo<BBSDisplayTopic>(list, 5);

		List<BBSLabel> list2 = bbsLabelService.list();

		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("BBSLabel", list2);
		model.addAttribute("labelId", labelId);
		model.addAttribute("isByMyId", isByMyId);

		return "knowledgeSharing/knowledge";
	}

	// 查看某个贴
	@RequestMapping(value = "/detailedTopic", method = RequestMethod.GET)
	public String detailedTopicPage(@RequestParam(value = "topicId") Integer topicId,
			@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

		BBSDetailedTopic bbsDetailedTopic = bbsTopicService.bbsDetailedTopic(topicId);

		PageInfo<Comments> pageInfo = null;
		PageHelper.startPage(pn, 12);
		List<Comments> list = bbsTopicService.getCommentsByTopicId(topicId);
		Collections.reverse(list);
		pageInfo = new PageInfo<Comments>(list, 5);

		int[] nums = pageInfo.getNavigatepageNums();
		for (int i : nums) {
			System.out.println(i);

		}
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("bbsDetailedTopic", bbsDetailedTopic);

		return "knowledgeSharing/detailedTopic";
	}

	// 跳转添加知识页面
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addKnowledgePage(Model model) {

		List<BBSLabel> list = bbsLabelService.list();

		model.addAttribute("bbsLabel", list);
		return "knowledgeSharing/add";
	}

	// 添加知识
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg addKnowledge(@RequestParam(value = "text", defaultValue = "") String text,
			@RequestParam(value = "title") String title, @RequestParam(value = "sketch") String sketch,
			@RequestParam(value = "order") String ids) {

		int i = bbsLabelTopicService.addKonwledge(text, title, sketch, ids);
		if (i == 1) {
			return Msg.success();
		} else {
			return Msg.fail();
		}

	}

}
