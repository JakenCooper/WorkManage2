/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.duty.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.duty.entity.WmOnduty;
import com.thinkgem.jeesite.modules.duty.dao.WmOndutyDao;

/**
 * 在线排班管理Service
 * @author 陈宏
 * @version 2018-04-24
 */
@Service
@Transactional(readOnly = true)
public class WmOndutyService extends CrudService<WmOndutyDao, WmOnduty> {

	public WmOnduty get(String id) {
		return super.get(id);
	}
	
	public List<WmOnduty> findList(WmOnduty wmOnduty) {
		return super.findList(wmOnduty);
	}
	
	public Page<WmOnduty> findPage(Page<WmOnduty> page, WmOnduty wmOnduty) {
		return super.findPage(page, wmOnduty);
	}
	
	@Transactional(readOnly = false)
	public void save(WmOnduty wmOnduty) {
		//设置处室交接状态为未接班
		wmOnduty.setChangeStatus("未接班");
		super.save(wmOnduty);
	}
	
	@Transactional(readOnly = false)
	public void delete(WmOnduty wmOnduty) {
		super.delete(wmOnduty);
	}
	
	public int countWmOnduty(){
		return super.findWmOndutyCount();
	}
	@Transactional(readOnly = false)
	public int updateWmOnduty(WmOnduty wmOnduty){
		return super.updateWmOnduty(wmOnduty);
	}
	
	
}