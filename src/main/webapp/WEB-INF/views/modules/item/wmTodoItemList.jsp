<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>保存&ldquo;事项&rdquo;成功管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/item/wmTodoItem/">保存&ldquo;事项&rdquo;成功列表</a></li>
		<shiro:hasPermission name="item:wmTodoItem:edit"><li><a href="${ctx}/item/wmTodoItem/form">保存&ldquo;事项&rdquo;成功添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="wmTodoItem" action="${ctx}/item/wmTodoItem/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="item:wmTodoItem:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="wmTodoItem">
			<tr>
				<td><a href="${ctx}/item/wmTodoItem/form?id=${wmTodoItem.id}">
					<fmt:formatDate value="${wmTodoItem.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${wmTodoItem.remarks}
				</td>
				<shiro:hasPermission name="item:wmTodoItem:edit"><td>
    				<a href="${ctx}/item/wmTodoItem/form?id=${wmTodoItem.id}">修改</a>
					<a href="${ctx}/item/wmTodoItem/delete?id=${wmTodoItem.id}" onclick="return confirmx('确认要删除该保存&ldquo;事项&rdquo;成功吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>