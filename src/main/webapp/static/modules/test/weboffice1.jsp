<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>编辑正文</title>
<meta name="decorator" content="default"/>
<link href="${pageContext.request.contextPath}/static/bootstrap/2.3.1/css_cerulean/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/static/jquery-jbox/2.3/Skins/Bootstrap/jbox.css" type="text/css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/static/jquery/jquery-1.9.1.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/commonUtils.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/custom/textEditor.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/jquery-jbox/2.3/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/jquery-jbox/2.3/i18n/jquery.jBox-zh-CN.js" type="text/javascript"></script>
<script>
	function GetRequest() {
		var url = location.search; //获取url中"?"符后的字串 
		var theRequest = new Object();
		if (url.indexOf("?") != -1) {
			var str = url.substr(1);
			strs = str.split("&");
			for (var i = 0; i < strs.length; i++) {
				theRequest[strs[i].split("=")[0]] = unescape(strs[i].split("=")[1]);
			}
		}
		return theRequest;
	}
	var request = GetRequest();
	console.log(request);
	var fileTypes = request['fileTypes'];
	//导入模板
	function loadTempalate(){
		var request = GetRequest();
		var fileTypes = request['fileTypes'];
		var filePath = request['filePath'];
		$.jBox(
			"iframe:${ctx}/template/doctemplate/choice?fileType="+fileTypes, 
			{
	        title: "选择正文模板",
	        top:50,
	        draggable: true,  //是否可以拖动窗口 
	        persistent: true,  //在显示隔离层的情况下，点击隔离层时，是否坚持窗口不关闭 
	        width: $(document).width()-200,
	        height: $(document).height()-200,
	        buttons:{"确定":"ok","关闭":true},
			bottomText:"", 
			submit:function(v, h, f){
				var path = h.find("iframe")[0].contentWindow.fileChiocePath.value;
				var type = h.find("iframe")[0].contentWindow.fileChioceType.value;
				if (v=="ok"){
					$(".jbox-content", top.document).css("overflow-y","hidden");
					//判断文件存储服务器，此文件是否存在
					var isok=false;		
					if(path==''||path.lenght<=0){
						alert("请选择一个正文模板后操作");
						return false;
					}	
					h.find("iframe")[0].contentWindow.$("body").mLoading("show");
					var token = getToken('${ctx}');		
					$.ajax({
						type:"POST",
						url: DocStorePath + "upload/isExists.do?path="+path+"&token="+token,
						cache: false,
						async: false,
						success: function(date) {
			 				var obj = eval('(' + date + ')');
			 				if (obj.status == 0) {
			 					isok=true;
		 						path=path+"?token="+token;
			 					if(type==0){
									webObj.LoadOriginalFile(path, "doc");
								}else if(type==1){
									webObj.LoadOriginalFile(path, "xls");
								}
			 				}else{
			 					isok=false;
			 					alert(obj.msg+"请重新选择！");
			 				}
						}
					}); 
					h.find("iframe")[0].contentWindow.$("body").mLoading("hide");
					//如果文件不存在页面不关闭
					if(!isok){
						return false;
					}
		    		return true;
					} 
				}, loaded:function(h){
					$(".jbox-content", document).css("overflow-y","hidden");
				}
			});
		
		/* $.jBox.open("iframe:${ctx}/template/doctemplate/choice?fileType="+fileTypes, "选择正文模板",$(document).width()-200,
			$(document).height()-200,{
			buttons:{"确定":"ok","关闭":true}, bottomText:"",submit:function(v, h, f){
				var path = h.find("iframe")[0].contentWindow.fileChiocePath.value;
				var type = h.find("iframe")[0].contentWindow.fileChioceType.value;
				if (v=="ok"){
					$(".jbox-content", top.document).css("overflow-y","hidden");
					if(type==0){
						webObj.LoadOriginalFile(path, "doc");
					}else if(type==1){
						webObj.LoadOriginalFile(path, "xls");
					}
		    		return true;
				} 
			}, loaded:function(h){
				$(".jbox-content", top.document).css("overflow-y","hidden");
			}
		});  */
	}
	//另存为模板
	function saveTemplate(){
		var request = GetRequest();
		var fileTypes = request['fileTypes'];
		var filePath = request['filePath'];
			if(filePath!=null&&filePath.length>0 && filePath != "undefined"){
				updateTemplateFile(filePath);
			}else{   
				filePath=newTemplateFile();
			} 
			if(filePath!=null&&filePath.length>0){
				// 执行保存
				$.jBox.open("iframe:${ctx}/template/doctemplate/newForm?fileType="+fileTypes+"&filePath="+filePath, "保存正文模板",$(document).width()-200,
				$(document).height()-200,{
					buttons:{"关闭":true}, bottomText:"",submit:function(v, h, f){
					
					}, loaded:function(h){
						$(".jbox-content", document).css("overflow-y","hidden");
					} 
				}); 
			}else{
				alert("路径为空，无法保存此模板，请联系管理员");
			}
		}	
</script>
<script type="text/javascript" for="WebOffice1" event="NotifyCtrlReady">
	/* var request = GetRequest();
	fileTypes = request['fileTypes']; */
	if(fileTypes == "0"){
		WebOffice1_NotifyToolBarClick();
	}else if(fileTypes == "1"){
		WebOffice1_NotifyToolBarClickExcel();
	}
</script>
</head>
<body>
<div style="width:100%;height:100%;">
<script type="text/javascript">
	var s = "";
	if(navigator.userAgent.indexOf("Chrome")>0){
		//alert("chrome");
		//alert(fileTypes)
		if(fileTypes == "0"){
			s = "<object id='WebOffice1' type='application/x-itst-activex' align='baseline' border='0'"
				+ "style='LEFT: 0px; WIDTH: 100%; TOP: 0px; HEIGHT: 100%'"
				+ "clsid='{E77E049B-23FC-4DB8-B756-60529A35FAD5}'"
				+ "event_NotifyCtrlReady='WebOffice1_NotifyToolBarClick'>"
				+ "</object>";
		}else if(fileTypes == "1"){
			s = "<object id='WebOffice1' type='application/x-itst-activex' align='baseline' border='0'"
				+ "style='LEFT: 0px; WIDTH: 100%; TOP: 0px; HEIGHT: 100%'"
				+ "clsid='{E77E049B-23FC-4DB8-B756-60529A35FAD5}'"
				+ "event_NotifyCtrlReady='WebOffice1_NotifyToolBarClickExcel'>"
				+ "</object>";
		}
	}
	else if(navigator.userAgent.indexOf("Firefox")>0){
		//alert("firefox");
		if(fileTypes == "0"){
			s = "<object id='WebOffice1' type='application/x-itst-activex' align='baseline' border='0'"
				+ "style='LEFT: 0px; WIDTH: 100%; TOP: 0px; HEIGHT: 100%' " 
				+ "clsid='{E77E049B-23FC-4DB8-B756-60529A35FAD5}' "
				+ "event_NotifyCtrlReady='WebOffice1_NotifyToolBarClick'>"
				+ "</object>";	
		}else if(fileTypes == "1"){
			s = "<object id='WebOffice1' type='application/x-itst-activex' align='baseline' border='0'"
				+ "style='LEFT: 0px; WIDTH: 100%; TOP: 0px; HEIGHT: 100%' " 
				+ "clsid='{E77E049B-23FC-4DB8-B756-60529A35FAD5}' "
				+ "event_NotifyCtrlReady='WebOffice1_NotifyToolBarClickExcel'>"
				+ "</object>";	
			}
	}
	else{
		//alert("ie");
		s = "<OBJECT id='WebOffice1' align='middle' height='100%' width='100%'"
			+ "classid=clsid:E77E049B-23FC-4DB8-B756-60529A35FAD5>"
			+ "</OBJECT>";
	}
	document.write(s) 
</script>

</div>
</body>
<script type="text/javascript">
	//document.all.WebOffice1.ShowToolBar = true;
	var webObj=document.getElementById("WebOffice1");
	var filePath = "";
	
	//关闭文件
	function colseFile(){
		if(webObj.IsSaved() != 0){
			webObj.CloseDoc(0);
		}else{
			if(confirm("文件已经修改，是否保存？")){
				saveFile();
			}
		}
	}
	//点击打开word
	function WebOffice1_NotifyToolBarClick(iCmd){		
		var request = GetRequest();
		var cacheAddr = request['cacheAddr'];
		//如果携带参数缓存地址不存在则为再编辑或查看
		if(cacheAddr!="undefined"){
			var filePaths=cacheAddr.split(",");
			for(var i=0;i<filePaths.length;i++){
				//文件的类型为docx或者doc时，为word文件路径赋值
				if(filePaths[i].indexOf(".docx")>=0 || filePaths[i].indexOf(".doc")>=0){
					filePath=filePaths[i];
				}
			}
		}else{
			filePath = request['filePath'];
		}
		//如果文件地址为空，或者不是word类型则新建文件，否则根据路径打开
		if(filePath == null || filePath.length == 0 || (filePath.indexOf(".docx")<0 && filePath.indexOf(".doc")<0)){
			newFileDoc();
		}else{
			$.ajax({
				type:"POST",
				url: "${ctx}/getToken",
				async: false,
				cache: false,
				success: function(msg) {
	 				var obj = eval('(' + msg + ')');
					if(obj.status == '0'){
						filePath=filePath+"?token="+obj.value
						document.all.WebOffice1.LoadOriginalFile(filePath, "doc");
						document.all.WebOffice1.SetTrackRevisions(1);
						document.all.WebOffice1.SetCurrUserName('${fns:getUser().getName()}');
					} else{
						alert("文件打开失败");
					}
				},
				error:function () {
					alert("请求失败！");
				}
			}); 
		}	
	}
	//点击打开Excel
	function WebOffice1_NotifyToolBarClickExcel(iCmd){		
		var request = GetRequest();
		var cacheAddr = request['cacheAddr'];
		if(cacheAddr!="undefined" ){
			var filePaths=cacheAddr.split(",");
			for(var i=0;i<filePaths.length;i++){
				if(filePaths[i].indexOf(".xlsx")>=0 || filePaths[i].indexOf(".xls")>=0){
					filePath=filePaths[i];
				}
			}
		}else{
			filePath = request['filePath'];
		}
		//如果文件地址为空，则新建文件
		if(filePath == null || filePath.length == 0 || (filePath.indexOf(".xlsx")<0 && filePath.indexOf(".xls")<0)){
			newFileXls();
		}else{
			$.ajax({
				type:"POST",
				url: "${ctx}/getToken",
				async: false,
				cache: false,
				success: function(msg) {
	 				var obj = eval('(' + msg + ')');
					if(obj.status == '0'){
						filePath=filePath+"?token="+obj.value
						document.all.WebOffice1.LoadOriginalFile(filePath, "xlsx");
					} else{
						alert("文件打开失败");
					}
				},
				error:function () {
					alert("请求失败！");
				}
			}); 
		}	
	}
	
	//获取该文档的对象，该方法非常重要※
	/*  function btn(){
		alert(webObj.GetDocumentObject());
	}  */
	
	function btn(){
/* 		alert(webObj.IsOpened())
		alert(webObj.IsSaved()) */
	}
	
	//文档保存
	function saveFile(){
 		if(filePath == null || filePath.length == 0){
			return createFile();
		}else{
			return updateFile();
		}
	}
	
	var fileDesc="[{'name':'textFileName.docx','author':'user'}]";
	//保存为模板
	function createTemplate(){
		//alert(token);
		webObj.HttpInit(); //初始化Http 引擎  
	    webObj.HttpAddPostString("fileId",DocStorePath + "FilePath/Template/2017-07-14/test/template.docx");//源文件地址
        $.ajax({
			type:"POST",
			url: "${ctx}/getToken",
			async: false,
			cache: false,
			success: function(msg) {
 				var obj = eval('(' + msg + ')');
				if(obj.status == '0'){
					webObj.HttpAddPostString("token",obj.value);//添加请求参数
				} else{
					alert("文件保存失败");
					return null;
				}
			},
			error:function () {
				alert("请求失败！");
				return null;
			}
		}); 
	    webObj.HttpAddPostString("fileDesc",fileDesc);//添加请求参数
	    webObj.HttpAddPostCurrFile("file","");//添加要上传的文件
	    var returnValue = webObj.HttpPost(DocStorePath + "upload/createTemplate.do");     
	    var jsonobj = eval('('+returnValue+')');	    
 	    if(jsonobj.status == 0){
		    alert("保存成功");
	    }else{
	    	alert("保存失败");
	    }
	}
	
	//更新文件
	function updateFile(){
		webObj.HttpInit(); //初始化Http 引擎  
	    webObj.HttpAddPostString("fileId",filePath);//源文件地址
	    $.ajax({
			type:"POST",
			url: "${ctx}/getToken",
			async: false,
			cache: false,
			success: function(msg) {
 				var obj = eval('(' + msg + ')');
				if(obj.status == '0'){
					webObj.HttpAddPostString("token",obj.value);//添加请求参数
				} else{
					alert("文件保存失败");
					return null;
				}
			},
			error:function () {
				alert("请求失败！");
				return null;
			}
		}); 
	    /* $.post("${ctx}/getToken",
			function(res){
				var data = eval('('+res+')');
				if (data.status == 0) {
				    webObj.HttpAddPostString("token",data.value);//添加请求参数
				}
			}); */
	    webObj.HttpAddPostString("fileDesc",fileDesc);//添加请求参数
	    webObj.HttpAddPostCurrFile("file","");//添加要上传的文件
	    var returnValue = webObj.HttpPost(DocStorePath + "upload/saveFile.do");     
	    var jsonobj = eval('('+returnValue+')');	    
 	    if(jsonobj.status == 0){
 	    	alert("文件更新成功");
		    return returnValue;
	    }else{
	    	alert("文件更新失败！");
	    	return null;
	    }
	}
	
	//新建文件
	function createFile(){
		//alert(DocStorePath);
	 	var request = GetRequest();
		var fileTypes = request['fileTypes']; 
		webObj.HttpInit(); //初始化Http 引擎  
	    webObj.HttpAddPostString("userName","admin");//添加请求参数、
	    $.ajax({
			type:"POST",
			url: "${ctx}/getToken",
			async: false,
			cache: false,
			success: function(msg) {
 				var obj = eval('(' + msg + ')');
				if(obj.status == '0'){
					webObj.HttpAddPostString("token",obj.value);//添加请求参数
				} else{
					alert("文件保存失败");
					return null;
				}
			},
			error:function () {
				alert("请求失败！");
				return null;
			}
		}); 
	   /*  $.post("${ctx}/getToken",
			function(res){
				var data = eval('('+res+')');
				if (data.status == 0) {
				    webObj.HttpAddPostString("token",ata.value);//添加请求参数
				   
				}
			}); */ 
	        webObj.HttpAddPostCurrFile("file","textFileName.docx");//添加要上传的文件
		    webObj.HttpAddPostString("fileDesc",fileDesc);//添加请求参数
		    var returnValue = webObj.HttpPost(DocStorePath + "upload/createFile.do");
		    //alert(returnValue); 
		    var jsonobj = eval('('+returnValue+')');
		    if(jsonobj.status == 0){
		    	alert("文件保存成功！");
	 	    	return returnValue;
		    }else{
		    	alert("文件保存失败！");
		    	return null;
		    }	 
 	    /* if(jsonobj.status == 0){
 	    	//alert(jsonobj.value[0].wordsCount);
 	    	window.parent.opener.updateFilePath(jsonobj.value[0].fileUrl,fileTypes,jsonobj.value[0].fileRealUrl,jsonobj.value[0].wordsCount);
		    alert("文件保存成功");
		    window.close();
	    }else{
	    	alert(jsonobj.msg);
	    } */
	}
	
	//另存为模板文件
	function newTemplateFile(){
		//alert(DocStorePath);
	 	var request = GetRequest();
		var fileTypes = request['fileTypes']; 
		webObj.HttpInit(); //初始化Http 引擎  
	    webObj.HttpAddPostString("userName","admin");//添加请求参数
	    $.ajax({
			type:"POST",
			url: "${ctx}/getToken",
			async: false,
			cache: false,
			success: function(msg) {
 				var obj = eval('(' + msg + ')');
				if(obj.status == '0'){
					webObj.HttpAddPostString("token",obj.value);//添加请求参数
				} else{
					alert("文件保存失败");
					return null;
				}
			},
			error:function () {
				alert("请求失败！");
				return null;
			}
		}); 
	    webObj.HttpAddPostCurrFile("file","textFileName.docx");//添加要上传的文件
	    webObj.HttpAddPostString("fileDesc",fileDesc);//添加请求参数
	    var returnValue = webObj.HttpPost(DocStorePath + "upload/createFile.do"); 
	    var jsonobj = eval('('+returnValue+')');	    
 	    if(jsonobj.status == 0){
 	    	return jsonobj.value[0].fileUrl;
	    }else{
	    	return null;
	    }
	}
	
	//流程正文编辑时更新模板文件
	//个人设置保存更新模板文件
	function updateTemplateFile(filePath){
		//alert(DocStorePath);
	 	var request = GetRequest();
		var fileTypes = request['fileTypes']; 
		webObj.HttpInit(); //初始化Http 引擎  
	    webObj.HttpAddPostString("fileId",filePath);//源文件地址
	     $.ajax({
			type:"POST",
			url: "${ctx}/getToken",
			async: false,
			cache: false,
			success: function(msg) {
 				var obj = eval('(' + msg + ')');
				if(obj.status == '0'){
					webObj.HttpAddPostString("token",obj.value);//添加请求参数
				} else{
					alert("文件保存失败");
					return null;
				}
			},
			error:function () {
				alert("请求失败！");
				return null;
			}
		}); 
	    webObj.HttpAddPostString("fileDesc",fileDesc);//添加请求参数
	    webObj.HttpAddPostCurrFile("file","");//添加要上传的文件
	    var returnValue = webObj.HttpPost(DocStorePath + "upload/saveFile.do");     
	    var jsonobj = eval('('+returnValue+')');	    
 	    if(jsonobj.status == 0){
 	    	//alert("模板更新成功！"); 
	    }else{
	    	alert("模板更新失败！");
	    }
	}
	
	// 模板新建文件
	function newFileFromTemplate(){
		webObj.LoadOriginalFile(DocStorePath + "FilePath/Template/2017-07-14/test/template.docx", "doc");
	}
	
	// 新建doc空文件
	function newFileDoc(){
		webObj.LoadOriginalFile("", "doc");
	}
	// 新建excel空文件
	function newFileXls(){
		webObj.LoadOriginalFile("", "xls");
	}
	
		/* $(document).ready(function() {
			
		}); */
	
</script>
</html>