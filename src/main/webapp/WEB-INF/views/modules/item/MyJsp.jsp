<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>待办事项</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/layui.css" media="all">
    <style>
        body{  margin:20px 10px 20px;  }
        .layui-tab-content table tr th{
            font-weight: bold;
            color: #333;
        }
         .background{  
       bgcolor:#CCC;  
  }  
    </style>
</head>
<body>
<%@ page import="java.util.*"%>
<% 
    Calendar calendar=Calendar.getInstance(); 
    int year=calendar.get(Calendar.YEAR); 
    int month=calendar.get(Calendar.MONTH)+1; 
    int day=calendar.get(Calendar.DATE);    
     %> 

<form class="layui-form">

<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <ul class="layui-tab-title liid">
         <li lay-id="11" id="1" onclick="showinfo(1)">一月</li>
        <li lay-id="22" id="2" onclick="showinfo(2)">二月</li>
        <li lay-id="33" id="3" onclick="showinfo(3)">三月</li>
        <li lay-id="44" id="4" onclick="showinfo(4)">四月</li>
        <li lay-id="55" id="5" onclick="showinfo(5)">五月</li>
        <li lay-id="66" id="6" onclick="showinfo(6)">六月</li>
        <li lay-id="77" id="7" onclick="showinfo(7)">七月</li>
        <li lay-id="88" id="8" onclick="showinfo(8)">八月</li>
        <li lay-id="99" id="9" onclick="showinfo(9)">九月</li>
        <li lay-id="100" id="10" onclick="showinfo(10)">十月</li>
        <li lay-id="101" id="11" onclick="showinfo(11)">十一月</li>
        <li lay-id="102" id="12" onclick="showinfo(12)">十二月</li>
    </ul>
    <shiro:hasPermission name="item:wmTodoItem:edit">
    <div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;padding: 20px 10px 0;" >
        <div style="float: left">
            <button type="button"  class="layui-btn addNews_btn" >添加事项</button>
            <button type="button"  class="layui-btn layui-btn-danger batchDel" >批量删除</button>
        </div>
        <div style="float: right">
            <button class="layui-btn layui-btn-normal">导出</button>
            <button class="layui-btn layui-btn-warm">打印</button>
        </div>
    </div>
    </shiro:hasPermission>
    
    <div class="layui-tab-content" style="clear: both;">
    
    <table id="domo" lay-filter="domo"></table>
    <sys:message content="${message}"/>	
    </div>
</div>
 
<!--列表操作按钮-->
  

<script src="${pageContext.request.contextPath}/static/jquery/jquery.min.js"></script>
<script type="text/html" id="userListBar">
         <a class="layui-btn layui-btn-sm" lay-event="detail">查看</a>
        
		 <a class="layui-btn layui-btn-warm layui-btn-sm" lay-event="edit">编辑</a>
		<a class="layui-btn layui-btn-sm layui-btn-normal" lay-event="apply">申领</a>
		<a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</a>

</script>

</form>

<script src="${pageContext.request.contextPath}/static/plugins/layui/layui.js"></script>

<script type="text/javascript">

        $(function(){
    var d=new Date();
    /*m值为3，下标从0开始*/
    var m=d.getMonth()+1;
    $('.liid li').eq(m-1).addClass('layui-this');
    showinfo(m);
});    



layui.use(['form','layer','table','laytpl'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laytpl = layui.laytpl,
        table = layui.table;

//alert("come in ..");
    //用户列表
   <%--  var tableIns = table.render({
        elem: '#domo',
        url : '${ctx}/item/wmTodoItem/list?month=<%=month %>',
        cellMinWidth : 95,
        page : true,
        height : "full-125",
        limit : 10,
        id : "domo",
        cols: [[ //表头
                {type:'numbers'},
//                {type: 'checkbox'},
                {type: 'checkbox'},
                 //{field: 'id', type:'hidden', title: '序号',align: 'center',fontWeight:'bold',width:120},
                 {field: 'content', title: '内容',align: 'center',fontWeight:'bold'},
                 {field: 'operationType', title: '待操作类型',align: 'center',fontWeight:'bold'},
                 {field: 'itemType', title: '事项类型',align: 'center',fontWeight:'bold'},
                 {field: 'status', title: '状态',align: 'center',fontWeight:'bold'},
                 {field: 'updateDate', title: '更新日期',align: 'center',fontWeight:'bold'},
                 {title: '操作', minWidth:175, templet:'#userListBar',fixed:"right",align:"center"}

        ]]
    });
 --%>
<%-- //$("#<%=month %>").addClass("layui-this");  --%>

 


 function addItem(edit){
        var index = layui.layer.open({
            title : "添加用户",
            type : 2,
            content : "${ctx}/item/wmTodoItem/itemsadd",
            success : function(layero, index){
                var body = layui.layer.getChildFrame('body', index);
                if(edit){
                   /*  body.find(".userName").val(edit.userName);  //登录名
                    body.find(".userEmail").val(edit.userEmail);  //邮箱
                    body.find(".userSex input[value="+edit.userSex+"]").prop("checked","checked");  //性别
                    body.find(".userGrade").val(edit.userGrade);  //会员等级
                    body.find(".userStatus").val(edit.userStatus);    //用户状态
                    body.find(".userDesc").text(edit.userDesc);    //用户简介
                    form.render(); */
                }
                setTimeout(function(){
                    layui.layer.tips('点击此处返回事项列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            }
        })
        layui.layer.full(index);
        window.sessionStorage.setItem("index",index);
        //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
        $(window).on("resize",function(){
            layui.layer.full(window.sessionStorage.getItem("index"));
        })
    }
    $(".addNews_btn").click(function(){
        addItem();
    })





   table.on('tool(domo)', function(obj){
        var layEvent = obj.event;
          var   data = obj.data;
          var daid = data.id;
        if(layEvent === 'edit'){ //编辑
            addItem(data);
        }else if(layEvent === 'del'){ //删除
            layer.confirm('确定删除此事项？',{icon:3, title:'提示信息'},function(index){
                // $.get("删除文章接口",{
                //     newsId : data.newsId  //将需要删除的newsId作为参数传入
                // },function(data){
                window.location.href="${ctx}/item/wmTodoItem/deletemore?str="+ daid+"";
                    tableIns.reload();
                    layer.close(index);
                // })
            });
        }else if(layEvent === 'detail'){//查看
           addItem(data);
        }else if(layEvent === 'apply'){//申领
           layer.confirm('确定要申领此事项？',{icon:3, title:'提示信息'},function(index){
           //alert("come in ");
                // $.get("删除文章接口",{
                //     newsId : data.newsId  //将需要删除的newsId作为参数传入
                // },function(data){
               window.location.href="${ctx}/item/wmTodoItem/applyfor?str="+ daid+"";
                    /*  $.ajax({
                    
                 url:'${ctx}/item/wmTodoItem/applyfor?str='+ daid+'',
                 type:"get",
                 msg:"",
                 success:function (data) {
                     var obj = JSON.parse(data);
                     alert(obj.data)
                 }
             }) */
                   
                   
                   
                    layer.close(index);
                // })
            });
        }
    });



//批量删除
    $(".batchDel").click(function(){
    
        var checkStatus = table.checkStatus('domo'),
            data = checkStatus.data,
            newsId = [];
        if(data.length > 0) {
            for (var i in data) {
                newsId.push(data[i].id);
               
            }
            layer.confirm('确定删除选中的事项？', {icon: 3, title: '提示信息'}, function (index) {
                // $.get("删除文章接口",{
                //     newsId : newsId  //将需要删除的newsId作为参数传入
                // },function(data){
                 window.location.href="${ctx}/item/wmTodoItem/deletemore?str="+ newsId.toString()+"";
                //  window.location.href="${ctx}/item/wmTodoItem/deletemore?str="+ newsId.toString()+"";
                tableIns.reload();
                layer.close(index);
                // })
            })
        }else{
            layer.msg("请选择需要删除的待办事项");
        }
    })




})

  


   
    
     
    
    
</script>

<script>
	function showinfo(month){
		//li 点击事件
		 var month = month;
		 var monthnow = <%=month %>;
		
		
		
		// var months = month-1;
		// alert(months);
		//alert("sfes");
		//month.addClass('layui-this').siblings().removeClass();
		  $('.liid li').eq(month-1).addClass('layui-this').siblings().removeClass();
		
		 layui.use('table', function(){
        var $ = layui.jquery
                ,element = layui.element;
        var table = layui.table;
        table.render({
            elem: '#domo'
            ,id: 'domo'
            ,height: $(window).height-100
            ,limit: 10
            ,url: '${ctx}/item/wmTodoItem/list?month='+month //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
              {type:'numbers'},
//                {type: 'checkbox'},
                {type: 'checkbox'},
             
                 {field: 'content', title: '内容',align: 'center',fontWeight:'bold'},
                 {field: 'operationType', title: '待操作类型',align: 'center',fontWeight:'bold'},
                 {field: 'itemType', title: '事项类型',align: 'center',fontWeight:'bold'},
                 {field: 'status', title: '状态',align: 'center',fontWeight:'bold'},
                 {field: 'updateDate', title: '更新日期',align: 'center',fontWeight:'bold'},
                  {title: '操作', minWidth:175, templet:'#userListBar',fixed:"right",align:"center"}
            ]]
        });
         });
         
         
         if(monthnow >2 && monthnow - month ==1){
         
	     
	     $("#domo").addClass("backgroud");
	     alert("只变色");
		}else if(monthnow >2 && monthnow - month >=2){
		//变色 改成补办
		alert("变色并改按钮");
		$("#domo").addClass("backgroud");
		}
		
	}
	</script>

</body>

</html>