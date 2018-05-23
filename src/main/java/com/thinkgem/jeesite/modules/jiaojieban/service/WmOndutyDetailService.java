/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jiaojieban.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.Collections3;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.jiaojieban.entity.WmOndutyDetail;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.DownLoadMsgConstant;
import com.thinkgem.jeesite.modules.sys.utils.DownloadUtil;
import com.thinkgem.jeesite.modules.sys.utils.MsgConstant;
import com.thinkgem.jeesite.modules.jiaojieban.dao.WmOndutyDetailDao;

/**
 * 交接班管理Service
 * @author 陈宏
 * @version 2018-04-26
 */
@Service
@Transactional(readOnly = true)
public class WmOndutyDetailService extends CrudService<WmOndutyDetailDao, WmOndutyDetail> {

	public WmOndutyDetail get(String id) {
		return super.get(id);
	}
	
	public List<WmOndutyDetail> findList(WmOndutyDetail wmOndutyDetail) {
		return super.findList(wmOndutyDetail);
	}
	
	public Page<WmOndutyDetail> findPage(Page<WmOndutyDetail> page, WmOndutyDetail wmOndutyDetail) {
		return super.findPage(page, wmOndutyDetail);
	}
	
	@Transactional(readOnly = false)
	public void save(WmOndutyDetail wmOndutyDetail) {
		super.save(wmOndutyDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(WmOndutyDetail wmOndutyDetail) {
		super.delete(wmOndutyDetail);
	}
	public int findWmOndutyDetailCount(){
		return super.findWmOndutyDetailCount();
	}
	@Transactional(readOnly = false)
	public int upDateWmOndutyDetail(WmOndutyDetail wmOndutyDetail){
		return super.upDateWmOndutyDetail(wmOndutyDetail);
	}
	
	public WmOndutyDetail beforeDetailInfo(){
		return super.beforeDetailInfo();
	}
	/**
	 * 打印
	 * @param commentTrans
	 * @return
	 */
	public Map<String, String> download(WmOndutyDetail wmOndutyDetail) {
		//替换模板中字符集
        Map<String, String> map = new HashMap<String, String>(); 

        map.put("${wmDeilTitle}", DownloadUtil.unescapeString("交接班信息表"));
        if(StringUtils.isNotBlank(wmOndutyDetail.getComputerNumber())){
        	map.put("${computerNumber}",DownloadUtil.unescapeString(wmOndutyDetail.getComputerNumber()));
        }else{
        	map.put("${computerNumber}",MsgConstant.NULL);
        }
        if(StringUtils.isNotBlank(wmOndutyDetail.getFaxMachineNumber())){
        	map.put("${faxMachineNumber}",DownloadUtil.unescapeString(wmOndutyDetail.getFaxMachineNumber()));
        }else{
        	map.put("${faxMachineNumber}", MsgConstant.NULL);
        }
        if(StringUtils.isNotBlank(wmOndutyDetail.getKeyNum())){
        	map.put("${keyNum}", DownloadUtil.unescapeString(wmOndutyDetail.getKeyNum()));
        }else{
        	map.put("${keyNum}", MsgConstant.NULL);
        }
        if(StringUtils.isNotBlank(wmOndutyDetail.getZsSysTransStatus())){
        	if("0".equals(wmOndutyDetail.getZsSysTransStatus())){
        		map.put("${zsSysTransStatus}",DownloadUtil.unescapeString("正常"));
        	}else if("1".equals(wmOndutyDetail.getZsSysTransStatus())){
        		map.put("${zsSysTransStatus}",DownloadUtil.unescapeString("不正常"));
        	}
        }else{
        	map.put("${zsSysTransStatus}", MsgConstant.NULL);
        }
        if(StringUtils.isNotBlank(wmOndutyDetail.getZsSysTransStatusRestarTime())){
        	map.put("${zsSysTransStatusRestarTime}",DownloadUtil.unescapeString(wmOndutyDetail.getZsSysTransStatusRestarTime()));
        }else{
        	map.put("${zsSysTransStatusRestarTime}", MsgConstant.NULL);
        }
        if(StringUtils.isNotBlank(wmOndutyDetail.getZhuanWangStatus())){
        	if("0".equals(wmOndutyDetail.getZhuanWangStatus())){
        		map.put("${zhuanWangStatus}",DownloadUtil.unescapeString("正常"));
        	}else if("1".equals(wmOndutyDetail.getZhuanWangStatus())){
        		map.put("${zhuanWangStatus}",DownloadUtil.unescapeString("不正常"));
        	}
        }else{
        	map.put("${zhuanWangStatus}", MsgConstant.NULL);
        }
        if(StringUtils.isNotBlank(wmOndutyDetail.getJiFangSafeStatus())){
        	map.put("${jiFangSafeStatus}", DownloadUtil.unescapeString(wmOndutyDetail.getJiFangSafeStatus()));
        }else{
        	map.put("${jiFangSafeStatus}",MsgConstant.NULL);
        }
        if(StringUtils.isNotBlank(wmOndutyDetail.getLeader())){
        	map.put("${leader}",DownloadUtil.unescapeString(wmOndutyDetail.getLeader()));
        }else{
        	map.put("${leader}",MsgConstant.NULL);
        }
        if(StringUtils.isNotBlank(wmOndutyDetail.getOndutyUser())){
        	map.put("${ondutyUser}",DownloadUtil.unescapeString(wmOndutyDetail.getOndutyUser()));
        }else{
        	map.put("${ondutyUser}",MsgConstant.NULL);
        }
        if(StringUtils.isNotBlank(wmOndutyDetail.getJiaoBanTime())){
        	map.put("${jiaoBanTime}", DownloadUtil.unescapeString(wmOndutyDetail.getJiaoBanTime()));
        }else{
        	map.put("${jiaoBanTime}",MsgConstant.NULL);
        }
        return map;
	}
	
}