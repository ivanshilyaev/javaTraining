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
        <c:url value="/adminCabinet.html" var="cabinetUrl"/>
        <form style="margin-left: auto" class="menu-form" name="findAllStudentsFromTheGroup" method="POST"
              action="${cabinetUrl}">
            <input type="submit" value="Мой профиль">
        </form>
        <c:url value="/search/listUsers.html" var="listUrl"/>
        <form class="menu-form" name="findAllUsersForm" method="POST" action="${listUrl}">
            <input type="submit" value="Пользователи">
        </form>
        <c:url value="/students/listGroups.html" var="listGroupsUrl"/>
        <form class="menu-form" name="findAllGroups" method="POST" action="${listGroupsUrl}">
            <input type="submit" value="Группы">
        </form>
        <c:url value="/tutors/listTutors.html" var="listTutorsUrl"/>
        <form class="menu-form" name="findAllGroups" method="POST" action="${listTutorsUrl}">
            <input type="submit" value="Преподаватели">
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