<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en" ng-app>
<head>
<meta charset="utf-8">
<title>用户注册</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" href="../css/main.css" type="text/css">
<link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="../css/bootstrap-responsive.min.css" type="text/css"> 

<style type="text/css">
   body {
        padding-top: 40px;
        padding-bottom: 40px;
		background:url(../img/re.jpg) !important;
    }
	
	#in{
		opacity: 0.8 !important;
	}
</style>
</head>
<body>
<div class="container" id="in">
    <form name="myForm" class="form-signin" ng-submit="save()" ng-controller="loginController">
        <h1 class="form-signin-heading">注册</h1>
        <input type="text" class="input-block-level" placeholder="用户名" ng-model="userName" required name="userName" ng-pattern="/^\S{6,20}$/">
        <p class="error-block" ng-show="myForm.userName.$error.pattern" style="">请输入6-20位英文字母、数字或符号</p>
        <input type="password" class="input-block-level" placeholder="密码" ng-model="passWord" required name="passWord" ng-pattern="/^\S{6,20}$/" ng-change="checkPassword()">
        <p class="error-block" ng-show="myForm.passWord.$error.pattern" style="">请输入6-20位英文字母、数字或符号</p>
        <input type="password" class="input-block-level" placeholder="重复密码" ng-model="repassWord" required name="repassWord" ng-pattern="/^\S{6,20}$/" ng-change="checkPassword()">
        <p class="error-block" ng-show="myForm.repassWord.$error.pattern" style="">请输入6-20位英文字母、数字或符号</p>    
        <p class="error-block" ng-show="myForm.repassWord.$error.dontMatch" style="">两次密码输入不一致</p>
        <input type="text" class="input-block-level" placeholder="邮箱" ng-model="email" required name="email" ng-pattern="/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/">
        <p class="error-block" ng-show="myForm.email.$error.pattern" style="">请输入正确的邮箱格式</p>  
        <div id="region">
            <select id="province" class="prov input-small"></select>
            <select id="city" class="city input-small"></select>
            <select id="district" class="dist input-small" disabled="disabled" style="display: none;"></select>
        </div> 
        <label class="checkbox">
            <input ng-model="agreement" type="checkbox">
            同意"服务协议"和"隐私条款"
        </label>
        <button class="btn btn-large btn-primary" type="submit" ng-disabled="!!myForm.$error.pattern || !!myForm.$error.required || hasNotAgreed()">提交</button>
    </form>
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
</body>
<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script src="../js/jquery-1.8.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/angular.min.js"></script>
<!-- 城市联动插件 -->
<script src="../js/city_json.min.js"></script>
<script src="../js/city.min.js"></script>
<script src="../js/myModel.js"></script>
<script>
angular.element(document).ready(function() {
    angular.module("loginController",[]);
});
function loginController ($scope) {
    //默认勾选
    $scope.agreement = true;
    //填充城市信息
    $("#region").citySelect({prov:"上海",nodata:"none"});
    // 同意条款勾选
    $scope.hasNotAgreed = function() {
        return !$scope.agreement;
    };
    // 前后密码校验
    $scope.checkPassword = function() {
        $scope.myForm.repassWord.$error.dontMatch = ($scope.passWord !== $scope.repassWord);
    };
    $scope.save = function() {
        alertInfo("数据验证、提交","300px");
        var user = {"username":$scope.userName,"password":$scope.passWord};
        $.ajax({
        	type:"POST",
        	url:"register.do",
        	async:false,
        	dataType: "json",
        	//contentType:"application/json;charset=utf-8",
        	data:user,
        	 error:function(data){  
        		 
                 alertInfo("注册失败,请重试","300px");  
             },  
             success:function(data){  
            	 alert(data.msg);
                 alert("注册成功"); 
                 window.location.href = "../index.jsp";
             }  		
        });
       
    };
}
</script>
</html>