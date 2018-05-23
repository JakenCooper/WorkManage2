package com.thinkgem.jeesite.modules.sys.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="${adminPath}/sysNews/systemNews")
public class NewsInfoController {
	@RequestMapping(value="form")
	public String form(){
		String s="";
	    s="fegeg";
		return "modules/sys/news";
	}
	
	
	
	


}
