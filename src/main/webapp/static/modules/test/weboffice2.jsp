<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>西安市人民政府办公厅（OA）系统使用说明书</title>
<meta name="decorator" content="default"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery-1.9.1.js"></script>
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
	document.write(s);
</script>
</div>

<% String contextPath = request.getContextPath();    
String realPath = request.getSession().getServletContext().getRealPath("/");    
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+contextPath+"/helpdoc/hhhh.docx";
                System.out.print(basePath);
 %>
 <input type="hidden" id="urlpath" value="<%=basePath %>">

</body>
<script type="text/javascript" >
	$(function(){
		 var path = document.getElementById("urlpath").value;
		 try{
		$('#WebOffice1')[0].LoadOriginalFile(path, "docx");
		}catch(e){alert(e);}
	});
</script>
<script type="text/javascript" for="WebOffice1" event="NotifyCtrlReady">
	function WebOffice1_NotifyToolBarClick(iCmd){
		alert(iCmd);
         var path = document.getElementById("urlpath").value;
		$('#WebOffice1')[0].LoadOriginalFile(path, "docx");
	}
</script>
</html>