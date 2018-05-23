<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%-- <%@include file="/WEB-INF/views/include/head.jsp" %> --%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>查看</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/layui.css" media="all">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery-1.8.3.js"></script> 

    </script>
    <style>
        body{  margin:20px 10px 20px; overflow-y: scroll; }
        .layui-body{overflow-y: scroll;}
    </style>
</head>

<body>
<div class="" style="clear: both;">
    <table id="news" lay-filter="test"></table>
</div>

<form class="layui-form" action="">
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">标题：</label>
        <div class="layui-input-block">
            <input class="layui-input title" type="text" />
        </div>
    </div>

    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">内容：</label>
        <div class="layui-input-block">
            <textarea class="layui-textarea content"  name="" cols="68" rows="5"></textarea>
        </div>
    </div>

    <div class="layui-form-item layui-form-text">
        <div class="layui-inline">
            <label class="layui-form-label">通知人：</label>
            <div class="layui-input-inline">
                <input class="layui-input sender" type="text" />
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">通知时间：</label>
            <div class="layui-input-inline">
                <input class="layui-input createdate" type="text" placeholder="2018-04-10"/>
            </div>
        </div>

    </div>
    <div>
			<hr>
			<div class="layui-tab-content" style="clear: both;">

				<table id="domo" lay-filter="domo"></table>


			</div>
</form>

<!-- <table id="looks" lay-filter="test"></table> -->

<script src="${pageContext.request.contextPath}/static/plugins/layui/layui.js"></script>
<script>
    layui.use(['form','laydate','table'], function(){
        var form=layui.form;
        var $ = layui.jquery
                ,element = layui.element;
        var table = layui.table;
        var layer = layui.layer;
        var laydate = layui.laydate;

        //常规用法
        laydate.render({
            elem: '#test1'
        });
        
        alert("是管理员");

		 $.ajax({
					type:'post',
					url:'${ctx}/wmnews/wmNews/detail?id=<%=request.getParameter("id")%>',
					dataType:'json',
					success:function(msg){
					//alert(msg.wmTodoItem.itemType);
						$(".content").val(msg.news.content);
						$(".title").val(msg.news.title);
						$(".sender").val(msg.news.sender);
						$(".createdate").val(msg.news.createDate);
						form.render('select');
						//alert(msg.msg);
						if(msg.msg == "sender" ){
						var messageid = msg.news.messageid;
						var id =msg.news.id;
						var news = msg.news;
						 var tableIns = table.render({
      					  elem: '#domo'
      					   ,height: $(window).height-100
           					 ,limit: 10
           					 ,page: true //开启分页
      					  //data : msg.newslist,
      					   ,url: '${ctx}/wmnews/wmNews/detaillist?id='+id //数据接口
      					 // ,cellMinWidth : 95,
       					 ,height : $(window).height-100,
        			     	id : "domo",
      					  cols: [[ //表头
           			     {type:'numbers'},
                 {field: 'user', title: '接收人',align: 'center',fontWeight:'bold'},
                 {field: 'status', title: '接收状态',align: 'center',fontWeight:'bold'},
                 {field: 'updateDate', title: '接收时间',align: 'center',fontWeight:'bold'},
                 {field: 'replaycontent', title: '回复内容',align: 'center',fontWeight:'bold'}
                ]]
						
						})
					
					}
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
</script>
</body>

</html>