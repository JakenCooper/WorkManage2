<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <link rel="StyleSheet" type="text/css" href="${pageContext.request.contextPath}/static/plugins/layui/css/layui.css" media="all"> 
  <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery-1.8.3.js"></script> 
  <script src="${pageContext.request.contextPath}/static/plugins/layui/layui.js" type="text/javascript"></script>
  <script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
  <title>排班日志管理</title>
  <style>
        body{  margin:20px 10px 20px;  }
         #jiaoBanTime{
             height:38px;
        }
        
        #selectinterest{
         height:38px;
        }
        
        .layui-form-select .layui-input {
		  padding-right: 30px;
		  cursor: pointer;
		  height:38px;
		}	
   </style>
</head>
<script type="text/javascript">
		$(function(){
			$("#searchForm").hide();
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/jiaojieban/wmOndutyDetail/exportFile");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
		});
</script>
	<script type="text/javascript">
   		
   			
			$(function(){
				$("#s2id_autogen1").hide();
				$("#s2id_autogen3").hide();
				//加载
				layui.use(['form','laydate', 'laypage', 'layer', 'table', 'carousel', 'upload', 'element'], function(){
				  var form=layui.form
				  ,laydate = layui.laydate //日期
				  ,laypage = layui.laypage //分页
				  ,layer = layui.layer //弹层
				  ,table = layui.table //表格
				  ,carousel = layui.carousel //轮播
				  ,upload = layui.upload //上传
				  ,element = layui.element;//表单验证
				
					laydate.render({ 
					  elem: '#jiaoBanTime'
					  ,type: 'date',
					}); 
				});
			})
	</script>
<body>
	<!--导出导入  -->
	<div id="importBox" class="hide">
		<form id="importForm" modelAttribute="wmOndutyDetail" action="${ctx}/jiaojieban/wmOndutyDetail/exportFile" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" ><br/>
			<input id="uploadFile" name="file" type="file" style="width:500px" /><br/><br/>　　
		</form>
	</div>
	<form:form id="searchForm" modelAttribute="wmOndutyDetail" action="${ctx}/jiaojieban/wmOndutyDetail/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	</form:form>
	<form>
	    <div style="float: left">
	        <div class="layui-form">
	            <div class="layui-form-item">
	                <div class="layui-input-inline">
	                    <input name="zhiBanTime" type="text"  class="layui-input" id="jiaoBanTime" placeholder="yyyy-MM-dd"> 
	                   <!-- <input name="jiaoBanTime" type="text"  class="layui-input" id="jiaoBanTime" placeholder="yyyy-MM-dd"> -->
	                </div>
	                <div class="layui-input-inline">
	                    <select name="interest" lay-filter="aihao" >
	                        <option value="" selected id="selectinterest">--请选择--</option>
	                        <option value="0">正常</option>
	                        <option value="1" >异常</option>
	                    </select>
	                </div>
	                <button type="button" class="layui-btn" id="serach_btn">查询</button>
	            </div>
	        </div>
	    </div>
    </form>
    <div style="float: right">
        <button class="layui-btn layui-btn-normal" id="btnExport">导出</button>
    <!--     <button class="layui-btn layui-btn-warm">打印</button> -->
    </div>
    <div class="" style="clear: both;">
		 <table class="layui-hide" id="test" lay-filter="demo" lay-data="{id: 'dutylogTable'}"></table> 
    </div>
 
<script type="text/html" id="barDemo">
  <button class="layui-btn  layui-btn-sm btn-datail" lay-event="detail" data-type="getCheckData">查看</button>
</script>

<script>
	layui.use(['laydate', 'laypage', 'layer', 'table', 'carousel', 'upload', 'element'], function(){
	  var laydate = layui.laydate //日期
	  ,laypage = layui.laypage //分页
	  layer = layui.layer //弹层
	  ,table = layui.table //表格
	  ,carousel = layui.carousel //轮播
	  ,upload = layui.upload //上传
	  ,element = layui.element; //元素操作
	  
	  //监听Tab切换
	  element.on('tab(demo)', function(data){
	    layer.msg('切换了：'+ this.innerHTML);
	    console.log(data);
	  });
	  
	  //执行一个 table 实例
	  table.render({
	    elem: '#test'
	    ,id:'dutylogTable'
	    ,height: "$(window).height-100"
	    ,limit: 10
	    ,url: '${ctx}/jiaojieban/wmOndutyDetail/list' //数据接口
	    ,page: true //开启分页
	    ,cols: [[ //表头
	      {field: 'zhiBanTime', title: '值班日期',sort: true,align: 'center'}
	      ,{field: 'changeUser', title: '接班人员',sort: true,align: 'center'}
	      ,{field: 'ondutyUser', title: '值班人员',sort: true,align: 'center'}
	      ,{field:'leader',title:'带班领导',align:'center',sort: true}
	    
	   
	       , {field: 'zhuanWangStatus', title: '线路监控状态', align:'center',sort:true ,templet:function(d){
                if(d.zhuanWangStatus == "0"){
                    return "正常";
                }else if(d.zhuanWangStatus == "1"){
                    return "异常";
                }else{
                  return "";
                }
            }}
	      ,{field:'jiFangSafeStatus',title:'机房监控状态',align:'center',sort: true}
	      ,{fixed: 'right', title:'操作',width: 165, align:'center', toolbar: '#barDemo'}
	    ]]
	  });
	  
	  //排序区域
	  table.on('sort(demo)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
		  console.log(obj.field); //当前排序的字段名
		  console.log(obj.type); //当前排序类型：desc（降序）、asc（升序）、null（空对象，默认排序）
		  console.log(this); //当前排序的 th 对象
		  
		  //尽管我们的 table 自带排序功能，但并没有请求服务端。
		  //有些时候，你可能需要根据当前排序的字段，重新向服务端发送请求，从而实现服务端排序，如：
		  table.reload('dutylogTable', {
		    initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。 layui 2.1.1 新增参数
		    ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
		      field: obj.field //排序字段
		      ,order: obj.type //排序方式
		    }
		  });
		});
	
	  
	
	  //监听工具条
	  table.on('tool(demo)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
	    var data = obj.data //获得当前行数据
	    ,layEvent = obj.event; //获得 lay-event 对应的值
	    var id=data.id;
       // alert(id)
	    if(layEvent === 'detail'){
	      var index = layui.layer.open({	
	                title : "交接班信息",
	                type : 2,
	                area:['950px','700px'],
	                offset: ['100px', '400px'],
	                content : '${ctx}/duty/wmOnduty/findDutyLogForm?id='+id,
	               /*  btn: ['取消', ''],
	                btnAlign: 'c' ,//按钮居中 */
	                shade:.3 //显示遮罩
	           /*      yes: function(){
	                    layer.closeAll();
	                    alert(1);
	                } */
	            })
	            //最大化窗口
	       /*      layui.layer.full(index);
		        window.sessionStorage.setItem("index",index);
		        //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
		        $(window).on("resize",function(){
		            layui.layer.full(window.sessionStorage.getItem("index"));
		        }) */
	    }
	  });
	  //查询区域
	  $("#serach_btn").click(function(){
	  	var time=$("#jiaoBanTime").val();
	  	table.reload('dutylogTable', {
		  url: '${ctx}/jiaojieban/wmOndutyDetail/list'
		  ,where: {
		  	search_time:time
		  },
		   page: {
		    curr: 1 //重新从第 1 页开始
		  }
		
		});
	  })
	 

	
	});
</script>


</body>
</html>        
        