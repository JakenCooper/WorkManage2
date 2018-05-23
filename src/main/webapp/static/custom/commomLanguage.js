//获取个人意见常用语
function getOptionLanguage(ctx){
	$.jBox.open("iframe:"+ctx+"/doc/docUserfulWord/refusedForm2", "个人意见",700,300,{
		buttons:{"确定":"ok","常用语设置":"set","关闭":true}, bottomText:"",submit:function(v, h, f){
			var reason = h.find("iframe")[0].contentWindow.reason;
			if (v=="ok"){
				// 执行保存
				var opinion=$("#opinion").val();
				var addOption=opinion+reason.value;
				if(opinion==null){
		    		$("#opinion").val(reason.value);
				}else{
					if(addOption.length<=255){
						$("#opinion").val(opinion+reason.value);
					}else{
						alert("输入内容已超过最大限制（255个字符）！");
					}
				}
		    	//document.getElementById("inputForm").action="${ctx}/doc/docReceive/save";
		    	//$("#inputForm").submit();
		    	return true;
			}
			if(v=="set"){
				h.find("iframe")[0].contentWindow.set();
				return false;
			}
		}, 
		loaded:function(h){
			$(".jbox-content", document).css("overflow-y","hidden");
		}
	});
}