<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="ctg" uri="customTags" %>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <title>Список пользователей</title>
</head>
<body>

<%@ include file="../header/adminHeader.jsp" %>

<div class="content">
    <c:if test="${requestScope.listUsers.size() != 0}">
        <table>
            <thead>
            <c:set var="index" value="1"/>
            <tr>
                <th scope="col">№</th>
                <th scope="col">ID</th>
                <th scope="col">Логин</th>
                <th scope="col">Фамилия</th>
                <th scope="col">Имя</th>
                <th scope="col">Отчество</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="user" items="${requestScope.listUsers}">
                <tr>
                    <td><c:out value="${index}"/></td>
                    <td><c:out value="${ user.id }"/></td>
                    <td><c:out value="${ user.login }"/></td>
                    <td><c:out value="${ user.surname }"/></td>
                    <td><c:out value="${ user.name }"/></td>
                    <td><c:out value="${ user.patronymic }"/></td>
                </tr>
                <c:set var="index" value="${index + 1}"/>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${requestScope.listUsers.size() == 0}">
        Список пуст!<br>
    </c:if>
</div>

<%@ include file="../footer/footer.jsp" %>

<%--<ctg:footer address="${sessionScope.address}"/>--%>
</body>
</html>
