<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>批量删除</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/layui.css" media="all">
<!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
<style type="text/css">
.childrenBody {padding:10px;}
</style>
</head>
<body class="childrenBody">
<blockquote class="layui-elem-quote news_search">
<div class="layui-inline">
<div class="layui-input-inline">
</div>
</div>
<div class="layui-inline">
</div>
<div class="layui-inline">
<a class="layui-btn layui-btn-danger batchDel">批量删除</a>
</div>
<div class="layui-inline">
<div class="layui-form-mid layui-word-aux"></div>
</div>
</blockquote>
<div class="layui-form list">
<table id="list" class="layui-table" lay-filter="list">
</table>
</div>
<script src="//res.layui.com/layui/dist/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script type="text/javascript">
var table_data=[{"id":45,"title":"zzzzzzzzzzzzz","cat_id":10,"picurl":"","info":"zzzzzzzzzzzzzzzz","sale_price":0,"tags":"1,9,10","on_off":1,"add_time":"2017-10-01 11:00:08","edit_time":"2017-10-01 11:00:08","add_auth":0,"edit_auth":0},{"id":43,"title":"yyyyyyyyyyyyyyyyyyy","cat_id":33,"picurl":"","info":"yyyyyyyyyyyyyyyyyyyyyyyyyyyy","sale_price":0,"tags":"2","on_off":1,"add_time":"2017-10-01 10:17:28","edit_time":"2017-10-01 10:58:11","add_auth":0,"edit_auth":0},{"id":42,"title":"1333333333333","cat_id":9,"picurl":"","info":"13333333333333333","sale_price":0,"tags":"1","on_off":1,"add_time":"2017-10-01 10:13:02","edit_time":"2017-10-01 10:37:02","add_auth":0,"edit_auth":0},{"id":40,"title":"11111111111111111111","cat_id":10,"picurl":"","info":"111111111111111111111111111111","sale_price":0,"tags":"2","on_off":0,"add_time":"2017-10-01 10:01:25","edit_time":"2017-10-01 10:04:29","add_auth":0,"edit_auth":0},{"id":39,"title":"199999999999999999","cat_id":10,"picurl":"","info":"1199999999999999","sale_price":0,"tags":"1,2,9","on_off":0,"add_time":"2017-10-01 09:53:36","edit_time":"2017-10-01 09:59:21","add_auth":0,"edit_auth":0},{"id":36,"title":"\u5927\u5bb6\u597d\u6211\u662f\u90d1\u5c11\u71d5","cat_id":0,"picurl":"","info":"\u5b9d\u5c9b\u773c\u773c\u955c\u3002\u54c8\u54c8\u54c8\u54c8","sale_price":0,"tags":"1,2,7,10","on_off":0,"add_time":"2017-10-01 09:48:56","edit_time":"2017-10-01 11:14:06","add_auth":0,"edit_auth":0},{"id":33,"title":"88888888","cat_id":0,"picurl":"","info":"88888888888","sale_price":0,"tags":"1,5,9","on_off":1,"add_time":"2017-09-30 23:08:21","edit_time":"2017-09-30 23:08:21","add_auth":0,"edit_auth":0},{"id":30,"title":"77777777777777","cat_id":0,"picurl":"","info":"77777777777","sale_price":0,"tags":"1,2,9,10","on_off":1,"add_time":"2017-09-30 22:34:49","edit_time":"2017-09-30 22:34:49","add_auth":0,"edit_auth":0},{"id":13,"title":"1999\u5143\u4e09\u5ce1\u770b\u58ee\u9614\u7ea2\u67ab\uff0c\u7ea6\u5417\uff1f\u6253\u98de\u7684\u8f7b\u677e\u53bb\uff01 | \u65b0\u610f\u4e2d\u56fd","cat_id":10,"picurl":"","info":"\u4e09\u5ce1\u7ea2\u53f6\u00b7\u795e\u5973\u5cf0\u00b7\u8239\u6e38\u5deb\u5ce1\u00b7\u767d\u5e1d\u57ce\u00b7\u4e09\u5ce1\u5927\u575d\u56db\u5929\u53cc\u98de\uff08\u5b9c\u660c\u98de\u673a\u5f80\u8fd4\uff09\r\n12\u670814\u300121\u300123\u65e5\u51fa\u53d1\r\n\u4ec51999\u5143\/\u4eba","sale_price":1999,"tags":"5","on_off":1,"add_time":"2015-12-15 17:03:34","edit_time":"2017-09-29 21:35:37","add_auth":20,"edit_auth":0},{"id":12,"title":"\u6ca1\u9519~\u53f9\u7f8e\u98df+\u4f4f\u4e94\u661f+\u6e38\u5e99\u4f1a\u90fd\u88ab2016\u53f0\u6e7e\u6625\u8282\u627f\u5305\u4e86 | \u53f0\u6e7e\u6625\u8282\u901f\u9012","cat_id":0,"picurl":"","info":"\u65b0\u5e74\u7279\u8f91\uff0c\u5177\u4f53\u4ef7\u683c\u4ee5\u6700\u7ec8\u5177\u4f53\u9009\u62e9\u884c\u7a0b\u4e3a\u51c6","sale_price":8199,"tags":"7","on_off":1,"add_time":"2015-12-15 17:00:12","edit_time":"2017-10-01 11:11:43","add_auth":20,"edit_auth":0},{"id":11,"title":"\u3010\u571f\u697c\u4e2d\u7684\u9152\u5e97\u3011\u6cb3\u6e90\u5df4\u4f10\u5229\u4e9a\u5e84\u56ed\uff01\u4e30\u76db\u53cc\u65e9\u81ea\u52a9\u9910\u4ec5\u9700688\uff01\u6ce1\u56fd\u836f\u6e29\u6cc9\uff0c\u4f53\u9a8c\u5e84\u56ed\u6e38\u4e50\u9879\u76ee\uff01","cat_id":0,"picurl":"","info":"\u571f\u697c\u9152\u5e97\u5185\u5708\uff1a\u5468\u65e5\u81f3\u5468\u56db688\u5143\/\u95f4\uff1b\u5468\u4e94\u3001\u516d888\u5143\/\u95f4 \r\n\u571f\u697c\u9152\u5e97\u5916\u5708\uff1a\u5468\u65e5\u81f3\u5468\u56db738\u5143\/\u95f4\uff1b\u5468\u4e94\u3001\u516d938\u5143\/\u95f4 \r\n\u571f\u697c\u9152\u5e97\u4eb2\u5b50\u623f\uff08\u5927\u5e8a\uff09\u5468\u65e5\u81f3\u5468\u56db838\u5143\/\u95f4\uff1b\u5468\u4e94\u3001\u516d1088\u5143\/\u95f4 \r\n\u571f\u697c\u9152\u5e97\u571f\u7095\u623f\uff082\u5f201.5\u7c73\u5e8a\uff09\u5468\u65e5\u81f3\u5468\u56db838\u5143\/\u95f4\uff1b\u5468\u4e94\u3001\u516d1088\u5143\/\u95f4 \r\n\u4e3b\u9898\u9152\u5e97\u5c71\u666f\u53cc\u4eba\u623f\uff08\u623f\u95f4\u5185\u5e26\u6e29\u6cc9\u6ce1\u6c60\uff09\u5468\u65e5\u81f3\u5468\u56db918\u5143\/\u95f4\uff1b\u5468\u4e94\u3001\u516d1218\u5143\/\u95f4\r\n\uff08\u5723\u8bde\u53ca\u5143\u65e6\u4e0d\u505a\u7279\u4ef7\uff0c\u5982\u6709\u9700\u8981\u8bf7\u53e6\u5916\u54a8\u8be2\uff01\uff09\r\n\r\n\u5305\u542b\u5185\u5bb9\uff1a\r\nA\u3001\u53cc\u4eba\u6b21\u65e5\u4e2d\u897f\u5f0f\u81ea\u52a9\u65e9\u9910 \r\nB\u3001\u6bcf\u95f4\u623f\u5305\u542b\u5e84\u56ed\u6e38\u4e50\u9879\u76ee\u4f53\u9a8c\u901a\u7968\uff1a\u901a\u7968\u5185\u5bb9\u5982\u4e0b\uff1a\uff08\u6bcf\u95f4\u623f\u5404\u542b\u4e00\u5f20\uff09\u56db\u5b63\u65f1\u96ea\u573a\u3001\u6e56\u7554\u9ad8\u5c14\u592b\u3001\u6e56\u7554\u63a8\u6746\u679c\u5cad\u3001\u78b0\u78b0\u8f66\u3001\u89c2\u5149\u8f66\u3001\u798f\u6e90\u5bfa \r\nC\u3001\u6bcf\u95f4\u623f\u542b\u65e0\u9650\u6b21\u6e29\u6cc9\u533a\u5185\u4ee5\u4e0b\u9879\u76ee\uff1a\u56fd\u533b\u56fd\u836f\u6e29\u6cc9\u3001\u6c57\u84b8\u623f\u3001\u5e72\u84b8\u623f\u3001\u51b0\u84b8\u623f\u3001\u76d0\u7597\u623f\u3001\u4e2d\u836f\u84b8\u623f\u3001\u77f3\u677f\u70ed\u5751\u3001\u6052\u6e29\u6cf3\u6c60\u3001\u6e29\u6cc9\u65e0\u9650\u91cf\u6c34\u679c\u996e\u6599\u3001\u7535\u5f71\u9662\u3002","sale_price":688,"tags":"2,5","on_off":1,"add_time":"2015-12-15 16:57:38","edit_time":"2017-09-29 21:36:52","add_auth":20,"edit_auth":0},{"id":10,"title":"\u3010\u79cb\u98ce\u8d77&\u6e29\u6cc9\u5b63\u3011\u4ec5\u9700499\uffe5\u4eab\u53d7\u6069\u5e73\u5c71\u6cc9\u6e7e\u517b\u751f\u6e29\u6cc9\u5ea6\u5047\u4e4b\u65c5","cat_id":0,"picurl":"","info":"\u6709\u6548\u671f12\u67086\u300113\u300120\u300127\u53f7\r\n\r\n499\u5143\/\u5957\r\n\u52a050\u5143\u5347\u7ea7\u6c34\u666f\u623f\r\n\u5957\u7968\u5305\u542b\uff1a\r\n\u5165\u4f4f\u9ad8\u7ea7\u5c71\u666f\u623f\/\u9ad8\u7ea7\u522b\u5885\u56ed\u666f1\u95f41\u665a\u3001\u53cc\u4eba\u517b\u751f\u65e9\u9910\u3001\u53cc\u4eba\u65e0\u9650\u6b21\u5927\u6e29\u6cc9\u533a\u95e8\u7968\u3001\u623f\u95f4\u8ff7\u4f60\u5427\u3001\u77ff\u6cc9\u6c34\u3001\u7ea2\/\u7dd1\u8336\u5305\u3001\u5ea6\u5047\u533a\u57df\u5185\u514d\u8d39WIFI\/\u623f\u95f4\u5bbd\u5e26\u4e0a\u7f51\u3001\u6e29\u6cc9\u533a\u514d\u8d39\u63d0\u4f9b\u4f11\u606f\u5ba4\u3001\u505c\u8f66\u7b49\u514d\u8d39\u9879\u76ee\u3002\r\n\r\n\u589e\u52a0\u65e9\u9910\uff1a1.19m\u4ee5\u4e0b\u514d\u8d39\uff0c1.2-1.5m45\u5143\/\u4f4d\uff0c1.5m\u4ee5\u4e0a88\u5143\/\u4f4d\uff1b\r\n\u589e\u52a0\u6e29\u6cc9\uff1a1.19m\u4ee5\u4e0b\u514d\u8d39\uff0c1.2-1.5m60\u5143\/\u4f4d\uff0c1.5m\u4ee5\u4e0a100\u5143\/\u4f4d","sale_price":499,"tags":"1","on_off":1,"add_time":"2015-12-15 16:54:20","edit_time":"2017-09-29 21:34:49","add_auth":20,"edit_auth":0},{"id":8,"title":"[12\u6708\u6700\u5f3a\u805a\u4f1a\u795e\u5668]\uffe51580\u8c6a\u5305\u4e00\u6574\u680b\u522b\u5885\uff01\u82b1\u56ed\u6e29\u6cc9\u6cf3\u6c60PARTY\uff01\u611f\u53d7\u571f\u8c6a\u822c\u7684\u751f\u6d3b\uff01","cat_id":0,"picurl":"","info":"\u2460\u3001\u72ec\u680b\u8c6a\u534e\u522b\u5885\u4f4f\u5bbf1\u665a\uff1b\r\n\u2461\u3001\u7545\u4eab\u79c1\u5bb6\u6e29\u6cc9\u5927\u6ce1\u6c60+\u6e38\u6cf3\u6c60\uff1b\r\n\u2462\u3001\u81ea\u52a8\u9ebb\u5c06\u673a\r\n\u2463\u3001\u4e13\u4e1aKTV\u5927\u5305\u623f\r\n\u2464\u30011\u4e2a\u65e0\u70df\u70e7\u70e4\u7089\r\n\u2465\u3001\u5168\u5c4b\u9ad8\u901f\u5149\u7ea4WIFI\r\n\u2466\u3001\u529f\u592b\u8336\u5177\r\n\u2467\u3001\u9152\u5427\u53f0\u9152\u5177\r\n\u2468\u3001\u53a8\u623f\u53a8\u5177+\u5927\u51b0\u7bb1\r\n\u6e29\u99a8\u63d0\u793a\uff1a\u6709\u6548\u671f\u81f32015\u5e7412\u670830\u65e5 \uff0812\u670825\u300131\u65e5\u6309\u5468\u516d\u4ef7\u683c\u7ed3\u7b97\uff09\r\n\u8ba2\u65e9\u991012\u5143\/\u4eba\u8d77\uff0c\u70e7\u70e4\u98df\u675025\u5143\/\u4eba\u8d77\r\n\u9152\u5e97\u62e5\u6709\u6b64\u6b21\u6d3b\u52a8\u7684\u89e3\u91ca\u6743\uff0c\u8282\u5047\u65e5\u4ef7\u683c\u53e6\u8bae \r\n\u56e0\u522b\u5885\u623f\u578b\u8f83\u591a\uff0c\u5e8a\u7684\u5c3a\u5bf8\u5927\u5c0f\u4ee5\u5b9e\u9645\u4e3a\u51c6\u3002","sale_price":1580,"tags":"1,2,5,7,9,10","on_off":1,"add_time":"2015-12-15 16:34:31","edit_time":"2017-09-30 16:40:22","add_auth":20,"edit_auth":0},{"id":7,"title":"\u5e74\u672b\u8d85\u62b5\uff011999\u62a2\u6cf8\u6cbd\u6e56\u53cc\u98de\u56e2\uff01\u7f8e\u7684\u795e\u79d8\u53c8\u7eaf\u51c0\uff01 | \u65b0\u610f\u4e2d\u56fd","cat_id":66,"picurl":"","info":"\u3010\u6df3\u5473\u56db\u5ddd\u2022\u6cf8\u6cbd\u6e56\u3011\u201c\u9633\u5149\u4e4b\u57ce\u201d\u6500\u679d\u82b1\u3001\u6df1\u79cb\u6cf8\u6cbd\u6e56\u3001\u683c\u8428\u62c9\u3001\u4e8c\u6ee9\u6c34\u7535\u7ad9\u4e94\u5929\u53cc\u98de\u6e38\r\n\u51fa\u53d1\u65e5\u671f\uff1a12\u670823\u65e5\uff0c26\u65e5\uff0c1\u67082\/9\u65e5\u51fa\u53d1\r\n\u6210\u4eba\u4ef7\u683c\uff1a\u4ec51999\u5143\/\u4eba","sale_price":1999,"tags":"","on_off":1,"add_time":"2015-12-15 16:32:37","edit_time":"0000-00-00 00:00:00","add_auth":20,"edit_auth":0}];


var table_fields=[[ //设置表头
{checkbox: true,fixed:true}
,{field: 'id', title: 'ID', width: 50}
,{field: 'title', title: '线路', width: 300}
,{field: 'add_time', title: '添加时间', width: 100}
,{field: 'edit_time', title: '最后修改', width: 100}
,{field: 'add_auth', title: '添加者', width: 80}
,{title: '操作',fixed:'right', width: 60,toolbar: '#optBar'}
]];


layui.use(['table','layer','jquery'], function(){
var layer = parent.layer === undefined ? layui.layer : parent.layer
,$ = layui.jquery
,table = layui.table;

//执行渲染
table.render({
elem: '#list'
,id:'list'
//,height: 315 //容器高度
,cols: table_fields
,page:true
,loading:false
,data:table_data
});


//监听工具条[删除]
table.on('tool(list)', function(obj){
var data = obj.data;//当前行数据
if(obj.event === 'del'){
layui.layer.confirm('真的删除行么', function(index){
layui.layer.close(index);
obj.del();
layui.layer.msg('删除成功');
});
}
});



//监听表格复选框选择
var checkedArr=[];
table.on('checkbox(list)', function(obj){
if (obj.type=='all') return;
if (obj.checked){
checkedArr[obj.data.id] = obj.data.LAY_TABLE_INDEX;
}
else{
delete checkedArr[obj.data.id];
}
});


//批量删除
$(".batchDel").click(function(){
var checkStatus = table.checkStatus('list')
,data = checkStatus.data, tmpArr = [], ids = [];
if (checkStatus.isAll){
for (var i=0; i<data.length ; i++){
checkedArr[data[i].id]=i;
ids.push(data[i].id);
}
}
else{
for (var i=0; i<data.length ; i++){
tmpArr[data[i].id]=checkedArr[data[i].id];
ids.push(data[i].id);
}
checkedArr = tmpArr;
}

//没有选中任何一行
if (checkedArr.length == 0){
layui.layer.msg('请选择要删除行');
return;
}

layui.layer.confirm('真的删除么', function(index){
layui.layer.close(index);
//ajax从数据库删除 ids.toString();
$.each(checkedArr, function(k){
$("tr[data-index="+checkedArr[k]+"]").remove();
});
layui.layer.msg('删除成功');
});

});
});

</script>

<script type="text/html" id="optBar">
<a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del">删除</a>
</script>
</body>
</html> 