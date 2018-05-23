/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.wmnewsreceivers.web;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.HashedMap;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.item.entity.WmTodoItem;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wmnewsreceivers.entity.WmNewsReceiver;
import com.thinkgem.jeesite.modules.wmnewsreceivers.service.WmNewsReceiverService;

/**
 * 消息接收管理Controller
 * @author 杨萌
 * @version 2018-05-10
 */
@Controller
@RequestMapping(value = "${adminPath}/wmnewsreceivers/wmNewsReceiver")
public class WmNewsReceiverController extends BaseController {

	@Autowired
	private WmNewsReceiverService wmNewsReceiverService;
	
	@ModelAttribute
	public WmNewsReceiver get(@RequestParam(required=false) String id) {
		WmNewsReceiver entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wmNewsReceiverService.get(id);
		}
		if (entity == null){
			entity = new WmNewsReceiver();
		}
		return entity;
	}
	
	@RequiresPermissions("wmnewsreceivers:wmNewsReceiver:view")
	@RequestMapping(value = {"list", ""})
	public String list(WmNewsReceiver wmNewsReceiver, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WmNewsReceiver> page = wmNewsReceiverService.findPage(new Page<WmNewsReceiver>(request, response), wmNewsReceiver); 
		model.addAttribute("page", page);
		return "modules/wmnewsreceivers/wmNewsReceiverList";
	}

	@RequiresPermissions("wmnewsreceivers:wmNewsReceiver:view")
	@RequestMapping(value = "form")
	public String form(WmNewsReceiver wmNewsReceiver, Model model) {
		model.addAttribute("wmNewsReceiver", wmNewsReceiver);
		return "modules/wmnewsreceivers/wmNewsReceiverForm";
	}

	@RequiresPermissions("wmnewsreceivers:wmNewsReceiver:edit")
	@RequestMapping(value = "save")
	public String save(WmNewsReceiver wmNewsReceiver, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, wmNewsReceiver)){
			return form(wmNewsReceiver, model);
		}
		wmNewsReceiverService.save(wmNewsReceiver);
		addMessage(redirectAttributes, "保存保存&quot;消息&quot;成功成功");
		return "redirect:"+Global.getAdminPath()+"/wmnewsreceivers/wmNewsReceiver/?repage";
	}
	
	@RequiresPermissions("wmnewsreceivers:wmNewsReceiver:edit")
	@RequestMapping(value = "delete")
	public String delete(WmNewsReceiver wmNewsReceiver, RedirectAttributes redirectAttributes) {
		wmNewsReceiverService.delete(wmNewsReceiver);
		addMessage(redirectAttributes, "删除保存&quot;消息&quot;成功成功");
		return "redirect:"+Global.getAdminPath()+"/wmnewsreceivers/wmNewsReceiver/?repage";
	}

	/**
	 * 回复提交
	 */
	@RequiresPermissions("wmnewsreceivers:wmNewsReceiver:edit")
	@RequestMapping(value = "edittj")
	@ResponseBody
	public String edittj(WmNewsReceiver wmNewsReceiver, HttpServletRequest request,RedirectAttributes redirectAttributes,Model model) {
		Map map = new HashedMap();
			if(wmNewsReceiver.getId() !=""){
				/*String datetime =DateUtils.getDate("yyyy-MM-dd HH:mm:ss");
				 Date date=new Date(datetime);  
				wmNewsReceiver.setUpdateDate(date);*/
			/*	String datetime =DateUtils.getDate("yyyy-MM-dd HH:mm:ss");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
				// Date date = sdf.parse(datetime);
				 Date date=new Date();  */
				 
			//addMessage(redirectAttributes, "修改成功");
				String datetime =DateUtils.getDate("yyyy-MM-dd HH:mm:ss");
			//	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				
				/*try {
					Date date =sdf.parse(datetime);
					
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}*/
				 try {
					Date date = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).parse(datetime);
					wmNewsReceiver.setUpdateDate(date);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
				wmNewsReceiverService.udpateone(wmNewsReceiver);
			map.put("msg", "回复成功");
			}else{
				map.put("msg", "回复失败");
				//model.addAttribute("ms","修改失败！");
			}
			/*addMessage(redirectAttributes, "查看事项成功...");
			return "modules/item/wmTodoItemForm";*/
		//	return "modules/item/wmTodoItemForm";
	return JsonMapper.toJsonString(map);
	}
	
	
	
	
	@RequiresPermissions("wmnewsreceivers:wmNewsReceiver:edit")
	@RequestMapping(value = "tochecknum")
	@ResponseBody
	public String tochecknum(RedirectAttributes redirectAttributes) {
	WmNewsReceiver wmNewsReceiver = new WmNewsReceiver();
		User user = UserUtils.getUser();
		wmNewsReceiver.setUser(user.getLoginName());
		wmNewsReceiver.setStatus("未读");
		
		int num = wmNewsReceiverService.tochecknumfind(wmNewsReceiver);
		Map map = new HashedMap();
		map.put("msg", num);
		
		return JsonMapper.toJsonString(map);
	}
	
}