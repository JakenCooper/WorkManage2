<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<html>
<head>
	<title>交接班管理</title>
	<meta name="decorator" content="default"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/plugins/layui/css/layui.css" media="all">
     <script src="${pageContext.request.contextPath}/static/plugins/layui/layui.js" type="text/javascript"></script>
    <style>
        body{  margin:20px 10px 20px;  }
        table{  width: 680px;
            border: 1px solid #e5e5e5;
            margin: 0 auto;
        }
        table td{
            border: 1px solid #e5e5e5;
            text-align: center;
            padding: 10px;
        }
        table tr td:first-child{
            background: #f2f2f2;
        }

        table input{
            border-color:transparent;
            width: 90px;}
        .pane_bottom{
            width: 680px;
            margin: 0 auto;
            padding: 10px 0 0;
        }
        .pane_bottom h3{
            font-weight: bold;
            margin-bottom: 5px;
        }
        .pane_bottom p{
            line-height: 28px;
        }
    </style>
</head>
<body>
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
	
		  //日期时间选择器
		  	laydate.render({ 
			  elem: '#zsSysTransStatusRestarTime'
			  ,type: 'datetime'
			}); 
			laydate.render({ 
			  elem: '#jiaoBanTime'
			  ,type: 'datetime'
			}); 
			
		  
		  //监听Tab切换
		  form.render('select','selFilter'); 
		  element.on('tab(demo)', function(data){
		    layer.msg('切换了：'+ this.innerHTML);
		    console.log(data);
		  });
		  //提交表单
	
		 //清空表单
		 $("#cleanForm").click(function(){
		 	document.getElementById('jiaoJieBanFrom').reset();
		 });
		});
	})
</script>
<script type="text/javascript">

	//获取id
	$(function(){


		
		//获取前一天交班信息
		$.ajax({
			type:'post',
			url:'${ctx}/jiaojieban/wmOndutyDetail/beforeDetailInfo',
			dataType:'json',
			success:function(msg){
				//alert(msg.computerNumber)
					$("#computerNumber").val(msg.computerNumber);
					$("#faxMachineNumber").val(msg.faxMachineNumber);
					$("#keyNum").val(msg.keyNum);
					$("#zsSysTransStatus").val(msg.zsSysTransStatus);
					$("#zsSysTransStatusRestarTime").val(msg.zsSysTransStatusRestarTime);
					$("#zhuanWangStatus").val(msg.zhuanWangStatus);
					$("#jiFangSafeStatus").val(msg.jiFangSafeStatus);
					$("#leader").val(msg.leader);
					$("#changeUser").val(msg.changeUser);
					$("#ondutyUser").val(msg.ondutyUser);
					$("#jiaoBanTime").val(msg.jiaoBanTime);
			},
		    error: function (XMLHttpRequest, textStatus, errorThrown) {
                  // 状态码
                  console.log(XMLHttpRequest.status);
                  // 状态
                  console.log(XMLHttpRequest.readyState);
                  // 错误信息   
                  console.log(textStatus);
            }
		})
	})	
</script>
<script type="text/javascript">
	$(function(){
		$("#jieBan_btn").click(function(){
			$("#jieBanFrom").submit();
		})
	})
</script>

<sys:message content="${message}"></sys:message>
<div class="" style="padding-right: 45%;">
    <div style="float: right">
        <button type="button"  class="layui-btn" id="jieBan_btn">接班</button>
        <button type="button"  class="layui-btn layui-btn-danger">导出</button> 
    </div>
</div>
<div>
		<div style="clear:both;padding-top:10px;width: 85%;float: left;hight:auto;">
			<form action="${ctx}/duty/wmOnduty/jieBan" id="jieBanFrom" class="layui-form">
			
		    <table  style="width:90%;margin-top:20px;">
		        <tr>
		            <td style="width: 10%;">设备清单</td>
		            <td style="width: 20%;">
		                <ul>
		                    <li>计算机<input type="text" name="computerNumber"  id="computerNumber" type="computerNumber" />台</li>
		                    <li>机器<input type="text"/>台</li>
		                </ul>
		            </td>
		            <td style="width: 20%;">
		                <ul>
		                    <li>传真机<input type="text" name="faxMachineNumber" id="faxMachineNumber"/>台</li>
		                    <li>机器<input type="text"/>台</li>
		                </ul>
		            </td>
		            <td style="width: 20%;">钥匙<input type="text" name="keyNum" id="keyNum"/>个</td>
		            <td>计算机 <input type="text" style="width: 10%;"/>台</td>
		            <td>传真机 <input type="text" style="width: 10%;"/>台</td>
		        </tr>
		        <tr>
		            <td>o6系统运行情况</td>
		             <td colspan="2">
		              <!--   <sapn>正常:<input type="text" /></sapn>
		                <sapn>不正常:<input type="text" name="zsSysTransStatus" id="zsSysTransStatus"/></sapn>
		                <sapn>重起时间:<input type="text" name="zsSysTransStatusRestarTime" id="zsSysTransStatusRestarTime"/></sapn> -->
					    <div class="layui-form-item">
				    	  <label class="layui-form-label">状态:</label>
						    <div class="layui-input-block">
						      <select name="zsSysTransStatus" >
						     		<option value="0">正常</option>
						     		<option value="1">不正常</option>
						      </select>
						    </div>
		  				</div>
		            	<div class="layui-form-item">
				    	  <label class="layui-form-label">重启时间:</label>
						    <div class="layui-input-block">
						  		<input type="text" class="layui-input" id="zsSysTransStatusRestarTime" name="zsSysTransStatusRestarTime">
						    </div>
		  				</div>
		            </td>
					<td>专网线路监控</td>  
					<td colspan="2">
		                <!-- <sapn>正常:<input type="text" /></sapn>
		                <sapn>不正常:<input type="text" name="zhuanWangStatus" id="zhuanWangStatus"/></sapn> -->
		                <div class="layui-form-item">
				    	  <label class="layui-form-label">状态:</label>
						    <div class="layui-input-block">
						      <select name="zhuanWangStatus">
						     		<option value="0">正常</option>
						     		<option value="1">不正常</option>
						      </select>
						    </div>
		  				</div>
		            </td>
		        </tr>
		   
		        <tr>
		            <td>机房监控及安全情况</td>
		            <td colspan="5">
		           <!--  <input type="" name="jiFangSafeStatus" id="jiFangSafeStatus"/> -->
		            <div class="layui-form-item layui-form-text">
					    <div class="layui-input-block">
					      <textarea placeholder="请输入内容" name="jiFangSafeStatus" class="layui-textarea" style="float: left;"></textarea>
					    </div>
		  			</div>
		            </td>
		        </tr>
		        <tr>
		            <td>带班领导</td>
		            <td colspan="5"><input type="text" name="leader" id="leader"/></td>
		        </tr>
		        <tr>
		            <td  rowspan="10">
		                 工作 内容和
					     <br>           
					                需要移交的事项
		                </td>
		            <td  rowspan="10" colspan="5">
		                <div class="layui-row">
		                    <span >交班人签名：<input type="text" name="changeUser" id="changeUser"/></span>
		                    <span >值班人员：<input type="text" name="ondutyUser" id="ondutyUser"/></span>
		                </div>
		            <!--     <div class="row" style="margin-top: 20px">
		                    <span class="layui-col-md-offset8 layui-col-md-3"><input type="text" name="jiaoBanTime" id="jiaoBanTime"/>年 <input type="text"/>月</span>
		                </div>  -->
		         <!--     <div class="layui-form">
			            <div class="layui-input-block">
			            	<span>交班时间：</span>
			                <input id="jiaoBanTime" type="date" name="jiaoBanTime" id="date"  placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input" style="width: 30%">
			            </div>
		        	</div> --> 
		        		<div class="layui-form-item">
						    <div class="layui-input-block">
						  		<span>交班时间 :</span><input type="text" class="layui-input" id="jiaoBanTime" name="jiaoBanTime" style="width: 35%;" >
						    </div>
		  				</div>
		            </td>
		        </tr>
		    </table>
		    </form>
		</div>
		  <div class="pane_bottom" style="float: right; width: 15%;">
	        <h3>注意事项：</h3>
	        <p>
	            1.坚持24小时值班，确保通讯畅通；<br/>
	            2.严格交接班手续，认真填写值班日志，遇有重大情况及时报告有关领导；<br/>
	            3.待办文件及其它事项要注明缓急程度、交代清楚需要注意的事项；<br/>
	            4.值班期间，坚守岗位，不得离岗，如造成工作失误，追究相关责任。
	        </p>
   		</div>
	</div>
</body>
</html>
