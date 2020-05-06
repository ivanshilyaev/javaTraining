<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="ctg" uri="customTags" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <title>Список всех групп</title>
    <style>
        table {
            border-collapse: collapse;
        }

        table, tr, td {
            border: 1px solid black;
        }
    </style>
</head>
<body>
<br>
${sessionScope.studentDeletedMessage}
<br>
<c:if test="${sessionScope.listGroups.size() != 0}">
    <c:forEach var="group" items="${sessionScope.listGroups}">
        <c:url value="/students/concreteGroup.html" var="concreteGroupUrl"/>
        <form name="findGroup" method="POST" action="${concreteGroupUrl}">
            <input type="hidden" name="groupNum" value="${group.groupNumber}">
            <input type="submit" value="Группа ${group.groupNumber}">
        </form>
        <br>
    </c:forEach>
</c:if>
<c:if test="${sessionScope.listGroups.size() == 0}">
    Список пуст!<br>
</c:if>
<hr>
<c:url value="/index.html" var="indexUrl"/>
<form name="findGroup" method="POST" action="${indexUrl}">
    <input type="submit" value="На главную">
</form>
<ctg:footer address="${sessionScope.address}"/>
</body>
</html>