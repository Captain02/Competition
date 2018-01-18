package com.hanming.oa.mbg;
import java.io.File;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;

import com.hanming.oa.model.Holiday;

//mybatis逆向工程搭建
public class MBGTest {
	public static void main(String[] args) throws Exception {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
//		System.out.println(df.format(new Date()));
//		System.out.println(java.sql.Date.valueOf(df.format(new Date())));
		Holiday holiday = new Holiday();
		System.out.println(new Date());
		//holiday.setDate(df.format(new Date())));
		
		
//		List<String> warnings = new ArrayList<String>();
//		boolean overwrite = true;
//		File configFile = new File("mbg.xml");
//		ConfigurationParser cp = new ConfigurationParser(warnings);
//		Configuration config = cp.parseConfiguration(configFile);
//		DefaultShellCallback callback = new DefaultShellCallback(overwrite);
//		MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
//		myBatisGenerator.generate(null);
	}
}
