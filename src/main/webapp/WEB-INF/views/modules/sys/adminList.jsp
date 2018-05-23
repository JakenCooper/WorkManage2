<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<html>
<head>
	<title>管理员列表</title>
	<meta name="decorator" content="default"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/layui/css/layui.css" media="all"> 
	<script src="${pageContext.request.contextPath}/static/plugins/layui/layui.js" type="text/javascript"></script>
</head>
<body>
	<div class="layui-form" style="width:90%;margin:0 auto;">
	    <div class="layui-form-pane" style="margin-top: 15px;">
	        <div class="layui-form-item">
	            <div class="layui-input-inline">
	                <input type="text"  class="layui-input" id="test1" placeholder="yyyy-MM-dd">
	            </div>
	            <div class="layui-input-inline">
	                <input type="text"  class="layui-input" id="test2" placeholder="yyyy-MM-dd">
	            </div>
	            <div class="layui-input-inline">
	                <input type="text" class="layui-input" placeholder="请输入"/>
	            </div>
	            <button type="button" class="layui-btn">查询</button>
	        </div>
	    </div>
	</div>
	<div class="">
	    <div style="float: left">
	        <button type="button"  class="layui-btn">添加</button>
	        <button type="button"  class="layui-btn layui-btn-danger">批量删除</button>
	    </div>
	    <div style="float: right">
	        <button class="layui-btn layui-btn-normal">导出</button>
	        <button class="layui-btn layui-btn-warm">打印</button>
	    </div>
	</div>
	<div>
	    <table id="rolelist" class="layui-table"></table>
	</div>
	<!--列表操作按钮-->
	<script type="text/html" id="eventBarDemo">
    <button class="layui-btn layui-btn-warm layui-btn-sm" lay-event="edit">编辑</button>
    <button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del">删除</button>
	</script>
	
	<script>
	    layui.use(['layer','table','laydate'], function() {
	        var layer = layui.layer;
	        var $ = layui.jquery
	                ,element = layui.element;
	        var table = layui.table;
	        var laydate = layui.laydate;
	        //常规用法
	        laydate.render({
	            elem: '#test1'
	        });
	        laydate.render({
	            elem: '#test2'
	        });
	
	        table.render({
	            elem: '#rolelist'
	            ,height: $(window).height-100
	            ,limit: 10
	            ,url: 'adminlists.json' //数据接口
	            ,page: true //开启分页
	            ,cols: [[ //表头
	//                {type:'numbers'},
	//                {type: 'checkbox'},
	                {field: 'id', title: 'ID',  sort: true, fixed: 'left',align: 'center',width:100},
	                {field: 'username', title: '登录名称',sort: true,align: 'center'},
	                {field: 'iphone', title: '手机',sort: true,align: 'center'},
	                {field: 'email', title: '邮箱',sort: true,align: 'center'},
	                {field: 'rolename', title: '角色名称',sort: true,align: 'center'},
	                {field: 'times', title: '创建时间',sort: true,align: 'center'},
	                {fixed:'right', title:'操作', align: 'center', toolbar:'#eventBarDemo'}
	            ]]
	        });
	    });
	</script>

</body>
</html>