/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.thinkgem.jeesite.modules.jiaojieban.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.thinkgem.jeesite.common.web.BaseController;

@Controller
@RequestMapping(value = "${adminPath}/jjb/jiaoJieBan")
public class JiaoJieBanController extends BaseController {

	

	@RequestMapping(value = {"form"})
	public String form() {
		return "modules/jiaoJieBan/jiaoJieBanForm";
	}


}
