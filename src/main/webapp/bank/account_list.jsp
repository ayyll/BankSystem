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
</head>
<body onload="init();">
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
			<li><a href="javascript:void(0);">账户列表</a></li>
			<li><a href="open_account.jsp">账户开户</a></li>
			<li><a href="cancle_account.jsp;">账户挂失</a></li>
			<li><a href="account_log.jsp;">流水账单</a></li>
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
			<h1 class="page-title">账户列表</h1>
		</div>
		<div id="total" style="height:40px;margin-top:30px" align="center"></div>
		<!-- 账户列表 -->
		<div class="account_list" style="margin-top:10px">
			<table class="table table-bordered table-hover table-condensed">
				<thead id="thead"></thead>
				<tbody id="tbody"></tbody>
			</table>
		</div>

		<!-- pagination分页 -->
		<div class="pagination" align="center">
			<ul id="myul"></ul>
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
<script type="text/javascript">
	var current_page = 1;//当前页,初始为首页
	var total_page = 999999;//总页数
	var count = 10; //每页显示的数据条数
	var id = 0;
	//type为请求类型  1:首页2:上一页3:下一页4:尾页
	function getPage(type) {

		if (type == 1) {
			current_page = 1;
		} else if (type == 2) {
			if (current_page != 1)
				current_page--;
			else return ;
		} else if (type == 3) {
			if (current_page != total_page)
				current_page++;
			else return ;
		} else if (type == 4) {
			current_page = total_page;
		}
		var message = {
			"page" : current_page,
			"count" : count
		};
		$.ajax({
			type : "GET",
			url : "account_list.do",
			//contentType:"application/json;charset=utf-8",
			data : message,
			async : true,
			error : function(request) {
				alert("服务器异常，请重试3");
			},
			success : function(data) {
				$("#tbody").empty();
				id = (current_page - 1) * 10 + 1;
				for ( var i = 0; i < data.info.length; i++,id++) {
					if (i % 2 == 0) {
						$("#tbody").append(
								"<tr class='warning'><td>" + id + "</td><td>" + data.info[i].card
										+ "</td><td>" + data.info[i].name
										+ "</td><td>" + data.info[i].sex
										+ "</td><td>" + data.info[i].money
										+ "</td><td>" + data.opentime[i]
										+ "</td></tr>");
					} else {
						$("#tbody").append(
								"<tr class='info'><td>" + id + "</td><td>" + data.info[i].card
										+ "</td><td>" + data.info[i].name
										+ "</td><td>" + data.info[i].sex
										+ "</td><td>" + data.info[i].money
										+ "</td><td>" + data.opentime[i]
										+ "</td></tr>");
					}
				}
				
			}
		});
	}

	function init() {
		var message = {
			"page" : current_page,
			"count" : count
		};
		$.ajax({
			type : "GET",
			url : "account_list_init.do",
			//contentType:"application/json;charset=utf-8",
			data : message,
			async : false,
			error : function(request) {
				alert("服务器异常，请重试3");
			},
			success : function(data) {
				total_page = (data.total%count==0?data.total/count:Math.floor(data.total/count)+1);//总页数
				document.getElementById("total").innerHTML = "总记录:"
						+ data.total + "条&nbsp;&nbsp;&nbsp;" + "总页数:" +total_page + "页";
				document.getElementById("total").style.color = "#800080";
				document.getElementById("total").style.fontWeight = "900";
				document.getElementById("total").style.fontSize = "20px";
				$("#thead").empty();
				$("#tbody").empty();
				$("#myul").empty();
				id = 1;
				$("#thead").append("<tr><th>序号</th><th>银行卡号</th><th>姓名</th><th>性别</th><th>账户余额</th><th>开户时间</th></tr>");
				for ( var i = 0; i < data.info.length; i++,id++) {
					if (i % 2 == 0) {
						$("#tbody").append(
								"<tr class='warning'><td>" + id + "</td><td>" + data.info[i].card
										+ "</td><td>" + data.info[i].name
										+ "</td><td>" + data.info[i].sex
										+ "</td><td>" + data.info[i].money
										+ "</td><td>" + data.opentime[i]
										+ "</td></tr>");
					} else {
						$("#tbody").append(
								"<tr class='info'><td>" + id + "</td><td>" + data.info[i].card
										+ "</td><td>" + data.info[i].name
										+ "</td><td>" + data.info[i].sex
										+ "</td><td>" + data.info[i].money
										+ "</td><td>" + data.opentime[i]
										+ "</td></tr>");
					}
				}
				$("#myul").append("<li><a href='javajavascript:void(0);' onclick='getPage(1);return false;'>首页</a></li>");
				$("#myul").append("<li><a href='javajavascript:void(0);' onclick='getPage(2);return false;'>上一页</a></li>");
				$("#myul").append("<li><a href='javajavascript:void(0);' onclick='getPage(3);return false;'>下一页</a></li>");
				$("#myul").append("<li><a href='javajavascript:void(0);' onclick='getPage(4);return false;'>尾页</a></li>");
			}
		});
	}
</script>
</html>
