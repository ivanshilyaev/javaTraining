<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="ctg" uri="customTags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="${cookie['language'].value}" scope="session"/>
<fmt:setBundle basename="text"/>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <title><fmt:message key="schedule"/></title>
</head>
<body>

<%@ include file="../header/studentHeader.jsp" %>

<div class="content">
    <div class="button-group-horizontal">
        <c:url value="/study/schedule.html" var="scheduleUrl"/>
        <form class="content-form" name="schedule" method="POST" action="${scheduleUrl}">
            <input type="hidden" name="day" value="0">
            <input type="submit" value="<fmt:message key="monday"/>">
        </form>
        <c:url value="/study/schedule.html" var="scheduleUrl"/>
        <form class="content-form" name="schedule" method="POST" action="${scheduleUrl}">
            <input type="hidden" name="day" value="1">
            <input type="submit" value="<fmt:message key="tuesday"/>">
        </form>
        <c:url value="/study/schedule.html" var="scheduleUrl"/>
        <form class="content-form" name="schedule" method="POST" action="${scheduleUrl}">
            <input type="hidden" name="day" value="2">
            <input type="submit" value="<fmt:message key="wednesday"/>">
        </form>
        <c:url value="/study/schedule.html" var="scheduleUrl"/>
        <form class="content-form" name="schedule" method="POST" action="${scheduleUrl}">
            <input type="hidden" name="day" value="3">
            <input type="submit" value="<fmt:message key="thursday"/>">
        </form>
        <c:url value="/study/schedule.html" var="scheduleUrl"/>
        <form class="content-form" name="schedule" method="POST" action="${scheduleUrl}">
            <input type="hidden" name="day" value="4">
            <input type="submit" value="<fmt:message key="friday"/>">
        </form>
        <c:url value="/study/schedule.html" var="scheduleUrl"/>
        <form class="content-form" name="schedule" method="POST" action="${scheduleUrl}">
            <input type="hidden" name="day" value="5">
            <input type="submit" value="<fmt:message key="saturday"/>">
        </form>
    </div>
    <c:if test="${requestScope.schedule == null}">
        <br>
    </c:if>
    <c:if test="${requestScope.schedule != null}">
        <c:if test="${requestScope.schedule.size() == 0}">
            <fmt:message key="emptyList"/>!<br>
        </c:if>
        <c:if test="${requestScope.schedule.size() != 0}">
            <table>
                <thead>
                <tr>
                    <th scope="col"><fmt:message key="pairNumber"/></th>
                        <%-- Время! (начала и окончания пары) --%>
                    <th scope="col"><fmt:message key="discipline"/></th>
                    <th scope="col"><fmt:message key="type"/></th>
                    <th scope="col"><fmt:message key="classroom"/></th>
                    <th scope="col"><fmt:message key="tutor"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="timetable" items="${requestScope.schedule}">
                    <tr>
                        <td><c:out value="${ timetable.pairNumber }"/></td>
                        <td><c:out value="${ timetable.subject.name }"/></td>
                        <td><c:out value="${ timetable.classType.getName() }"/></td>
                        <td><c:out value="${ timetable.classroom.number }"/></td>
                        <td><c:out value="${ timetable.tutor.user.surname }
                        ${fn:substring(timetable.tutor.user.name, 0, 1)}.${fn:substring(timetable.tutor.user.patronymic, 0, 1)}."/></td>
                    </tr>
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