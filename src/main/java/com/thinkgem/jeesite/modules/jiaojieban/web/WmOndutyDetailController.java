/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jiaojieban.web;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.modules.duty.entity.WmOnduty;
import com.thinkgem.jeesite.modules.duty.service.WmOndutyService;
import com.thinkgem.jeesite.modules.duty.util.Layui;
import com.thinkgem.jeesite.modules.jiaojieban.entity.WmOndutyDetail;
import com.thinkgem.jeesite.modules.jiaojieban.service.WmOndutyDetailService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DownLoadMsgConstant;
import com.thinkgem.jeesite.modules.sys.utils.DownloadUtil;
import com.thinkgem.jeesite.modules.sys.utils.MsgConstant;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.sys.utils.WordPOIUtil;


/**
 * 交接班管理Controller
 * @author 陈宏
 * @version 2018-04-26
 */
@Controller
@RequestMapping(value = "${adminPath}/jiaojieban/wmOndutyDetail")
public class WmOndutyDetailController extends BaseController {

	@Autowired
	private WmOndutyDetailService wmOndutyDetailService;
	
	@ModelAttribute
	public WmOndutyDetail get(@RequestParam(required=false) String id) {
		WmOndutyDetail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wmOndutyDetailService.get(id);
		}
		if (entity == null){
			entity = new WmOndutyDetail();
		}
		return entity;
	}
	
	@RequiresPermissions("jiaojieban:wmOndutyDetail:view")
	@RequestMapping(value = {"list", ""})
	@ResponseBody
	public String list(HttpServletRequest request, HttpServletResponse response, Model model,String jiaoBanTime) {
		//接收分页参数
		String layuiPage=request.getParameter("page");
		String layuiLimit=request.getParameter("limit");
		//接收表头排序参数 field排序字段,order排序方式
		String field=request.getParameter("field");
		String order=request.getParameter("order");
		//通过key获取layui的查询参数
		String search_time=request.getParameter("search_time");
		layuiPage=String.valueOf((Integer.parseInt(layuiPage)-1)*(Integer.parseInt(layuiLimit)));
		int count=wmOndutyDetailService.findWmOndutyDetailCount();
		WmOndutyDetail wmOndutyDetail=new WmOndutyDetail();
		//设置排序参数
		if(field!=null & field!=""){
			wmOndutyDetail.setField(field);
		}
		if(order!=null & order!=""){
			wmOndutyDetail.setOrder(order);
		}
		
		//新增  需要做权限判断  管理员不设置   
		User user = UserUtils.getUser();
		
		String userid =user.getId();
		//判断用户是否是系统管理员
		//List<String> roleid =wmNewsService.findroleid(userid);
		List<String> roleid=	user.getRoleIdList();
		if( roleid.contains("1")){
			
		}else{
		wmOndutyDetail.setOndutyUser(user.getLoginName());
		}
		wmOndutyDetail.setLayuiLimit(layuiLimit);
		wmOndutyDetail.setLayuiPage(layuiPage);
		wmOndutyDetail.setJiaoBanTime(jiaoBanTime);
		//如果查询参数有值则设置查询条件
		if(search_time!=null && search_time.length()>0){
			wmOndutyDetail.setZhiBanTime(search_time);
		}
		List<WmOndutyDetail> list=wmOndutyDetailService.findList(wmOndutyDetail);
		//转换成layui需要的json格式数据
		Layui<WmOndutyDetail> layui=new Layui<WmOndutyDetail>();
		layui.setCode(0);
		layui.setMsg("");
		layui.setCount(count);
		layui.setData(list);
		return JsonMapper.toJsonString(layui);
	}

	@RequiresPermissions("jiaojieban:wmOndutyDetail:view")
	@RequestMapping(value = "form")
	public String form(WmOndutyDetail wmOndutyDetail, Model model) {
		model.addAttribute("wmOndutyDetail", wmOndutyDetail);
		return "modules/jiaoJieBan/jiaoJieBanForm";
	}

	@RequiresPermissions("jiaojieban:wmOndutyDetail:edit")
	@RequestMapping(value = "save")
	public String save(WmOndutyDetail wmOndutyDetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, wmOndutyDetail)){
			return form(wmOndutyDetail, model);
		}
		try {
			wmOndutyDetailService.save(wmOndutyDetail);
			model.addAttribute("message", "交班成功");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "交班失败");
		}
		
		return "modules/jiaoJieBan/jiaoJieBanForm";
	}
	
	@RequiresPermissions("jiaojieban:wmOndutyDetail:edit")
	@RequestMapping(value = "delete")
	public String delete(WmOndutyDetail wmOndutyDetail, RedirectAttributes redirectAttributes) {
		wmOndutyDetailService.delete(wmOndutyDetail);
		addMessage(redirectAttributes, "删除保存&ldquo;交接班&rdquo;成功成功");
		return "redirect:"+Global.getAdminPath()+"/jiaojieban/wmOndutyDetail/?repage";
	}
	@RequiresPermissions("jiaojieban:wmOndutyDetail:view")
	@RequestMapping(value="findWmOndutyDetailById")
	@ResponseBody
	public String findWmOndutyDetailById(@RequestParam(value = "id",required = false)String id,Model model){
		WmOndutyDetail wmOndutyDetail=wmOndutyDetailService.get(id);
		model.addAttribute("wmOndutyDetail", wmOndutyDetail);
		return JsonMapper.toJsonString(wmOndutyDetail);
	}
	@RequiresPermissions("jiaojieban:wmOndutyDetail:view")
	@RequestMapping(value="beforeDetailInfo")
	@ResponseBody
	public String beforeDetailInfo(Model model){
		WmOndutyDetail wmOndutyDetail=wmOndutyDetailService.beforeDetailInfo();
		model.addAttribute("wmOndutyDetail", wmOndutyDetail);
		return JsonMapper.toJsonString(wmOndutyDetail);
	}
	
	
	@RequiresPermissions("duty:wmOnduty:view")
    @RequestMapping(value = "exportFile", method=RequestMethod.POST)
    public String exportFile(WmOndutyDetail wmOndutyDetail, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "日志"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<WmOndutyDetail> page = wmOndutyDetailService.findPage(new Page<WmOndutyDetail>(request, response, -1), wmOndutyDetail);
    		new ExportExcel("日志", WmOndutyDetail.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出日志数据失败！失败信息："+e.getMessage());
		}
		return "modules/dutyLog/dutyLogList";
    }
	@RequiresPermissions("duty:wmOnduty:view")
	@RequestMapping(value="downLoad")
	public void downLoad(WmOndutyDetail wmOndutyDetail,HttpServletRequest request, HttpServletResponse response) {
		try {
			String template_type=request.getParameter("type");
			String fileName = ""; // 文件的默认保存名
			String path = DownloadUtil.getTemplatePath(
					DownLoadMsgConstant.jiaoJieBan_print.get("1"))+".doc";
			String suffix = path.substring(path.lastIndexOf(DownLoadMsgConstant.DOT));
			String title = "交接班信息表";
			if(MsgConstant.NULL.equals(title)){
				title = DownLoadMsgConstant.NULLFILENAME;
			}
			fileName = title + suffix;
			if (request.getHeader("User-Agent").toLowerCase().indexOf("firefox") > 0)
			{
				fileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1");//firefox浏览器
			}
			else
			{
				//fileName = URLEncoder.encode(fileName, "UTF-8");//IE浏览器、360、谷歌
				fileName = new String(fileName.getBytes("GBK"), "ISO8859-1");
			}
			// 清空response
			response.reset();
			// 设置response
			response.setContentType("application/x-msdownload");
			response.addHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
			Map<String, String> map  = wmOndutyDetailService.download(wmOndutyDetail);
			WordPOIUtil.replaceAndDownloadWord(path, map, response.getOutputStream());
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}