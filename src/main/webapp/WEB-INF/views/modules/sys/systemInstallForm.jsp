<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<html>
<head>
	<title>系统设置</title>
	<meta name="decorator" content="default"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/layui/css/layui.css" media="all"> 
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/plugins/jquery/jquery-1.8.3.js"></script>
	<script src="${pageContext.request.contextPath}/static/plugins/layui/layui.js" type="text/javascript"></script>
</head>
<body>
	<div class="x-body">
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <li class="layui-this">网站设置</li>
            <li>安全设置</li>
            <li>邮件设置</li>
            <li>关闭网站</li>
            <li>其它设置</li>
        </ul>
        <div class="layui-tab-content" >
            <div class="layui-tab-item layui-show">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>网站名称
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="title" autocomplete="off" placeholder="控制在25个字、50个字节以内"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>关键词
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="title" autocomplete="off" placeholder="5个左右,8汉字以内,用英文,隔开"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>描述
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="title" autocomplete="off" placeholder="空制在80个汉字，160个字符以内"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>css、js、images路径配置
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="title" autocomplete="off" placeholder="默认为空，为相对路径"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>上传目录配置
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="title" autocomplete="off" placeholder="默认为uploadfile"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>底部版权信息
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="title" autocomplete="off" placeholder="&copy; 2016 X-admin"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>备案号
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="title" autocomplete="off" placeholder="京ICP备00000000号"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item layui-form-text">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>统计代码
                        </label>
                        <div class="layui-input-block">
                            <textarea placeholder="请输入内容" class="layui-textarea"></textarea>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <button class="layui-btn" lay-submit="" lay-filter="*">
                		            保存
                        </button>
                    </div>
                </form>
                <div style="height:100px;"></div>
            </div>
            <div class="layui-tab-item">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item layui-form-text">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>允许访问后台的IP列表
                        </label>
                        <div class="layui-input-block">
                            <textarea placeholder="请输入内容" class="layui-textarea"></textarea>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label" >
                            <span class='x-red'>*</span>最大次数
                        </label>
                        <div class="layui-input-inline" >
                            <input type="number" name="number" lay-verify="number" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <button class="layui-btn" lay-submit="" lay-filter="*">
              		              保存
                        </button>
                    </div>
                </form>
            </div>
            <div class="layui-tab-item">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>邮件发送模式
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="title" autocomplete="off" placeholder=""
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>SMTP服务器
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="title" autocomplete="off" placeholder="smtp.qq.com"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>SMTP 端口
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="title" autocomplete="off" placeholder="25"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>邮箱帐号
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="title" autocomplete="off" placeholder="邮件服务商申请的帐号"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>邮箱密码
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="title" autocomplete="off" placeholder="邮件服务商申请的密码"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>收件邮箱地址
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="title" autocomplete="off" placeholder=""
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <button class="layui-btn" lay-submit="" lay-filter="*">
                         		   保存
                        </button>
                    </div>
                </form>
            </div>
            <div class="layui-tab-item">
                <form class="layui-form">
                    <div class="layui-form-item">
                        <label for="AppId" class="layui-form-label">
                            <span class="x-red">*</span>是否开启
                        </label>
                        <div class="layui-input-block">
                            <input type="checkbox" checked="" name="open" lay-skin="switch" lay-filter="switchTest" title="开关">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label for="L_repass" class="layui-form-label">
                        </label>
                        <button  class="layui-btn" lay-filter="*" lay-submit="">
                        	    保存
                        </button>
                    </div>
                </form>
            </div>
            <div class="layui-tab-item">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>其它功能
                        </label>
                        <div class="layui-input-inline">
                            <input type="text" name="title" autocomplete="off" placeholder="请输入内容"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>其它功能
                        </label>
                        <div class="layui-input-inline">
                            <input type="text" name="title" autocomplete="off" placeholder="请输入内容"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <button class="layui-btn" lay-submit="" lay-filter="*">
                  		          保存
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    layui.use(['element','layer','form'], function(){
        $ = layui.jquery;//jquery
        lement = layui.element();//面包导航
        layer = layui.layer;//弹出层
        form = layui.form()



        //监听提交
        form.on('submit(*)', function(data){
            console.log(data);
            //发异步，把数据提交给php
            layer.alert("保存成功", {icon: 6});
            return false;
        });

    })
</script>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>

</body>
</html>