/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.myitems.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
import com.thinkgem.jeesite.common.utils.Layui;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.item.entity.WmTodoItem;
import com.thinkgem.jeesite.modules.myitems.entity.WmUserItem;
import com.thinkgem.jeesite.modules.myitems.service.WmUserItemService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 我的工作管理Controller
 * @author 杨萌
 * @version 2018-04-26
 */
@Controller
@RequestMapping(value = "${adminPath}/myitems/wmUserItem")
public class WmUserItemController extends BaseController {

	@Autowired
	private WmUserItemService wmUserItemService;
	
	@ModelAttribute
	public WmUserItem get(@RequestParam(required=false) String id) {
		WmUserItem entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wmUserItemService.get(id);
		}
		if (entity == null){
			entity = new WmUserItem();
		}
		return entity;
	}
	
	@RequiresPermissions("myitems:wmUserItem:view")
	@RequestMapping(value = {"list", ""})
	@ResponseBody
	public String list( HttpServletRequest request, HttpServletResponse response, Model model) {
		/*Page<WmUserItem> page = wmUserItemService.findPage(new Page<WmUserItem>(request, response), wmUserItem); 
		model.addAttribute("page", page);*/
		//layui传递参数page 冲突解决方法 获取layui分页page limit参数
		 String layuiPage = request.getParameter("page");
		 String layuiLimit= request.getParameter("limit");
		 StringBuilder key ;
		
			//排序字段
			String  field = "";
			//排序方式
			String order= "";
			
			String title="";
			String createdate="";
			String itemtype="";
			//默认查询未完成的
			String isFinished="0";
			
			
			WmUserItem wmUserItem = new WmUserItem();
			
		 if(request.getParameter("title") !="" && request.getParameter("title") != null  ){
			 title = request.getParameter("title");
			 wmUserItem.setTitle(title);
			//content ="b."+content;
		 }
		 if(request.getParameter("createdate") !="" && request.getParameter("createdate") != null  ){
			 createdate = request.getParameter("createdate");
			// createdate=""
			// wmUserItem.setCreateDate(createDate);
			String arr[]= createdate.split("-");
			/*String statr = arr[0];
			String ss =arr[1];*/
		String 	starttime =arr[0]+"-"+arr[1];
		String endtime = arr[2]+"-"+arr[3];
			
			
			wmUserItem.setStart(starttime.trim());
			 wmUserItem.setEnd(endtime.trim());
			
		 }
		 if(request.getParameter("itemtype") !="" && request.getParameter("itemtype") != null  ){
			 itemtype = request.getParameter("itemtype");
			wmUserItem.setItemType(itemtype);
		 }
		 
		 if(request.getParameter("isfinished") !="" && request.getParameter("isfinished") != null  ){
			 isFinished = request.getParameter("isfinished");
			 wmUserItem.setIsFinished(isFinished);
			//content ="b."+content;
		 }else{
			 wmUserItem.setIsFinished(isFinished);
		 }
		 
		 //排序字段
		 if(request.getParameter("field") !="" && request.getParameter("field") != null  ){
			 
			 field = request.getParameter("field");
				
			 //item_type
			 if(field.equals("itemType")){
				 field="b.item_type";
			 }else  if(field.equals("title")){
				 field="b.title";
			 }else if(field.equals("createDate")){
				 field="a.create_date";
			 }else if(field.equals("isFinished")){
				 field ="a.is_finished";
			 }else if(field.equals("handleType")){
				 field="a.handle_type";
			 }else if(field.equals("handleResult")){
				 field="a.handle_result";
			 }
			 
			
			  wmUserItem.setField(field);
			 }
		 
		 //排序方式
		 if(request.getParameter("order") !="" && request.getParameter("order") != null  ){
			 order = request.getParameter("order");
			  wmUserItem.setOrder(order);
			 }
		 
		 //month 获取当前页面查看的month值 通过month查看指定月份的事项
		// String month= request.getParameter("month");
		
		 
		//分页设置 
		layuiPage=String.valueOf((Integer.parseInt(layuiPage)-1)*(Integer.parseInt(layuiLimit)));
		//创建wm对象  利用set注入值
		wmUserItem.setLayuiLimit(layuiLimit);
		wmUserItem.setLayuiPage(layuiPage);
		//wmUserItem.setMonth(month);
		 
		User user = UserUtils.getUser();
		String username =user.getLoginName();
		wmUserItem.setUser(username);
		/*if(key.length()>0){
			wmUserItem.setContent(key); 
		}*/
		 
		
		//使用list 讲查到的数据封装  
		List<WmUserItem> list = wmUserItemService.findList(wmUserItem);
		//获取count 数量
		int count=wmUserItemService.sumcount(wmUserItem) ;
		
		//利用Layui工具类 以 data msg code count 的返回方式 返回到前台
		Layui<WmUserItem> layui = new Layui<WmUserItem>();
		layui.setCount(count);
		layui.setMsg("");
		layui.setData(list);
		layui.setCode(0);
		return JsonMapper.toJsonString(layui);
		
		
		//return "modules/myitems/wmUserItemList";
	}

	@RequiresPermissions("myitems:wmUserItem:view")
	@RequestMapping(value = "form")
	public String form(WmUserItem wmUserItem, Model model) {
		model.addAttribute("wmUserItem", wmUserItem);
		return "modules/myitems/wmUserItemForm";
	}

	@RequiresPermissions("myitems:wmUserItem:edit")
	@RequestMapping(value = "save")
	public String save(WmUserItem wmUserItem, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, wmUserItem)){
			return form(wmUserItem, model);
		}
		wmUserItemService.save(wmUserItem);
		addMessage(redirectAttributes, "保存加入&rdquo;我的工作&ldquo;成功成功");
		return "redirect:"+Global.getAdminPath()+"/myitems/wmUserItem/?repage";
	}
	
	@RequiresPermissions("myitems:wmUserItem:delete")
	@RequestMapping(value = "delete")
	public String delete(WmUserItem wmUserItem, RedirectAttributes redirectAttributes) {
		wmUserItemService.delete(wmUserItem);
		addMessage(redirectAttributes, "删除加入&rdquo;我的工作&ldquo;成功成功");
		return "redirect:"+Global.getAdminPath()+"/myitems/wmUserItem/?repage";
	}
	
	
	
	
	@RequiresPermissions("myitems:wmUserItem:view")
	@RequestMapping(value = "myitemjob")
	public String myitemjob(WmUserItem wmUserItem, Model model) {
	//	model.addAttribute("wmTodoItem", wmTodoItem);
		
		return "modules/myitems/myitem";
	}
	
	
	@RequiresPermissions("myitems:wmUserItem:view")
	@RequestMapping(value = "viewonedetailopen")
	public String viewonedetailopen(WmUserItem wmUserItem, Model model) {
	//	model.addAttribute("wmTodoItem", wmTodoItem);
	//	String id= 
		
		
		
		return "modules/myitems/myitem";
	}
	@RequiresPermissions("myitems:wmUserItem:view")
	@RequestMapping(value = "updateonedetailopen")
	public String updateonedetailopen(WmUserItem wmUserItem, Model model) {
	//	model.addAttribute("wmTodoItem", wmTodoItem);
	//	String id= 
		
		
		
		
		return "modules/myitems/myitemupdate";
	}
	
	
	
	
	@RequiresPermissions("myitems:wmUserItem:view")
	@RequestMapping(value = "viewonedetail")
	@ResponseBody
	public String viewonedetail(HttpServletRequest request, HttpServletResponse response, Model model) {
	//	model.addAttribute("wmTodoItem", wmTodoItem);
	//	String id= 
		
		/*private String user;		// 用户名
		private String itemId;		// 事项ID
		private String isFinished;		// 是否完成
		private String handleType;		// 办理类型
		private String handleResult;		// 办理原因
		private String layuiPage;
		private String layuiLimit;*/
		
		String id = request.getParameter("id");
		WmUserItem wmUserItem = wmUserItemService.get(id);
		
		Map map = new HashedMap();
		String itemtype = wmUserItem.getItemType();
		//map.put("title",wmUserItem.getContent());
		map.put("content",wmUserItem.getContent());
		map.put("handleResult",wmUserItem.getHandleResult());
		map.put("HandleType",wmUserItem.getHandleType());
		//map.put("", wmUserItem.getIsFinished());
		map.put("itemType", wmUserItem.getItemType());
		map.put("isFinished", wmUserItem.getIsFinished());
		
		
		
		map.put("wmUserItem", wmUserItem);
		
		
	
		return JsonMapper.toJsonString(map);
		
		
		
	}
	
	@RequiresPermissions("myitems:wmUserItem:view")
	@RequestMapping(value = "updateonedetail")
	@ResponseBody
	public String updateonedetail(HttpServletRequest request, HttpServletResponse response, Model model) {
	//	model.addAttribute("wmTodoItem", wmTodoItem);
	//	String id= 
		
		/*private String user;		// 用户名
		private String itemId;		// 事项ID
		private String isFinished;		// 是否完成
		private String handleType;		// 办理类型
		private String handleResult;		// 办理原因
		private String layuiPage;
		private String layuiLimit;*/
		
		String id = request.getParameter("id");
		WmUserItem wmUserItem = wmUserItemService.get(id);
		//获取到主表需要修改的内容
		String itemid= wmUserItem.getItemId();
		String content = wmUserItem.getContent();
		
		//修改从表
		
		
		
		Map map = new HashedMap();
		String itemtype = wmUserItem.getItemType();
		map.put("content",wmUserItem.getContent());
		map.put("handleResult",wmUserItem.getHandleResult());
		map.put("HandleType",wmUserItem.getHandleType());
		//map.put("", wmUserItem.getIsFinished());
		map.put("itemType", wmUserItem.getItemType());
		map.put("isFinished", wmUserItem.getIsFinished());
		
		
		
		map.put("wmUserItem", wmUserItem);
		
		
	
		return JsonMapper.toJsonString(map);
		
		
		
	}
	
	
	
	
	@RequiresPermissions("myitems:wmUserItem:view")
	@RequestMapping(value = "finished")
	@ResponseBody
	public String finished(HttpServletRequest request, HttpServletResponse response, Model model) {
	
		
		String id = request.getParameter("str");
		WmUserItem wmUserItem = wmUserItemService.get(id);
		wmUserItem.setIsFinished("1");
		
		wmUserItemService.updatefinish(wmUserItem);
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map.put("msg","提交成功");
		} catch (Exception e) {
			map.put("msg","提交失败,请联系管理员");
			e.printStackTrace();
		}
		
		return JsonMapper.toJsonString(map);
		
		
		
	}
	
	
	
	
	
	/**
	 * 编辑提交
	 */
	/**
	 * 编辑保存功能
	 * @throws ParseException 
	 */
	@RequiresPermissions("myitems:wmUserItem:view")
	@RequestMapping(value = "edittj")
	@ResponseBody
	public String edittj(WmUserItem wmUserItem, HttpServletRequest request,RedirectAttributes redirectAttributes,Model model) throws ParseException {
		Map map = new HashedMap();
			if(wmUserItem.getId() !=""){
			//wmTodoItemService.udpateone(wmTodoItem);
			//addMessage(redirectAttributes, "修改成功");
			//设置update——date 时间
			Date day=new Date();    

			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 

			String date =df.format(day);
			
			User user = UserUtils.getUser();
			String id = user.getId();
			wmUserItem.setUpdateBy(user);
			//System.out.println(); 
			Date dates =df.parse(date);
			wmUserItem.setUpdateDate(dates);
			wmUserItemService.updateone(wmUserItem);
			map.put("msg", "修改成功");
			
			
			}else{
				map.put("msg", "修改失败");
				//model.addAttribute("ms","修改失败！");
			}
			
			/*addMessage(redirectAttributes, "查看事项成功...");
			return "modules/item/wmTodoItemForm";*/
		
		//	return "modules/item/wmTodoItemForm";
	return JsonMapper.toJsonString(map);
	}
	
	
	
	
}