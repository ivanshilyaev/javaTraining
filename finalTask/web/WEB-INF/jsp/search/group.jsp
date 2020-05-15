<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="ctg" uri="customTags" %>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <title>Моя группа</title>
</head>
<body>

<%@ include file="../header/studentHeader.jsp" %>

<div class="content">
    <c:if test="${requestScope.groupList.size() != 0}">
        <table>
            <thead>
            <c:set var="index" value="1"/>
            <tr>
                <th scope="col">№</th>
                <th scope="col">Фамилия</th>
                <th scope="col">Имя</th>
                <th scope="col">Отчество</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="student" items="${requestScope.groupList}">
                <tr>
                    <td><c:out value="${index}"/></td>
                    <td><c:out value="${ student.user.surname }"/></td>
                    <td><c:out value="${ student.user.name }"/></td>
                    <td><c:out value="${ student.user.patronymic }"/></td>
                </tr>
                <c:set var="index" value="${index + 1}"/>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${requestScope.groupList.size() == 0}">
        Список пуст!<br>
    </c:if>
</div>

<%@ include file="../footer/footer.jsp" %>

</body>
</html>