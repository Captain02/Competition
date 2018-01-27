package com.hanming.oa.controller;

import java.util.Collections;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.BBSDetailedTopic;
import com.hanming.oa.model.BBSDisplayTopic;
import com.hanming.oa.model.BBSLabel;
import com.hanming.oa.model.Comments;
import com.hanming.oa.service.BBSCollectionService;
import com.hanming.oa.service.BBSLabelService;
import com.hanming.oa.service.BBSLabelTopicService;
import com.hanming.oa.service.BBSLikeService;
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
	@Autowired
	BBSLikeService bbsLikeService;
	@Autowired
	BBSCollectionService bbsCollectionService;

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
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");

		BBSDetailedTopic bbsDetailedTopic = bbsTopicService.bbsDetailedTopic(topicId);

		PageInfo<Comments> pageInfo = null;
		PageHelper.startPage(pn, 12);
		List<Comments> list = bbsTopicService.getCommentsByTopicId(topicId);
		pageInfo = new PageInfo<Comments>(list, 5);

		int[] nums = pageInfo.getNavigatepageNums();
		for (int i : nums) {
			System.out.println(i);

		}

		Integer likeNum = bbsLikeService.selectCountLikeByUserIdAndTopicId(userId, topicId);
		Integer collectionNum = bbsCollectionService.selectCountCollectionByUserAndTopic(userId, topicId);

		model.addAttribute("likeNum", likeNum);
		model.addAttribute("collectionNum", collectionNum);
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

	// 点赞
	@ResponseBody
	@RequestMapping(value = "/like", method = RequestMethod.POST)
	public Msg like(@RequestParam("isLike") Integer isLike, @RequestParam("topicId") Integer topicId) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		if (isLike != 0) {

			isLike = bbsLikeService.deleLikeTopic(userId, topicId);
			Integer likeNum = bbsLikeService.countByTopicId(topicId);

			return Msg.success().add("isLike", isLike).add("likeNum", likeNum);
		} else {

			isLike = bbsLikeService.likeTopic(userId, topicId);
			Integer likeNum = bbsLikeService.countByTopicId(topicId);

			return Msg.success().add("isLike", isLike).add("likeNum", likeNum);
		}
	}

	// 收藏
	@ResponseBody
	@RequestMapping(value = "/collection", method = RequestMethod.POST)
	public Msg collection(@RequestParam("topicId") Integer topicId,
			@RequestParam("isCollection") Integer isCollection) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		if (isCollection != 0) {

			isCollection = bbsCollectionService.deleCollectionTopic(userId, topicId);
			Integer collectionNum = bbsCollectionService.countNumByTopic(topicId);

			return Msg.success().add("isCollection", isCollection).add("collectionNum", collectionNum);
		} else {

			isCollection = bbsCollectionService.collectionTopce(userId, topicId);
			Integer collectionNum = bbsCollectionService.countNumByTopic(topicId);

			return Msg.success().add("isCollection", isCollection).add("collectionNum", collectionNum);
		}
	}

	// 删除帖子
	@ResponseBody
	@RequestMapping(value = "/dele", method = RequestMethod.DELETE)
	public Msg deleTopic(@RequestParam("topicId") Integer topicId) {

		bbsTopicService.deleTopicById(topicId);

		return Msg.success();
	}

	// 跳转标签列表
	@RequestMapping(value = "/labelList", method = RequestMethod.GET)
	public String labelList(@RequestParam(value = "/labelList", defaultValue = "1") Integer pn, Model model) {

		Integer id = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");

		PageInfo<BBSLabel> pageInfo = null;
		PageHelper.startPage(pn, 10);
		List<BBSLabel> list = bbsLabelService.list();
		Collections.reverse(list);
		pageInfo = new PageInfo<BBSLabel>(list, 5);
		
		model.addAttribute("pageInfo", pageInfo);
		
		return "knowledgeSharing/labelOrder";
	}

}
