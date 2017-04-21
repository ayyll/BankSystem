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
			<li><a href="javascript:void(0);">存款</a>
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
			<li><a href="cancle_account.jsp">账户挂失</a>
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
			<h1 class="page-title">存款操作</h1>
		</div>
		
		<div class="save_money" style="margin-top:50px;margin-left:200px;">
			<!-- edit form -->
			<form class="form-horizontal" role="form" id="myform">
				<div class="form-group" style="margin-top:10px;">
					<label for="account" class="col-sm-2 control-label"><strong>存款账户:</strong>&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="col-sm-5">
						<input type="text" class="form-control" id="account"
							placeholder="请输入银行卡账号" name="account">
					</div>
				</div>
				<div class="form-group" style="margin-top:30px;">
					<label for="money" class="col-sm-2 control-label"><strong>金额(元):</strong>&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="col-sm-5">
						<input type="text" class="form-control" id="money"
							placeholder="请输入存款金额" oninput="check()" name="money"><lable id = "ck"></lable>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10" style="margin-left:100px;margin-top:30px;">
						<button type="button" class="btn btn-default" onclick="save()">提交</button>
					</div>
				</div>
			</form>
		</div>
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
	<script type="text/javascript" src="../js/particle.js"></script>
   	<canvas id="c_n27" width="449" height="690" style="position: fixed; top: 0px; left: 0px; z-index: -1; opacity: 0.5;"></canvas>
</body>
<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script src="../js/jquery-1.8.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/myModel.js"></script>
<script type="text/javascript">
	//是否为正整数 
	function isPositiveNum(s){ 
    	var re = /^[0-9]*[1-9][0-9]*$/ ;  
    	return re.test(s);  
	} 
	function check() {
		var input = document.getElementById("money");
		var ck = document.getElementById("ck");
		if(input.value == "")return false;
		if(!isPositiveNum(input.value)) {
			ck.innerHTML="&nbsp;&nbsp;&nbsp;请输入正整数!";
			ck.style.color="red";
			return false;
		} else {
			ck.innerHTML="";
			return true;
		}
	}
	function save() {
		
		if(document.getElementById("account").value == "") {
			//alert("x");
			alertInfo("账户不能为空!","250px");
			return ;
		}
		if(!check()) {
			alertInfo("请输入合法金额!","300px");
			return ;	
		}
		
		//alert($('#myform').serialize());
		$.ajax({  
            type: "GET",  
            url:"save_money.do",  
            data:$('#myform').serialize(),// 序列化表单值  
            async: true,  
            error: function(request) {  
            	alertInfo("服务器异常,请重试","250px");
            },  
            success: function(data) {  
               //alert(data.msg);
               if(data.msg == "ok") {
            	   alertInfo("存款成功","250px");
               } else {
            	   alertInfo("账户不存在!","250px");
               }
            }  
        });  
	}
</script>
</html>
