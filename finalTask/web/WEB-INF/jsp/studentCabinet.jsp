<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="ctg" uri="customTags" %>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <title>Кабинет студента</title>
</head>
<body>

<%@ include file="header/studentHeader.jsp" %>

<div class="content">
    <%--Для полного имени нужен свой пользовательский тег!--%>
    <h2>Добро пожаловать, ${sessionScope.authorizedUser.surname}
        ${sessionScope.authorizedUser.name}
        ${sessionScope.authorizedUser.patronymic}!</h2>
</div>

<%@ include file="footer/footer.jsp" %>

</body>
</html>