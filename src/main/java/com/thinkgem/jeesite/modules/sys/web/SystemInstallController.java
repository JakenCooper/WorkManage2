package com.thinkgem.jeesite.modules.sys.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="${adminPath}/sysIns/systemInstallForm")
public class SystemInstallController {
	@RequestMapping(value="form")
	public String form(){
		return "modules/sys/systemInstallForm";
	}

}
