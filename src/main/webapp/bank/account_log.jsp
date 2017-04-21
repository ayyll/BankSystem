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
<%
	if (session.getAttribute("username") == null) {
		response.sendRedirect("../index.jsp");
	}
%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="../css/bootstrap-responsive.min.css">
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
							<li><a tabindex="-1" href="../user/updatepsw.jsp">修改密码</a></li>
							<li class="divider"></li>
							<li><a tabindex="-1" href="../index.jsp">安全退出</a></li>
						</ul>
					</li>
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
			<li><a href="save_money.jsp">存款</a></li>
			<li><a href="take_money.jsp">取款</a></li>
			<li><a href="transfer_money.jsp">转账</a></li>
		</ul>
		<a href="#accounts-menu" class="nav-header" data-toggle="collapse"><i
			class="icon-exclamation-sign"></i>账户管理</a>
		<ul id="accounts-menu" class="nav nav-list collapse">
			<li><a href="account_list.jsp">账户列表</a></li>
			<li><a href="open_account.jsp">账户开户</a></li>
			<li><a href="cancle_account.jsp;">账户挂失</a></li>
			<li><a href="javascript:void(0);">流水账单</a></li>
		</ul>
		<a href="#legal-menu" class="nav-header" data-toggle="collapse"><i
			class="icon-exclamation-sign"></i>系统页面</a>
		<ul id="legal-menu" class="nav nav-list collapse">
			<li><a href="../index.jsp">登录页面</a></li>
			<li><a href="../user/regiset.jsp">注册页面</a></li>
			<li><a href="../user/updatepsw.jsp">密码修改</a></li>
		</ul>
		<a href="http://www.ayyll.com" target="_blank" class="nav-header"><i
			class="icon-exclamation-sign"></i>关于作者</a>
	</div>
	<!-- 右 -->
	<div class="content">
		<div class="header">
			<h1 class="page-title">账单查询</h1>
		</div>
		<div style="margin-top:50px;margin-left:200px">
			<span><input type="text" id="account" placeholder="请输入银行卡号">
			</span> <span style="margin-left:30px"><input type="button"
				value="查询"
				style="width:50px;color:#FFFBFB;font-weight:900;background:#E52396"
				onclick="save()" /> </span>
		</div>
		<div id="answer" style="margin-top:30px;margin-left:50px">
			<h3 align="left" id="lable_title" style="color:red;"></h3>
			<table id="lable_info" class="table table-hover"
				style="margin-top:16px">
				<thead id="table_head"></thead>
				<tbody id="table_body"></tbody>
			</table>
		</div>
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
	var id = 0;
	function save() {

		var message = {
			"account" : $("#account").val()
		};
		//alert(message.account);
		$
				.ajax({
					type : "GET",
					url : "account_log.do",
					data : message,
					async : false,
					error : function(request) {
						alertInfo("服务器异常,请重试", "300px");
					},
					success : function(data) {
						if (data.msg == "error") {
							alertInfo("未查询到结果,请检查卡号输入是否有误", "400px");
						} else {
							$("#lable_title").text("查询结果:");
							$("#table_head").empty();
							$("#table_body").empty();
							id = 1;
							$("#table_head")
									.append(
											"<tr><th>序号</th><th>银行卡号</th><th>交易类型</th><th>交易金额</th><th>交易时间</th></tr>");
							for ( var i = 0; i < data.info.length; i++, id++) {
								$("#table_body").append(
										"<tr><td>" + id + "</td><td>"
												+ data.info[i].card
												+ "</td><td>"
												+ data.info[i].msg
												+ "</td><td>"
												+ data.info[i].deal + "元"
												+ "</td><td>"
												+ data.dealtime[i]
												+ "</td></tr>");
							}
						}
					}
				});
	}
</script>
</html>
