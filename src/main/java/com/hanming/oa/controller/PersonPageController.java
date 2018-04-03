package com.hanming.oa.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.BBSDisplayTopic;
import com.hanming.oa.model.BugDisplay;
import com.hanming.oa.model.DustyDisplay;
import com.hanming.oa.model.Holiday;
import com.hanming.oa.model.MyImageDispaly;
import com.hanming.oa.model.NoticeDisplay;
import com.hanming.oa.model.ProjectDisplay;
import com.hanming.oa.model.Reimbursement;
import com.hanming.oa.model.SystemMessageDisplay;
import com.hanming.oa.model.Things;
import com.hanming.oa.model.User;
import com.hanming.oa.service.BBSTopicService;
import com.hanming.oa.service.BugService;
import com.hanming.oa.service.DustyService;
import com.hanming.oa.service.HolidayService;
import com.hanming.oa.service.ImageService;
import com.hanming.oa.service.NoticeService;
import com.hanming.oa.service.ProjectService;
import com.hanming.oa.service.ReimbursementService;
import com.hanming.oa.service.SystemMessageService;
import com.hanming.oa.service.ThingsService;
import com.hanming.oa.service.UpDownFileService;
import com.hanming.oa.service.UserService;

@Controller
@RequestMapping("/admin/personPage")
public class PersonPageController {

	@Autowired
	UserService userService;
	@Autowired
	UpDownFileService upDownFileService;
	@Autowired
	NoticeService noticeService;
	@Autowired
	BBSTopicService bbsTopicService;
	@Autowired
	SystemMessageService systemMessageService;
	@Autowired
	ProjectService projectService;
	@Autowired
	BugService bugService;
	@Autowired
	DustyService dustyService;
	@Autowired
	ImageService imageService;
	@Autowired
	TaskService taskService;
	@Autowired
	HolidayService holidayService;
	@Autowired
	ReimbursementService reimbursementService;
	@Autowired
	ThingsService thingsService;

	// 跳转个人主页
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {

		// 个人信息
		String username = (String) SecurityUtils.getSubject().getSession().getAttribute("username");
		User user = userService.selectByUsername(username);

		// 公告信息
		List<NoticeDisplay> Notices = noticeService.list(0);
		Collections.reverse(Notices);
		if (Notices.size() > 2) {
			List<NoticeDisplay> reverseNotices = Notices.subList(0, 2);
			model.addAttribute("Notices", reverseNotices);
		} else {
			model.addAttribute("Notices", Notices);
		}

		// 知识
		List<BBSDisplayTopic> topics = bbsTopicService.selectDisplayTopic(0, 0);
		Collections.reverse(topics);
		if (topics.size() > 2) {
			List<BBSDisplayTopic> reverseTopics = topics.subList(0, 2);
			model.addAttribute("topics", reverseTopics);
		} else {
			model.addAttribute("topics", topics);
		}

		// 系统消息
		List<SystemMessageDisplay> systemMessageDisplay = systemMessageService.list("类型", "未读", user.getId());
		Collections.reverse(systemMessageDisplay);
		if (systemMessageDisplay.size() > 5) {
			model.addAttribute("systemMessage", systemMessageDisplay.subList(0, 5));
		} else {
			model.addAttribute("systemMessage", systemMessageDisplay);
		}
		model.addAttribute("systemMessagesize", systemMessageDisplay.size());

		// 项目
		List<ProjectDisplay> ProjectDisplay = projectService.list("项目状态", "项目名称", user.getId());
		if (ProjectDisplay.size() > 5) {
			model.addAttribute("ProjectDisplay", ProjectDisplay.subList(0, 5));
		} else {
			model.addAttribute("ProjectDisplay", ProjectDisplay);
		}

		// bug
		List<BugDisplay> BugDisplay = bugService.list("状态", "名称", 0, null, user.getId());
		if (BugDisplay.size() > 5) {
			model.addAttribute("BugDisplay", BugDisplay.subList(0, 5));
		} else {
			model.addAttribute("BugDisplay", BugDisplay);
		}

		// 任务
		List<DustyDisplay> DustyDisplay = dustyService.list("任务类型", "任务状态", "任务名称", 0, null, user.getId());
		if (DustyDisplay.size() > 5) {
			model.addAttribute("DustyDisplay", DustyDisplay.subList(0, 5));
		} else {
			model.addAttribute("DustyDisplay", DustyDisplay);
		}

		// 相册
		List<MyImageDispaly> MyImageDispaly = imageService.selectList(user.getId());
		if (MyImageDispaly.size() > 5) {
			model.addAttribute("MyImageDispaly", MyImageDispaly.subList(0, 5));
		} else {
			model.addAttribute("MyImageDispaly", MyImageDispaly);
		}
		
		//我的请假审批任务
		List<Holiday> holidays = new ArrayList<>();
		List<String> listProcessinstanceidHoliday = new ArrayList<>();
		List<Task> Tasks = taskService.createTaskQuery().taskAssignee(username).list();
		for (Task task : Tasks) {
			Holiday holiday = holidayService
					.selectHolidayByProcessInstanceIdLikeStateType(task.getProcessInstanceId(), "状态", "类型");
			if (holiday != null) {
				listProcessinstanceidHoliday.add(holiday.getProcessinstanceid());
			}
		}
		if (listProcessinstanceidHoliday.size() > 0) {
			holidays = holidayService.selectListHolidayByProcessInstanceId(listProcessinstanceidHoliday);

			if (holidays.size() > 5) {
				model.addAttribute("holidays", holidays.subList(0, 5));
			} else {
				model.addAttribute("holidays", holidays);
			}
		}
		
		
		//我的物品审批任务
		List<Reimbursement> listReimbursement = new ArrayList<>();
		List<String> listProcessinstanceidReimbursement = new ArrayList<>();
		for (Task task : Tasks) {
			Reimbursement reimbursement = reimbursementService
					.selectReimbursementByProcessInstanceIdLikeStateType(task.getProcessInstanceId(), "状态", "类型");
			if (reimbursement != null) {
				listProcessinstanceidReimbursement.add(reimbursement.getProcessinstanceid());
			}
		}
		if (listProcessinstanceidReimbursement.size() > 0) {
			listReimbursement = reimbursementService.selectListReimbursementByProcessInstanceId(listProcessinstanceidReimbursement);

			if (listReimbursement.size() > 5) {
				model.addAttribute("listReimbursement", listReimbursement.subList(0, 5));
			} else {
				model.addAttribute("listReimbursement", listReimbursement);
			}
		}
		
		
		//我的物品审批任务
		List<String> listProcessinstanceidTings = new ArrayList<>();
		List<Things> listTings = new ArrayList<>();
		for (Task task : Tasks) {
			Things things = thingsService.selectThingsByProcessInstanceIdLikeStateName(task.getProcessInstanceId(),
					"状态", "");
			if (things != null) {
				listProcessinstanceidTings.add(things.getProcessinstanceid());
			}
		}
		if (listProcessinstanceidTings.size() > 0) {
			listTings = thingsService.selectListThingsByProcessInstanceId(listProcessinstanceidTings);

			if (listTings.size() > 5) {
				model.addAttribute("listTings", listTings.subList(0, 5));
			} else {
				model.addAttribute("listTings", listTings);
			}
		}
		

		model.addAttribute("user", user);
		return "personPage/personPage";
	}

	// 上传头像页面
	@RequestMapping(value = "/personHeadPage", method = RequestMethod.GET)
	public String personHeadPage() {

		return "personPage/personHead";
	}

	// 上传头像
	@ResponseBody
	@RequestMapping(value = "/upPersonHeadFile", method = RequestMethod.POST)
	public Msg upPersonHeadFile(@RequestParam(value = "imgData") String dataURL,
			@RequestParam(value = "oldImg", defaultValue = "") String oldImg, HttpServletRequest request) {

		upDownFileService.upPersonHead(dataURL, request, "");
		if (!("".equals(oldImg))) {
			upDownFileService.upPersonHead(oldImg, request, "old");
		}

		return Msg.success();
	}

}
