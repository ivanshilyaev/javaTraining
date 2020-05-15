<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="ctg" uri="customTags" %>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

<header id="appHeader">
    <div class="navbar">
        <a href="https://bsu.by/">БГУ</a>
        <c:url value="/studentCabinet.html" var="cabinetUrl"/>
        <form style="margin-left: auto" class="menu-form" name="findAllStudentsFromTheGroup" method="POST"
              action="${cabinetUrl}">
            <input type="submit" value="Мой профиль">
        </form>
        <c:url value="/search/group.html" var="groupUrl"/>
        <form class="menu-form" name="findAllStudentsFromTheGroup" method="POST" action="${groupUrl}">
            <input type="submit" value="Моя группа">
        </form>
        <c:url value="/study/schedule.html" var="scheduleUrl"/>
        <form class="menu-form" name="schedule" method="POST" action="${scheduleUrl}">
            <input type="submit" value="Расписание">
        </form>
        <c:url value="/study/performance.html" var="performanceUrl"/>
        <form class="menu-form" name="performance" method="POST" action="${performanceUrl}">
            <input type="submit" value="Успеваемость">
        </form>
        <c:url value="/password.html" var="passwordUrl"/>
        <form class="menu-form" name="changePasswordForm" method="POST" action="${passwordUrl}">
            <input type="submit" value="Изменить пароль">
        </form>
        <c:url value="/logout.html" var="logoutUrl"/>
        <form class="menu-form" name="logoutForm" method="POST" action="${logoutUrl}">
            <input type="submit" value="Выйти">
        </form>
    </div>
</header>

</body>
</html>