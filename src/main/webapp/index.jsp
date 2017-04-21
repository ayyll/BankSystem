<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="en" ng-app>
<head>

<meta charset="utf-8">
<title>用户登陆</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" href="css/main.css" type="text/css">
<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="css/bootstrap-responsive.min.css"
	type="text/css">
<style type="text/css">
body {
	padding-top: 40px;
	padding-bottom: 40px;
	background: url(img/sky.jpg) !important;
}

#in {
	opacity: 0.8 !important;
}

#lb {
	margin-left: 15px;
	font-weight: 800; /*字体粗细*/
	letter-spacing: 10px; /*字间距*/
	color: red;
}
</style>
</head>
<body onload="createCode()">

	<div class="container" id="in">
		<form name="myForm" class="form-signin" ng-submit="save()"
			ng-controller="loginController">
			<h1 class="form-signin-heading">请登录</h1>
			<input type="text" required class="input-block-level"
				placeholder="userName" ng-model="userName" name="userName">
			<input type="password" required class="input-block-level"
				placeholder="Password" ng-model="passWord" name="passWord">
			<input type="text" required placeholder="请输入验证码" ng-model="code"
				name="code" style="width:150px;" id="input">

			<lable id="lb" onclick="createCode()"></lable>

			<label class="checkbox"> <input type="checkbox"
				value="remember-me"> 下次自动登录 </label>
			<center>
				<button class="btn btn-large btn-primary" type="submit">登录</button>
				<button style="margin-left:59px;" class="btn btn-large btn-primary"
					type="button" onclick="window.location.href = './user/regiset.jsp'">注册</button>
			</center>
		</form>
	</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h3 class="modal-title" id="myModalLabel">提示</h3>
				</div>
				<div class="modal-body" id="alertInfo"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
</body>
<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

<!--  
<script src="js/jquery-1.8.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/angular.min.js"></script>
-->

<script src="js/jquery-1.8.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/angular.min.js"></script>
<script src="js/myModel.js"></script>
<script>
	var code = "";//验证码
	angular.element(document).ready(function() {
		angular.module("loginController", []);
	});
	function loginController($scope) {
		$scope.save = function() {
			//alert($scope.userName+"##"+$scope.passWord)
			if (isValidate() == false) {
				alertInfo("验证码错误","250px");
				return;
			}
			//alert("数据保存,后台请求验证");
			var user = {
				"username" : $scope.userName,
				"password" : $scope.passWord
			};
			$.ajax({
				type : "POST",
				url : "user/login.do",
				async : true,
				dataType : "json",
				//contentType:"application/json;charset=utf-8",
				data : user,
				error : function(data) {
					alertInfo("服务器异常,请重试","300px");
				},
				success : function(data) {
					if (data.msg == "yes") {
						window.location.href = "./bank/index.jsp";
					} else {
						alertInfo("用户名或密码错误!","300px");
					}

				}
			});
			//window.location.href = "index.html";
		}
	}

	//生成验证码
	function createCode() {
		code = "";
		var codeLength = 4;//验证码的长度  
		var checkCode = document.getElementById("lb");
		var random = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C',
				'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
				'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');//随机数  
		for ( var i = 0; i < codeLength; i++) {
			var index = Math.floor(Math.random() * 36);//取得随机数的索引（0~35）  
			code += random[index];//根据索引取得随机数加到code上  
		}
		checkCode.innerHTML = code;
	}
	//校验验证码  
	function isValidate() {
		//取得输入的验证码并转化为大写        
		var inputCode = document.getElementById("input").value;
		inputCode = angular.uppercase(inputCode);
		if (inputCode != code) { //若输入的验证码与产生的验证码不一致时  

			$("#input").val("");//清空文本框 
			createCode();//刷新验证码  
			return false;
		} else { //输入正确时  
			return true;
		}
	}
</script>
</html>