package com.hanming.oa.Tool;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.flash;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTool {

	// 日期格式化
	public static String dateToString(Date date) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateString = formatter.format(date);
		return dateString;
	}

	// 时间比较
	//如果第一个时间比第二个时间早返回true 否则返回 false
	public static Boolean compareDate(String oldStrDate, String newStrDate) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		try {
			Date olDate = dateFormat.parse(oldStrDate);
			Date newDate = dateFormat.parse(newStrDate);
			if (olDate.getTime() > newDate.getTime()) {
				return false;
			} else {
				return true;
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return false;
	}
}
