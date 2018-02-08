package com.hanming.oa.service;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.hanming.oa.Tool.DateTool;
import com.hanming.oa.dao.MyImageMapper;
import com.hanming.oa.model.BBSTopic;
import com.hanming.oa.model.MyImage;
import com.hanming.oa.model.MyImageDispaly;

@Service
public class ImageService {
	
	@Autowired
	BBSTopicService bbsTopicService;
	@Autowired
	MyImageMapper myImageMapper;
	
	@Transactional
	public void addMyImage(MultipartFile[] files, Integer userId, String path, HttpServletRequest request) {
		for (MultipartFile file : files) {
			String fileName = new Date().toString().replace(":", "-") + file.getOriginalFilename();
			
			//插入贴吧
			BBSTopic bbsTopic = new BBSTopic(null,file.getOriginalFilename(),
					"我想知道图片背后的故事","<img src=\" "+ request.getContextPath() +"/myImage/"+fileName+"\"  height=\"50%\" width=\"50%\"  alt=\"\" />",
					userId,
					DateTool.dateToString(new Date()),
					"myImage") ;
			bbsTopicService.insertTopic(bbsTopic);
			
			//插入我的相册
			MyImage myImage = new MyImage(null, userId, fileName, bbsTopic.getId());
			myImageMapper.insertSelective(myImage);
			File dir = new File(path, fileName);
			if (!dir.exists()) {
				dir.mkdirs();
			}

			// MultipartFile自带的解析方法
			try {
				file.transferTo(dir);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
	}

	public List<MyImageDispaly> selectList(Integer isByMy) {
		List<MyImageDispaly> list = myImageMapper.selectList(isByMy);
		return list;
	}

}
