/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.item.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.item.entity.WmTodoItem;
import com.thinkgem.jeesite.modules.itemattch.dao.WmTodoItemAttachDao;
import com.thinkgem.jeesite.modules.itemattch.entity.WmTodoItemAttach;
import com.thinkgem.jeesite.modules.item.dao.WmTodoItemDao;

/**
 * 待办事项管理Service
 * @author 杨萌
 * @version 2018-04-23
 */
@Service
@Transactional(readOnly = true)
public class WmTodoItemService extends CrudService<WmTodoItemDao, WmTodoItem> {
	@Autowired
	private WmTodoItemDao wmTodoItemDao;
	
	
	public WmTodoItem get(String id) {
		return super.get(id);
	}
	
	public List<WmTodoItem> findList(WmTodoItem wmTodoItem) {
		
		return super.findList(wmTodoItem);
	}
	
	public Page<WmTodoItem> findPage(Page<WmTodoItem> page, WmTodoItem wmTodoItem) {
		return super.findPage(page, wmTodoItem);
	}
	
	@Transactional(readOnly = false)
	public void save(WmTodoItem wmTodoItem) {
		super.save(wmTodoItem);
	}
	
	@Transactional(readOnly = false)
	public void delete(WmTodoItem wmTodoItem) {
		super.delete(wmTodoItem);
	}
	
	
	@Transactional(readOnly = false)
	public void deletemore(List<String> list) {
		//super.delete(wmTodoItem);
		if(list.size()==1){
			WmTodoItem wmTodoItem = new WmTodoItem();
			wmTodoItem.setId(list.get(0));
			super.delete(wmTodoItem);
		}else{
			wmTodoItemDao.deletemore(list);
		}
		
	}
	
	
	

	@Transactional(readOnly = false)
	public int count(WmTodoItem wmTodoItem){
		return super.sumcounttodoitem(wmTodoItem);
	}
	
	//update方法
	@Transactional(readOnly = false)
	public void udpateone(WmTodoItem wmTodoItem){
		
		 wmTodoItemDao.updateone(wmTodoItem);
	}
	
	
	//content是否重复
	
	@Transactional(readOnly = false)
	public int checkcontent(WmTodoItem wmTodoItem){
		
		return  wmTodoItemDao.checkwmcontent(wmTodoItem);
	}
}