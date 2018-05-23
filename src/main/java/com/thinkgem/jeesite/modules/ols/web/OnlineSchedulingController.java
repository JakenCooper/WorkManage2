package com.thinkgem.jeesite.modules.ols.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.modules.ols.entity.OnlineScheduling;
import com.thinkgem.jeesite.modules.ols.service.OnlineSchedulingService;

@Controller
@RequestMapping(value = "${adminPath}/ols/onlineScheduling")
public class OnlineSchedulingController {
	@Autowired
	private OnlineSchedulingService onlineSchedulingService;
	@RequestMapping(value="form")
	public String form(){
		return "modules/ols/onlineSchedulingList";
	}
	
	@RequestMapping(value="findonlineSchedulingList")
	@ResponseBody
	public String findonlineSchedulingList(ModelMap modelMap,Map<String,Object> map){
		List<OnlineScheduling> onlineSchedulingList=onlineSchedulingService.findonlineSchedulingList(map);
		return JsonMapper.toJsonString(onlineSchedulingList);
	}
}
