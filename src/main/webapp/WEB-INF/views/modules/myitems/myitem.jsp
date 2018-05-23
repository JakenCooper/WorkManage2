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
<form class="layui-form" style="width:80%;" <%-- action="${ctx}/item/wmTodoItem/save" id="itemadd" --%>>
	
	<!-- 
	<div class="layui-form-item layui-row layui-col-xs12">
			<label class="layui-form-label">事项类型</label>
			<div class="layui-input-block">
				<select name="itemType" class="itemType" lay-filter="itemType" disabled  >
					<option value="0">干部管理</option>
					<option value="1">设备管理</option>
					<option value="2">业务管理</option>
				</select>
			</div>
	</div>
	<div class="layui-form-item layui-row layui-col-xs12">
			<label class="layui-form-label">办理类型</label>
			<div class="layui-input-block">
				<select name="handleType" class="handleType" lay-filter="handleType"disabled  >
					<option value="0">办理类型</option>
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
	 -->
	
	<div class="layui-form-item layui-row layui-col-xs12">
		<label class="layui-form-label">事项内容</label>
		<div class="layui-input-block">
			<textarea  class="layui-textarea content" name="content" readonly></textarea>
			<input id="complete" type="button" class="layui-btn layui-btn-sm" value="完 成" style="margin-top: 10px;">
		</div>
	</div>
	<!-- <div class="layui-form-item layui-row layui-col-xs12">
		<label class="layui-form-label">办理原因</label>
		<div class="layui-input-block">
			<textarea  class="layui-textarea handleResult" name="handleResult" readonly></textarea>
		</div>
	</div> -->
	
	<!-- <div class="layui-form-item layui-row layui-col-xs12">
		<div class="layui-input-block">
			<button class="layui-btn layui-btn-sm" lay-submit="" lay-filter="addItem">立即添加</button>
			<button type="reset" class="layui-btn layui-btn-sm layui-btn-primary">重置</button>
			
		</div>
	</div> -->
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/plugins/layui/layui.js"></script>
<script type="text/javascript">

layui.use(['form','layer'],function(){
    var form = layui.form;

  $.ajax({
					type:'post',
					url:'${ctx}/myitems/wmUserItem/viewonedetail?id=<%=request.getParameter("id") %>',
					dataType:'json',
					success:function(msg){
				//	alert(msg.wmUserItem.itemType);
						$(".handleResult").val(msg.wmUserItem.handleResult);
						$(".content").val(msg.wmUserItem.content);
						$(".itemType").val(msg.itemType);
						$(".isFinished").val(msg.isFinished);
						$(".handleType").val(msg.handleType);
						form.render('select');
						//$(".itemType option:selected").val(msg.itemType);
						//optionstring += "<option value=\"" + value.billMchntCd + "\" >" + value.billNm + "</option>";
						//$("#test").prepend("<option value='0'>""</option>");   //为Select插入一个Option(第一个位置)
						//itemType : data.field.userGrade
					//	$(".content").val(msg.wmUserItem.content);
						
						/* $("#faxMachineNumber").val(msg.faxMachineNumber);
						$("#keyNum").val(msg.keyNum);
						$("#zsSysTransStatus").val(msg.zsSysTransStatus);
						$("#zsSysTransStatusRestarTime").val(msg.zsSysTransStatusRestarTime);
						$("#zhuanWangStatus").val(msg.zhuanWangStatus);
						$("#jiFangSafeStatus").val(msg.jiFangSafeStatus);
						$("#leader").val(msg.leader);
						$("#changeUser").val(msg.changeUser);
						$("#ondutyUser").val(msg.ondutyUser);
						$("#jiaoBanTime").val(msg.jiaoBanTime); */
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
  
  
  


 
})

</script>
<script type="text/javascript">
	$(function(){
		layui.use(['form','layer','table','laytpl','laydate'],function(){
		    var form = layui.form,
	        layer = parent.layer === undefined ? layui.layer : top.layer,
	        $ = layui.jquery,
	        laytpl = layui.laytpl,
	        table = layui.table;
		  	var laydate = layui.laydate;
			$("#complete").click(function(){
				  layer.confirm('确定提交已完成?', function(index){
				  		$.ajax({
				  			type:'post',
							url:'${ctx}/myitems/wmUserItem/finished?str=<%=request.getParameter("id")%>',
							dataType:'json',
							success:function(msg){
							  	layer.msg(msg.msg);
							    parent.layer.closeAll();
		                        window.parent.location.reload();
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
			      });
			});
		});
	});
</script>
</body>

</html>
