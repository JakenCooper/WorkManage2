/**
* 公用变量
*/
//文件存储服务器地址

var DocStorePath = "http://192.168.2.103:8081/OfficalStoreSys/";


function selectNext(url, flag, action, ctx){
	top.$.jBox.open(
			url, 
			"选择下一步",
			810,
			$(top.document).height()-240,
			{buttons:{"确定":"ok", "关闭":true}, 
			submit:function(v, h, f){
				if (v=="ok"){
					//获取下一步骤
					var next = h.find("iframe")[0].contentWindow.$("#userfulWord").val();
					var nextName = h.find("iframe")[0].contentWindow.$("#userfulWord option:selected").text();
					var isok=true;
					if(next == null || next == ""){
						top.$.jBox.tip("请选择下一步骤！");
						return false;
					}
					h.find("iframe")[0].contentWindow.$("body").mLoading("show");
					if(next == "99"){
						setNextStep(next, "");
					}else{
						var nodes = h.find("iframe")[0].contentWindow.tree.getNodesByParam("checked", true, null);
						if(nodes == null || nodes.length == 0 || nodes == ""){
							h.find("iframe")[0].contentWindow.$("body").mLoading("hide");
							top.$.jBox.tip("请选择下一步骤处理人！");
							return false;
						}
						var people = "";
						for(var i in nodes){
							if(nodes[i].isParent){
								continue;
							}
							if(nextName=="处室审核"||nextName=="其他处室审核"){
								//根据部门得到部门处长名
								$.ajax({
									type:"POST",
									url: ctx+"/sys/userProcTask/queryDirectorName?officeId="+nodes[i].id,
									async: false,
									cache: false,
									success: function(msg) {
										if(msg != '' && msg != null){
											people = msg;
										} else{
											top.$.jBox.tip("获取部门处长信息失败！");
											isok=false;
										}
									},
									error:function () {
										top.$.jBox.tip("请求失败，请稍等再试！");
										isok=false;
									}
								});
							}else{
								if(people == ""){
									people = nodes[i].loginname;
								}else{
									people += "," + nodes[i].loginname;
								}
							}
						}			
						setNextStep(next, people);
					}
					if(isok){
						submitReal(flag,action);
					}else{
						h.find("iframe")[0].contentWindow.$("body").mLoading("hide");
						return false;
					}
					h.find("iframe")[0].contentWindow.$("body").mLoading("hide");
					return true;
				}else if(v){
					return true;
				}
				return false;
		}, loaded:function(h){
			$(".jbox-content", top.document).css("overflow-y","hidden");
		}
	});
}

/**
 * 文本框根据输入内容自适应高度
 * @param {HTMLElement}	输入框元素
 * @param {Number}		设置光标与输入框保持的距离(可选，默认0)
 * @param {Number}		设置最大高度(可选)
 */
var autoTextarea = function (elem, extra, maxHeight) {
	try{
        extra = extra || 0;
        var isFirefox = !!document.getBoxObjectFor || 'mozInnerScreenX' in window,
        isOpera = !!window.opera && !!window.opera.toString().indexOf('Opera'),
                addEvent = function (type, callback) {
                        elem.addEventListener ?
                                elem.addEventListener(type, callback, false) :
                                elem.attachEvent('on' + type, callback);
                },
                getStyle = elem.currentStyle ? function (name) {
                        var val = elem.currentStyle[name];
 
                        if (name === 'height' && val.search(/px/i) !== 1) {
                                var rect = elem.getBoundingClientRect();
                                return rect.bottom - rect.top -
                                        parseFloat(getStyle('paddingTop')) -
                                        parseFloat(getStyle('paddingBottom')) + 'px';        
                        };
 
                        return val;
                } : function (name) {
                                return getComputedStyle(elem, null)[name];
                },
                minHeight = parseFloat(getStyle('height'));
 
        elem.style.resize = 'none';
 
        var change = function () {
                var scrollTop, height,
                        padding = 0,
                        style = elem.style;
 
                if (elem._length === elem.value.length) return;
                elem._length = elem.value.length;
 
                if (!isFirefox && !isOpera) {
                        padding = parseInt(getStyle('paddingTop')) + parseInt(getStyle('paddingBottom'));
                };
                scrollTop = document.body.scrollTop || document.documentElement.scrollTop;
 
                elem.style.height = minHeight + 'px';
                if (elem.scrollHeight > minHeight) {
                        if (maxHeight && elem.scrollHeight > maxHeight) {
                                height = maxHeight - padding;
                                style.overflowY = 'auto';
                        } else {
                                height = elem.scrollHeight - padding;
                                style.overflowY = 'hidden';
                        };
                        style.height = height + extra + 'px';
                        scrollTop += parseInt(style.height) - elem.currHeight;
                        document.body.scrollTop = scrollTop;
                        document.documentElement.scrollTop = scrollTop;
                        elem.currHeight = parseInt(style.height);
                };
        };
 
        addEvent('propertychange', change);
        addEvent('input', change);
        addEvent('focus', change);
        change();

	}
	catch(e){
		console.log(e.name + ": " + e.message);
	}
};

function DocForwardToSend(url){
	top.$.jBox.open(
			url, 
			"转发公文",
			$(top.document).width()-240,
			$(top.document).height()-240,
			{buttons:{"发送":"ok", "浏览正文":"doc", "关闭":true},
			persistent: true,  //在显示隔离层的情况下，点击隔离层时，是否坚持窗口不关闭 
			submit:function(v, h, f){
				if(v == "ok"){
					return h.find("iframe")[0].contentWindow.submitForm();
				}else if(v == "doc"){
					h.find("iframe")[0].contentWindow.readDocBody();
					return false;
				}								
		}, loaded:function(h){
			$(".jbox-content", top.document).css("overflow-y","hidden");
		}
	});
}

//check正文文件后缀名
function checkFileExt(filename) {
	filename = filename.toLowerCase();
	var flag = false; //状态
	var arr = ["doc", "docx", "ofd", "gw", "pdf"];
	//取出上传文件的扩展名
	var index = filename.lastIndexOf(".");
	var ext = filename.substr(index+1);
	//循环比较
	for(var i=0;i<arr.length;i++)
	{
		if(ext == arr[i])
		{
		flag = true; //一旦找到合适的，立即退出循环
		break;
		}
	}
	return flag;
}

// 获取正文文件类型
function getFileType(filename) {
	var fileType = "";
	filename = filename.toLowerCase();
	var index = filename.lastIndexOf(".");
	var ext = filename.substr(index + 1);
	if(ext == "doc" || ext == "docx"){
		fileType = "0"
	}else if(ext == "ofd" || ext == "pdf"){
		fileType = "3"
	}else if(ext == "gw"){
		fileType = "4"
	}
	return fileType;
}

/**
 * 
 * @param ctx				${ctx}路径
 * @param fileInputId		选择文件input的id
 * @param userNameInputId	当前用户input的id
 * @param textTypeInputId	正文类型input的id
 * @param textAddrInputId	正文实际地址input的id
 * @param textSpotInputId	正文网络地址input的id
 * @param contentInputId	富文本内容input的id
 */
function uploadBodyFiles(ctx, fileInputId, userNameInputId, textTypeInputId,
		textAddrInputId, textSpotInputId, contentInputId){
	var obj = document.getElementById(fileInputId);
	var bFile = obj.files[0];
	var filename = bFile.name;
	obj.outerHTML = obj.outerHTML;
	if(bFile == null || bFile == undefined){
		return;
	}
	if(!checkFileExt(bFile.name)){
		top.$.jBox.tip("正文只支持doc, docx, ofd, gw, pdf格式文件！","error");
		return
	}
	//显示loading组件
	$("body").mLoading("show");
	$.post(ctx+"/getToken",function(res){
		var data = eval('('+res+')');
		if (data.status == 0) {
			var username = $("#"+userNameInputId+"").val()
			// 设置token
			token = data.value;
			// 创建文件参数数组
			var fileDescArr = new Array();
			// 创建FormData
			var formData = new FormData();
			// 创建数组中的对象
			var fileDescObj = new Object();
			// 设置对象的参数name
			fileDescObj.name = filename;
			// 设置对象的参数author
			fileDescObj.author = username;
			// 将对象装进数组中
			fileDescArr.push(fileDescObj);
			// 将装着对象的数组转为Json数组([{}])
			var fileDesc = JSON.stringify(fileDescArr);
			// 添加token
			formData.append("token",token);
			// 将当前遍历到的文件放进FormData中
			formData.append("file", bFile);  
         	// 将用户放入FormData
			formData.append("userName", username);
         	// 将文件描述的Json数组放入FormData
			formData.append("fileDesc", fileDesc);
         	// 通过ajax上传
			$.ajax({
				url: DocStorePath + "upload/createFile.do",
				type: "POST",
				data: formData,
				// 必须false才会自动加上正确的Content-Type
				contentType: false,
				async: false,
                // 必须false才会避开jQuery对 formdata 的默认处理
                // XMLHttpRequest会对 formdata 进行正确的处理
				processData: false,
				success: function (res) {
					var data = eval('('+res+')');
 					if (data.status == 0) {
 						var resInfo = data.value;
 						for(var i=0; i<resInfo.length; i++){
 							if(resInfo[i].status == 0){
 								var msgType = getFileType(filename);
 								var msgAddr = resInfo[i].fileRealUrl;
 								var msgSpot = resInfo[i].fileUrl;
 								var msgContent = "";
 								$("#"+textTypeInputId+"").val(msgType);
 								$("#"+textAddrInputId+"").val(msgAddr);
 								$("#"+textSpotInputId+"").val(msgSpot);
 								$("#"+contentInputId+"").val(msgContent);
 								//隐藏loading组件
 								$("body").mLoading("hide");
 								top.$.jBox.tip("正文替换成功","success");
 							}else {
 								//隐藏loading组件
 								$("body").mLoading("hide");
 								top.$.jBox.tip("正文替换失败，请联系管理员，"+resInfo[i].msg,"error");
 								return;
 							}
 						}
					}else{
						//隐藏loading组件
						$("body").mLoading("hide");
						top.$.jBox.tip("正文替换失败，请联系管理员，"+data.msg,"error");
						return;
					}
				},
				error: function () {
					//隐藏loading组件
					$("body").mLoading("hide");
					top.$.jBox.tip("正文替换失败，请联系管理员。","error");
					return;
 				}
			});
		}else{
			//隐藏loading组件
			$("body").mLoading("hide");
			top.$.jBox.tip("网页已过期，请刷新。","error");
			return;
		}
	});
}

/**
 * 窗口大小改变事件
 * */
/*$(window).resize(function(){
	setMainViewH();
});*/

/**
 * 重新设置主view高度
 * */
function setMainViewH(){
	$("#mainView").height($(window).height() - $("#headView").height() - 10);
}

/**
 * 收文说明自动保存
 * */
function saveRecExplain(ctx, textId, dataId, procDefKey){
	$("#" + textId).blur(function(){
		var param = new Object();
		param.content = this.value;
		param.dataId = dataId;
		param.procDefKey = procDefKey;
		$.ajax({
			url: ctx + "/act/task/saveRecExplain",
			type: "POST",
			data: param,
			success: function (res) {
				//alert(res);
			},
			error: function () {
				//alert("error");
			}
		});
	});
	
}

/**
 * 设置标题宽度，控制每行字数显示
 * */
function setTitleWidth(titleId, remarksId){
	var mainWidth = ($("#" + remarksId).width() - 120) * 0.96;
	var paddingSize = (mainWidth - 400) / 2;
	$("#" + titleId).css("width",400);
	$("#" + titleId).css("padding-left",paddingSize);
	$("#" + titleId).css("padding-right",paddingSize);
}

