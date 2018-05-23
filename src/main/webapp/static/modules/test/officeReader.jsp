<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>编辑正文</title>
<meta name="decorator" content="default"/>
<script src="${pageContext.request.contextPath}/static/custom/textEditor.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/jquery/jquery-1.9.1.js" type="text/javascript"></script>
<script type="text/javascript">
	//var url = 'e:/test.doc';
	var url='http://localhost:8080/jeesite/helpdoc/test.doc';
	var fileType = 'doc';
	
	//点击打开word
	function WebOffice1_NotifyToolBarClick(iCmd){
		// document.all.WebOffice1.ShowToolBar = false; // 菜单栏
		if(url == null){
			alertx("打开文件失败！", closeJBox);
		}else{
			var token = getToken('${ctx}');
			var filePath = url + "?token=" + token;
			document.all.WebOffice1.LoadOriginalFile(filePath, fileType);
		}
	}
	
	function closeJBox(){
		top.$.jBox.close(true);
	}
</script>
<script type="text/javascript" for="WebOffice1" event="NotifyCtrlReady">
	WebOffice1_NotifyToolBarClick();
</script>
</head>
<body>
<div style="width:100%;height:100%;">
<script type="text/javascript">
	var s = "";
	if(navigator.userAgent.indexOf("Chrome")>0){
		s = "<object id='WebOffice1' type='application/x-itst-activex' align='baseline' border='0'"
			+ "style='LEFT: 0px; POSITION: absolute; WIDTH: 100%; TOP: 0px; HEIGHT: 100%'"
			+ "clsid='{E77E049B-23FC-4DB8-B756-60529A35FAD5}'"
			+ "event_NotifyCtrlReady='WebOffice1_NotifyToolBarClick'>"
			+ "</object>";
	}
	else if(navigator.userAgent.indexOf("Firefox")>0){
		s = "<object id='WebOffice1' type='application/x-itst-activex' align='baseline' border='0'"
			+ "style='LEFT: 0px; POSITION: absolute; WIDTH: 100%; TOP: 0px; HEIGHT: 100%' " 
			+ "clsid='{E77E049B-23FC-4DB8-B756-60529A35FAD5}' "
			+ "event_NotifyCtrlReady='WebOffice1_NotifyToolBarClick'>"
			+ "</object>";
	}
	else{
		s = "<OBJECT id='WebOffice1' align='middle' height='100%' width='100%'"
			+ "style='POSITION: absolute;'" 
			+ "classid=clsid:E77E049B-23FC-4DB8-B756-60529A35FAD5>"
			+ "</OBJECT>";
	}
	document.write(s) 
</script>
</div>
</body>
</html>