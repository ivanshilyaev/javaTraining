<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="ctg" uri="customTags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="${cookie['language'].value}" scope="session"/>
<fmt:setBundle basename="text"/>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <title><fmt:message key="users"/></title>
</head>
<body>

<%@ include file="../header/adminHeader.jsp" %>

<div class="content">
    <c:set var="listUsers" value="${requestScope.listUsers}"/>
    <c:set var="rowsPerPage" value="20"/>
    <c:set var="pageNumber" value="${requestScope.pageNumber}"/>
    <c:set var="a">
        <fmt:formatNumber value="${listUsers.size()/rowsPerPage}" maxFractionDigits="0"/>
    </c:set>
    <c:set var="b" value="${listUsers.size()/rowsPerPage}"/>
    <%--Считаем количество страниц--%>
    <c:choose>
        <c:when test="${a==0}">
            <c:set var="numberOfPages" value="1" scope="request"/>
        </c:when>
        <c:when test="${b>a}">
            <c:set var="xxx" value="${b%a}"/>
            <c:if test="${xxx>0}">
                <c:set var="numberOfPages" value="${b-xxx+1}" scope="request"/>
            </c:if>
        </c:when>
        <c:when test="${a>=b}">
            <c:set var="numberOfPages" value="${a}" scope="request"/>
        </c:when>
    </c:choose>

    <c:set var="start" value="${(pageNumber-1)*rowsPerPage}"/>
    <c:set var="stop" value="${pageNumber*rowsPerPage-1}"/>
    <table>
        <thead>
        <tr>
            <th scope="col">№</th>
            <th scope="col">ID</th>
            <th scope="col"><fmt:message key="login"/></th>
            <th scope="col"><fmt:message key="surname"/></th>
            <th scope="col"><fmt:message key="name"/></th>
            <th scope="col"><fmt:message key="patronymic"/></th>
        </tr>
        </thead>

        <c:set var="index" value="${1 + (pageNumber-1)*rowsPerPage}"/>

        <c:forEach items="${listUsers}" var="user" begin="${start}" end="${stop}">
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
    </table>

    <div class="button-group-horizontal">
        <%--For displaying Previous link --%>
        <c:if test="${pageNumber gt 1}">
            <c:url value="/search/listUsers.html" var="listUsersUrl"/>
            <form class="content-form" name="addStudent" method="POST" action="${listUsersUrl}">
                <input type="hidden" name="pageNumber" value="${requestScope.pageNumber - 1}">
                <input type="submit" value="<fmt:message key="previous"/>">
            </form>
        </c:if>
        <c:forEach begin="1" end="${numberOfPages}" var="i">
            <c:choose>
                <c:when test="${i!=pageNumber}">
                    <c:url value="/search/listUsers.html" var="listUsersUrl"/>
                    <form class="content-form" name="addStudent" method="POST" action="${listUsersUrl}">
                        <input type="hidden" name="pageNumber" value="${i}">
                        <input type="submit" value="${i}">
                    </form>
                </c:when>
                <c:otherwise>
                    <form class="content-form">
                        <input type="hidden" name="pageNumber" value="${i}">
                        <input type="submit" value="${i}">
                    </form>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <%--For displaying Next link --%>
        <c:if test="${pageNumber lt numberOfPages}">
            <c:url value="/search/listUsers.html" var="listUsersUrl"/>
            <form class="content-form" name="addStudent" method="POST" action="${listUsersUrl}">
                <input type="hidden" name="pageNumber" value="${requestScope.pageNumber + 1}">
                <input type="submit" value="<fmt:message key="next"/>">
            </form>
        </c:if>
    </div>
</div>

<%@ include file="../footer/footer.jsp" %>

<%--<ctg:footer address="${sessionScope.address}"/>--%>
</body>
</html>
