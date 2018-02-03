package com.hanming.oa.controller;

import java.util.Date;
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

	// 遍历
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

		List<String> dateList = WorkAttendenceService.selectDateList(isByMyId, userName);

		DateStandard dateStandard = dateStandardService.selectByprimaryKey(1);

		model.addAttribute("dateStandard", dateStandard);
		model.addAttribute("dateList", dateList);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("isByMyId", isByMyId);
		model.addAttribute("userName", userName);
		model.addAttribute("date", date);
		model.addAttribute("workAttendenceByMonthStatistics", workAttendenceByMonthStatistics);
		return "wordAttendence/wordAttendence";
	}

	// 签到打卡
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg addAttendece(@RequestParam(value = "date") String date, HttpServletRequest request) {
		System.out.println(GetIpTool.getIP(request));
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");

		// 查询标准时间和现在日期
		DateStandard dateStandard = dateStandardService.selectByprimaryKey(1);
		String nowDate = DateTool.dateToYearMonthDay(new Date());

		// 获取签到次数
		WorkAttendance workAttendanceOld = WorkAttendenceService.selectByUserIdAndDate(userId, nowDate);

		if (workAttendanceOld == null) {
			WorkAttendance workAttendance = new WorkAttendance();
			workAttendance.setStartdate(date);
			workAttendance.setDate(nowDate);
			workAttendance.setUserid(userId);
			workAttendance.setUserip(GetIpTool.getIP(request));

			WorkAttendencePunishment WorkAttendencePunishment = new WorkAttendencePunishment();
			WorkAttendencePunishment.setWorkattendenceid(workAttendance.getId());
			System.out.println(workAttendance.getId());
			if (DateTool.compareDate(date, dateStandard.getLatetime())) {
				WorkAttendencePunishment.setState("正常");
				WorkAttendencePunishment.setPunishmenttime("0");
				WorkAttendenceService.addAttendence(workAttendance, WorkAttendencePunishment);

				return Msg.success();
			} else {
				WorkAttendencePunishment.setState("迟到");
				WorkAttendencePunishment
						.setPunishmenttime(DateTool.substractTime(date, dateStandard.getLatetime()).toString());
				WorkAttendenceService.addAttendence(workAttendance, WorkAttendencePunishment);
				return Msg.success();
			}

		} else {

			workAttendanceOld.setEnddate(date);
			workAttendanceOld.setDate(nowDate);
			workAttendanceOld.setUserid(userId);
			workAttendanceOld.setUserip(GetIpTool.getIP(request));

			WorkAttendencePunishment WorkAttendencePunishment = new WorkAttendencePunishment();
			WorkAttendencePunishment.setWorkattendenceid(workAttendanceOld.getId());
			int isSuccess = 1;
			if (DateTool.compareDate(dateStandard.getLeavetime(), date)) {
				if (DateTool.compareDate(dateStandard.getOvertime(), date)) {
					WorkAttendencePunishment.setState("加班");
					WorkAttendencePunishment
							.setPunishmenttime(DateTool.substractTime(date, dateStandard.getOvertime()).toString());
					isSuccess = WorkAttendenceService.addAttendence(workAttendanceOld, WorkAttendencePunishment);
				} else {
					WorkAttendencePunishment.setState("正常");
					WorkAttendencePunishment.setPunishmenttime("0");
					isSuccess = WorkAttendenceService.addAttendence(workAttendanceOld, WorkAttendencePunishment);
				}
			} else {
				WorkAttendencePunishment.setState("早退");
				WorkAttendencePunishment.setPunishmenttime(
						DateTool.substractTime(dateStandard.getOvertime().toString(), date).toString());
				isSuccess = WorkAttendenceService.addAttendence(workAttendanceOld, WorkAttendencePunishment);
			}
			if (isSuccess == 1) {
				return Msg.success();
			} else {
				return Msg.fail();
			}
		}
	}

	// 删除签到
	@ResponseBody
	@RequestMapping(value = "/dele", method = RequestMethod.POST)
	public Msg dele(@RequestParam("ids") String ids) {
		WorkAttendenceService.deleByids(ids);
		return Msg.success();
	}

	// 修改标准时间
	@ResponseBody
	@RequestMapping(value = "/updateStanderTime", method = RequestMethod.POST)
	public Msg updateStandarTime(@RequestParam("changeTime") String changeTime,
			@RequestParam("whichStandardTime") Integer whichStandardTime) {
		DateStandard dateStandard = new DateStandard();
		dateStandard.setId(1);
		if (whichStandardTime==1) {
			dateStandard.setLatetime(changeTime);
			dateStandardService.update(dateStandard);
			return Msg.success().add("whichStandardTime", 1).add("changeTime", changeTime);
		}else if (whichStandardTime == 2) {
			dateStandard.setLeavetime(changeTime);
			dateStandardService.update(dateStandard);
			return Msg.success().add("whichStandardTime", 2).add("changeTime", changeTime);
		}else {
			dateStandard.setOvertime(changeTime);
			dateStandardService.update(dateStandard);
			return Msg.success().add("whichStandardTime", 3).add("changeTime", changeTime);
		}
	}

}
