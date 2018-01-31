package com.hanming.oa.Tool;

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

	// 日期格式化为年月日
	public static String dateToYearMonthDay(Date date) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(date);
		return dateString;
	}

	// 日期格式化为时分秒
	public static String dateToHoursMinutesSeconde(Date date) {
		SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");
		String dateString = formatter.format(date);
		return dateString;
	}

	// 时分秒相减
	public static long substractTime(String date1, String date2) {
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		date1 = date1.substring(11, 19);
		date2 = date2.substring(11, 19);
		long diff = 0;
		try {
			Date d1 = df.parse(date1);
			Date d2 = df.parse(date2);
			diff = d1.getTime() - d2.getTime();

		} catch (Exception e) {
		}

		return diff / 60000;
	}

	// 时间比较
	// 如果第一个时间比第二个时间早返回true 否则返回 false
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

	public static void main(String[] args) {
		System.out.println("09:32:00".compareTo("08:00:00"));

		long time = substractTime("2012-11-12 09:32:00", "2012-11-11 08:00:00");

		System.out.println(time);
	}
}
