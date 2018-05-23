package com.thinkgem.jeesite.test;

import java.net.URLEncoder;

import com.sun.tools.extcheck.Main;

public class JakenTest {
	public static void main(String[] args) throws Exception{
		String encoder=URLEncoder.encode("file:///e:/test.doc", "UTF-8");
		System.out.println(encoder);
	}
}
