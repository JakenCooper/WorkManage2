<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%-- <%@include file="/WEB-INF/views/include/head.jsp"%> --%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>查看事项</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/jquery/jquery-1.8.3.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/plugins/layui/css/layui.css"
	media="all">
<style>
body {
	margin: 20px 10px 20px;
}
</style>
</head>

<body class="childrenBody">
	<sys:message content="${message}" />
	<form class="layui-form" style="width:100%;" id="itemsss">
	
	<div><input type="hidden" name ="id" class="id"></div>
	<div><input type="hidden" name ="showicon" class="showicon"></div>
		<div class="layui-form-item layui-row layui-col-xs12">
			<label class="layui-form-label">事项内容</label>
			<div class="layui-input-block">
				<textarea class="layui-textarea content" name="content"  lay-verify="content"></textarea>
			</div>
		</div>

	<div class="layui-form-item layui-row layui-col-xs12">
				<label class="layui-form-label">附件上传</label> 
				<div class="layui-upload" style=" margin-left: 110px;">
				  <button type="button" class="layui-btn " id="testList">选择文件</button>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				    <button type="button" class="layui-btn " id="testListAction">开始上传</button>
				  <div class="layui-upload-list">
				    <table class="layui-table">
				     <!--  <thead>
				        <tr><th>文件名</th>
				        <th>大小</th>
				        <th>状态</th>
				        <th>操作</th>
				      </tr></thead> -->
				      <tbody id="demoList"></tbody>
				    </table>
				  </div>
				
				</div> 
			</div>


	<div class="layui-form-item layui-row layui-col-xs12 shenling" id="shenling" style="display:none" >
		<div class="layui-input-block" align="right" style="margin-right:50px;">
	
			<button class="layui-btn  applyfor"  id="applyfor">申领</button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
		
			
		</div>
	</div> 
	
	
		<div class="layui-form-item layui-row layui-col-xs12 wancheng" id="wancheng" style="display:none">
		<div class="layui-input-block" align="right" style="margin-right:50px;">
		<!-- 	<button class="layui-btn " lay-submit="" lay-filter="itemsubmit" >确认修改</button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
		
			
			<button class="layui-btn finished"  id="finished" >完成</button>
		
			
		</div>
	</div> 
	
	
	
		<div>
			<hr>
			<div class="layui-tab-content" style="clear: both;">

				<table id="domo" lay-filter="domo"></table>


			</div>
		


		</div>


		</div>
		</div>
		
	

	</form>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/plugins/layui/layui.js"></script>
	<script type="text/javascript">

layui.use(['form','layer','table','upload'],function(){
    var form = layui.form
        layer = parent.layer === undefined ? layui.layer : top.layer,
          upload = layui.upload,
        $ = layui.jquery;

	  var table = layui.table;
	
	
	
				
				//多文件列表示例
  var demoListView = $('#demoList')
  ,uploadListIns = upload.render({
    elem: '#testList'
    ,url: '/upload/'
    ,accept: 'file'
    ,multiple: true
    ,auto: false
    ,bindAction: '#testListAction'
    ,choose: function(obj){   
      var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
      //读取本地文件
      obj.preview(function(index, file, result){
        var tr = $(['<tr id="upload-'+ index +'">'
          ,'<td>'+ file.name +'</td>'
          ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
          ,'<td>等待上传</td>'
          ,'<td>'
            ,'<button class="layui-btn layui-btn-mini demo-reload layui-hide">重传</button>'
            ,'<button class="layui-btn layui-btn-mini layui-btn-danger demo-delete">删除</button>'
          ,'</td>'
        ,'</tr>'].join(''));
        
        //单个重传
        tr.find('.demo-reload').on('click', function(){
          obj.upload(index, file);
        });
        
        //删除
        tr.find('.demo-delete').on('click', function(){
          delete files[index]; //删除对应的文件
          tr.remove();
          uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
        });
        
        demoListView.append(tr);
      });
    }
    ,done: function(res, index, upload){
      if(res.code == 0){ //上传成功
        var tr = demoListView.find('tr#upload-'+ index)
        ,tds = tr.children();
        tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
        tds.eq(3).html(''); //清空操作
        return delete this.files[index]; //删除文件队列已经上传成功的文件
      }
      this.error(index, upload);
    }
    ,error: function(index, upload){
      var tr = demoListView.find('tr#upload-'+ index)
      ,tds = tr.children();
      tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
      tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
    }
  });

          $.ajax({
					type:'post',
					url:'${ctx}/item/wmTodoItem/detail?id=<%=request.getParameter("id")%>&showicon=<%=request.getParameter("showicon")%>',
					dataType:'json',
					success:function(msg){
					
					if(msg.wmTodoItem.showicon =='0'){
					
					  	$('.shenling').css('display','initial') ;
					}
					if(msg.wmTodoItem.showicon =='1'){
					
					  	$('.wancheng').css('display','initial') ;
					}
					//alert(msg.wmTodoItem.itemType);
						$(".content").val(msg.wmTodoItem.content);
						$(".itemType").val(msg.wmTodoItem.itemType);
						$(".id").val(msg.wmTodoItem.id);
						$(".status").val(msg.wmTodoItem.status);
						$(".itemType").val(msg.wmTodoItem.itemType);
						$(".showicon").val(msg.wmTodoItem.showicon);
						$(".operationType").val(msg.wmTodoItem.operationType);
						form.render('select');
						//alert(msg.msg);
						if(msg.msg == "有人认领" ){
						/* //$(".rlinfo").show();
						alert("sgfe"); */
						//有认领信息
						 var tableIns = table.render({
        elem: '#domo',
        data : msg.useritemlist,
        cellMinWidth : 95,
        height : $(window).height-100,
        id : "domo",
        cols: [[ //表头
                {type:'numbers'},
//                {type: 'checkbox'},
              
                 {field: 'user', title: '认领人',align: 'center',fontWeight:'bold'},
               
                 {field: 'createDate', title: '认领时间',align: 'center',fontWeight:'bold'},
                 {field: 'handleResult', title: '办理原因',align: 'center',fontWeight:'bold'},
               /*   {field: 'updateDate', title: '最后修改时间',align: 'center',fontWeight:'bold'}, */
                 {field: 'isFinished', title: '是否完成', align:'center',templet:function(d){
                if(d.isFinished == "0"){
                    return "待完成";
                }else if(d.isFinished == "1"){
                    return "已完成";
                }else{
                return "";
                }
            }},
             {field: 'handleType', title: '办理类型', align:'center',templet:function(d){
                if(d.handleType == "0"){
                    return "办理类型1";
                }else if(d.handleType == "1"){
                    return "办理类型2";
                }else if(d.handleType == "2"){
                    return "办理类型3";
                }else {
                return "";
                }
            }}
            

        ]]
    });
						
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
				
				
				
				
				
				 form.verify({  
        content: function(value){  
          if(value.length < 5){  
            return '办理原因请输入至少4个字符';  
          }  
        }
       /*  ,phone: [/^1[3|4|5|7|8]\d{9}$/, '手机必须11位，只能是数字！']  
        ,email: [/^[a-z0-9._%-]+@([a-z0-9-]+\.)+[a-z]{2,4}$|^1[3|4|5|7|8]\d{9}$/, '邮箱格式不对']   */
  }); 

   form.on('submit(itemsubmit)', function (data) {
       
      
            $.ajax({
                url: '${ctx}/item/wmTodoItem/edittj',
                type: "post",
                dataType: "json",
                data: $('#itemsss').serialize(),
                async: false,
                success:function(msg) {
             
                        parent.layer.closeAll();
                         window.parent.location.reload();
                     
                }
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });
  
  
  
 $(document).on('click','#applyfor',function(){
       
   var daid = $(".id").val();
  

              layer.confirm('确定要申领此事项？',{icon:3, title:'提示信息'},function(index){
             
                    $.ajax({
					type:'post',
					url:'${ctx}/item/wmTodoItem/applyfor?str='+ daid,
					dataType:'json',
					success:function(msg){
						//alert(msg.msg);
						if(msg.msg == "您已申领过此事项，不可重复申领!"){
						 layer.msg(msg.msg);
						}else{
						//判断是否跳转页面
					/* layer.confirm('申领成功，立即跳转到我的工作界面？', {
				    btn: ['确定跳转','暂不跳转'], //按钮
				    shade: false //不显示遮罩
				}, function(){
					//跳转到我的工作界面
					layer.closeAll();
					//window.location.reload();
				parent.cursorToUnionSealToSignList();
			//	parent.cursorToUnionSealToSignList2();
				}, function(){
				    
				}); */
				 layer.msg("申领成功，可到我的工作界面中进行查看");
			//	 layer.close(index);
				   parent.layer.closeAll();
				     window.parent.location.reload();
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
                   
              
           
     });
  
  
  
  
  
   $(document).on('click','#finished',function(){
       
   var daid = $(".id").val();
  

              layer.confirm('确定提交已完成？',{icon:3, title:'提示信息'},function(index){
             
                    $.ajax({
					type:'post',
					url:'${ctx}/item/wmTodoItem/finished?str='+ daid,
					dataType:'json',
					success:function(msg){
						//alert(msg.msg);
						
				
						 layer.msg(msg.msg);
			//	 layer.close(index);
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
  
 
})

</script>
</body>

</html>
