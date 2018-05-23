package com.thinkgem.jeesite.common.utils;

import java.util.HashMap;
import java.util.List;



import com.thinkgem.jeesite.modules.item.entity.WmTodoItem;
import com.thinkgem.jeesite.modules.myitems.entity.WmUserItem;

public class Layui<T> {
	
	 private int code;
	 private String msg;
	 private int count;
     private List<T> data;
	
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}
	public List<T> getData() {
		return data;
	}

	public void setData(List<T> data) {
		this.data = data;
	}

	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}

	

}
