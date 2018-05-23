<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
 <%-- <%@include file="/WEB-INF/views/include/head.jsp" %>   --%>
<!DOCTYPE html>
<html>

<head>
   <!--  <meta charset="utf-8"> -->
    <title>工作台历</title>
    
    <meta name="decorator" content="default"/>
   <!--   <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">  -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <%-- <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery-1.8.3.js"></script> --%>
      <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/plugins/layui/css/layui.css" media="all"> 
	<script src="${pageContext.request.contextPath}/static/plugins/layui/layui.js" type="text/javascript"></script> 
  <%--   <script src="${pageContext.request.contextPath}/static/jquery/jquery.min.js"></script>  --%>
    <style>
        body{  margin:20px 10px 20px;  }
        .layui-tab-content table tr th{
            font-weight: bold;
            color: #333;
        }
         .background{  
       bgcolor:#333;  
  }  
    .disabled{
     
      display:none;
    }
    .layui-btn-showicon-0 {
  background-color: #c5c5c5;
}
 .layui-btn-showicon-1 {
  background-color: #c5c5c5;
}

 .layui-btn-showicon-2 {
  background-color: #009688;
}

.layui-table-cell {
  height: 32px!important;
  line-height: 32px!important;
   padding: 0 15px;
  position: relative;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  box-sizing: border-box;
}
    </style>
    <!-- 导入导出  -->
    <script type="text/javascript">
		$(function(){
			
			$("#searchForm").hide();
			//导出数据
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
					//alert("egwege");
						$("#searchForm").attr("action","${ctx}/item/wmTodoItem/exportFile");
						//console.log($("#searchForm"));
						$("#searchForm").submit();
					//	alert("fewfe");
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			//导入数据
			$("#btnImport").click(function(){
			   console.log($("#importBox"));
			//	$.jBox('id:importBox', {title:"导入数据", buttons:{"关闭":true}, 
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
				bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
		})
	</script>
    
    
</head>
<body>
	
	
<%@ page import="java.util.*"%>

<% 
    Calendar calendar=Calendar.getInstance(); 
    int year=calendar.get(Calendar.YEAR); 
    int month=calendar.get(Calendar.MONTH)+1; 
    int day=calendar.get(Calendar.DATE);     
    
   // String m = Model.getAttributes("month");
   
    
     %> 
    


<!-- 导入导出 -->
<form:form id="searchForm" modelAttribute="wmTodoItem"  class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input type="hidden" id="msss" value="${ms}" name="month">
	</form:form>
		<div id="importBox" class="hide">
		<form id="importForm" modelAttribute="wmTodoItem" action="${ctx}/item/wmTodoItem/importFile" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" ><br/>
			<input id="uploadFile" name="file" type="file" style="width:500px" /><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   " style="float: right;"/>
		</form>
	</div>
<!-- end -->



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
            <button type="button"  class="layui-btn addNews_btn"  >添加事项</button>
            
           <%--  <a  class="layui-btn" href="${ctx}/item/wmTodoItem/itemsadd">添加事项</a> --%>
     
            <button type="button"  class="layui-btn layui-btn-danger batchDel" >批量删除</button>
        </div>
        <div style="float: right">
             <a href="${ctx}/item/wmTodoItem/exportFileTemplate" class="layui-btn">下载模板</a>
            <button class="layui-btn layui-btn-norma" id="btnImport">导入</button>
            <button class="layui-btn layui-btn-norma"  id="btnExport">导出</button>
        </div>
    </div>
    </shiro:hasPermission>
    
    <div class="layui-tab-content" style="clear: both;">
    
    <table id="domo" lay-filter="domo" lay-size="lg"></table>
    <sys:message content="${message}"/>	
    
    <input type="hidden" id="mss" value="${ms}">
   <%--  <input id="sss" name="month" type="text" value="${month}">  --%>
    </div>
   
</div>
 
<!--列表操作按钮-->
  
<script type="text/html" id="showiconss">
      

     {{# if(d.showicon =="0" ){  }}
      
     <div  style="background:url(${ctxStatic}/images/yellow.png); width:56px; height:30px;color: white;"  >未申领</div>
	   

        {{# }else if(d.showicon =="1"){ }} 
		 <div  style="background:url(${ctxStatic}/images/blue.png); width:56px; height:30px;color: white;"  >已申领</div>
{{# }else{ }}
		<div  style="background:url(${ctxStatic}/images/green.png); width:56px; height:30px;color: white;"  >已完成</div>
{{# };}}

	

</script>
	<!-- <a class="layui-btn layui-btn-sm  layui-btn-warm" id="applyss" lay-event="apply" >未申领</a> -->
		<!-- <a class="layui-btn layui-btn-sm layui-btn-normal" i
d="applyss">已申领</a> -->
<!-- <a class="layui-btn layui-btn-sm layui-btn-showicon-2" i
d="applyss"  >已完成</a> -->

<script type="text/html" id="showiconss2">
      

       {{# if(d.showicon =="0" ){  }}
      
     <div  style="background:url(${ctxStatic}/images/yellow.png); width:56px; height:30px;color: white;"  >未申领</div>
	   

        {{# }else if(d.showicon =="1"){ }} 
		 <div  style="background:url(${ctxStatic}/images/blue.png); width:56px; height:30px;color: white;"  >已申领</div>
{{# }else{ }}
		<div  style="background:url(${ctxStatic}/images/green.png); width:56px; height:30px;color: white;"  >已完成</div>
{{# };}}

	

</script>




<script type="text/html" id="userListBar">
         <a class="layui-btn layui-btn-sm" lay-event="detail" >查看</a>
       

     {{# if(d.showicon =="0" ){  }}
      
		<a class="layui-btn layui-btn-sm layui-btn-normal" id="applyss" lay-event="apply" >申领</a>

        {{# }else{ }} 
		<a class="layui-btn layui-btn-sm layui-btn-showicon" i
d="applyss" lay-event="apply" >申领</a>
{{# } ;}}


		 <shiro:hasPermission name="item:wmTodoItem:edit">
		 <a class="layui-btn layui-btn-warm layui-btn-sm" lay-event="edit">编辑</a>

		<a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</a>
          </shiro:hasPermission>

</script>


<script type="text/html" id="userListBar2">
         <a class="layui-btn layui-btn-sm" lay-event="detail" >查看</a>
       
      
		{{# if(d.showicon =="0" ){  }}
		<a class="layui-btn layui-btn-sm layui-btn-normal buban" id="buban" lay-event="buban">补办</a>
   {{# }else{ }} 
         <a class="layui-btn layui-btn-sm layui-btn-showicon buban" id="buban" lay-event="buban">补办</a>
{{# } ;}}
		 <shiro:hasPermission name="item:wmTodoItem:edit">
		 <a class="layui-btn layui-btn-warm layui-btn-sm" lay-event="edit">编辑</a>

		<a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</a>
          </shiro:hasPermission>

</script>



       
      
	

</script>

<script src="${pageContext.request.contextPath}/static/plugins/layui/layui.js"></script>

<script type="text/javascript">


var id ="";

layui.use(['form','layer','table','laytpl'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laytpl = layui.laytpl,
        table = layui.table;


      var toolbar = '#showiconss';
//alert("come in ..");
    //用户列表
    var tableIns = table.render({
        elem: '#domo',
        url : '${ctx}/item/wmTodoItem/list',
        cellMinWidth : 95,
        page : true,
        height :  $(window).height-100,
        limit : 10,
        id : "domo",
        cols: [[ //表头
                {type: 'checkbox'},
                {type:'numbers'},
                 {field: 'title', title: '事项',sort:true,align: 'left',fontWeight:'bold', event: 'detail' , style:'cursor: pointer;/* text-decoration: underline; */'},
                  {field: 'status', title: '状态', width:150,sort:true,align: 'center',fontWeight:'bold',templet: '#showiconss'}
               
            /*  {field: 'showicon',title: '', align:'',templet:function(d){
                if(d.showicon == "0"){
                 toolbar="#userListBar";
                    return "未申领";
                  // $("#applyss").text("申领"); 
                   $("#applyss").val("申领"); 
                 //   console.log("#applyss");
                }else if(d.showicon == "1"){
                 //     $("#applyss").val("已申领");
                 toolbar="#userListBar3";
                //   $("#applyss").text("已申领"); 
                   $("#applyss").val("已申领"); 
                    return "已申领";
                }
            }}, */
                /*  {title: '状态',  templet:toolbar,minWidth: 262, fixed:"right",align:"center"} */

        ]]
    });



 var ms = '${ms}'

 var mss ="#"+ms;
 
  $(mss).addClass("layui-this");

 	  table.on('sort(domo)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
		  console.log(obj.field); //当前排序的字段名
		  console.log(obj.type); //当前排序类型：desc（降序）、asc（升序）、null（空对象，默认排序）
		  console.log(this); //当前排序的 th 对象
		  
		  //尽管我们的 table 自带排序功能，但并没有请求服务端。
		  //有些时候，你可能需要根据当前排序的字段，重新向服务端发送请求，从而实现服务端排序，如：
		  table.reload('domo', {
		    initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。 layui 2.1.1 新增参数
		    ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
		      field: obj.field //排序字段
		      ,order: obj.type //排序方式
		    }
		  });
		});

   table.on('tool(domo)', function(obj){
        var layEvent = obj.event;
          var   data = obj.data;
          var daid = data.id;
          var showicon = data.showicon;
          var toolbar="";
          var status = data.status;   
        if(layEvent === 'edit'){ //编辑
          udpate(daid);
        
        }else if(layEvent === 'del'){ //删除
            layer.confirm('确定删除此事项？',{icon:3, title:'提示信息'},function(index){
                
                window.location.href="${ctx}/item/wmTodoItem/deletemore?str="+ daid+"";
                    tableIns.reload();
                    layer.close(index);
               
            });
        }else if(layEvent === 'detail'){//查看
    
           detail(daid,showicon);
        }else if(layEvent === 'apply'){//申领
        
          if(status=="1"){
          //判断事项是否是未办，已办状态不需要申领
               layer.msg("该事项状态为已办，无需申领");
               }else{
              
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
					layer.confirm('申领成功，立即跳转到我的工作界面？', {
				    btn: ['确定跳转','暂不跳转'], //按钮
				    shade: false //不显示遮罩
				}, function(){
					//跳转到我的工作界面
					layer.closeAll();
					//window.location.reload();
				parent.cursorToUnionSealToSignList();
			//	parent.cursorToUnionSealToSignList2();
				}, function(){
				    
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
                    layer.close(index);
                    
              
            });
            }
        } else if(layEvent === 'buban'){//补办  bubancheck
        
                $.ajax({
					type:'post',
					url:'${ctx}/item/wmTodoItem/bubancheck?str='+ daid,
					dataType:'json',
					success:function(msg){
						//alert(msg.msg);
						if(msg.msg == "您已领取此事项，不可重复选择!"){
						 layer.msg("您已提交补办申请，请勿重复提交");
						}else{
						  
						   layer.prompt({title: '请输入补办原因，并确认', formType: 2}, function(text, index){
           
            
				                    $.ajax({
									type:'post',
									url:'${ctx}/item/wmTodoItem/bubanfor?str='+ daid+'&reason='+text,
									dataType:'json',
									success:function(msg){
										//跳转到我的工作页面
									layer.confirm('提交补办成功，立即跳转到我的工作界面？', {
								    btn: ['确定跳转','暂不跳转'], //按钮
								    shade: false //不显示遮罩
								}, function(){
								//跳转
								parent.cursorToUnionSealToSignList();
								}, function(){
								});
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
        }
    });




 function addItem(){
  var layEvent = obj.event;
  
        var index = layui.layer.open({
            title : "添加事项",
            type : 2,
            area:['900px','500px'],
            content : "${ctx}/item/wmTodoItem/itemsadd",
            success : function(layero, index){
                var body = layui.layer.getChildFrame('body', index);
                setTimeout(function(){
                    layui.layer.tips('点击此处返回事项列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            }
        })
       /*  layui.layer.full(index);
        window.sessionStorage.setItem("index",index);
        //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
        $(window).on("resize",function(){
            layui.layer.full(window.sessionStorage.getItem("index"));
        }) */
    }
    $(".addNews_btn").click(function(){
        addItem();
    })






 function udpate(daid){
  var layEvent = obj.event;
  
        var index = layui.layer.open({
            title : "修改",
            type : 2,
            area:['900px','500px'],
            content : "${ctx}/item/wmTodoItem/updateone?id="+daid,
            success : function(layero, index){
                var body = layui.layer.getChildFrame('body', index);
                setTimeout(function(){
                    layui.layer.tips('点击此处返回事项列表', '.layui-layer-setwin .layui-layer-close', {
                    //layer.close(index);
                     // layer.msg("修改成功！");
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


 function detail(daid,showicon){
  var layEvent = obj.event;
  
       //alert(showicon);
        var index = layui.layer.open({
            title : "查看",
            type : 2,
            area:['900px','500px'],
            content : "${ctx}/item/wmTodoItem/detailopen?id="+daid+"&showicon="+showicon,
            success : function(layero, index){
                var body = layui.layer.getChildFrame('body', index);
                setTimeout(function(){
                    layui.layer.tips('点击此处返回事项列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            }
        })
       /*  layui.layer.full(index);
        window.sessionStorage.setItem("index",index);
        //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
        $(window).on("resize",function(){
            layui.layer.full(window.sessionStorage.getItem("index"));
        }) */
    }



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
                table.reload();
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
		// if()
		//给导出设置月份
		 $("#msss").val(month);
		      
    /*m值为3，下标从0开始*/

    var d=new Date();
    var m=d.getMonth();
    var ms = '${ms}';
    //alert (ms);
    var t=ms;
    var toolbar = '#showiconss';
	
	//设置申领-补办 按钮转换
	if((month+1)<t){
	//alert("sf");
	    toolbar = '#showiconss2';
	}else{
	//alert("seg");
	toolbar = '#showiconss';
	}
	
		
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
              
                  {type: 'checkbox'},
                {type:'numbers'},
                 {field: 'title', title: '事项',sort:true,align: 'left',fontWeight:'bold', event: 'detail' , style:'cursor: pointer;padding：50px 0 ;/* text-decoration: underline; */'},
                  {field: 'status', title: '状态', width:150,sort:true,align: 'center',fontWeight:'bold',templet: toolbar}
               
           /*   {field: 'status', title: '状态',sort:true,align:'center',templet:function(d){
                if(d.status == "0"){
                    return "待办";
                }else if(d.status == "1"){
                    return "已办";
                }
            }}, */
              
            ]]
        });
         });
      
      //设置日历颜色变灰模式
         if(monthnow >2 && monthnow - month ==1){
          $('.liid li').eq(month-1).css({background:'#c5c5c5',borderColor:'transparent'}).siblings().css('background','transparent').removeClass();
	     
	   
		}else if(monthnow >2 && monthnow - month >=2){
		//变色 改成补办
		//alert("sgs");
		 $('.liid li').eq(month-1).css({background:'#c5c5c5',borderColor:'transparent'}).siblings().css('background','transparent').removeClass();
		 
		}else {
		
		$('.liid li').eq(month-1).css('background','#358fce').siblings().css('background','transparent').removeClass();
		}
		
	}
	</script>

</body>

</html>