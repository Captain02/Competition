package com.hanming.oa.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.concurrent.SuccessCallback;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.DateTool;
import com.hanming.oa.Tool.GetIpTool;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.DateStandard;
import com.hanming.oa.model.WorkAttendance;
import com.hanming.oa.model.WorkAttendenceByMonthStatistics;
import com.hanming.oa.model.WorkAttendenceDisplay;
import com.hanming.oa.model.WorkAttendencePunishment;
import com.hanming.oa.service.DateStandardService;
import com.hanming.oa.service.WorkAttendencePunishmentService;
import com.hanming.oa.service.WorkAttendenceService;

@Controller
@RequestMapping("admin/wordAttendence")
public class WorkAttendenceController {

	@Autowired
	WorkAttendenceService WorkAttendenceService;
	@Autowired
	DateStandardService dateStandardService;
	@Autowired
	WorkAttendencePunishmentService workAttendencePunishmentService;

	//遍历
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "0") Integer pn,
			@RequestParam(value = "isByMyId", defaultValue = "0") Integer isByMyId,
			@RequestParam(value = "date", defaultValue = "") String date,
			@RequestParam(value = "userName", defaultValue = "姓名") String userName, Model model) {
		Integer id = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");

		if (isByMyId != 0) {
			isByMyId = id;
		}
		if ("".equals(date)) {
			date = DateTool.dateToYearMonthDay(new Date()).substring(0, 7);
		}

		PageInfo<WorkAttendenceDisplay> pageInfo = null;
		PageHelper.startPage(pn, 20);
		List<WorkAttendenceDisplay> list = WorkAttendenceService.list(date, isByMyId, userName);
		pageInfo = new PageInfo<WorkAttendenceDisplay>(list, 5);

		WorkAttendenceByMonthStatistics workAttendenceByMonthStatistics = WorkAttendenceService
				.getWorkAttendenceByMonthStatistics(date);

		model.addAttribute("workAttendenceByMonthStatistics", workAttendenceByMonthStatistics);
		model.addAttribute("pageInfo", pageInfo);
		return "wordAttendence/wordAttendence";
	}

	// 签到打卡
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg addAttendece(@RequestParam(value = "date") String date, HttpServletRequest request) {

		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");

		// 查询标准时间和现在日期
		DateStandard dateStandard = dateStandardService.selectByprimaryKey(1);
		String nowDate = DateTool.dateToYearMonthDay(new Date());

		// 获取签到次数
		Integer attendenceNum = WorkAttendenceService.selectCountByDate(nowDate);

		if (attendenceNum == 0) {
			WorkAttendance workAttendance = new WorkAttendance();
			workAttendance.setStartdate(date);
			workAttendance.setDate(nowDate);
			workAttendance.setUserid(userId);
			workAttendance.setUserip(GetIpTool.getIP(request));

			WorkAttendencePunishment WorkAttendencePunishment = new WorkAttendencePunishment();
			WorkAttendencePunishment.setWorkattendenceid(workAttendance.getId());

			if (DateTool.compareDate(date, dateStandard.getLatetime())) {
				WorkAttendencePunishment.setState("正常");
				WorkAttendencePunishment.setPunishmenttime("0");
				WorkAttendenceService.addAttendence(workAttendance, WorkAttendencePunishment);
			} else {
				WorkAttendencePunishment.setState("迟到");
				WorkAttendencePunishment
						.setPunishmenttime(DateTool.substractTime(date, dateStandard.getLatetime()).toString());
				WorkAttendenceService.addAttendence(workAttendance, WorkAttendencePunishment);

			}

		} else if (attendenceNum == 1) {
			WorkAttendance workAttendance = new WorkAttendance();
			workAttendance.setEnddate(date);
			workAttendance.setDate(nowDate);
			workAttendance.setUserid(userId);
			workAttendance.setUserip(GetIpTool.getIP(request));

			WorkAttendencePunishment WorkAttendencePunishment = new WorkAttendencePunishment();
			WorkAttendencePunishment.setWorkattendenceid(workAttendance.getId());

			if (DateTool.compareDate(dateStandard.getLatetime(), date)) {
				if (DateTool.compareDate(dateStandard.getOvertime(), date)) {
					WorkAttendencePunishment.setState("加班");
					WorkAttendencePunishment
							.setPunishmenttime(DateTool.substractTime(date, dateStandard.getOvertime()).toString());
					WorkAttendenceService.addAttendence(workAttendance, WorkAttendencePunishment);

				} else {
					WorkAttendencePunishment.setState("正常");
					WorkAttendencePunishment.setPunishmenttime("0");
					WorkAttendenceService.addAttendence(workAttendance, WorkAttendencePunishment);
				}
			} else {
				WorkAttendencePunishment.setState("早退");
				WorkAttendencePunishment.setPunishmenttime(
						DateTool.substractTime(dateStandard.getOvertime().toString(), date).toString());
				WorkAttendenceService.addAttendence(workAttendance, WorkAttendencePunishment);
			}
		} else {
			return Msg.fail();
		}
		return Msg.fail();
	}
	
	@ResponseBody
	@RequestMapping(value="/dele",method=RequestMethod.POST)
	public Msg dele(@RequestParam("ids")String ids) {
		WorkAttendenceService.deleByids(ids);
		return Msg.success();
	}

}
