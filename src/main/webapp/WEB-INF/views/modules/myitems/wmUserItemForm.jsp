<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%-- <%@include file="/WEB-INF/views/include/head.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>用户中心--layui后台管理模板 2.0</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/public.css" media="all" />
	  <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery-1.8.3.js"></script> 
</head>
<body class="childrenBody">
<form class="layui-form">
	<blockquote class="layui-elem-quote quoteBox">
		<form class="layui-form" action="${ctx}/myitems/wmUserItem/search" id="searchform">
			<div class="layui-inline">
				<div class="layui-input-inline">
					<input type="text" class="layui-input title" placeholder="请输入要搜索的事项标题" />
				</div>
			</div>
				 
    
      <div class="layui-input-inline">
        <input type="text" class="layui-input createdate" id="test8" placeholder="年月范围">
      </div>
      <div class="layui-input-inline">
	                    <select name="itemType" lay-filter="itemType" class="itemtype" >
	                        <option value="" selected>--请选择--</option>
	                        <option value="0">干部管理</option>
	                        <option value="1" >设备管理</option>
	                        <option value="2" >业务管理</option>
	                    </select>
	                </div>
      <div class="layui-inline">
      
       <div class="layui-input-inline">
	                    <select name="isfinished" lay-filter="isfinished" class="isfinished" >
	                        <option value="0">未完成</option>
	                        <option value="1" >已完成</option>
	                      
	                    </select>
	                </div>
      <div class="layui-inline">
				<a class="layui-btn search_btn" data-type="reload">搜索</a>
			</div>
		<!-- 	<div class="layui-inline">
				<a class="layui-btn layui-btn-normal addNews_btn">添加用户</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-danger layui-btn-normal delAll_btn">批量删除</a>
			</div> -->
		</form>
		
		<%-- <form:form id="searchForm" modelAttribute="dict" action="${ctx}/myitems/wmUserItem/list" method="post" class="breadcrumb form-search">
	
		
	   <form:input path="description" htmlEscape="false" maxlength="50" class="input-medium"/>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
	</form:form> --%>
		
		
		
	</blockquote>
	<table id="domo" lay-filter="domo"></table>

	<!--操作-->
	<script type="text/html" id="userListBar">
		<a class="layui-btn layui-btn-sm"  lay-event="finish">完成</a>
		
		
	</script>
	<!-- <a class="layui-btn layui-btn-warm layui-btn-sm"  lay-event="update">编辑</a> -->
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/plugins/layui/layui.js"></script>
<script type="text/javascript">


layui.use(['form','layer','table','laytpl','laydate'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laytpl = layui.laytpl,
        table = layui.table;
  var laydate = layui.laydate;
//年月范围
 laydate.render({
    elem: '#test8'
    ,type: 'month'
    ,range: true
  });
    //用户列表
    var tableIns = table.render({
        elem: '#domo',
        url : '${ctx}/myitems/wmUserItem/list',
        cellMinWidth : 95,
        page : true,
        height : $(window).height-100,
        limit : 10,
        id : "useritemtable",
        cols : [[	
            {type: "checkbox", fixed:"left", width:50},
           // {field: 'user', title: '用户名', minWidth:100, align:"center"},
           /* {field: 'isFinished', title: '是否完成', minWidth:200, align:'center',templet:function(d){
                return '<a class="layui-blue" href="mailto:'+d.userEmail+'">'+d.userEmail+'</a>';
            }},*/
            {field: 'title', title: '事项标题', align:'left', event:'detail',sort:true ,style:'cursor: pointer;padding：50px 0 ;/* text-decoration: underline; */'},
          /*     {field: 'itemType', title: '事项类型', align:'center',sort:true ,templet:function(d){
                if(d.itemType == "0"){
                    return "干部管理";
                }else if(d.itemType == "1"){
                    return "设备管理";
                }else if(d.itemType == "2"){
                    return "业务管理";
                }
            }},
            {field: 'createDate', title: '申领日期',align: 'center',sort:true ,fontWeight:'bold'},
                {field: 'isFinished', title: '是否完成', align:'center',sort:true ,templet:function(d){
                if(d.isFinished == "0"){
                    return "待完成";
                }else if(d.isFinished == "1"){
                    return "已完成";
                }else{
                  return "";
                }
            }},
           
             {field: 'handleType', title: '办理类型', align:'center',sort:true ,templet:function(d){
                if(d.handleType == "0"){
                    return "办理类型1";
                }else if(d.handleType == "1"){
                    return "办理类型2";
                }else if(d.handleType == "2"){
                    return "办理类型3";
                }else{
                  return "";
                }
            }},
            
           
            
            {title: '操作', minWidth:175, templet:'#userListBar',fixed:"right",align:"center"} */
             {field: 'finishdate', width:350 ,title: '结束日期', sort:true ,align:'center'},
              {title: '操作', width:150 , templet:'#userListBar',fixed:"right",align:"center"} 
        ]]
    });

    //搜索【此功能需要后台配合，所以暂时没有动态效果演示】
    $(".search_btn").on("click",function(){
      //  if($(".searchVal").val() != ''){
            table.reload("useritemtable",{
                page: {
                    curr: 1 //重新从第 1 页开始
                },
                where: {
                   title: $(".title").val(),
                    createdate: $(".createdate").val(),
                   itemtype: $(".itemtype").val() ,
                   isfinished:$(".isfinished").val()
                  /*   createdate: $(".createdate").val();
                    */
                }
            })
            
    });

   //添加用户
  function viewitem(data){
 // var layEvent = obj.event;
   var daid = data.id;
  
        var index = layui.layer.open({
            title : "查看",
            type : 2,
            area:['900px','500px'],
            content : "${ctx}/myitems/wmUserItem/viewonedetailopen?id="+daid,
            success : function(layero, index){
              
                
                setTimeout(function(){
                    layui.layer.tips('点击此处返回我的工作列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            }
        })
     /*    layui.layer.full(index);
        window.sessionStorage.setItem("index",index);
        //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
        $(window).on("resize",function(){
            layui.layer.full(window.sessionStorage.getItem("index"));
        }) */
    }
   
  
      function updateitem(data){
 // var layEvent = obj.event;
   var daid = data.id;
  
        var index = layui.layer.open({
            title : "修改",
            type : 2,
             area:['900px','500px'],
            content : "${ctx}/myitems/wmUserItem/updateonedetailopen?id="+daid,
            success : function(layero, index){
              
                
                setTimeout(function(){
                    layui.layer.tips('点击此处返回我的工作列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            }
        })
        /* layui.layer.full(index);
        window.sessionStorage.setItem("index",index);
        //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
        $(window).on("resize",function(){
            layui.layer.full(window.sessionStorage.getItem("index"));
        }) */
    }
    
    
    
       function finished(data){
 		// var layEvent = obj.event;
 	  var daid = data.id;
  
              layer.confirm('确定提交已完成？',{icon:3, title:'提示信息'},function(index){
             
                    $.ajax({
					type:'post',
					url:'${ctx}/myitems/wmUserItem/finished?str='+ daid,
					dataType:'json',
					success:function(msg){
						//alert(msg.msg);
						
				
						 layer.msg(msg.msg);
			//	 layer.close(index);
				   parent.layer.closeAll();
				     window.location.reload();
						
						
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
        
    }
    
    
    
   table.on('tool(domo)', function(obj){
        var layEvent = obj.event;
          var   data = obj.data;
          var daid = data.id;
        if(layEvent === 'update'){ //编辑
          
          
            updateitem(data);
        }else if(layEvent === 'detail'){//查看
           viewitem(data);
        }else if(layEvent === 'finish'){
            finished(data)
        }
    });
    
    
    table.on('sort(domo)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
		  console.log(obj.field); //当前排序的字段名
		  console.log(obj.type); //当前排序类型：desc（降序）、asc（升序）、null（空对象，默认排序）
		  console.log(this); //当前排序的 th 对象
		  
		  //尽管我们的 table 自带排序功能，但并没有请求服务端。
		  //有些时候，你可能需要根据当前排序的字段，重新向服务端发送请求，从而实现服务端排序，如：
		  table.reload('useritemtable', {
		    initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。 layui 2.1.1 新增参数
		    ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
		      field: obj.field //排序字段
		      ,order: obj.type //排序方式
		    }
		  });
		});
    
    
    
    
    
    
    
    
    
    
    

})




</script>



</body>






</html>