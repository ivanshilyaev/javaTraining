<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="ctg" uri="customTags" %>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <title>Успеваемость</title>
</head>
<body>

<%@ include file="../header/studentHeader.jsp" %>

<div class="content">
    <div class="button-group-horizontal">
        <c:url value="/study/performance.html" var="performanceUrl"/>
        <form class="content-form" name="sem1" method="POST" action="${performanceUrl}">
            <input type="hidden" name="semester" value="1">
            <input type="submit" value="Семестр 1">
        </form>
        <c:url value="/study/performance.html" var="performanceUrl"/>
        <form class="content-form" name="sem2" method="POST" action="${performanceUrl}">
            <input type="hidden" name="semester" value="2">
            <input type="submit" value="Семестр 2">
        </form>
        <c:url value="/study/performance.html" var="performanceUrl"/>
        <form class="content-form" name="schedule" method="POST" action="${performanceUrl}">
            <input type="hidden" name="sem3" value="3">
            <input type="submit" value="Семестр 3">
        </form>
        <c:url value="/study/performance.html" var="performanceUrl"/>
        <form class="content-form" name="sem4" method="POST" action="${performanceUrl}">
            <input type="hidden" name="semester" value="4">
            <input type="submit" value="Семестр 4">
        </form>
    </div>
    <c:if test="${requestScope.performance == null}">
        <br>
    </c:if>
    <c:if test="${requestScope.performance != null}">
        <c:if test="${requestScope.performance.size() == 0}">
            Список пуст!<br>
        </c:if>
        <c:if test="${requestScope.performance.size() != 0}">
            <table>
                <thead>
                <c:set var="index" value="1"/>
                <tr>
                    <th scope="col">№</th>
                    <th scope="col">Предмет</th>
                    <th scope="col">Зачёт</th>
                    <th scope="col">Экзамен</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="performance" items="${requestScope.performance}">
                    <tr>
                        <td><c:out value="${index}"/></td>
                        <td><c:out value="${ performance.subject.name }"/></td>
                        <td><c:out value="${ performance.credit }"/></td>
                        <td><c:out value="${ performance.exam }"/></td>
                    </tr>
                    <c:set var="index" value="${index + 1}"/>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
    </c:if>
</div>

<%@ include file="../footer/footer.jsp" %>

<%--<ctg:footer address="${sessionScope.address}"/>--%>
</body>
</html>