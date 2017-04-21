<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>银行管理系统</title>
<!-- 验证用户是否登陆  -->
<% if(session.getAttribute("username") == null) {
	response.sendRedirect("../index.jsp");
} %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="../css/bootstrap-responsive.min.css">
<style type="text/css">
#info {
	margin-top: 77px;
	margin-left: 200px;
	font-size: 250%;
	font-weight: bold;
	color: red;
}
</style>

</head>
<body>
	<!-- 上 -->
	<div class="navbar">
		<div class="navbar-inner">
			<div class="container-fluid">
				<ul class="nav pull-right">
					<li id="fat-menu" class="dropdown"><a href="#" id="drop3"
						role="button" class="dropdown-toggle" data-toggle="dropdown">
							<i class="icon-user icon-white"></i> ${sessionScope.username} <i
							class="icon-caret-down"></i> </a>
						<ul class="dropdown-menu">
							<li><a tabindex="-1" href="../user/updatepsw.jsp">修改密码</a>
							</li>
							<li class="divider"></li>
							<li><a tabindex="-1" href="../index.jsp">安全退出</a>
							</li>
						</ul></li>
				</ul>
				<a class="brand" href="index.jsp"><span class="first">银行管理系统</span>
				</a>
				<ul class="nav">

				</ul>

			</div>
		</div>
	</div>
	<!-- 左 -->
	<div class="sidebar-nav">
		<a href="#dashboard-menu" class="nav-header" data-toggle="collapse"><i
			class="icon-exclamation-sign"></i>账户操作</a>
		<ul id="dashboard-menu" class="nav nav-list collapse in">
			<li><a href="save_money.jsp">存款</a>
			</li>
			<li><a href="take_money.jsp">取款</a>
			</li>
			<li><a href="transfer_money.jsp">转账</a>
			</li>
		</ul>
		<a href="#accounts-menu" class="nav-header" data-toggle="collapse"><i
			class="icon-exclamation-sign"></i>账户管理</a>
		<ul id="accounts-menu" class="nav nav-list collapse">
			<li><a href="account_list.jsp">账户列表</a>
			</li>
			<li><a href="open_account.jsp">账户开户</a>
			</li>
			<li><a href="javascript:void(0);">账户挂失</a>
			</li>
			<li><a href="account_log.jsp">流水账单</a>
			</li>
		</ul>
		<a href="#legal-menu" class="nav-header" data-toggle="collapse"><i
			class="icon-exclamation-sign"></i>系统页面</a>
		<ul id="legal-menu" class="nav nav-list collapse">
			<li><a href="../index.jsp">登录页面</a>
			</li>
			<li><a href="../user/regiset.jsp">注册页面</a>
			</li>
			<li><a href="../user/updatepsw.jsp">密码修改</a>
			</li>
		</ul>
		<a href="http://www.ayyll.com" target="_blank" class="nav-header"><i
			class="icon-exclamation-sign"></i>关于作者</a>
	</div>
	<!-- 右 -->
	<div class="content">
		<div class="header">
			<h1 class="page-title">挂失账户</h1>
		</div>
		<div class="save_money" style="margin-top:50px;margin-left:200px;">
			<!-- edit form -->
			<form class="form-horizontal" role="form" id="myform">

				<div class="form-group" style="margin-top:10px;">
					<label for="account" class="col-sm-2 control-label"><strong>挂失账户:</strong>&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="col-sm-5">
						<input type="text" class="form-control" id="account"
							placeholder="请输入挂失账户" name="account" oninput="check_account(true)">
						<lable id="ck_account"></lable>
					</div>
				</div>
				<div class="form-group" style="margin-top:30px;">
					<label for="password" class="col-sm-2 control-label"><strong>挂失密码:</strong>&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="col-sm-5">
						<input type="password" class="form-control" id="password"
							placeholder="请输入密码" name="password" oninput="check_password(true)">
						<lable id="ck_password"></lable>
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10"
						style="margin-left:80px;margin-top:40px;">
						<button type="button" class="btn btn-danger" onclick="save()">挂失</button>
					</div>
				</div>
			</form>
		</div>
		<div id="info" style="height:100px"></div>
		<!-- 模态框（Modal） -->
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
	</div>
	<script type="text/javascript" src="../js/particle.js"></script>
	<canvas id="c_n27" width="449" height="690"
		style="position: fixed; top: 0px; left: 0px; z-index: -1; opacity: 0.5;"></canvas>
</body>
<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script src="../js/jquery-1.8.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/myModel.js"></script>
<script type="text/javascript">
	var isAccountOK = false;
	var isPasswordOK = false;
	//校验输入的账号是否存在
	function check_account(isAsync) {
		//alert(isAsync);
		var input = document.getElementById("account");
		var ck_account = document.getElementById("ck_account");
		//请求账户名是否存在
		var acc = {
			"account" : input.value
		};
		$.ajax({
			type : "GET",
			url : "checkAccountIsExists.do",
			data : acc,
			async : isAsync,
			error : function(request) {
				alertInfo("服务器异常,请重试", "300px");
			},
			success : function(data) {
				//alert(data.msg);
				if (data.msg == "ok") {

					ck_account.innerHTML = "";
					isAccountOK = true;
					return true;
				} else {

					ck_account.innerHTML = "&nbsp;&nbsp;&nbsp;账户不存在!";
					ck_account.style.color = "red";
					ck_account.style.fontWeight = "bold";//设置字体加粗
					isAccountOK = false;
					return false;
				}
			}
		});
	}
	//校验输入的密码是否正确
	function check_password(isAsync) {

		//if(!check_account()) return false;
		var input_account = document.getElementById("account");
		var input_password = document.getElementById("password");
		var ck_password = document.getElementById("ck_password");
		//请求密码是否正确
		var acc = {
			"account" : input_account.value,
			"password" : input_password.value
		};
		$.ajax({
			type : "GET",
			url : "checkPasswordIsRight.do",
			data : acc,
			async : isAsync,
			error : function(request) {
				alertInfo("服务器异常,请重试", "300px");
			},
			success : function(data) {
				//alert(data.msg);
				if (data.msg == "ok") {
					ck_password.innerHTML = "";
					isPasswordOK = true;
					return true;
				} else {
					ck_password.innerHTML = "&nbsp;&nbsp;&nbsp;密码错误!";
					ck_password.style.color = "red";
					ck_password.style.fontWeight = "bold";//设置字体加粗
					isPasswordOK = false;
					return false;
				}
			}
		});
	}
	function save() {

		if (!isPasswordOK || !isAccountOK) {
			alertInfo("卡号或密码错误!", "300px");
			return;
		}
			
		//alert($('#myform').serialize());
		$.ajax({
			type : "GET",
			url : "cancle_account.do",
			data : $('#myform').serialize(),// 序列化表单值  
			async : true,
			error : function(request) {
				alertInfo("服务器异常,请重试", "300px");
			},
			success : function(data) {
				//alert(data.msg);
				if (data.msg == "ok") {
					alertInfo("挂失成功!", "250px");
					$("#info").empty();
					$("#info").css({
						  "color":"#9400d3",
						  "margin-left":"280px",
						  "font-size":"20px",
						  "line-height":"150%"
					});
					$("#info").append("新卡号:" + data.account_msg.card + "<br />");
					$("#info").append("姓名:" + data.account_msg.name + "<br />");
					$("#info").append("余额:" + data.account_msg.money + "<br />");
					$("#info").append("PS:密码为卡号后6位<br />");
					
				} else {
					alertInfo("账户不存在或已挂失!", "320px");
				}
			}
		});
	}
</script>
</html>
