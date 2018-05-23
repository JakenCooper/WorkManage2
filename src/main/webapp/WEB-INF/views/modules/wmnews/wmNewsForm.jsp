<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>历史消息</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/layui.css" media="all">
     <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery-1.8.3.js"></script> 
<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
    <style>
        body{  margin:20px 10px 20px;  }
        #inputserch{
        	height:38px;
        	  margin-top: 10px;
        }
        .layui-form-select .layui-input {
 		 padding-right: 30px;
 	 	cursor: pointer;
 	 	height:38px;
 	 	  margin-top: 10px;
		}
		#fasongbutton{
			margin-top: 10px;
		}
    </style>
</head>

<body>

<form class="layui-form">
	<blockquote class="layui-elem-quote quoteBox">
		<form class="layui-form" action="${ctx}//wmnews/wmNews/search" id="searchform">
			<div class="layui-inline">
				<div class="layui-input-inline">
					<input type="text" class="layui-input title" id="inputserch" placeholder="请输入消息标题" />
				</div>
			</div>
				 
    
      <div class="layui-input-inline">
        <input type="text" class="layui-input createdate" id="test8" style="height: 38px;  margin-top: 10px;" placeholder="年月范围">
      </div>
      <div class="layui-input-inline" >
	                    <select name="status" lay-filter="status" class="status" >
	                         <option value="" selected>--请选择状态--</option>
	                         <option value="未读" >未读</option>-->
	                        <option value="已读" >已读</option>
	                        
	                    </select>
	                </div>
       <shiro:hasPermission name="item:wmTodoItem:edit">
      <div class="layui-input-inline"  style="display:none">
	                    <select name="type" lay-filter="type" class="type" >
	                        
	                        <!--  <option value="0" >我发送的消息</option>-->
	                        <option value="1" selected>我接收的消息</option>
	                       
	                        <option value="2">所有消息</option>
	                        
	                    </select>
	                </div>
	                </shiro:hasPermission>
      <div class="layui-inline">
				<a class="layui-btn search_btn" data-type="reload">搜索</a>
			</div>
	 
        <div class="layui-inline" style="float: right">
            <button type="button"  class="layui-btn addNews_btn"  id="fasongbutton" >发送通知</button>
            
        </div>
      
		</form>
		
     
	</blockquote>



 <div class="" style="clear: both;">
    <table id="history" lay-filter="test"></table>
</div>
<!--列表操作按钮-->
<script type="text/html" id="eventBarDemo">
    <button class="layui-btn layui-btn-sm" lay-event="view">查看</button>
</script>
</form>
<script src="${pageContext.request.contextPath}/static/plugins/layui/layui.js"></script>
<script>

    layui.use(['form','laydate','table'], function(){
        var form=layui.form;
        var $ = layui.jquery
                ,element = layui.element;
        var table = layui.table;
        var layer = layui.layer;
        var laydate = layui.laydate;


$(".addNews_btn").click(function() {
			$.jBox.open("iframe:${ctx}/sysNews/systemNews/form", "消息发布", 700, 500, {


			});
		});


var type= $(".type").val() ;
//alert(type);
var createdate =$(".createdate").val();
var title=$(".title").val() ;
var status = $(".status").val() ;
                  
 var test =1;
        //常规用法
        laydate.render({
            elem: '#test1'
        });
        //年月范围
			 laydate.render({
			    elem: '#test8'
			    ,type: 'month'
			    ,range: true
			  });

        //数据表格
       table.render({
            elem: '#history'
          
            ,height: $(window).height-100
            ,limit: 10
            ,url: '${ctx}/wmnews/wmNews/list?type='+type //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
               {type:'numbers'},
                {field: 'title', title: '标题',sort: true, event:'view',align: 'center',style:'cursor: pointer;/* text-decoration: underline; */'},
                {field: 'sender', title: '通知人',sort: true,align: 'center'},
                {field: 'createDate', title: '通知时间',sort: true,align: 'center'},
                 {field: 'status', title: '状态',sort: true,align: 'center'},
               /*  {fixed:'right', title:'操作', align: 'center', toolbar:'#eventBarDemo'} */
            ]]
        });
        
         table.on('sort(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
		  console.log(obj.field); //当前排序的字段名
		  console.log(obj.type); //当前排序类型：desc（降序）、asc（升序）、null（空对象，默认排序）
		  console.log(this); //当前排序的 th 对象
		  
		  //尽管我们的 table 自带排序功能，但并没有请求服务端。
		  //有些时候，你可能需要根据当前排序的字段，重新向服务端发送请求，从而实现服务端排序，如：
		  table.reload('history', {
		    initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。 layui 2.1.1 新增参数
		    ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
		      field: obj.field //排序字段
		      ,order: obj.type //排序方式
		    }
		  });
		});
           //搜索【此功能需要后台配合，所以暂时没有动态效果演示】
    $(".search_btn").on("click",function(){
             type =$(".type").val();
             createdate= $(".createdate").val();
             title =$(".title").val();
             status =$(".status").val();
          table.reload("history",{
                page: {
                    curr: 1 //重新从第 1 页开始
                },
                where: {
                  //type =$(".type").val(),
            	 createdate: $(".createdate").val(),
            	 title :$(".title").val(),
            	 status :$(".status").val()
                }
            })
           
          
            
    });
        
 });
    
   
</script>

<script>
    layui.use('table', function(){
        var table = layui.table;
        //监听表格复选框选择
        table.on('checkbox(test)', function(obj){
            console.log(obj)
        });
        //监听工具条
        table.on('tool(test)', function(obj){
        
            var data = obj.data;
            var messageid =data.messageid;
            var id = data.id;
       //  alert(  JSON.stringify(data));
            if(obj.event === 'view'){
            
                layer.open({
                        title : "查看",
                        type : 2,
                        content : "${ctx}/wmnews/wmNews/viewonedetailopen?messageid="+messageid+'&id='+id,
                        area:['1000px','665px'],
                        shade:.3,
                        success : function(layero, index){
              
                setTimeout(function(){
                    layui.layer.tips('点击此处返回历史消息界面', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            },
                       /*  btnAlign: 'c' ,//按钮居中
                        btn: ['取消'] */
                     })

            }
        });
    });
</script>
</body>

</html>