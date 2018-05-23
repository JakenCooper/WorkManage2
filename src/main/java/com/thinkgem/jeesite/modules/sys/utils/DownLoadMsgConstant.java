package com.thinkgem.jeesite.modules.sys.utils;

import java.util.HashMap;

/**
 * 下载相关常量
 * @author 陈宏
 *
 */
public class DownLoadMsgConstant {
	public static final String DOT = ".";
	
	public static final String TEMPLATE_PATH = "/templates/modules/doc/";
	
	public static final String NULLFILENAME = "打印单";
	
	public static final HashMap<String, String> jiaoJieBan_print = new HashMap<String, String>();
	static{
		jiaoJieBan_print.put("1","交接班信息表");
	}
	

}
