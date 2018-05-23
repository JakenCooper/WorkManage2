	<%@ page contentType="text/html;charset=UTF-8" %>
	<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@include file="/WEB-INF/views/include/head.jsp" %> 
<html>
<head>
	<title>保存&ldquo;排班&rdquo;成功管理</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/plugins/layui/css/layui.css" media="all"> 
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery-1.8.3.js"></script>
	<script src="${pageContext.request.contextPath}/static/plugins/layui/layui.js" type="text/javascript"></script>
	<style>
        body{  margin:20px 10px 20px;  }
    </style>
	
</head>
<body>
<div>
    <form class="layui-form" modelAttribute="wmOnduty" id="addWmOndutyForm" >
        <div class="layui-form-item">
            <label class="layui-form-label">值班日期：</label>
            <div class="layui-input-block">
                <input type="text" name="date" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input" style="width: 65%;">
            </div>
        </div>
       <%--  
        <div class="layui-form-item">
            <label class="layui-form-label">接班人：</label>
            <div class="layui-input-block">
                <sys:treeselect url="/sys/office/treeData?type=3" id="changeUser" value="${user.loginName}" labelName="user.name" labelValue="${user.name}" title="用户" name="changeUser"></sys:treeselect>
            </div>
        </div> --%>
        <div class="layui-form-item">
            <label class="layui-form-label">带班领导：</label>
            <div class="layui-input-block">
                  <sys:treeselect url="/sys/office/treeData?type=3" id="leader" value="${user.loginName}" labelName="user.name" labelValue="${user.name}" title="带班领导" name="leader"/> 
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">值班人：</label>
            <div class="layui-input-block">
                 <sys:treeselect url="/sys/office/treeData?type=3" id="ondutyUser" value="${user.loginName}" labelName="user.name" labelValue="${user.name}" title="值班人" name="ondutyUser"/> 
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">描述：</label>
            <div class="layui-input-block">
                <textarea name="wmDesc" id="" cols="200" rows="5" style="border-color:#e6e6e6;width: 400px;"  ></textarea>
            </div>
        </div>
        <div class="layui-form-item layui-row layui-col-xs12">
			<div class="layui-input-block">
				<button class="layui-btn"  type="button" lay-submit="" lay-filter="addWmonduty">立即添加</button>
				<button type="reset" class="layui-btn layui-btn-sm layui-btn-primary">重置</button>
				<!-- <input type="button" class="layui-btn layui-btn-sm layui-btn-primary" value="返回" onclick="javascript:history.go(-1);"> -->
			</div>
		</div>
		
    </form>
</div>

        <script>
        	$(function(){
			    layui.use(['form','laydate'],function(){
			        var form = layui.form
			                ,layer = layui.layer
			                ,laydate = layui.laydate;
			        //日期
			        laydate.render({
			            elem: '#date',
			            type:'date'
			        });
			        form.on('submit(addWmonduty)', function (data) {
			            $.ajax({
			                url: '${ctx}/duty/wmOnduty/save',
			                type: "post",
			                dataType: "json",
			                data: $('#addWmOndutyForm').serialize(),
			                async: false,
			                success:function(msg) {
		                        parent.layer.closeAll();
		                        window.parent.location.reload();
			                }
			            });
			            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
			        });
			    });
        	})
		</script>
</body>	
</html>