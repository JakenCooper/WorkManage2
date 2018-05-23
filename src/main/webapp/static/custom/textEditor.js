/**
 * 正文编辑,查看正文
 * 
 * type：0，word；1，excel；2，富文本；3，ofd文件/pdf文件（仅查看）；4，gw文件
 * butType：1，编辑；2，再次编辑；3，查看；4，添加模板时按钮
 * path：正文地址(控件ID)
 * cacheAddr:缓存地址(控件ID)
 * content：富文本内容(控件ID)
 * DocStorePath：文件存储服务器地址
 */
function operDoc(type,butType,path,cacheAddr,content,ctx,contextPath,DocStorePath){
	//打开webOffice地址
	var url = '';
	//操作的按钮
	var button ='';
	var title = "正文编辑";
	if(type=="0" || type=="1" || type=="2" || type=="3"){
		if(type=="0"){
			url="iframe:"+contextPath+"/weboffice1.jsp?fileTypes="+type+"&cacheAddr="+$('#'+cacheAddr).val()+"&filePath="+$('#'+path).val();
			if(butType=="1"){
				button = {"保存":"ok1","导入模板":"load","另存为模板":"saveAs","关闭":true};
			}else if(butType=="2"){
				if(!isExists(ctx,DocStorePath,$('#'+path).val())){return}
				button = {"保存":"ok1","关闭":true};
			}else if(butType=="3"){
				if(!isExists(ctx,DocStorePath,$('#'+path).val())){return}
				button = {"关闭":true};
			}else if(butType=="4"){
				button = {"保存":"ok1","关闭":true};
			}
		}
		else if(type=="1"){
			url="iframe:"+contextPath+"/weboffice1.jsp?fileTypes="+type+"&cacheAddr="+$('#'+cacheAddr).val()+"&filePath="+$('#'+path).val();
			if(butType=="1"){
				button = {"保存":"ok2","导入模板":"load","另存为模板":"saveAs","关闭":true};
			}else if(butType=="2"){
				if(!isExists(ctx,DocStorePath,$('#'+path).val())){return}
				button = {"保存":"ok2","关闭":true};
			}else if(butType=="3"){
				if(!isExists(ctx,DocStorePath,$('#'+path).val())){return}
				button = {"关闭":true};
			}else if(butType=="4"){
				button = {"保存":"ok2","关闭":true};
			}
		}
		else if(type=="2"){
			url="iframe:"+ctx+"/secret/secs/oaSecretSendFile/edit?content="+$('#'+content).val();
			if(butType=="1"){
				button = {"保存":"ok3","关闭":true};
			}else if(butType=="2"){
				button = {"保存":"ok3","关闭":true};
			}else if(butType=="3"){
				button = {"关闭":true};
			}
		}
		else if(type=="3"){
			title = "正文查看";
			url="iframe:"+contextPath+"/ofdReader.jsp?filePath="+$('#'+path).val()+"&ctx="+ctx;
			if(!isExists(ctx,DocStorePath,$('#'+path).val())){return}
			button = {"关闭":true};
		}
		top.$.jBox(
			url, 
			{
	        title: title,
	        top:0,
	        showClose: true,  //是否显示窗口右上角的关闭按钮 
	        draggable: false,  //是否可以拖动窗口 
	        dragLimit: false,  //在可以拖动窗口的情况下，是否限制在可视范围 
	        dragClone: false,  //在可以拖动窗口的情况下，鼠标按下时窗口是否克隆窗口 
	        persistent: true,  //在显示隔离层的情况下，点击隔离层时，是否坚持窗口不关闭
	        width: $(top.document).width(),
	        height: $(top.document).height()-10,
	        buttons:button,
			submit:function(v, h, f){
				if (v=="ok1"){
				 	//保存word
					var returnValue = h.find("iframe")[0].contentWindow.saveFile();
					if(returnValue!=null&&returnValue.length>0){
						var jsonobj = eval('('+returnValue+')');
						//保存word文件
						if(jsonobj.value.length!=null||jsonobj.value.length>0||jsonobj.value.length=="underfind"){
							updateFilePath(jsonobj.value[0].fileUrl,0,jsonobj.value[0].fileRealUrl,jsonobj.value[0].wordsCount);
						//更新word文件
						}else{
							updateFilePath("",0,"",jsonobj.value.wordsCount);
						}
						return true;
					}
					return false;
				 } else if (v=="ok2"){
					//保存excel
					var returnValue = h.find("iframe")[0].contentWindow.saveFile();
					if(returnValue!=null&&returnValue.length>0){
						var jsonobj = eval('('+returnValue+')');
						//保存Excel
						if(jsonobj.value.length!=null||jsonobj.value.length>0||jsonobj.value.length=="underfind"){
							updateFilePath(jsonobj.value[0].fileUrl,1,jsonobj.value[0].fileRealUrl,0);
						//更新Excel
						}else{
							updateFilePath("",1,"",0);
						}
						return true;
					}
					return false;
		         } else if (v=="ok3"){
					//保存富文本
					var returnValue = h.find("iframe")[0].contentWindow.getComtents();
					if(returnValue!=null&&returnValue.length>0){
						updateFileContent(returnValue,2);
						return true;
					}
					return false;
		         } else if (v=="load"){
					h.find("iframe")[0].contentWindow.loadTempalate();
					return false;
		         } else if (v=="saveAs"){
					h.find("iframe")[0].contentWindow.saveTemplate();
					return false;
		         }
			}, 
			loaded:function(h){
				$(".jbox-content", top.document).css("overflow-y","hidden");
				if(type=="2"){
					h.find("iframe")[0].contentWindow.saveContent($('#'+content).val());
				}
			}
		}
	);
	
		/*top.$.jBox.open(
			url, 
			"正文编辑", 
			$(top.document).width(),
			$(top.document).height()-200, 
			{
				buttons:button,
				bottomText:"正在编辑正文...", 
				submit:function(v, h, f){
					if (v=="ok1"){
					 	//保存word
						var returnValue = h.find("iframe")[0].contentWindow.saveFile();
						if(returnValue!=null&&returnValue.length>0){
							var jsonobj = eval('('+returnValue+')');
							updateFilePath(jsonobj.value[0].fileUrl,0,jsonobj.value[0].fileRealUrl,jsonobj.value[0].wordsCount);
						}
						return true;
					 } else if (v=="ok2"){
						//保存excel
						var returnValue = h.find("iframe")[0].contentWindow.saveFile();
						if(returnValue!=null&&returnValue.length>0){
							var jsonobj = eval('('+returnValue+')');
							updateFilePath(jsonobj.value[0].fileUrl,1,jsonobj.value[0].fileRealUrl,0);
						}
						return true;
			         } else if (v=="ok3"){
						//保存富文本
						var returnValue = h.find("iframe")[0].contentWindow.getComtents();
						if(returnValue!=null&&returnValue.length>0){
							updateFileContent(returnValue,2);
						}
						return true;
			         } else if (v=="load"){
						h.find("iframe")[0].contentWindow.loadTempalate();
						return false;
			         } else if (v=="saveAs"){
						h.find("iframe")[0].contentWindow.saveTemplate();
						return false;
			         }
				}, 
				loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			}
		);*/
	}else if(type == "4"){
		alert("文件类型不支持在线编辑或浏览。")
	}else{
		alert("未添加正文！");
	}
}

/**
 * 文件是否存在
 * @param DocStorePath 文件存储服务器路径
 * @param path 文件网络地址
 */
function isExists(ctx,DocStorePath,path){
	//是否存在，默认不存在
	var isok=false;
	//获取token
	var token=getToken(ctx);
	//判断文件存储服务器，此文件是否存在
	$.ajax({
		type:"POST",
		url: DocStorePath + "upload/isExists.do?path="+path+"&token="+token,
		cache: false,
		async: false,
		success: function(date) {
			var obj = eval('(' + date + ')');
			if (obj.status == 0) {
				isok=true;
			}else{
				alert(obj.msg);
				isok=false;
			}
		}
	}); 
	return isok;
}

/**
 * 获取token
 * @param ctx请求路径
 * @returns {String}
 */
function getToken(ctx){
	var token="";
	 $.ajax({
		type:"POST",
		url: ctx+"/getToken",
		async: false,
		cache: false,
		success: function(msg) {
			var obj = eval('(' + msg + ')');
			if(obj.status == '0'){
				token=obj.value;
			} else{
				alert("文件保存失败");
				token= null;
			}
		},
		error:function () {
			alert("请求失败！");
			token= null;
		}
	}); 
	 return token;
}


/**
 * 正文是否编辑过多种文件
 * @param cacheAddr 缓存地址
 * @param textContent 富文本地址
 * @param textType 正文类型
 * @returns {Boolean}
 */
function editFileNum(cacheAddr,textContent){
	//是否编辑过多种文件,默认为否
	var flag=false;
	//得到缓存地址和富文本内容
	var cacheAdds=$('#'+cacheAddr).val();
	var textContents=$('#'+textContent).val();
	//文件的数量
	var addrNums=0;
	if(cacheAdds!=''||cacheAdds.length>0){
		++addrNums;
		cacheAdds.indexOf(",")>=0 ? ++addrNums : addrNums;
	}
	
	textContents!=''||textContents.length>0 ? ++addrNums : addrNums;
	addrNums>1 ? flag= true : flag= false;
	return flag;
}
/**
 * 获取正文类型
 * @param textType
 * @returns {String}
 */
function editFileType(textType){
	//最后选择的正文类型
	var selectFileType=$('#'+textType).val();
	switch (selectFileType) {
	case "0":
		selectFileType="Word";
		break;
	case "1":
		selectFileType="Excel";
		break;
	case "2":
		selectFileType="富文本";
		break;
	default:
		selectFileType="未知";
		break;
	}
	return selectFileType;
}

/**
 * 提交时是否提示正文类型
 * @param flag 携带请求类型参数，
 * @param cacheAddr 缓存地址，
 * @param textContent 文件内容，
 * @param textType 正文类型，
 * @param action 请求地址
 */
function submitType(flag,cacheAddr,textContent,textType,action){
	//如果编辑过多种文件则获取最后一次编辑保存过的文件类型，提示！
	if(editFileNum(cacheAddr,textContent)){
		var selectFileType=editFileType(textType);
		top.$.jBox.confirm("您确定要提交"+selectFileType+"类型正文吗？", "提示", function(v, h, f){
			if(v == 'ok'){
				submit(flag,action);
			}else{
				return;
			}
		});
	}else{
		submit(flag,action);
	}
}


/**
 * 清空缓存记录
 * @param textType 文件类型，
 * @param textContent 富文本内容，
 * @param textAddr 文件网络地址，
 * @param textRealurl 文件真实地址，
 * @param wordsCount 字数
 */
function emptyCacheAddr(textType,textContent,textAddr,textRealurl,wordsCount){
	//最后选择的正文类型
	var selectFileType=$('#'+textType).val();
	switch (selectFileType) {
	case "0":
		$('#'+textContent).val("");
		break;
	case "1":
		$('#'+textContent).val("");
		$('#'+wordsCount).val(0);
		break;
	case "2":
		$('#'+textAddr).val("");
		$('#'+textRealurl).val("");
		$('#'+wordsCount).val(0);
		break;
	default:
		break;
	}
}

/**
 * 下载查看附件
 * @param ctx 获取token路径
 * @param path 需要下载查看的文件地址
 */
function downloadFile(ctx, path){
	if(path == null || path.trim() == ""){
		alertx("文件不存在，无法下载和打开。");
		return;
	}
	//获取token
	var token = getToken(ctx);
	$.ajax({
		type: "POST",
		url: DocStorePath+"upload/isExists.do",
		data: {path:path, token:token},
		cache: false,
		async: false,
		success: function(res) {
			var data = eval('('+res+')');
			if (data.status == 0) {
				window.open(path+"?token="+token);
			}else{
				alertx("文件不存在，无法下载和打开。");
			}
		},
		error:function () {
			alertx("请求失败，请稍后再试。");
		}
	});
}
	/*var ext = path.substring(path.lastIndexOf(".") + 1).toLowerCase();
	// check文件后缀名是否支持打开
	if(extIsSupportOpen(ext)){
		top.$.jBox("iframe:"+ctx+"/act/task/readFile?path="+path, {
			title: "浏览文件",
			width: document.body.clientWidth,
			height: document.documentElement.clientHeight-1,
			buttons: {'关闭': true},
			persistent: true,
			draggable: false,
			top: '7%',
			loaded:function(h){
				$(".jbox-content", top.document).css("overflow-y","hidden");
			}
		});
	}else{// 后缀名不支持时直接下载}*/

/**
 * check文件后缀名是否支持打开
 */
function extIsSupportOpen(ext){
	var flag = false;
	/***start****************关注的后缀名****************start***/
	var myExt = ["doc", "docx", "xls", "xlsx", "ppt", "pptx", "wps", "ofd", "pdf"];
	/***end******************关注的后缀名******************end***/
	for(var i=0; i<myExt.length; i++) {
		if(ext.toLowerCase() == myExt[i]) {
			flag = true; //一旦找到合适的，立即退出循环
			break;
		}
	}
	return flag;
}
	
/**
 * 判断公文传输模块正文类型是否为 OFD
 */
function fileTypeIsOFD(path){
	if(path == null || path == ""){
		return false;
	}
	var index = path.lastIndexOf(".");
	if(index == -1){
		return false;
	}
	var typeStr = path.substr(index);
	typeStr = typeStr.toLocaleLowerCase();
	if(typeStr == ".ofd"){
		return true;
	}
	
	return false;
}

/**
 * 打开收回原因页面
 * */
function submitBack(flag, ctx){
	// 执行收回
	top.$.jBox.confirm("你确定要收回该流程吗？", "提示", function(v, h, f){
		if(v == 'ok'){
			submitBackReal(flag, "");
		}
	});
	
/*	$.jBox.open("iframe:"+ ctx +"/act/task/refusedForm?type=1", "收回原因",700,300,{
		buttons:{"确定":"ok","常用语设置":"set","关闭":true}, bottomText:"",submit:function(v, h, f){
			var reason = h.find("iframe")[0].contentWindow.reason;
			if (v=="ok"){
				if(reason.value.trim().length == 0){
					top.$.jBox.tip("请填写收回原因", 'error');
					return false;
				}
				// 执行收回
				submitBackReal(flag, reason.value);
		    	return true;
			}
			if(v=="set"){
				h.find("iframe")[0].contentWindow.set();
				return false;
			}
		}, loaded:function(h){
			$(".jbox-content", document).css("overflow-y","hidden");
		}
	});*/
}

/**
 * 选择主送/抄送单位
 * */
function selectOffice(idInput, nameInput, ctx){
	var selectedIds = $("#"+idInput+"").val();
	var selectedNames = $("#"+nameInput+"").val();
	var url = ctx + "/sys/office/selectOfficeUser?selectedIds="+selectedIds+"&selectedNames="+selectedNames;
	top.$.jBox.open("iframe:"+url+"", "选择单位",810,$(top.document).height()-240,{
		buttons:{"确定":"ok", "清除已选":"clear", "关闭":true}, bottomText:"在所有单位/群组列表中单击展开单位并选择单位；在已选单位列表中单击移除所选，拖拽可调整单位顺序。",submit:function(v, h, f){
			if (v=="ok"){
				var selectedTree = h.find("iframe")[0].contentWindow.selectedTree;
				var nodes = selectedTree.getNodes();
				// 将所选的单位放入数组中
		    	var idList = new Array();
		    	var nameList = new Array();
		    	for(var i=0; i<nodes.length; i++){
		    		idList.push(nodes[i].id);
		    		nameList.push(nodes[i].name);
		    	}
		    	if(idInput == 'sealOfficeIds' && idList.length < 2 && idList.length > 0){
		    		top.$.jBox.tip("联合盖章至少需要两个单位！", 'error');
		    		return false;
		    	}
		    	ids = idList.join(",");
		    	names = nameList.join(",");
		    	
		    	$("#"+idInput+"").val(ids);
		    	$("#"+nameInput+"").val(names);
		    	
		    	return true;
			} else if (v=="clear"){
				h.find("iframe")[0].contentWindow.clearSelected();
				return false;
			} 
		}, loaded:function(h){
			$(".jbox-content", top.document).css("overflow-y","hidden");
		},persistent: true
	});
}
