/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.item.web;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.commons.collections.map.HashedMap;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.Layui;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.item.entity.WmTodoItem;
import com.thinkgem.jeesite.modules.item.service.WmTodoItemService;
import com.thinkgem.jeesite.modules.itemattch.entity.WmTodoItemAttach;
import com.thinkgem.jeesite.modules.itemattch.entity.WmTodoItemAttachModel;
import com.thinkgem.jeesite.modules.itemattch.service.WmTodoItemAttchService;
import com.thinkgem.jeesite.modules.myitems.entity.WmUserItem;
import com.thinkgem.jeesite.modules.myitems.service.WmUserItemService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 
 * 
 * 待办事项管理Controller
 * @author 杨萌
 * @version 2018-04-23
 */
@Controller
@RequestMapping(value = "${adminPath}/item/wmTodoItem")
@PropertySource(value="classpath:jeesite.properties")
public class WmTodoItemController extends BaseController {

	@Autowired
	private WmTodoItemService wmTodoItemService;
	@Autowired
	private WmUserItemService wmUserItemService;
	
	@ModelAttribute
	public WmTodoItem get(@RequestParam(required=false) String id) {
		WmTodoItem entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wmTodoItemService.get(id);
		}
		if (entity == null){
			entity = new WmTodoItem();
		}
		return entity;
	}
	
	@RequiresPermissions("item:wmTodoItem:view")
	@RequestMapping(value = {"list", ""})
	@ResponseBody
	public String list( HttpServletRequest request, HttpServletResponse response, Model model/*,String page,String limit*/) {
		
		//layui传递参数page 冲突解决方法 获取layui分页page limit参数
		 String layuiPage = request.getParameter("page");
		 String layuiLimit= request.getParameter("limit");
		 
		 Calendar calendar=Calendar.getInstance(); 
		    int year=calendar.get(Calendar.YEAR); 
		    int m=calendar.get(Calendar.MONTH)+1; 
		    int day=calendar.get(Calendar.DATE); 
		    String month ="";
		    String order="";
		    String field="";
		    WmTodoItem wmTodoItem = new WmTodoItem();	
		 //month 获取当前页面查看的month值 通过month查看指定月份的事项
		    if(request.getParameter("month") != null && request.getParameter("month")!=""){
		    	month= request.getParameter("month");
		    	
		    }else{
		    	month = Integer.toString(m);
		    }
		   // model.addAttribute("ms", month);
		   
		    model.addAttribute("month", month);
		    
		    if(request.getParameter("field") != null && request.getParameter("field")!=""){
		    	field= request.getParameter("field");
		    	
		    	if(field.equals("operationType")){
		    		field="operation_type";
		    	}else if(field.equals("itemType")){
		    		field="item_type";
		    	}else if(field.equals("updateDate")){
		    		field="update_date";
		    	}
		    	
		    	wmTodoItem.setField(field);
		    }
		    if(request.getParameter("order") != null && request.getParameter("order")!=""){
		    	order= request.getParameter("order");
		    	wmTodoItem.setOrder(order);
		    }
		//分页设置 
		layuiPage=String.valueOf((Integer.parseInt(layuiPage)-1)*(Integer.parseInt(layuiLimit)));
		User user = UserUtils.getUser();
		//创建wm对象  利用set注入值
		
		wmTodoItem.setLayuiLimit(layuiLimit);
		wmTodoItem.setLayuiPage(layuiPage);
		wmTodoItem.setMonth(month);
		wmTodoItem.setUser(user.getLoginName());
		
		//使用list 讲查到的数据封装  
		List<WmTodoItem> list = wmTodoItemService.findList(wmTodoItem);
		//获取count 数量
		int count=wmTodoItemService.count(wmTodoItem) ;
	//	int count=wmTodoItemService.count(wmTodoItem) ;
		
		//利用Layui工具类 以 data msg code count 的返回方式 返回到前台
		Layui layui = new Layui();
		layui.setCount(count);
		layui.setMsg("");
		layui.setData(list);
		layui.setCode(0);
		  model.addAttribute("showiconlist", list);
		return JsonMapper.toJsonString(layui);
	}

	@RequiresPermissions("item:wmTodoItem:view")
	@RequestMapping(value = "form")
	public String form(WmTodoItem wmTodoItem, Model model) {
		
		 Calendar calendar=Calendar.getInstance(); 
		    int year=calendar.get(Calendar.YEAR); 
		    int m=calendar.get(Calendar.MONTH)+1; 
		    int day=calendar.get(Calendar.DATE); 
		 
		    
		model.addAttribute("ms", m);
		
		return "modules/item/wmTodoItemForm";
		//测试优化界面
		//return "modules/item/MyJsp";
	}

	@RequiresPermissions("item:wmTodoItem:edit")
	@RequestMapping(value = "save")
	@ResponseBody
	public String save(WmTodoItem wmTodoItem, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, wmTodoItem)){
			return form(wmTodoItem, model);
		}
		Map<String, Object> maps = new HashedMap();
		Calendar calendar=Calendar.getInstance(); 
	    int year=calendar.get(Calendar.YEAR); 
	    int m=calendar.get(Calendar.MONTH)+1; 
	    int day=calendar.get(Calendar.DATE); 
		String content = wmTodoItem.getContent();
		wmTodoItem.setMonth(Integer.toString(m));
		//判断content是否重复
		int checkcontent = wmTodoItemService.checkcontent(wmTodoItem);
	    if(checkcontent >0){
	    	//说明本月已经添加过相同内容的事项了
	    	maps.put("msg", "本月已有相同内容的事项了，不可重复添加");
	    	return JsonMapper.toJsonString(maps);
	    }
	    
	    String finishdate = wmTodoItem.getFinishdate();
	    
	    //modify by zhangys @0523 finishdate初始值问题
	    if("".equals(wmTodoItem.getFinishdate())){
	    	wmTodoItem.setFinishdate(null);
	    }
	
	 /*   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");//小写的mm表示的是分钟  
	  
	    try {
			Date date=sdf.parse(finishdate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  */
	    
	  //  wmTodoItem.setFinishdate(finishdate);
	    
	    
	    if(StringUtils.isNotBlank(wmTodoItem.getPreId())){
	    	wmTodoItem.setId(wmTodoItem.getPreId());
	    }
	    wmTodoItem.setJtag(true);
	    wmTodoItem.setjIgnoreNew(true);
	    wmTodoItem.setIsNewRecord(true);
		wmTodoItemService.save(wmTodoItem);
		model.addAttribute("message", "添加事项成功");
		model.addAttribute("ms", m);
		maps.put("msg", "添加事项成功");
		//addMessage(redirectAttributes, "保存保存&ldquo;事项&rdquo;成功成功");
		return JsonMapper.toJsonString(maps);
		//return "modules/item/MyJsp";
		//return "modules/item/wmTodoItemForm";
	}
	
	@RequiresPermissions("item:wmTodoItem:edit")
	@RequestMapping(value = "delete")
	public String delete(WmTodoItem wmTodoItem, RedirectAttributes redirectAttributes) {
		wmTodoItemService.delete(wmTodoItem);
		addMessage(redirectAttributes, "删除保存&ldquo;事项&rdquo;成功成功");
		return "redirect:"+Global.getAdminPath()+"/item/wmTodoItem/?repage";
	}
	
	
	/**
	 * 
	 * @param request
	 * @param redirectAttributes
	 * @return
	 * 
	 * 批量删除操作
	 * 前端传递str的id字符串 利用,进行分割成string数组  遍历id进行删除操作
	 */
	@RequiresPermissions("item:wmTodoItem:edit")
	@RequestMapping(value = "deletemore")
	public String deletemore( HttpServletRequest request,RedirectAttributes redirectAttributes,Model model) {
		String str = request.getParameter("str");

		 Calendar calendar=Calendar.getInstance(); 
		    int year=calendar.get(Calendar.YEAR); 
		    int m=calendar.get(Calendar.MONTH)+1; 
		    int day=calendar.get(Calendar.DATE); 
		 
		    
		model.addAttribute("ms", m);
		
		String idarr[]=null;
		int [] arr =null;
		if(str.contains(",")){
			//批量删除
			idarr = str.split(",");
			arr = new int[idarr.length];
			for(int j=0;j<arr.length;j++){
				WmTodoItem wmTodoItem = new WmTodoItem();
				wmTodoItem.setId(idarr[j]);
				wmTodoItemService.delete(wmTodoItem);
			}
		}else{
			//单条删除
			WmTodoItem wmTodoItem = new WmTodoItem();
			wmTodoItem.setId(str);
			wmTodoItemService.delete(wmTodoItem);
		}
		addMessage(redirectAttributes, "删除保存&ldquo;事项&rdquo;成功成功");
		//return "redirect:"+Global.getAdminPath()+"/modules/item/wmTodoItemForm/list";
		//return "modules/item/MyJsp";
		return "modules/item/wmTodoItemForm";
	}
	
	
	
	@RequiresPermissions("item:wmTodoItem:edit")
	@RequestMapping(value = "itemsadd")
	public String itemsaddopen(WmTodoItem wmTodoItem, Model model) {
	//	model.addAttribute("wmTodoItem", wmTodoItem);
		/**
		 * add by zhangys
		 * */
		model.addAttribute("preid", IdGen.uuid());
		return "modules/item/items";
	}
	
	@Autowired
	private Environment env;
	
	@Autowired
	private WmTodoItemAttchService attchService;
	/**
	 * 附件上传功能
	 * add by zhangys
	 * */
//	@RequiresPermissions("item:wmTodoItem:edit")
	@RequestMapping(value = "saveAttachment")
	public ResponseEntity<WmTodoItemAttachModel> saveAttachment(MultipartFile file,DefaultMultipartHttpServletRequest request,Model model){
		String preid=request.getParameter("preid");
		if(StringUtils.isBlank(preid)){
			ResponseEntity<WmTodoItemAttachModel> re=new ResponseEntity<WmTodoItemAttachModel>(new WmTodoItemAttachModel(1, null, null),HttpStatus.OK);
			return re;
		}
		WmTodoItemAttachModel attachModel=null;
		try {
			String filename = file.getOriginalFilename()+"_"+String.valueOf(System.currentTimeMillis());
			String attchPath = env.getProperty("todoitem.attachment");
			File localfile = new File(attchPath + filename);
			if (!localfile.exists()) {
				localfile.createNewFile();
			}
			file.transferTo(localfile);
			WmTodoItemAttach attach=new WmTodoItemAttach(preid, DateUtils.formatDateTime(new Date()), localfile.getAbsolutePath());
			attchService.save(attach);
			attachModel=new WmTodoItemAttachModel(0,preid,localfile.getAbsolutePath());
		} catch (Exception e) {
			e.printStackTrace();
		}
		ResponseEntity<WmTodoItemAttachModel> re=new ResponseEntity<WmTodoItemAttachModel>(attachModel,HttpStatus.OK);
		return re;
	}
	
	/**
	 * 查询页面跳转功能
	 */

	@RequiresPermissions("item:wmTodoItem:view")
	@RequestMapping(value = "detailopen")
	public String detailopen(HttpServletRequest request, Model model) {
	
		String id = request.getParameter("id");
		WmTodoItem wmTodoItem= wmTodoItemService.get(id);
		
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
		Date date= wmTodoItem.getCreateDate();
		String str=sdf.format(date);  
		
		String arr[] = str.split("-");
		String month = arr[1];
		if(month == "11" || month == "12" || month =="10"){
			
		}else{
			char sdsf = month.charAt(1);
			 month = String.valueOf(sdsf); 
			 
		}

		 Calendar calendar=Calendar.getInstance(); 
		   // int year=calendar.get(Calendar.YEAR); 
		    int m=calendar.get(Calendar.MONTH)+1; 
		 //   int day=calendar.get(Calendar.DATE); 
		    
		    int monthcompare = Integer.parseInt(month);
		    
		
		    if(monthcompare+2 <=m){
		    	//补办
		    	return "modules/item/itemsview2";
		    }else{
		    	
		    	return "modules/item/itemsview";
		    }
		
	}
	
	
	
	
	
	/**
	 * 跳转到我的工作界面
	 */
	@RequiresPermissions("item:wmTodoItem:view")
	@RequestMapping(value = "mywork")
	public String mywork(HttpServletRequest request, Model model) {
	
		return "modules/myitems/wmUserItemForm";
	}
	/**
	 * 修改页面跳转功能
	 */

	@RequiresPermissions("item:wmTodoItem:edit")
	@RequestMapping(value = "updateone")
	public String updateopen(HttpServletRequest request, Model model) {
	//	model.addAttribute("wmTodoItem", wmTodoItem);
	/*	HttpSession session = 
		String str = request.getParameter("str");
		if(str.length()>0){
			
		}*/
		return "modules/item/itemsupdate";
	}
	
	
	
	
	/**
	 * 待办事项查询功能 
	 */
	@RequiresPermissions("item:wmTodoItem:view")
	@RequestMapping(value = "detail")
	@ResponseBody
	public String detailone( HttpServletRequest request,RedirectAttributes redirectAttributes) {
		String str = request.getParameter("id");
		String showicon = request.getParameter("showicon");
		if(str.length() !=0){
			
			//接收到id值 利用get(id)方法获取到对象 讲对象返回给页面
			List<WmTodoItem> list =  new ArrayList<WmTodoItem>();
			WmTodoItem wmTodoItem = wmTodoItemService.get(str);
			//事项的创建者
			User user = wmTodoItem.getCreateBy();//这里获取的是userid
			 
			String s =  String.valueOf(user);
			
			User userss = UserUtils.get(s);
			
			
			String name = userss.getLoginName();
			//现在的登陆者
			User users = UserUtils.getUser();
			String loginname = users.getLoginName();
			String userid =users.getId();
			List<String> roleid=	user.getRoleIdList();
			
			
		
			
			wmTodoItem.setShowicon(showicon);
			Map map = new HashedMap();
			map.put("wmTodoItem", wmTodoItem);
			
			//发布者和管理员可以看到详细的申请情况
			if (loginname.equals(name) || roleid.contains("1")){
				//说明是同一个人 
			
			//查看此事项是否已经有人认领
			List<WmUserItem> useritemlist = new ArrayList<WmUserItem>();
			//findslinfo
			WmUserItem userItem = new WmUserItem();
			userItem.setItemId(str);
			useritemlist = wmUserItemService.findslinfo(userItem);
			if(useritemlist.size()>0){
				//说明已经有人申领了
				map.put("msg", "有人认领");
				
				map.put("useritemlist",useritemlist);
				
			}else{
				map.put("msg","无人认领");
			}
			
			}else{
				
				}	
			
			
			
			//addMessage(redirectAttributes, "查看事项成功...");
			return JsonMapper.toJsonString(map);
			/*addMessage(redirectAttributes, "查看事项成功...");
			return "modules/item/wmTodoItemForm";*/
		}else{
			return null;
		}
		
	
	}
	
	/**
	 * 编辑保存功能
	 */
	@RequiresPermissions("item:wmTodoItem:edit")
	@RequestMapping(value = "edittj")
	@ResponseBody
	public String edittj(WmTodoItem wmTodoItem, HttpServletRequest request,RedirectAttributes redirectAttributes,Model model) {
		Map map = new HashedMap();
			if(wmTodoItem.getId() !=""){
			wmTodoItemService.udpateone(wmTodoItem);
			//addMessage(redirectAttributes, "修改成功");
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
	
	
	
	@RequiresPermissions("item:wmTodoItem:view")
	@RequestMapping(value = "finished")
	@ResponseBody
	public String finished(HttpServletRequest request, HttpServletResponse response, Model model) {
	
		
		String itemid = request.getParameter("str");
		 User user = UserUtils.getUser();
		 String loginname = user.getLoginName();
		 WmUserItem wm = new WmUserItem();
		 wm.setItemId(itemid);
		 wm.setUser(loginname);
		 
		WmUserItem wmUserItem =wmUserItemService.findonebyitemidanduser(wm);
		
		
		wmUserItem.setIsFinished("1");
		
		wmUserItemService.updatefinish(wmUserItem);
		Map map = new HashedMap();
		map.put("msg","提交成功");
		return JsonMapper.toJsonString(map);
		
		
		
	}
	
	

	
	
	
	/**
	 * 申领功能
	 * 逻辑 ： insert 一条 信息给  wm_uesr_item
	 */
	@RequiresPermissions("item:wmTodoItem:view")
	@RequestMapping(value = "applyfor")
    @ResponseBody
	public String applyforuser( HttpServletRequest request,RedirectAttributes redirectAttributes,Model model) {
		//传入wm_todo_item 表中的id 
		String itemid = request.getParameter("str");
		if(itemid.length() !=0){
			//获取到当前系统登陆用户
			User user = UserUtils.getUser();
			//获取到系统用户名
			String username = user.getLoginName();
			WmUserItem wmUserItem = new WmUserItem();
			//将用户登录名，itemid传入
			wmUserItem.setUser(username);
			wmUserItem.setItemId(itemid);
			//先去库里查找是否已经申领过了
			List<WmUserItem> list = wmUserItemService.findList(wmUserItem);
				
			Map<String, Object> maps = new HashedMap();
			if(list.size()>0){
				//给前台返回提示已经申领不可在申领
				maps.put("msg", "您已申领过此事项，不可重复申领!");
				return JsonMapper.toJsonString(maps);
			}else{
				wmUserItem.setIsFinished("0");
			wmUserItemService.save(wmUserItem);
			//返回待办事项查询界面
			maps.put("msg", "申领成功!");
			 return JsonMapper.toJsonString(maps);
			}
		
		}
		return null;
	}
	
	/**
	 * 补办功能
	 * 逻辑 ： insert 一条 信息给  wm_uesr_item
	 */
	@RequiresPermissions("item:wmTodoItem:view")
	@RequestMapping(value = "bubanfor")
    @ResponseBody
	public String bubanfor( HttpServletRequest request,RedirectAttributes redirectAttributes,Model model) {
		//传入wm_todo_item 表中的id 
		String itemid = request.getParameter("str");
		String reason = request.getParameter("reason");
		if(itemid.length() !=0){
			//获取当前用户  利用 UserUtils.getUser() 获取用户  .get(id) 来获取用户信息
		    //掉用service方法执行insert方法 把对象传进去
			//获取到当前系统登陆用户
			User user = UserUtils.getUser();
			//获取到系统用户名
			String username = user.getLoginName();
			WmUserItem wmUserItem = new WmUserItem();
			//将用户登录名，itemid传入
			wmUserItem.setUser(username);
			wmUserItem.setItemId(itemid);
			wmUserItem.setHandleResult(reason);
			//先去库里查找是否已经申领过了
			List<WmUserItem> list = wmUserItemService.findList(wmUserItem);
				
			Map<String, Object> maps = new HashedMap();
			if(list.size()>0){
				//给前台返回提示已经申领不可在申领
				maps.put("msg", "您已领取此事项，不可重复选择!");
				return JsonMapper.toJsonString(maps);
			}else{
				wmUserItem.setIsFinished("0");
			
			wmUserItemService.save(wmUserItem);
			//返回待办事项查询界面
			maps.put("msg", "申请补办成功!");
			 return JsonMapper.toJsonString(maps);
			}
		
		}
		return null;
	}
	
	
	
	/**
	 * 补办检查是否已经补办
	 * 逻辑 ： insert 一条 信息给  wm_uesr_item
	 */
	@RequiresPermissions("item:wmTodoItem:view")
	@RequestMapping(value = "bubancheck")
    @ResponseBody
	public String bubancheck( HttpServletRequest request,RedirectAttributes redirectAttributes,Model model) {
		//传入wm_todo_item 表中的id 
		String itemid = request.getParameter("str");
		//String reason = request.getParameter("reason");
		if(itemid.length() !=0){
			//获取当前用户  利用 UserUtils.getUser() 获取用户  .get(id) 来获取用户信息
			//获取到当前系统登陆用户
			User user = UserUtils.getUser();
			//获取到系统用户名
			String username = user.getLoginName();
			WmUserItem wmUserItem = new WmUserItem();
			//将用户登录名，itemid传入
			wmUserItem.setUser(username);
			wmUserItem.setItemId(itemid);
		//	wmUserItem.setHandleResult(reason);
			//先去库里查找是否已经申领过了
			List<WmUserItem> list = wmUserItemService.findList(wmUserItem);
				
			Map<String, Object> maps = new HashedMap();
			if(list.size()>0){
			
				maps.put("msg", "您已领取此事项，不可重复选择!");
				return JsonMapper.toJsonString(maps);
			}else{
				maps.put("msg","success");
			return JsonMapper.toJsonString(maps);
			}
		
		}
		return null;
	}
	
	/**
	 * 导入导出==导入模板
	 * 
	 */
	@RequiresPermissions("item:wmTodoItem:edit")
	@RequestMapping(value = "exportFileTemplate")
	   public String exportFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
			try {
		        String fileName = "待办事项模板.xlsx";
		   		List<WmTodoItem> list = Lists.newArrayList(); //list.add(UserUtils.getUser());
		   		
		   		new ExportExcel("待办事项", WmTodoItem.class, 2).setDataList(list).write(response, fileName).dispose();
		   		return null;
			} catch (Exception e) {
				addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
			}
			return "redirect:" + adminPath + "/item/wmTodoItem/form";
	   }
	
	/*
	 * 导出待办事项
	 * */
	@RequiresPermissions("item:wmTodoItem:edit")
    @RequestMapping(value = "exportFile", method=RequestMethod.POST)
    public String exportFile(WmTodoItem wmTodoItem, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
		//	String month = request.getp
            String fileName = "待办事项数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<WmTodoItem> page = wmTodoItemService.findPage(new Page<WmTodoItem>(request, response, -1), wmTodoItem);
    		new ExportExcel("待办事项数据", WmTodoItem.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出待办事项数据失败！失败信息："+e.getMessage());
		}
		//
		return "modules/item/wmTodoItemForm";
    }
	
	/*
	 * 导入待办事项
	 * */
	@RequiresPermissions("item:wmTodoItem:edit")
    @RequestMapping(value = "importFile", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes,Model model) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/item/wmTodoItem/form";
		}
		try {
			Calendar calendar=Calendar.getInstance(); 
		    int year=calendar.get(Calendar.YEAR); 
		    int m=calendar.get(Calendar.MONTH)+1; 
		    int day=calendar.get(Calendar.DATE); 
			int successNum = 0;
			int num =1;
			int failureNum = 0;
			String itemtype="";
			String operationtype="";
			String status="";
			String content ="";
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<WmTodoItem> list = ei.getDataList(WmTodoItem.class);
			for (WmTodoItem wmTodoItem : list){
				try{
					
					itemtype= wmTodoItem.getItemType();
					status = wmTodoItem.getStatus();
					operationtype=wmTodoItem.getOperationType();
					content = wmTodoItem.getContent();
					wmTodoItem.setMonth(Integer.toString(m));
					//这里明天补充
					//先判断状态
					if("0".equals(status)||"1".equals(status)){
						//待操作类型
						if("0".equals(operationtype)|| "1".equals(operationtype)||"2".equals(operationtype)||"3".equals(operationtype)){
							//事项类型
							if(itemtype.equals("0")|| itemtype.equals("1") || itemtype.equals("2")){
								//判断content是否已经存在
								int checkcontent = wmTodoItemService.checkcontent(wmTodoItem);
							    if(checkcontent == 0){
							    	//执行save方法
									wmTodoItemService.save(wmTodoItem);
									successNum++;
							    }else{
							    	//说明本月已经添加过相同内容的事项了
							    	failureMsg.append("<br/>登录名 "+UserUtils.getUser().getName()+" 导入失败：第"+num+"行数据中的事项内容本月已存在，不可重复");
									failureNum++;
								
							    }
							}else{
							//说明事项类型不对
								failureMsg.append("<br/>登录名 "+UserUtils.getUser().getName()+" 导入失败：第"+num+"行事项类型不规范，(干部管理;设备管理;业务管理)");
							failureNum++;
							}
						}else{
						//说明待操作类型不规范
						failureMsg.append("<br/>登录名 "+UserUtils.getUser().getName()+" 导入失败：第"+num+"行待操作类型不规范，(下载类;在线填写类;上报计划类;在线提示类)");
						failureNum++;
						
						}
					}else{
					//说明状态不正确
					failureNum++;
					failureMsg.append("<br/>登录名 "+UserUtils.getUser().getName()+" 导入失败：第"+num+"行数据状态填写不规范，(待办; 已办)");
					
					}
					
				}catch(ConstraintViolationException ex){
					failureMsg.append("<br/>登录名 "+UserUtils.getUser().getName()+" 导入失败：");
					List<String> messageList = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
					for (String message : messageList){
						failureMsg.append(message+"; ");
						failureNum++;
					}
				}catch (Exception ex) {
					failureMsg.append("<br/>登录名 "+UserUtils.getUser().getName()+" 导入失败："+ex.getMessage());
				}
				num++;
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条用户，导入信息如下：");
			//这里添加 提示
				model.addAttribute("message","导入"+failureNum+"条数据失败,请检查书写是否规范"+failureMsg);
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条用户"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入用户失败！失败信息："+e.getMessage());
		}
		return "modules/item/wmTodoItemForm";
    }
	
	
	
	
	
	
	
	
}
	
	
