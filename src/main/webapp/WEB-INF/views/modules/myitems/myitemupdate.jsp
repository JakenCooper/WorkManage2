<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>我的工作事项详情</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery-1.8.3.js"></script> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/layui.css" media="all">
    <style>
        body{  margin:20px 10px 20px;  }
    </style>
</head>


<body class="childrenBody">
<sys:message content="${message}"/>	
<form class="layui-form" style="width:80%;"  id="myitemssss"<%-- action="${ctx}/item/wmTodoItem/save" id="itemadd" --%>>
	
	<div><input type="hidden" name ="id" class="id"></div>
	<div class="layui-form-item layui-row layui-col-xs12">
			<label class="layui-form-label">事项类型</label>
			<div class="layui-input-block">
				<select  class="itemType" lay-filter="itemType"  disabled >
					<option value="0">干部管理</option>
					<option value="1">设备管理</option>
					<option value="2">业务管理</option>
				</select>
			</div>
	</div>
	<div class="layui-form-item layui-row layui-col-xs12">
			<label class="layui-form-label">办理类型</label>
			<div class="layui-input-block">
				<select name="handleType" class="handleType" lay-filter="handleType"  >
					<option value="0">办理类型1</option>
					<option value="1">办理类型2</option>
					<option value="2">办理类型3</option>
				</select>
			</div>
	</div>


	<div class="layui-form-item layui-row layui-col-xs12">
			<label class="layui-form-label">是否完成</label>
			<div class="layui-input-block">
				<select name="isFinished" class="isFinished" lay-filter="handleType"  >
					<option value="0">未完成</option>
					<option value="1">已完成</option>
					
				</select>
			</div>
	</div>
	
	
	<div class="layui-form-item layui-row layui-col-xs12">
		<label class="layui-form-label">事项内容</label>
		<div class="layui-input-block">
			<textarea  class="layui-textarea content"  readonly ></textarea>
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-xs12">
		<label class="layui-form-label">办理原因</label>
		<div class="layui-input-block">
			<textarea  class="layui-textarea handleResult" name="handleResult" lay-verify="handleResult"></textarea>
		</div>
	</div>
	
	<div class="layui-form-item layui-row layui-col-xs12">
		<div class="layui-input-block">
			<button class="layui-btn layui-btn-sm" lay-submit="" lay-filter="myitemsubmit">确定</button>
		
			
		</div>
	</div>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/plugins/layui/layui.js"></script>
<script type="text/javascript">

layui.use(['form','layer'],function(){
     var form = layui.form, 
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery;

  $.ajax({
					type:'post',
					url:'${ctx}/myitems/wmUserItem/updateonedetail?id=<%=request.getParameter("id") %>',
					dataType:'json',
					success:function(msg){
				//	alert(msg.wmUserItem.itemType);
						$(".handleResult").val(msg.wmUserItem.handleResult);
						$(".content").val(msg.wmUserItem.content);
						$(".itemType").val(msg.itemType);
						$(".id").val(msg.wmUserItem.id);
						$(".handleType").val(msg.handleType);
						form.render('select');
						
					},
					error: function (XMLHttpRequest, textStatus, errorThrown) {
                    // 状态码
                    console.log(XMLHttpRequest.status);
                    // 状态
                    console.log(XMLHttpRequest.readyState);
                    // 错误信息   
                    console.log(textStatus);
                	}
				});
  
  
  
  
  form.verify({  
        handleResult: function(value){  
          if(value.length < 5){  
            return '办理原因请输入至少4个字符';  
          }  
        }
       /*  ,phone: [/^1[3|4|5|7|8]\d{9}$/, '手机必须11位，只能是数字！']  
        ,email: [/^[a-z0-9._%-]+@([a-z0-9-]+\.)+[a-z]{2,4}$|^1[3|4|5|7|8]\d{9}$/, '邮箱格式不对']   */
  }); 
  
  
   form.on('submit(myitemsubmit)', function (data) {
       
      
            $.ajax({
                url: '${ctx}/myitems/wmUserItem/edittj',
                type: "post",
                dataType: "json",
                data: $('#myitemssss').serialize(),
                async: false,
                success:function(msg) {
               //
             
              //alert(msg.msg);
              
                  // layer.msg(msg.msg);
                 //   if (data.code == 0) {
                       //window.location.reload(true);
                      
                        parent.layer.closeAll();
                         window.parent.location.reload();
                       //window.location.href="${ctx}/item/wmTodoItem/list";
                   // }
                }
            });
            return false; 
        });
  
  
  
  
  
  
  
  
 
})

</script>
</body>

</html>
