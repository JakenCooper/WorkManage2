<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@include file="/WEB-INF/views/include/head.jsp" %> 
<html>
<head>
	<title>在线排班</title>
	<meta name="decorator" content="default"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/plugins/layui/css/layui.css" media="all"> 
	<script src="${pageContext.request.contextPath}/static/plugins/layui/layui.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(function(){
			
			$("#searchForm").hide();
			//导出数据
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/duty/wmOnduty/exportFile");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			//导入数据
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
				bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
			
		})
	</script>
</head>
<body style="margin:15px;">
	<sys:message content="${message}"></sys:message>
	
	<form:form id="searchForm" modelAttribute="wmOnduty"  method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	</form:form>
	<!--导入  -->
	<div id="importBox" class="hide">
		<form id="importForm" modelAttribute="wmOnduty" action="${ctx}/duty/wmOnduty/importFile" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" ><br/>
			<input id="uploadFile" name="file" type="file" style="width:500px" /><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   " style="float: right;"/>
		</form>
	</div>
	<!--end  -->
	<div class="">
	    <div style="float: left">
	      <button type="button"  class="layui-btn newsAdd_btn">在线排班</button>
	      <button type="button"  class="layui-btn layui-btn-danger" id="batchDel" >批量删除</button>
 	     <%-- <a href="${ctx}/duty/wmOnduty/addWmonDutyForm" class="layui-btn">在线排班</a>   --%>
	        <!--<button type="button"  class="layui-btn layui-btn-danger">批量删除</button>-->
	    </div>
	    <div style="float: right">
	        <button class="layui-btn layui-btn-warm" id="btnImport">导入</button>
	        <button class="layui-btn layui-btn-normal" id="btnExport">导出</button>
	        <a href="${ctx}/duty/wmOnduty/exportFileTemplate" class="layui-btn">下载模板</a>
	      <!--   <button class="layui-btn layui-btn-warm">打印</button> -->
	    </div>
	</div>
	<div>
	    <table id="testlog" class="layui-table" lay-filter="wmOnduty_info" ></table>
	</div>
	<!-- <div id="layuiPage"></div> -->
<!--列表操作按钮-->
<script type="text/html" id="eventBarDemo">
    <!--<button class="layui-btn layui-btn-sm" lay-event="view">分配权限</button>-->
    <!--<button class="layui-btn layui-btn-warm layui-btn-sm" lay-event="edit">编辑</button>-->
    <!--<button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del">删除</button>-->
<button class="layui-btn  layui-btn-sm btn-datail" lay-event="wmOnduty" data-type="addWmOnduty">在线排班</button>
</script>
<script type="text/html" id="del_btn">
  <button class="layui-btn  layui-btn-sm btn-datail" lay-event="del_wmOnduty" data-type="getCheckData">删除</button>
</script>
<script>
	$(function(){
		
	/* 	layui.use('laypage', function(){
		var num="${countWmOnduty}";
		alert(num);
		var laypage = layui.laypage;
		  
		  //执行一个laypage实例
		  laypage.render({
		    elem: 'layuiPage' //注意，这里的 test1 是 ID，不用加 # 号
		    ,count: 13 //数据总数，从服务端得到
		  });
		}); */
 		
		
	    layui.use(['form','laydate','table'], function(){
	        var form=layui.form;
	        var $ = layui.jquery
	                ,element = layui.element;
	        var table = layui.table;
	        var layer = layui.layer;
	        var laydate = layui.laydate;
	       
		     $(".newsAdd_btn").click(function(){
				layui.layer.open({	
	                title : "在线排班",
	                type : 2,
	                area:['600px','450px'],
	                content : '${ctx}/duty/wmOnduty/addWmonDutyForm',
	               /*  btn: ['取消', ''],
	                btnAlign: 'c' ,//按钮居中 */
	                shade:.3 //显示遮罩
	           /*      yes: function(){
	                    layer.closeAll();
	                    alert(1);
	                } */
	            });
			 });
			 //排序区域
			  table.on('sort(wmOnduty_info)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
				  console.log(obj.field); //当前排序的字段名
				  console.log(obj.type); //当前排序类型：desc（降序）、asc（升序）、null（空对象，默认排序）
				  console.log(this); //当前排序的 th 对象
				  
				  //尽管我们的 table 自带排序功能，但并没有请求服务端。
				  //有些时候，你可能需要根据当前排序的字段，重新向服务端发送请求，从而实现服务端排序，如：
				  table.reload('id', {
				    initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。 layui 2.1.1 新增参数
				    ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
				      field: obj.field //排序字段
				      ,order: obj.type //排序方式
				    }
				  });
				});
			 //批量删除
 			 $("#batchDel").click(function(){
			 	 var checkStatus = table.checkStatus('id');
			 	 var data=checkStatus.data;
			 	 var ids=[];
			 	 
		 	     if(data.length > 0) {
		            for (var i in data) {
		                ids.push(data[i].id);
		            }
		            var ids_Str=ids.toString();
		            console.log(ids_Str);
		            layer.confirm('确定删除所选排班信息吗？', {icon: 3, title: '提示信息'}, function (index) {
				 		$.ajax({
				  	 		url:'${ctx}/duty/wmOnduty/delMoreWmondutyInfo',
							type:'post',
							data:{'ids':ids_Str},
							dataType:'json',
							success:function(msg){
								 layer.msg(msg.msg,{time:500});
							     setTimeout(function(){
									 window.location.reload();
				                },800)
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
		        }else{
		            layer.msg("请选择需要删除的排班信息");
		        }
			 }); 
			 
			
	        //常规用法
	      laydate.render({
	            elem: '#test1'
	      });
	      //删除操作
		  table.on('tool(wmOnduty_info)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
		    var data = obj.data //获得当前行数据
		    ,layEvent = obj.event; //获得 lay-event 对应的值
		    var id=data.id;
		    if(layEvent === 'del_wmOnduty'){
		  	 layer.confirm('确定删除排班信息吗', function(index){
		  	 	$.ajax({
		  	 		url:'${ctx}/duty/wmOnduty/delete',
					type:'post',
					data:{"id":id},
					dataType:'json',
					success:function(msg){
						 layer.msg(msg.msg,{time:500});
						 setTimeout(function(){
								 window.location.reload();
			             },800)
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
		        layer.close(index);
		      });
		    }
		  });
	        
	
	        //数据表格
	        table.render({
	        	 id:'id',
	             elem: '#testlog'
	            ,height: "$(window).height-100"
	            ,limit: 10
	            ,url: '${ctx}/duty/wmOnduty/list' //数据接口
	           	,page:true
	            ,cols: [[ //表头
	//                    {type:'numbers'},
		                   {type: 'checkbox'},
	                //{field: 'id', title: 'ID',  sort: true, fixed: 'left',align: 'center',width:100},
	                {field: 'date', title: '值班日期',sort: true,align: 'center'},
	             /*    {field: 'receiveTime', title: '接班时间',sort: true,align: 'center'}, */
	                 /* {field: 'changeUser', title: '接班人',sort: true,align: 'center'}, */ 
	                {field: 'ondutyUser', title: '值班人',sort: true,align: 'center'},
	                {field:'leader',title:'带班领导',align:'center',sort:true},
	                {field:'wmDesc',title:'描述',align:'center',sort:true},
	               /*  {field: 'realOndutyUser', title: '实际接班人',sort: true,align: 'center'},
	                {field: 'changeStatus', title: '交接情况',sort: true,align: 'center'},*/
	                {fixed: 'right', title:'操作',width: 200, align:'center', toolbar: '#del_btn'}

	            ]]
	        });
	    });
	})
</script>

</body>
</html>