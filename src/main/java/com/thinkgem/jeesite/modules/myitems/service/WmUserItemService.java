/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.myitems.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.myitems.entity.WmUserItem;
import com.thinkgem.jeesite.modules.item.dao.WmTodoItemDao;
import com.thinkgem.jeesite.modules.myitems.dao.WmUserItemDao;

/**
 * 我的工作管理Service
 * @author 杨萌
 * @version 2018-04-26
 */
@Service
@Transactional(readOnly = true)
public class WmUserItemService extends CrudService<WmUserItemDao, WmUserItem> {

	@Autowired
	private WmUserItemDao wmUserItemDao;
	public WmUserItem get(String id) {
		return super.get(id);
	}
	
	public List<WmUserItem> findList(WmUserItem wmUserItem) {
		return super.findList(wmUserItem);
	}
	
	public Page<WmUserItem> findPage(Page<WmUserItem> page, WmUserItem wmUserItem) {
		return super.findPage(page, wmUserItem);
	}
	
	@Transactional(readOnly = false)
	public void save(WmUserItem wmUserItem) {
		super.save(wmUserItem);
	}
	
	@Transactional(readOnly = false)
	public void delete(WmUserItem wmUserItem) {
		super.delete(wmUserItem);
	}
	
	public int count(){
		return super.findCount();
	}
	
	public int sumcount(WmUserItem wmUserItem){
		return super.findSumCount(wmUserItem);
	}
	//修改方法
	@Transactional(readOnly = false)
	public void updateone(WmUserItem wmUserItem){
		wmUserItemDao.updateone(wmUserItem);
	}
	
	
	
	public List<WmUserItem> findslinfo(WmUserItem wmUserItem){
		 return  wmUserItemDao.findslinfo(wmUserItem);
		
	}


	
	public WmUserItem findonebyitemidanduser(WmUserItem wmUserItem){
		 return wmUserItemDao.findonebyitemidanduser(wmUserItem);
	}
	
	
	@Transactional(readOnly = false)
	public void updatefinish(WmUserItem wmUserItem){
		wmUserItemDao.updatefinish(wmUserItem);
	}
	
	
}