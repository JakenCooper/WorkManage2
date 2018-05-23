package com.thinkgem.jeesite.modules.itemattch.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.itemattch.dao.WmTodoItemAttachDao;
import com.thinkgem.jeesite.modules.itemattch.entity.WmTodoItemAttach;

@Service
@Transactional
public class WmTodoItemAttchService extends CrudService<WmTodoItemAttachDao, WmTodoItemAttach> {
	
	public void save(WmTodoItemAttach attch){
		super.save(attch);
	}

}
