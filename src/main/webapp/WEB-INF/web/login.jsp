<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../public/tag.jsp" %>

<html lang="en">
<head>
    <title>高职学生信息管理系统</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">

    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/login.css" media="all">
</head>
<body>
<div class="larry-canvas" id="canvas"></div>
<div class="layui-layout layui-layout-login">
    <h1>
        <strong>高职学生信息</strong>
        <em>Management System</em>
    </h1>
    <div class="layui-user-icon larry-login">
        <input type="text" placeholder="账号" id="userName" required class="login_txtbx"/>
    </div>
    <div class="layui-pwd-icon larry-login">
        <input type="password" placeholder="密码" id="password" required class="login_txtbx"/>
    </div>
    <div class="layui-submit larry-login" style="margin-top: 20px;width:90%">
        <button  onclick="login()"  class="submit_btn">立即登录</button>
    </div>

    <div class="layui-login-text">
        <p>© 2017-thoughtWorks studio 版权所有</p>
    </div>
</div>
<script type="text/javascript" src="${baseurl}/public/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${baseurl}/public/common/jsplugin/jparticle.jquery.js"></script>
<script type="text/javascript" src="${baseurl}/public/js/login.js"></script>

<script>
    function login() {
        let userName = $("#userName").val();
        let password = $("#password").val();
        $.ajax({
            url: "${baseurl}/login",
            data: {userName: userName, password: password},
            success: function (data) {
                if (data.result) {
                    location.href = "${baseurl}/index";
                } else {
                    layer.msg(data.msg);
                }
            }
        });
    }

</script>
</body>
</html>