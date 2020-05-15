<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="ctg" uri="customTags" %>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <title>Список групп</title>
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
                    <input type="submit" value="${group.courseNumber} курс ${group.groupNumber} группа">
                </form>
                <br>
            </c:forEach>
        </c:if>
        <c:if test="${requestScope.listGroups.size() == 0}">
            Список пуст!<br>
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
