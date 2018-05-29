/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.duty.web;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.modules.duty.entity.WmOnduty;
import com.thinkgem.jeesite.modules.duty.service.WmOndutyService;
import com.thinkgem.jeesite.modules.duty.util.Layui;
import com.thinkgem.jeesite.modules.jiaojieban.entity.WmOndutyDetail;
import com.thinkgem.jeesite.modules.jiaojieban.service.WmOndutyDetailService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 在线排班管理Controller
 * @author 陈宏
 * @version 2018-04-24
 */
@Controller
@RequestMapping(value = "${adminPath}/duty/wmOnduty")
public class WmOndutyController extends BaseController {

	@Autowired
	private WmOndutyService wmOndutyService;
	@Autowired
	private WmOndutyDetailService wmOndutyDetailService;
	@Autowired
	private SystemService systemService;
	
	@ModelAttribute
	public WmOnduty get(@RequestParam(required=false) String id) {
		WmOnduty entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wmOndutyService.get(id);
		}
		if (entity == null){
			entity = new WmOnduty();
		}
		return entity;
	}
	/*
	 * 查询排班列表
	 * 
	 * */
	@RequiresPermissions("duty:wmOnduty:view")
	@RequestMapping(value = {"list", ""})
	@ResponseBody
	public String list(HttpServletRequest request, HttpServletResponse response, Model model) {
		//接收分页参数
		String layuiPage=request.getParameter("page");
		String layuiLimit=request.getParameter("limit");
		layuiPage=String.valueOf((Integer.parseInt(layuiPage)-1)*(Integer.parseInt(layuiLimit)));
		int countWmOnduty=wmOndutyService.countWmOnduty();
		//接收表头排序参数 field排序字段,order排序方式
		String field=request.getParameter("field");
		String order=request.getParameter("order");
		
		WmOnduty wmOnduty=new WmOnduty();
		wmOnduty.setLayuiPage(layuiPage);
		wmOnduty.setLayuiLimit(String.valueOf(layuiLimit));
		wmOnduty.setField(field);
		wmOnduty.setOrder(order);
		List<WmOnduty> wmOndutiesList=wmOndutyService.findList(wmOnduty);
		//Layui data =Layui.data(wmOndutiesList.size(), wmOndutiesList);
		//request.setAttribute("countWmOnduty", countWmOnduty);
		//System.out.println(data);
		Layui<WmOnduty> layui=new Layui<WmOnduty>();
		layui.setCode(0);
		layui.setMsg("");
		layui.setCount(countWmOnduty);
		layui.setData(wmOndutiesList);
		
		return JsonMapper.toJsonString(layui);
	}
	
	@RequiresPermissions("duty:wmOnduty:view")
	@RequestMapping(value="countWmOnduty")
	public ModelMap countWmOnduty(ModelMap modelMap){
		modelMap.put("countWmOnduty", wmOndutyService.countWmOnduty());
		return modelMap;
	}
	@RequiresPermissions("duty:wmOnduty:view")
	@RequestMapping(value = "form")
	public String form(WmOnduty wmOnduty, Model model) {
		model.addAttribute("wmOnduty", wmOnduty);
		return "modules/duty/wmOndutyList";
	}
	
	@RequiresPermissions("duty:wmOnduty:view")
	@RequestMapping(value="addWmonDutyForm")
	public String addWmonDutyForm(){
		return "modules/duty/addWmOndutyForm";
	}
	

	@RequiresPermissions("duty:wmOnduty:edit")
	@RequestMapping(value = "save")
	@ResponseBody
	public String save(WmOnduty wmOnduty,User user, Model model, RedirectAttributes redirectAttributes,WmOndutyDetail wmOndutyDetail) {
		if (!beanValidator(model, wmOnduty)){
			return form(wmOnduty, model);
		}
		Map<String, Object>map=new HashMap<String, Object>();
		try {
			//获取值班人登录名
			User ondutyUser=systemService.getUser(wmOnduty.getOndutyUser());
			//获取接班人登录名
			//User changeUser=systemService.getUser(wmOnduty.getChangeUser());
			//获取领导登录名
			User leader=systemService.getUser(wmOnduty.getLeader());
			
			wmOnduty.setOndutyUser(ondutyUser.getLoginName());
			//wmOnduty.setChangeUser(changeUser.getLoginName());
			wmOnduty.setLeader(leader.getLoginName());
			wmOnduty.setChangeStatus("未接班");
			wmOndutyService.save(wmOnduty);
			map.put("msg", "排班成功");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("msg", "排班失败");
		}
		return JsonMapper.toJsonString(map);
	}
	
	@RequiresPermissions("duty:wmOnduty:edit")
	@RequestMapping(value = "delete")
	@ResponseBody
	public String delete(WmOnduty wmOnduty, RedirectAttributes redirectAttributes) {
		Map<String, Object> map=new HashMap<String, Object>();
		try {
			wmOndutyService.delete(wmOnduty);
			map.put("msg","删除排班信息成功");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg","删除排班信息失败请联系管理员");
		}
		return JsonMapper.toJsonString(map);
	}
	
	/*
	 * 导出排班模板
	 * */
   @RequiresPermissions("duty:wmOnduty:edit")
   @RequestMapping(value = "exportFileTemplate")
   public String exportFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
	        String fileName = "在线排班模板.xlsx";
	   		List<WmOnduty> list = Lists.newArrayList(); //list.add(UserUtils.getUser());
	   		
	   		new ExportExcel("值班人数据", WmOnduty.class, 2).setDataList(list).write(response, fileName).dispose();
	   		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:" + adminPath + "/duty/wmOnduty/list";
   }
	/*
	 * 导入排班表
	 * */
	@RequiresPermissions("duty:wmOnduty:edit")
    @RequestMapping(value = "importFile", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes,Model model) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/duty/wmOnduty/list";
		}
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<WmOnduty> list = ei.getDataList(WmOnduty.class);
			for (WmOnduty wmOnduty : list){
				try{
					wmOndutyService.save(wmOnduty);
					successNum++;
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
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条用户，导入信息如下：");
			}
			//addMessage(redirectAttributes, "已成功导入 "+successNum+" 条用户"+failureMsg);
			model.addAttribute("message","已成功导入 "+successNum+" 条排班信息"+failureMsg);
		} catch (Exception e) {
			//addMessage(redirectAttributes, "导入用户失败！失败信息："+e.getMessage());
			model.addAttribute("message", "导入用户失败！失败信息："+e.getMessage());
		}
		return "modules/duty/wmOndutyList";
    }
	/*
	 * 导出排班表
	 * */
    @RequestMapping(value = "exportFile", method=RequestMethod.POST)
    public String exportFile(WmOnduty wmOnduty, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "在线排班数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
//            Page<WmOnduty> page = wmOndutyService.findPage(new Page<WmOnduty>(request, response, -1), wmOnduty);
            WmOnduty duty1=new WmOnduty();
    		duty1.setWmDesc("desc1");
    		duty1.setDate("2018-05-24");
    		duty1.setOndutyUser("zhangys");
    		duty1.setLeader("jingli");
    		WmOnduty duty2=new WmOnduty();
    		duty2.setWmDesc("desc1");
    		duty2.setDate("2018-05-24");
    		duty2.setOndutyUser("zhangys");
    		duty2.setLeader("jingli");
    		List<WmOnduty> dutyList=new ArrayList<WmOnduty>();
    		Collections.addAll(dutyList, duty1,duty2);
    		new ExportExcel("在线排班数据", WmOnduty.class).setDataList(dutyList).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出排班数据失败！失败信息："+e.getMessage());
		}
		return "modules/duty/wmOndutyList";
    }
	
	@RequiresPermissions("duty:wmOnduty:edit")
	@RequestMapping(value="addWmOnduty")
	public String addWmOnduty(){
		return "modules/duty/addWmOndutyForm";
	}
	
	@RequiresPermissions("duty:wmOnduty:view")
	@RequestMapping(value="dutyLogForm")
	public String dutyLogForm(){
		return "modules/dutyLog/dutyLogList";
		
	}
	@RequiresPermissions("duty:wmOnduty:view")
	@RequestMapping(value="findDutyLogForm")
	public String findDutyLogForm(){	
		return "modules/jiaoJieBan/jiaoJieBanForm";
	}	
	//登陆时首次加载弹出交班信息表
	@RequiresPermissions("duty:wmOnduty:view")
	@RequestMapping(value="firstJiaoJiebanFrom")
	public String firstJiaoJiebanFrom(Model model){
	
		return "modules/jiaoJieBan/firstJiaoJiebanFrom";
	}
	
	@RequiresPermissions("duty:wmOnduty:edit")
	@RequestMapping(value="jieBan")
	public String jieBan(Model model,WmOnduty wmOnduty,WmOndutyDetail wmOndutyDetail){
		Date date=new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		//获取系统年月
		String str_date=formatter.format(date);
		wmOnduty.setOndutyUser(UserUtils.getUser().getLoginName());
		wmOnduty.setDate(str_date);
		wmOnduty.setRealOndutyUser(UserUtils.getUser().getName());
		wmOnduty.setChangeStatus("接班成功");
		
		int count=wmOndutyService.updateWmOnduty(wmOnduty);
		if(count!=0){
			model.addAttribute("message", "接班成功");
		}else{
			model.addAttribute("message", "接班失败请联系管理员");
		}
		return "modules/jiaoJieBan/firstJiaoJiebanFrom";
	}
	
	@RequiresPermissions("duty:wmOnduty:edit")
	@RequestMapping(value="jiaoBan")
	public String jiaoBan(Model model,WmOndutyDetail wmOndutyDetail){
		Date date=new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String str_date=formatter.format(date);
		wmOndutyDetail.setZhiBanTime(str_date);
		wmOndutyDetailService.save(wmOndutyDetail);
		model.addAttribute("message", "交班成功");
		return "modules/jiaoJieBan/jiaoJieBanForm";
	}
	
	
	/*
	 * 判断是否有接班,若已接班则不弹出接班请求
	 * */
	@RequiresPermissions("duty:wmOnduty:view")
	@RequestMapping(value="findWmOndutyByStatus")
	@ResponseBody
	public String findWmOndutyByStatus(WmOnduty wmOnduty){
		Map<String,Object> map=new HashMap<String, Object>();
		Date date=new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String str_date=formatter.format(date);
		wmOnduty.setOndutyUser(UserUtils.getUser().getLoginName());
		wmOnduty.setDate(str_date);
		String changeStatus = "";
		if(wmOndutyService.findWmOndutyByStatus(wmOnduty)!=null){
			 changeStatus=wmOndutyService.findWmOndutyByStatus(wmOnduty).getChangeStatus();
		}
		//changeStatus 0 还未接班, 1已经接班
		if("接班成功".equals(changeStatus)){
			map.put("changeStatus",1);
		}else if("未接班".equals(changeStatus)){
			map.put("changeStatus",0);
		}
		return JsonMapper.toJsonString(map);
	}
	/*
	 * 批量删除
	 * */
	@RequiresPermissions("duty:wmOnduty:edit")
	@RequestMapping(value="delMoreWmondutyInfo", method = RequestMethod.POST) 
	@ResponseBody
	public String delMoreWmondutyInfo(@RequestParam(value = "ids") String ids,WmOnduty wmOnduty){
		String[] ids_2=ids.split(",");
		Map<String,Object> map=new HashMap<String, Object>();
		int success=0;
		int field=0;
		if(ids_2.length>0){
			for (int i = 0; i < ids_2.length; i++) {
				wmOnduty.setId(ids_2[i]);
				wmOndutyService.delete(wmOnduty);
				success++;
			}
		}else{
			field++;
		}
		map.put("msg", "成功删除"+success+"条数据"+",失败"+field+"条数据");
		return JsonMapper.toJsonString(map);
	}
	
}