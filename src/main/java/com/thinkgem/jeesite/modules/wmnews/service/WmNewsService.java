/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.wmnews.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wmnews.entity.WmNews;
import com.thinkgem.jeesite.modules.myitems.dao.WmUserItemDao;
import com.thinkgem.jeesite.modules.myitems.entity.WmUserItem;
import com.thinkgem.jeesite.modules.wmnews.dao.WmNewsDao;

/**
 * 通知管理Service
 * @author 陈宏
 * @version 2018-05-09
 */
@Service
@Transactional(readOnly = true)
public class WmNewsService extends CrudService<WmNewsDao, WmNews> {

	@Autowired
	private WmNewsDao newsDao;
	
	public WmNews get(String id) {
		return super.get(id);
	}
	
	public List<WmNews> findList(WmNews wmNews) {
		return super.findList(wmNews);
	}
	
	public Page<WmNews> findPage(Page<WmNews> page, WmNews wmNews) {
		return super.findPage(page, wmNews);
	}
	
	@Transactional(readOnly = false)
	public void save(WmNews wmNews) {
		super.save(wmNews);
	}
	
	@Transactional(readOnly = false)
	public void delete(WmNews wmNews) {
		super.delete(wmNews);
	}
	
	
	public int sumcount(WmNews wmNews){
		return super.findSumCount(wmNews);
	}
	
	public int sumcountdetail(WmNews wmNews){
		return newsDao.findSumCountdetail(wmNews);
	}

	
	public List<WmNews> findreceivers(WmNews wmNews){
		 return  newsDao.findslinfo(wmNews);
		
	}

	public WmNews findnews(WmNews wmNews){
		 return  newsDao.findnewss(wmNews);
		
	}
	
	
	public List<String> findroleid(String userid){
		 return  newsDao.findroleidbyuserid(userid);
		
	}
	public WmNews getbymessageid(String messageid){
		 return  newsDao.getbymessageid(messageid);
		
	}
	
	
	
	
}