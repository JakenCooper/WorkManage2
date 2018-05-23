
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
 
 <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/layui.css" media="all">



<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>通知</title>
    	<%--   <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery-1.8.3.js"></script> --%>

    
    <style>
        body{  margin:20px 10px 20px;  }
        
        #newsreceiverName{
          width:200px;
          height:30px;
          border:1px solid red!improtant;
        }
    </style>
</head>

<body>
<div class="" style="clear: both;">
    <table id="news" lay-filter="test"></table>
</div>

<form class="layui-form" action="${ctx}/wmnews/wmNews/save" id="newsadd">
    <div class="layui-form-item">
        <label class="layui-form-label">标题：</label>
        <div class="layui-input-block" >
            <input type="text" class="layui-input" placeholder="秦柳" name="title" style="margin-top:8px;">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">内容：</label>
        <div class="layui-input-block">
            <textarea class="layui-textarea" placeholder="市领导下周巡检，请相关部门做好准备，收到请回复" name="content" cols="50" rows="7"></textarea>
        </div>
    </div>

    <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">接收人：</label>
            <div class="layui-input-block">
                 <sys:treeselect url="/sys/office/treeData?type=3" checked="true" notAllowSelectParent="true" id="newsreceiver" value="${user.loginName}" labelName="user.name" labelValue="${user.name}" title="接收人" name="receivers"/> 
            </div>
        </div>

    <div class="layui-form-item layui-row layui-col-xs12">
		<div class="layui-input-block">
			<button  class=" layui-btn-sm layui-btn-primary" onclick="javascript:history.back();">取消</button>
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<button class="layui-btn layui-btn-sm" lay-submit="" lay-filter="addItem" >确定</button>
			<!-- <button type="reset" class="layui-btn layui-btn-sm layui-btn-primary">重置</button> -->
		
			
			
		</div>
	</div>
   

</form>


<!--列表操作按钮-->
<!--<script type="text/html" id="eventBarDemo">-->
    <!--<button class="layui-btn layui-btn-sm" lay-event="view">上传附件</button>-->
<!--</script>-->

<script src="${pageContext.request.contextPath}/static/plugins/layui/layui.js"></script>


<script>
    layui.use(['form', 'element','layer'], function () {
     var form = layui.form
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery;
          form.on('submit(addItem)', function (data) {
       
      
            $.ajax({
                url: '${ctx}/wmnews/wmNews/save',
                type: "post",
                dataType: "json",
                data: $('#newsadd').serialize(),
                async: false,
                success:function(msg) {
                layer.msg(msg.msg);
                parent.layer.closeAll();
                window.parent.location.reload();
                 
                }
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });
        
    
   $( "#newsreceiverId").addClass("layui-input");
    
    });
    

  /*   $(document).ready(function () {
        initSelectTree("demo", true, {"Y": "ps", "N": "s"});
        $(".layui-nav-item a").bind("click", function () {
            if (!$(this).parent().hasClass("layui-nav-itemed") && !$(this).parent().parent().hasClass("layui-nav-child")) {
                $(".layui-nav-tree").find(".layui-nav-itemed").removeClass("layui-nav-itemed")
            }
        })
    }); */
</script>




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


//        $(".callback").click(function(){
//            $('.backcont').toggle();
//        });
        //即时通知

//        $(".news").click(function(){
//            var index = layui.layer.open({
//                title : "即时通知",
//                type : 2,
//                area:['700px','450px'],
//                content : "news.html",
//                btn: ['取消', '提交'],
//                btnAlign: 'c' ,//按钮居中
//                shade:.3, //显示遮罩
//                yes: function(){
//                    layer.closeAll();
//                }
//            })
//        });

        //数据表格
//        table.render({
//            elem: '#news'
//            ,height: $(window).height-100
//            ,limit: 10
//            ,url: 'news.json' //数据接口
//            ,page: true //开启分页
//            ,cols: [[ //表头
////                    {type:'numbers'},
////                    {type: 'checkbox'},
//                {field: 'id', title: 'ID',  sort: true, fixed: 'left',align: 'center',width:100},
//                {field: 'username', title: '消息内容',sort: true,align: 'center'},
//                {field: 'next', title: '下发人',sort: true,align: 'center'},
//                {field: 'data', title: '下发时间',sort: true,align: 'center'},
//                {field: 'affirm', title: '确认人',sort: true,align: 'center'},
//                {field: 'affirmcode', title: '确认状态',sort: true,align: 'center'},
//                {field: 'affirmtime', title: '确认时间',sort: true,align: 'center'}
////                {fixed:'right', title:'操作', align: 'center', toolbar:'#eventBarDemo'}
//            ]]
//        });
    });
</script>
</body>

</html>