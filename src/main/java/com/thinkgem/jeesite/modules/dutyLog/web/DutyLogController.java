package com.thinkgem.jeesite.modules.dutyLog.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "${adminPath}/dl/dutyLog")
public class DutyLogController {
	
	@RequestMapping(value="form")
	public String form(){
		return "modules/dutyLog/dutyLogList";
	}

}
