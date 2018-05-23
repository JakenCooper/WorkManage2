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

<form class="layui-form" action="" id="replay">
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">标题：</label>
        <div class="layui-input-block">
            <input class="layui-input title" type="text" readonly/>
        </div>
    </div>
   

    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">内容：</label>
        <div class="layui-input-block">
            <textarea class="layui-textarea content"  name="" cols="68" rows="1" readonly></textarea>
        </div>
    </div>

    <div class="layui-form-item layui-form-text">
        <div class="layui-inline">
            <label class="layui-form-label">通知人：</label>
            <div class="layui-input-inline">
                <input class="layui-input sender" type="text" readonly/>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">通知时间：</label>
            <div class="layui-input-inline">
                <input class="layui-input createdate" type="text" placeholder="2018-04-10" readonly />
            </div>
        </div>

    </div>
    <div>
			
			 <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">回复：</label>
        <div class="layui-input-block">
            <textarea class="layui-textarea replaycontent"  name="replaycontent" cols="15" lay-verify="replaycontent"  rows="1"></textarea>
        </div>
    </div>
    
    
    <div class="layui-form-item layui-row layui-col-xs12" id="replaycontent" style="align:center" >
		<div class="layui-input-block">
			<button class="layui-btn layui-btn-sm" lay-submit="" lay-filter="addreplaycontent" style="align:center" >确认回复</button>
			<!-- <button type="reset" class="layui-btn layui-btn-sm layui-btn-primary">重置</button> -->
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<!-- <button style="marginright:10px;" class=" layui-btn-sm layui-btn-primary close"  onclick="close()">取消</button> -->
			
		</div>
	</div>
    <input type="hidden" name="id" class="newsidid">
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
form.verify({  
        replaycontent: function(value){  
          if(value.length < 1){  
            return '回复请输入至少1个字符';  
          }  
        }
       /*  ,phone: [/^1[3|4|5|7|8]\d{9}$/, '手机必须11位，只能是数字！']  
        ,email: [/^[a-z0-9._%-]+@([a-z0-9-]+\.)+[a-z]{2,4}$|^1[3|4|5|7|8]\d{9}$/, '邮箱格式不对']   */
  }); 


  form.on('submit(addreplaycontent)', function (data) {
       
      
            $.ajax({
                url: '${ctx}/wmnewsreceivers/wmNewsReceiver/edittj',
                type: "post",
                dataType: "json",
                data: $('#replay').serialize(),
                async: false,
                success:function(msg) {
               // alert(msg.msg);    
                 //   if (data.code == 0) {
                       //window.location.reload(true);
                      // location.reload();
                       //layer.msg(msg.msg);
                     //  alert(msg.msg);
                      // this.layer.msg(msg.msg);
                     //layer.msg(msg.msg);
                    // layui.layer.msg("用户添加成功！");
                        parent.layer.closeAll();
                         window.parent.location.reload();
                       //window.location.href="${ctx}/item/wmTodoItem/list";
                   // }
                }
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });








	//	alert("是普通人并且不是他发送的");
		 $.ajax({
					type:'post',
					url:'${ctx}/wmnews/wmNews/detail?messageid=<%=request.getParameter("messageid")%>&id=<%=request.getParameter("id")%>',
					dataType:'json',
					success:function(msg){
					//alert(  JSON.stringify(msg.news.replaycontent));
					//alert(msg.wmTodoItem.itemType);
						$(".content").val(msg.news.content);
						$(".title").val(msg.news.title);
						$(".sender").val(msg.news.sender);
						$(".createdate").val(msg.news.createDate);
						$(".replaycontent").val(msg.news.replaycontent);
						$(".newsidid").val(msg.newssid);
						
						form.render('select');
						if(msg.replay !=="没有回复"){
						   $("#replaycontent").css('display','none');
						}
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
                // {field: 'createDate', title: '接收时间',align: 'center',fontWeight:'bold'},
                  {field: 'updateDate', title: '回复时间',align: 'center',fontWeight:'bold'},
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
    
    
    
    /* function close(){
    alert("gsweg");
     layer.closeAll();
    } */
     });
</script>
</body>

</html>