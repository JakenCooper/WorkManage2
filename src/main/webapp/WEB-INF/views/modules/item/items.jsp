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
    <title>添加事项</title>
   
  <script src="${pageContext.request.contextPath}/static/custom/textEditor.js" type="text/javascript"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery-1.8.3.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/layui.css" media="all">
    <style>
        body{  margin:20px 10px 20px;  }
        
        .layui-textarea {
		  min-height: 50px;
		  /* height: auto; */
		  line-height: 20px;
		  padding: 6px 10px;
		  resize: vertical;
			}
			 .uploadBox{
            position: relative;
        }
        #demoList{
            position: absolute;
            top:8px;
            left: 115px;
        }
        #demoList li{
            float: left;
            margin-right:5px;;
        }
    </style>
</head>

<body class="childrenBody">
<sys:message content="${message}"/>	
<form class="layui-form" style="width:80%;" <%-- action="${ctx}/item/wmTodoItem/save" --%> id="itemadd" method="post" enctype="multipart/form-data" >
	<div class="layui-form-item layui-row layui-col-xs12">
			<label class="layui-form-label">工作标题</label>
			<div class="layui-input-block">
				<textarea placeholder="请输入工作标题" class="layui-textarea title" name="title" lay-verify="title" ></textarea>
			</div>
		</div>


	
	<div class="layui-form-item layui-row layui-col-xs12">
		<label class="layui-form-label">工作内容</label>
		<div class="layui-input-block">
			<textarea placeholder="请输入工作内容" class="layui-textarea content" name="content" lay-verify="content" ></textarea>
		</div>
	</div>
	
	
			<!-- <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
			
			</fieldset>  -->
		<!-- 	<div class="layui-form-item layui-row layui-col-xs12">
			<label class="layui-form-label">附件上传</label> 
			<div class="layui-upload" style=" margin-left: 110px;">
			  <button type="button" class="layui-btn " id="testList">选择文件</button>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			    <button type="button" class="layui-btn " id="testListAction">开始上传</button>
			  <div class="layui-upload-list">
			    <table class="layui-table">
			      <thead>
			        <tr><th>文件名</th>
			        <th>大小</th>
			        <th>状态</th>
			        <th>操作</th>
			      </tr></thead>
			      <tbody id="demoList"></tbody>
			    </table>
			  </div>
			
			</div> 
		</div>
		 -->
		 <div class="layui-form-item layui-row layui-col-xs12">
			<label class="layui-form-label">上传正文</label> 
		 <div class="layui-upload uploadBox">
 		 <button type="button" class="layui-btn layui-btn-normal" id="test8">选择文件</button> <ul style="margin-left:100px;"id="singleList"> </ul>
	   <!--   <button type="button" class="layui-btn" id="test9">开始上传</button> -->
		</div>
			</div>	
			
			
			 <div class="layui-form-item layui-row layui-col-xs12">
			<label class="layui-form-label">上传附件</label> 
		  	<div class="layui-upload uploadBox">
  			  <button type="button" class="layui-btn layui-btn-normal" id="testList">选择文件</button> <ul style="margin-left:100px;"id="demoList"> </ul>
   
    <!--<button type="button" class="layui-btn" id="testListAction">开始上传</button>-->
</div>
			</div>	
			
			
			
	<div class="layui-form-item layui-row layui-col-xs12">
				<label class="layui-form-label">完成时限</label>
				 <div class="layui-input-block">
		        <input type="text" class="layui-input" id="test1" name="finishdate">
		        <input type="hidden" id="preid"/>
		        <!-- <a id="operDoc" role="menuitem" tabindex="-1" href="#" onclick="operDoc(1,1,'msgSpot','cacheAddr','msgContent','${ctx}','${pageContext.request.contextPath}','e://')">打开word</a> -->
		      </div>
			</div>
	
	
	
		<div class="layui-form-item layui-row layui-col-xs12">
				<label class="layui-form-label">是否回馈</label>
				<div class="layui-input-block">
					<select name="isreplay" class="isreplay" lay-filter="isreplay">
						<option value="0">是</option>
						<option value="1" selected>否</option>
					
					</select>
				</div>
			</div>
	
		
	
	
	<div class="layui-form-item layui-row layui-col-xs12" style="height:38px;">
	
	</div>
	
	
	<div class="layui-form-item layui-row layui-col-xs12">
		<div class="layui-input-block" align="center">
			<button class="layui-btn layui-btn-sm" lay-submit="" lay-filter="addItem" >添加</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<!-- <button type="reset" class="layui-btn layui-btn-sm layui-btn-primary">重置</button> -->
			<!-- <button  class=" layui-btn-sm layui-btn-primary" onclick="javascript:history.back();">取消</button> -->
			
		</div>
	</div>
</form>
 <script src="${pageContext.request.contextPath}/static/plugins/layui/layui.js"></script>
<script type="text/javascript">
 
layui.use(['form','layer','upload','laydate'],function(){
    var form = layui.form
        layer = parent.layer === undefined ? layui.layer : top.layer,
         upload = layui.upload,
         laydate = layui.laydate,
        $ = layui.jquery;
       
     //  layer = layui.layer;
 
 
 
 	var singleList=$('#singleList');
    uploadSingle=upload.render({
    elem: '#test8'
    ,url: '${ctx}/item/wmTodoItem/save'
    ,auto: false
    ,data:$('#itemadd').serialize()
    ,accept: 'file'
    //,multiple: true
  //  ,bindAction: '#test9'
    ,done: function(res){
      console.log(res);
    },choose:function(obj){
     	var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
              //读取本地文件
              obj.preview(function(index, file, result){
                  var li = $(['<li id="upload-'+ index +'">'
                          ,'<a>'+ file.name +'</a>'
                      ,'<a>'
                      ,'<i class="layui-icon demo-delete" style="cursor: pointer;">&#x1006;</i>'
                      ,'</a>'
                      ,'</li>'].join(''));

                  //单个重传
                  li.find('.demo-reload').on('click', function(){
                      obj.upload(index, file);
                  });

                  //删除
                  li.find('.demo-delete').on('click', function(){
                      delete files[index]; //删除对应的文件
                      li.remove();
                      uploadSingle.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
                  });

                  singleList.append(li);
              });
    }
  });
 
 
  laydate.render({
    elem: '#test1'
  });
  //附件多文件
   var demoListView = $('#demoList')
                ,uploadListIns = upload.render({
                    elem: '#testList'
                    //,url: '/upload/'
                    ,url:'${ctx}/item/wmTodoItem/saveAttachment'
                    ,data:{preid:'${preid}'}
                    ,accept: 'file'
                    ,multiple: true
                    ,auto: false
                    //,bindAction: '#testListAction'
                    ,choose: function(obj){
                        var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
                        //读取本地文件
                        obj.preview(function(index, file, result){
                            var li = $(['<li id="upload-'+ index +'">'
                                    ,'<a>'+ file.name +'</a>'
                                ,'<a>'
                                ,'<i class="layui-icon demo-delete" style="cursor: pointer;">&#x1006;</i>'
                                ,'</a>'
                                ,'</li>'].join(''));

                            //单个重传
                            li.find('.demo-reload').on('click', function(){
                                obj.upload(index, file);
                            });

                            //删除
                            li.find('.demo-delete').on('click', function(){
                                delete files[index]; //删除对应的文件
                                li.remove();
                                uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
                            });

                            demoListView.append(li);
                        });
                    }
                    ,done:function(res,index,upload){
                    	if(res.code==0){
                    		//$('#preid').val(res.preid);
                    		submitFormOnce(res.preid);
                    	}else{
                    		parent.layer.msg('请重新刷新页面');
                    	}
                    }
                    ,error:function(){
                    	this.layer.msg('error!');
                    }
//                    ,done: function(res, index, upload){
//                        if(res.code == 0){ //上传成功
//                            var tr = demoListView.find('tr#upload-'+ index)
//                                    ,tds = tr.children();
//                            tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
//                            tds.eq(3).html(''); //清空操作
//                            return delete this.files[index]; //删除文件队列已经上传成功的文件
//                        }
//                        this.error(index, upload);
//                    }
//                    ,error: function(index, upload){
//                        var tr = demoListView.find('tr#upload-'+ index)
//                                ,tds = tr.children();
//                        tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
//                        tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
//                    }
                });
	var submit_charge=false;
	function submitFormOnce(){
		/*if(submit_charge){
			return ;
		}
		submit_charge=true;
		var data_to_submit=$('#itemadd').serialize()+'&preId='+arguments[0];
		console.log(data_to_submit);
        $.ajax({
           url: '${ctx}/item/wmTodoItem/save',
           type: "post",
           dataType: "json",
           data: data_to_submit,
           async: false,
           success:function(msg) {
              parent.layer.closeAll();
              window.parent.location.reload();
           }
       });*/
	}
  
   form.verify({  
        content: function(value){  
          if(value.length < 1){  
            return '请输入事项内容';  
          }  
        },
         title: function(value){  
          if(value.length < 1){  
            return '请输入事项标题';  
          }  
        }
       /*  ,phone: [/^1[3|4|5|7|8]\d{9}$/, '手机必须11位，只能是数字！']  
        ,email: [/^[a-z0-9._%-]+@([a-z0-9-]+\.)+[a-z]{2,4}$|^1[3|4|5|7|8]\d{9}$/, '邮箱格式不对']   */
  }); 
  
    form.on('submit(addItem)', function (data) {
       
       		console.log($('#file').val());
       		console.log(uploadSingle.config.elem[0].value);
       		uploadSingle.upload();
       		//uploadListIns.upload();
      		//return false;
           	
           	/*var formdata=$('#itemadd').serialize()+'&preId=${preid}';
           	console.log(formdata);
           	$.ajax({
                url: '${ctx}/item/wmTodoItem/save',
                type: "post",
                dataType: "json",
                data: formdata,
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
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。*/
        });


    //格式化时间
    function filterTime(val){
        if(val < 10){
            return "0" + val;
        }else{
            return val;
        }
    }
    //定时发布
    var time = new Date();
    var submitTime = time.getFullYear()+'-'+filterTime(time.getMonth()+1)+'-'+filterTime(time.getDate())+' '+filterTime(time.getHours())+':'+filterTime(time.getMinutes())+':'+filterTime(time.getSeconds());

})

</script>

<script>
/* function additems(){
   

  
 $("#itemadd").submit(); 
} */

/* function history(){
$
} */


</script>
</body>

</html>
