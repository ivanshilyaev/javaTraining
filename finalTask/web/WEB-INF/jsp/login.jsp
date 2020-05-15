<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="ctg" uri="customTags" %>
<html>
<head>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css"/>
    <title>Авторизация</title>
</head>

<body>
<div class="wrapper fadeInDown">
    <div id="formContent">

        <!-- Icon -->
        <div class="fadeIn first">
            <img src="${pageContext.request.contextPath}/images/bsu.png" width="60" alt="bsu-logo"/>
        </div>

        <!-- Login Form -->
        <c:url value="/login.html" var="loginUrl"/>
        <form name="loginForm" method="POST" action="${loginUrl}">
            <input type="text" id="login" class="fadeIn second" name="login" placeholder="Логин">
            <input type="password" id="password" class="fadeIn third" name="password" placeholder="Пароль">
            <input type="submit" class="fadeIn fourth" value="Войти">
        </form>
        ${requestScope.message}
        <br>

    </div>
</div>

</body>
</html>
