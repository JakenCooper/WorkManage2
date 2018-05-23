<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')} 登录</title>
	<meta name="decorator" content="blank"/>
	<style>
	    body{
	        background: #185786;
	    }
	    .login_main{
	        width: 100%;
	        margin: 0 auto;
	    }
	    .login_main  .title_img{
	        display: inline-block;
	        width: 180px;
	        vertical-align: middle;
	        overflow: hidden;
	        margin:0 0 0 45%;
	        /*width: 100%;*/
	        /*position: absolute;*/
	        /*top: 20%;*/
	        /*left: 0;*/
	
	        /*z-index: 999999999999999;*/
	    }
	    .login_main .nav_title{
	        width: 100%;
	        position: absolute;
	        top: 10%;
	        left: 0;
	        /*padding: 10px 20px;*/
	        margin: 0;
	        color: #fff;
	        /*z-index: 999;*/
	        font-size:32px;
	        overflow: hidden;
	    }
	    .login_main .mainBox{
	        width:80%;
	        margin: 24% auto 0;
	        height: 80px;
	
	        border: 1px solid rgba(255,255,255,.2);
	         background-image:linear-gradient(to bottom,rgba(40,142,228,.5),rgba(29,86,144,.5));
	    }
	    .login_main .mainBox form{
	        line-height:80px;
	        margin: 0 0 0 28%;
	    }
	    .login_main .mainBox form input{
	        padding: 10px;
	        margin: 0 10px;
	    }
	    .login_main .mainBox form div{
	       margin:0 50px 0 0;
	    }
	    .login_main .mainBox form span img{
	        padding:9px;
	        background: #ff7c00;
	    }
	    .login_main .mainBox form button{
	        padding:8px 15px;
	        border: none;
	        background: #0199d3;color:#fff;
	    }
	     .scrollBox{
            width: 80%;
            margin:10px auto 0 ;
        }
        .scrollBox .childbox{
            height: 70px;
            background: rgba(0,0,0,.1);
        }
        .scrollBox .childbox ul li{
            text-align: center;
            margin: 5px 0;
        }
        .scrollBox .childbox ul li a{
            color: yellow;
            /*color: white;*/
        }
	</style>
	<script type="text/javascript">
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}
	</script>
</head>
<body>
	<div class="login_main">
		<div class="header">
			<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button>
				<label id="loginError" class="error">${message}</label>
			</div>
		</div>
	    <div class="nav_title">
	        <img class="title_img" src="${ctxStatic}/images/nav_logo.png" alt=""/>
	        <p class="title_p" style="text-align: center">
	            <span>${fns:getConfig('productName')}</span>
	        </p>
	    </div>
	    <div class="mainBox">
	        <form id="loginForm" action="${ctx}/login" method="post">
	            <div style="float: left">
	                <span><img src="${ctxStatic}/images/used.png" alt=""/></span>
	                <input type="text" placeholder="用户名" id="username" name="username" value="${username}"/>
	            </div>
	            <div style="float: left">
	                <span><img src="${ctxStatic}/images/passwords.png" alt=""/></span>
	                <input type="password" placeholder="密码" id="password" name="password"/>
	            </div>
	            <div style="float: left">
	                <button id="submintBtn">登录</button>
	            </div>
	        </form>
	    </div>
	     <div class="scrollBox">
	        <marquee class="childbox" direction="up" behavior="scroll" scrollamount="1" scrolldelay="0" loop="-1"   hspace="10" vspace="10">
	            <ul>
	                <li><a href="https://www.baidu.com" target="_blank">习近平在视察军事科学院时强调 努力建设高水平军事科研机构 为实现党在新时代的强军目标提供有力支撑</a></li>
	                <li><a href="https://www.sogou.com" target="_blank">陕西省将全面开展脱贫攻坚问题整改督导检查</a></li>
	                <li><a href="javascript:;">陕西省公开中央环境保护督察整改情况：26名厅级官员被追责</a></li>
	                <li><a href="javascript:;">省教育厅：规范民办高校招生宣传 查处违法违规招生行为</a></li>
	                <li><a href="javascript:;">陕西多部门解读铁腕治霾三年行动方案 任务已划分</a></li>
	                <li><a href="javascript:;">陕西博物馆总数302座 年均接待观众3600多万人次</a></li>
	            </ul>
	        </marquee>
    	  </div>
	</div>
<script>
	$("#submintBtn").click(function(){
		$("#loginForm").submint();    	
	});
</script>
</body>
</html>