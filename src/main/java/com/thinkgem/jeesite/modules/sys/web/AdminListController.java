package com.thinkgem.jeesite.modules.sys.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "${adminPath}/adm/adminList")
public class AdminListController {
	@RequestMapping(value="form")
	public String form(){
		return "modules/sys/adminList";
	}
	
}
