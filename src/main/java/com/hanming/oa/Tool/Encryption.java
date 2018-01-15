package com.hanming.oa.Tool;

import org.apache.shiro.crypto.hash.Md5Hash;

public class Encryption {

	public static String md5(String password,String salt) {
		return new Md5Hash(password, salt).toString();
	}
}
