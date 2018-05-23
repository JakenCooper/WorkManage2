/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.wmnews.web;

import java.util.ArrayList;
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
import com.thinkgem.jeesite.modules.myitems.entity.WmUserItem;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wmnews.entity.WmNews;
import com.thinkgem.jeesite.modules.wmnews.service.WmNewsService;
import com.thinkgem.jeesite.modules.wmnewsreceivers.entity.WmNewsReceiver;
import com.thinkgem.jeesite.modules.wmnewsreceivers.service.WmNewsReceiverService;

/**
 * 通知管理Controller
 * @author 陈宏
 * @version 2018-05-09
 */
@Controller
@RequestMapping(value = "${adminPath}/wmnews/wmNews")
public class WmNewsController extends BaseController {

	@Autowired
	private WmNewsService wmNewsService;
	
	@Autowired
	private WmNewsReceiverService newsReceiverService;
	@Autowired
	private SystemService systemService;
	
	@ModelAttribute
	public WmNews get(@RequestParam(required=false) String id) {
		WmNews entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wmNewsService.get(id);
		}
		if (entity == null){
			entity = new WmNews();
		}
		return entity;
	}
	
	@RequiresPermissions("wmnews:wmNews:view")
	@RequestMapping(value = {"list", ""})
	@ResponseBody
	public String list( HttpServletRequest request, HttpServletResponse response, Model model) {
		//layui传递参数page 冲突解决方法 获取layui分页page limit参数
		 String layuiPage = request.getParameter("page");
		 String layuiLimit= request.getParameter("limit");
		 
		//排序字段
			String  field = "";
			//排序方式
			String order= "";
			
			String title="";
			String createdate="";
			String type="";
			String messageid="";
			String status="";
			//默认查找自己发送的
			WmNews news = new WmNews();
			User user = UserUtils.getUser();
			String username =user.getLoginName();
			
			
		 
		 
		 //用于搜索
		 if(request.getParameter("title") !="" && request.getParameter("title") != null  ){
			 title = request.getParameter("title");
			 news.setTitle(title);
			//content ="b."+content;
		 }
		 if(request.getParameter("status") !="" && request.getParameter("status") != null  ){
			 status = request.getParameter("status");
			 news.setStatus(status);
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
			
			
		news.setStart(starttime.trim());
		news.setEnd(endtime.trim());
			
		 }
		 if(request.getParameter("type") !="" && request.getParameter("type") != null  ){
			 type = request.getParameter("type");
			 if(type.equals("0")){
				 //查找自己发送的
				 news.setSender(username);
			 }else if(type.equals("1")){
				 //查找自己接收的
				 news.setUser(username);
			//	 news.setReceiver(username);
			 }else{
				 //说明管理远权限 可查找所有的
				 
			 }
			 news.setType(type);
			// news.setType(type);
		 }else{
			// news.setSender(username); 默认查询自己发送的
			 news.setUser(username);// 默认查询自己接收的
		 }
		 	
		//排序	
		 if(request.getParameter("field") !="" && request.getParameter("field") != null  ){
			 
			 field = request.getParameter("field");
				
			 //item_type
			 if(field.equals("content")){
				 field="content";
			 }else if(field.equals("createDate")){
				 field="create_date";
			 }else if(field.equals("title")){
				 field ="title";
			 }else if(field.equals("sender")){
				 field="sender";
			 }
			  news.setField(field);
			 }
		 
		 //排序方式
		 if(request.getParameter("order") !="" && request.getParameter("order") != null  ){
			 order = request.getParameter("order");
			  news.setOrder(order);
			 }
			
		
		 
		 
		 
			//分页设置 
			layuiPage=String.valueOf((Integer.parseInt(layuiPage)-1)*(Integer.parseInt(layuiLimit)));
			//创建wm对象  利用set注入值
			news.setLayuiLimit(layuiLimit);
			news.setLayuiPage(layuiPage);
		
			//使用list 讲查到的数据封装  
			List<WmNews> list = wmNewsService.findList(news);
			//获取count 数量
			int count=wmNewsService.sumcount(news) ;
			
			//利用Layui工具类 以 data msg code count 的返回方式 返回到前台
			Layui<WmNews> layui = new Layui<WmNews>();
			layui.setCount(count);
			layui.setMsg("");
			layui.setData(list);
			layui.setCode(0);
			return JsonMapper.toJsonString(layui);
		 
			
		
		//return "modules/wmnews/wmNewsForm";
	}
	
	
	
	
	
	/**
	 * 详情页面分页
	 * @param wmNews
	 * @param model
	 * @return
	 */
	
	@RequiresPermissions("wmnews:wmNews:view")
	@RequestMapping(value = {"detaillist", ""})
	@ResponseBody
	public String detaillist( HttpServletRequest request, HttpServletResponse response, Model model) {
		//layui传递参数page 冲突解决方法 获取layui分页page limit参数
		 String layuiPage = request.getParameter("page");
		 String layuiLimit= request.getParameter("limit");
	
			String messageid="";
			String id="";
			String sender="";
			//默认查找自己发送的
			WmNews news = new WmNews();
			User user = UserUtils.getUser();
			String username =user.getLoginName();
			List<WmNews> newslist = new ArrayList<WmNews>();
		//	List<WmNewsReceiver> receiverlist = new ArrayList<WmNewsReceiver>();
			
		
		 //查看详情分页显示
		 if(request.getParameter("id") !="" && request.getParameter("id") != null  ){
			//获取到的messageid 
			/* messageid = request.getParameter("messageid");
			 news.setMessageid(messageid);*/
			 
			news = wmNewsService.get(request.getParameter("id"));
			sender = news.getSender();
				
				//先这样写着 后面需要修改管理员的部分
				if(user.getLoginName().equals(sender) || user.getLoginName().equals("thinkgem")){
					//说明他是发送人 可以查看所有的
					newslist= wmNewsService.findreceivers(news);
				}else{
					//说明他只是接收人，不需要追加table让他查看谁接收了
				}
				
			 
			 }
		 
		 
		 
			//分页设置 
			layuiPage=String.valueOf((Integer.parseInt(layuiPage)-1)*(Integer.parseInt(layuiLimit)));
			//创建wm对象  利用set注入值
			news.setLayuiLimit(layuiLimit);
			news.setLayuiPage(layuiPage);
		
			/*//使用list 讲查到的数据封装  
			List<WmNews> list = wmNewsService.findList(news);*/
			//获取count 数量
			int count=wmNewsService.sumcountdetail(news) ;
			
			//利用Layui工具类 以 data msg code count 的返回方式 返回到前台
			Layui<WmNews> layui = new Layui<WmNews>();
			layui.setCount(count);
			layui.setMsg("");
			layui.setData(newslist);
			layui.setCode(0);
			return JsonMapper.toJsonString(layui);
		 
			
		
		//return "modules/wmnews/wmNewsForm";
	}
	
	
	

	@RequiresPermissions("wmnews:wmNews:view")
	@RequestMapping(value = "form")
	public String form(WmNews wmNews, Model model) {
		model.addAttribute("wmNews", wmNews);
		return "modules/wmnews/wmNewsForm";
	}

	@RequiresPermissions("wmnews:wmNews:view")
	@RequestMapping(value = "form2")
	public String form2(WmNews wmNews, Model model) {
		model.addAttribute("wmNews", wmNews);
		return "modules/wmnews/wmNewsForm2";
	}
	
	@RequiresPermissions("wmnews:wmNews:view")
	@RequestMapping(value = "save")
	@ResponseBody
	public String save(WmNews wmNews, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, wmNews)){
			return form(wmNews, model);
		}
		
		List<WmNews> newslist = new ArrayList<WmNews>();
		List<WmNewsReceiver> newsreceiverlist = new ArrayList<WmNewsReceiver>();
		String content=wmNews.getContent();
		String title = wmNews.getTitle();
	     User userss = UserUtils.getUser();
	    
		//这里 提交的时候 names 获取到的是id  需要把loginname 取出来
		String names =wmNews.getReceivers();
		wmNews.setSender( userss.getLoginName());
	   Map map = new HashedMap();
	    //1.给news表添加一条信息
	    wmNewsService.save(wmNews);
	    //获取到刚新增的news的id
		WmNews ness = wmNewsService.findnews(wmNews);
		
		String id =ness.getId();
	    
		WmNewsReceiver wmNewsReceiver = new WmNewsReceiver();
	    
		if(names.contains(",")){
			//多人发送
			String arr[] = names.split(",");
			for(int i=0;i<arr.length;i++){
				User user = systemService.getUser(arr[i]);
				WmNewsReceiver wmNewsReceiver2 = new WmNewsReceiver();
			    String loginname = user.getLoginName();
			    wmNewsReceiver2.setUser(loginname);
			    wmNewsReceiver2.setStatus("未读");
			    wmNewsReceiver2.setNewsid(id);
			 //   wmNewsReceiver2.setUpdateDate(null);
				    newsReceiverService.save(wmNewsReceiver2);  
				   
			}
		}else{
			//单人发送  
		
		    
		    //2.给receiver表添加一条信息
			User user = systemService.getUser(names);
		    String loginname = user.getLoginName();
		    wmNewsReceiver.setUser(loginname);
		    wmNewsReceiver.setStatus("未读");
		    wmNewsReceiver.setNewsid(id);
		    newsReceiverService.save(wmNewsReceiver);
		   
		    
		}
		 map.put("msg","发送消息成功！");
		addMessage(redirectAttributes, "保存保存&ldquo;通知&rdquo;成功成功");
		return  JsonMapper.toJsonString(map);
	/*	return "redirect:"+Global.getAdminPath()+"/wmnews/wmNews/?repage";*/
	}
	
	@RequiresPermissions("wmnews:wmNews:edit")
	@RequestMapping(value = "delete")
	public String delete(WmNews wmNews, RedirectAttributes redirectAttributes) {
		wmNewsService.delete(wmNews);
		addMessage(redirectAttributes, "删除保存&ldquo;通知&rdquo;成功成功");
		return "redirect:"+Global.getAdminPath()+"/wmnews/wmNews/?repage";
	}
	

	@RequiresPermissions("wmnews:wmNews:view")
	@RequestMapping(value = "viewonedetailopen")
	public String viewonedetailopen(HttpServletRequest request,WmNews wmNews, Model model) {
	//	model.addAttribute("wmTodoItem", wmTodoItem);
	//	String id= 
		String newsssid = request.getParameter("id");
		String messageid = request.getParameter("messageid");
		WmNews news = wmNewsService.getbymessageid(messageid);
		String id = news.getId();
		String sender = news.getSender();
		//查看是不是自己发送的
		User user= UserUtils.getUser();
		String userid =user.getId();
		//判断用户是否是系统管理员
		//List<String> roleid =wmNewsService.findroleid(userid);
		List<String> roleid=	user.getRoleIdList();
		
		
		
		/**
		 * 判断sender是否是自己， 如果是，返回wmNewsdetail 界面
		 * 如果不是， 判断user有没有自己  如果有 返回wmNewsdetailreplay界面 回复
		 * 如果没有 说明是管理员， 直接返回wmNewsdetail
		 */
		
		
		
		
		
		if(user.getLoginName().equals(sender)  ){
			WmNewsReceiver wmNewsReceiver = new WmNewsReceiver();
			wmNewsReceiver.setNewsid(id);
			wmNewsReceiver.setUser(user.getLoginName());
			 wmNewsReceiver = newsReceiverService.findwmnews(wmNewsReceiver);
			
			 if("".equals(wmNewsReceiver) || wmNewsReceiver ==null) {
				 return "modules/wmnews/wmNewsdetail";
			 }else {
				 wmNewsReceiver.setStatus("已读");
				
				 newsReceiverService.updatstatus(wmNewsReceiver);
		//	 newsReceiverService.udpateone(wmNewsReceiver);
			//说明他是发送人 可以查看所有的  然后让他查看
			return "modules/wmnews/wmNewsdetail";
			 }
			
			//待定设置管理员
		}/*else if( roleid.contains("1")){
			//说明他只是接收人设置回复框让他回复消息  以及提交 但是他是管理员
			return "modules/wmnews/wmNewsdetailreplaygly";
		}*/else{
			//需要判断user有没有自己  获取此id 发送的所有人
			/*List<WmNewsReceiver> people = newsReceiverService.finduserlistbynewsid(id );
			//查看people.getuser 是否含有自己
		  List<String> peopleuser = new ArrayList<String>();
			for(int j=0;j<people.size();j++){
				peopleuser.add(people.get(j).getUser());
			}
			
			if(peopleuser.contains(user.getLoginName())){
				//说明user有自己 
				
			}*/
			
			
			WmNewsReceiver wmNewsReceiver = new WmNewsReceiver();
			wmNewsReceiver.setNewsid(id);
			wmNewsReceiver.setUser(user.getLoginName());
			WmNewsReceiver  newsReceiver2 = new WmNewsReceiver();
			
			newsReceiver2 = newsReceiverService.findwmnews(wmNewsReceiver);
			 if("".equals(newsReceiver2) || newsReceiver2 ==null) {
				 return "modules/wmnews/wmNewsdetail";
			 }else{
				 newsReceiver2.setStatus("已读");
				 newsReceiverService.updatstatus(newsReceiver2);
				 //newsReceiverService.udpateone(newsReceiver2);
				 return "modules/wmnews/wmNewsdetailreplay";
			 }
			
			
		}
		
		
		
	}
	
	
	@RequiresPermissions("wmnews:wmNews:view")
	@RequestMapping(value = "detail")
	@ResponseBody
	public String detail(HttpServletRequest request, HttpServletResponse response, Model model) {
	//	model.addAttribute("wmTodoItem", wmTodoItem);
	//	String id= 
		//这里获取的是从表的id
	//	String id = request.getParameter("id");
		String messageid = request.getParameter("messageid");
		WmNews news =wmNewsService.getbymessageid(messageid);
		//WmNews news = wmNewsService.get(id);
		//news.setId(id);
		String zhuid=news.getId();
		User user = UserUtils.getUser();
		String id ="";
		//去找自己的信息进行打开  
		Map map = new HashedMap();
		WmNewsReceiver fffsih = new WmNewsReceiver();
		fffsih.setNewsid(zhuid);
		fffsih.setUser(user.getLoginName());
		WmNewsReceiver wmNewsReceiver = newsReceiverService.findwmnews(fffsih);
		//需要对管理员进行设置
		if("".equals(wmNewsReceiver) || wmNewsReceiver ==null) {
			//说明是管理员进行查看的 
		 }else{
		 id = wmNewsReceiver.getId();
		 map.put("newssid", id);
		String replaycontent = wmNewsReceiver.getReplaycontent();
	    if(replaycontent != null){
	    	news.setReplaycontent(replaycontent);
	    	
	    }else{
	    	map.put("replay","没有回复");
	    }
		 }
		map.put("news", news);
		//查看发送情况
		
		List<WmNews> newslist = new ArrayList<WmNews>();
	//	List<WmNewsReceiver> receiverlist = new ArrayList<WmNewsReceiver>();
		//findslinfo
	//	WmNews  nesss= new WmNews();
		//获取到他的messageid
	
		String sender = news.getSender();
		
		List<String> roleid=	user.getRoleIdList();
		//先这样写着 后面需要修改管理员的部分
		if(user.getLoginName().equals(sender) ||roleid.contains("1")){
			//说明他是发送人 可以查看所有的
			newslist= wmNewsService.findreceivers(news);
		}else{
			//说明他只是接收人，不需要追加table让他查看谁接收了
		}
		
		//判断用户是否是管理员，如果是，可以查看所有的消息内容
	
		
		if(newslist.size()>0){
			//说明已经有人申领了
			map.put("msg", "sender");
			
			map.put("newslist",newslist);
			
		}else{
			map.put("msg","recevier");
		}
		
		
		
		
		
		return JsonMapper.toJsonString(map);
	}
	
	
	
	/**
	 * 默认查找我接收的
	 */
	@RequiresPermissions("wmnews:wmNews:view")
	@RequestMapping(value = {"jieshou", ""})
	@ResponseBody
	public String jieshou( HttpServletRequest request, HttpServletResponse response, Model model) {
		//layui传递参数page 冲突解决方法 获取layui分页page limit参数
		 String layuiPage = request.getParameter("page");
		 String layuiLimit= request.getParameter("limit");
		 
		//排序字段
			String  field = "";
			//排序方式
			String order= "";
			
			String title="";
			String createdate="";
			String type="";
			String messageid="";
			//默认查找自己发送的
			WmNews news = new WmNews();
			User user = UserUtils.getUser();
			String username =user.getLoginName();		 
		 //用于搜索
		 if(request.getParameter("title") !="" && request.getParameter("title") != null  ){
			 title = request.getParameter("title");
			 news.setTitle(title);
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
		news.setStart(starttime.trim());
		news.setEnd(endtime.trim());			
		 }
		
		 news.setUser(username);
		//排序	
		 if(request.getParameter("field") !="" && request.getParameter("field") != null  ){
			 
			 field = request.getParameter("field");
				
			 //item_type
			 if(field.equals("content")){
				 field="content";
			 }else if(field.equals("createDate")){
				 field="create_date";
			 }else if(field.equals("title")){
				 field ="title";
			 }else if(field.equals("sender")){
				 field="sender";
			 }
			  news.setField(field);
			 }
		 
		 //排序方式
		 if(request.getParameter("order") !="" && request.getParameter("order") != null  ){
			 order = request.getParameter("order");
			  news.setOrder(order);
			 }
			
		
		 
		 
		 
			//分页设置 
			layuiPage=String.valueOf((Integer.parseInt(layuiPage)-1)*(Integer.parseInt(layuiLimit)));
			//创建wm对象  利用set注入值
			news.setLayuiLimit(layuiLimit);
			news.setLayuiPage(layuiPage);
		
			//使用list 讲查到的数据封装  
			List<WmNews> list = wmNewsService.findList(news);
			//获取count 数量
			int count=wmNewsService.sumcount(news) ;
			
			//利用Layui工具类 以 data msg code count 的返回方式 返回到前台
			Layui<WmNews> layui = new Layui<WmNews>();
			layui.setCount(count);
			layui.setMsg("");
			layui.setData(list);
			layui.setCode(0);
			return JsonMapper.toJsonString(layui);
		 
			
		
		//return "modules/wmnews/wmNewsForm";
	}
	

}