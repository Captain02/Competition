package com.hanming.oa.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.hanming.oa.model.Holiday;
import com.hanming.oa.model.Reimbursement;
import com.hanming.oa.model.Things;
import com.hanming.oa.model.UserHolidayByHolidayId;
import com.hanming.oa.model.UserReimbursementByReimbursementId;
import com.hanming.oa.model.UserThingsByThingsId;

@Service
public class UpDownFileService {

	// 文件下载
	public void down(HttpServletResponse response, HttpServletRequest request, Object obj, String dirName)
			throws NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException,
			InvocationTargetException, IOException {

		String enclosure = null;

		String filename = null;

		if (obj instanceof UserHolidayByHolidayId) {
			enclosure = ((UserHolidayByHolidayId) obj).getEnclosure();
			filename = ((UserHolidayByHolidayId) obj).getFilename();
		} else if (obj instanceof Holiday) {
			enclosure = ((Holiday) obj).getEnclosure();
			filename = ((Holiday) obj).getFilename();
		} else if (obj instanceof UserReimbursementByReimbursementId) {
			enclosure = ((UserReimbursementByReimbursementId) obj).getEnclosure();
			filename = ((UserReimbursementByReimbursementId) obj).getFilename();
		} else if (obj instanceof Reimbursement) {
			enclosure = ((Reimbursement) obj).getEnclosure();
			filename = ((Reimbursement) obj).getFilename();
		} else if (obj instanceof Things) {
			enclosure = ((Things) obj).getEnclosure();
			filename = ((Things) obj).getFilename();
		} else if (obj instanceof UserThingsByThingsId) {
			enclosure = ((UserThingsByThingsId) obj).getEnclosure();
			filename = ((UserThingsByThingsId) obj).getFilename();
		}

		// 获取文件
		String fileName = request.getSession().getServletContext().getRealPath(dirName) + "/" + enclosure;
		// 获取输入流
		InputStream bis = new BufferedInputStream(new FileInputStream(new File(fileName)));
		// 假如以中文名下载的话

		// 转码，免得文件名中文乱码
		filename = URLEncoder.encode(filename, "UTF-8");
		// 设置文件下载头
		response.addHeader("Content-Disposition", "attachment;filename=" + filename);
		// 1.设置文件ContentType类型，这样设置，会自动判断下载文件类型
		response.setContentType("multipart/form-data");
		BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
		int len = 0;
		byte[] bs = new byte[1024];
		while ((len = bis.read(bs)) != -1) {
			out.write(bs, 0, len);
			out.flush();
		}
		out.close();
		bis.close();

	}


}
