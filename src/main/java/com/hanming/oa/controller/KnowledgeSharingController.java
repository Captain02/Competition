package com.hanming.oa.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.model.BBSDetailedTopic;
import com.hanming.oa.model.BBSDisplayTopic;
import com.hanming.oa.model.BBSLabel;
import com.hanming.oa.model.BBSTopic;
import com.hanming.oa.service.BBSLabelService;
import com.hanming.oa.service.BBSTopicService;

@Controller
@RequestMapping("/admin/KnowledgeSharing")
public class KnowledgeSharingController {

	@Autowired
	BBSTopicService bbsTopicService;
	@Autowired
	BBSLabelService bbsLabelService;

	// 遍历贴
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

		PageInfo<BBSDisplayTopic> pageInfo = null;
		PageHelper.startPage(pn, 15);
		List<BBSDisplayTopic> list = bbsTopicService.selectDisplayTopic();
		Collections.reverse(list);
		pageInfo = new PageInfo<BBSDisplayTopic>(list, 5);
		model.addAttribute("pageInfo", pageInfo);

		return "knowledgeSharing/knowledge";
	}

	// 查看某个贴
	@RequestMapping(value = "/detailedTopic/{topicId}", method = RequestMethod.GET)
	public String detailedTopicPage(@PathVariable("topicId") Integer topicId, Model model) {
		BBSDetailedTopic bbsDetailedTopic = bbsTopicService.bbsDetailedTopic(topicId);

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
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addKnowledge(@RequestParam(value = "text", defaultValue = "") String text,
			@RequestParam(value = "title") String title, @RequestParam(value = "sketch") String sketch,
			BBSTopic bbsTopic) {
		System.out.println(title);
		System.out.println(sketch);
		System.out.println(text);
		
		
		// BBSTopic bbsTopic = new BBSTopic();
		// Integer userId = (Integer)
		// SecurityUtils.getSubject().getSession().getAttribute("id");
		// bbsTopic.setText(text);
		// bbsTopic.setUserId(userId);
		// bbsTopicService.insertTopic(bbsTopic);

		return "knowledgeSharing/add";
	}

}
