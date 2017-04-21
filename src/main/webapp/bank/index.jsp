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
<script src="../js/showtime.js"></script>
</head>
<body onload="ShowTime();">
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
				<a class="brand" href="javascript:void(0);"><span class="first">银行管理系统</span>
				</a>
				<ul class="nav">

					<li id="stime"
						style="margin-top:12px;margin-left:700px;color:#FFFFFF;"></li>
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
			<li><a href="cancle_account.jsp">账户挂失</a></li>
			<li><a href="account_log.jsp">流水账单</a></li>
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
		<div>
			<br> <br>
			<h1 align="center">Welcome to online bank</h1>
			<br>
			<p
				style="font-size:16px;font-family:arial;letter-spacing: 3px;line-height:150%">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;近年来，随着银行存取款数目的逐渐增加，人工书写的方式已经不能满足如此庞大的数据。为了更好的适应信息时代的高效性，一个利用计算机来实现银行业务管理工作的系统将必然诞生。<span
					style="color:#FF0000;font-weight:bold;">本系统旨在简化银行工作人员的业务处理，提高银行业务数据的安全性。</span>
			</p>
			
		</div>
		<script type="text/javascript" src="../js/particle.js"></script>
		<canvas id="c_n27" width="449" height="600"
			style="position: fixed; top: 0px; left: 0px; z-index: -1; opacity: 0.5;"></canvas>
	</div>


</body>
<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script src="../js/LAB.min.js"></script>
<script>
	$LAB.script("../js/jquery-1.8.1.min.js").script("../js/bootstrap.min.js")
			.wait().script("../js/highcharts.js")//for highchar
			.script("../js/exporting.js")//for highchar
			.wait().script("../js/draw.js")
</script>
</html>
