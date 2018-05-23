package com.thinkgem.jeesite.modules.sys.utils;

import java.net.URISyntaxException;

import org.apache.commons.lang3.StringEscapeUtils;

/**
 * 下载工具类
 * @author wangna
 *
 */
public class DownloadUtil {
	
	/**
	 * 获取模板地址
	 * @param docName
	 * @return
	 */
	public static String getTemplatePath(String docName){
		//模板地址
    	String path = "";
		try {
			path = DownloadUtil.class.getClassLoader().getResource("").toURI().getPath();
			path = path + DownLoadMsgConstant.TEMPLATE_PATH + docName;
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return path;
	}
	
	/**
	 * 转义字符串的反转义
	 * @param text
	 * @return
	 */
	public static String unescapeString(String string) {
		return (string == null ? MsgConstant.NULL : StringEscapeUtils.unescapeHtml4(string.trim()));
	}
	
	/**
	 * 转义字符串的反转义不取空
	 * @param text
	 * @return
	 */
	public static String unescapeStringNoTrim(String string) {
		return (string == null ? MsgConstant.NULL : StringEscapeUtils.unescapeHtml4(string));
	}
	
}
