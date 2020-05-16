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
    <title><fmt:message key="groups"/></title>
</head>
<body>

<%@ include file="../header/adminHeader.jsp" %>

<div class="content">
    <div class="button-group-horizontal">
        <c:if test="${requestScope.listGroups.size() != 0}">
            <c:forEach var="group" items="${requestScope.listGroups}">
                <c:url value="/students/concreteGroup.html" var="concreteGroupUrl"/>
                <form class="content-form" name="findGroup" method="POST" action="${concreteGroupUrl}">
                    <input type="hidden" name="groupNum" value="${group.groupNumber}">
                    <input type="hidden" name="courseNum" value="${group.courseNumber}">
                    <input type="submit"
                           value="${group.courseNumber} <fmt:message key="course"/> ${group.groupNumber} <fmt:message key="group"/>">
                </form>
                <br>
            </c:forEach>
        </c:if>
        <c:if test="${requestScope.listGroups.size() == 0}">
            <fmt:message key="emptyList"/>!<br>
        </c:if>
    </div>
    <br>
    ${requestScope.message}
    <br>
</div>

<%@ include file="../footer/footer.jsp" %>

<%--<ctg:footer address="${sessionScope.address}"/>--%>
</body>
</html>
