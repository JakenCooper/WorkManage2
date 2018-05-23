/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.wmnewsreceivers.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wmnewsreceivers.entity.WmNewsReceiver;
import com.thinkgem.jeesite.modules.item.dao.WmTodoItemDao;
import com.thinkgem.jeesite.modules.item.entity.WmTodoItem;
import com.thinkgem.jeesite.modules.wmnewsreceivers.dao.WmNewsReceiverDao;

/**
 * 消息接收管理Service
 * @author 杨萌
 * @version 2018-05-10
 */
@Service
@Transactional(readOnly = true)
public class WmNewsReceiverService extends CrudService<WmNewsReceiverDao, WmNewsReceiver> {

	@Autowired
	private WmNewsReceiverDao newsReceiverDao;
	public WmNewsReceiver get(String id) {
		return super.get(id);
	}
	
	public List<WmNewsReceiver> findList(WmNewsReceiver wmNewsReceiver) {
		return super.findList(wmNewsReceiver);
	}
	
	public Page<WmNewsReceiver> findPage(Page<WmNewsReceiver> page, WmNewsReceiver wmNewsReceiver) {
		return super.findPage(page, wmNewsReceiver);
	}
	
	@Transactional(readOnly = false)
	public void save(WmNewsReceiver wmNewsReceiver) {
		super.save(wmNewsReceiver);
	}
	
	@Transactional(readOnly = false)
	public void delete(WmNewsReceiver wmNewsReceiver) {
		super.delete(wmNewsReceiver);
	}
	
	//update方法
	@Transactional(readOnly = false)
	public void udpateone(WmNewsReceiver wmNewsReceiver){
		
		newsReceiverDao.updateone(wmNewsReceiver);
	}
	
	
		@Transactional(readOnly = false)
		public WmNewsReceiver findwmnews(WmNewsReceiver wmNewsReceiver){
			
			return newsReceiverDao.findwmnews(wmNewsReceiver);
		}
	
		
	
				@Transactional(readOnly = false)
				public List<WmNewsReceiver> finduserlistbynewsid(String newsid){
					
					return newsReceiverDao.finduserlistbynewsid(newsid);
				}
			
		//updatez状态方法
		@Transactional(readOnly = false)
	  public void updatstatus(WmNewsReceiver wmNewsReceiver){
					
		newsReceiverDao.updatstatus(wmNewsReceiver);
		}
		
		@Transactional(readOnly = false)
		  public int tochecknumfind(WmNewsReceiver wmNewsReceiver){
						
		return 	newsReceiverDao.readornot(wmNewsReceiver);
			}
		
		
				
}