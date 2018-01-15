package com.hanming.oa.testMd5;

import org.apache.shiro.crypto.hash.Md5Hash;

public class TestMd5 {
	
	public static String md5(String password,String salt) {
		return new Md5Hash(password, salt).toString();
	}
	public static void main(String[] args) {
		System.out.println(md5("123456", "asdasd"));
	}
}
