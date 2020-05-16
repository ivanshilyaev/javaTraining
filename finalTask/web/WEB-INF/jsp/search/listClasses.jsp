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
    <title><fmt:message key="listOfAllClasses"/></title>
</head>
<body>

<%@ include file="../header/tutorHeader.jsp" %>

<div class="content">
    <c:if test="${requestScope.timetableList.size() != 0}">
        <table>
            <thead>
            <c:set var="index" value="1"/>
            <tr>
                <th scope="col">№</th>
                <th scope="col"><fmt:message key="day"/></th>
                <th scope="col"><fmt:message key="pairNumber"/></th>
                <th scope="col"><fmt:message key="subject"/></th>
                <th scope="col"><fmt:message key="type"/></th>
                <th scope="col"><fmt:message key="classroom"/></th>
                <th scope="col"><fmt:message key="group"/></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="timetable" items="${requestScope.timetableList}">
                <tr>
                    <td><c:out value="${index}"/></td>
                    <td><c:out value="${ timetable.day.getName() }"/></td>
                    <td><c:out value="${ timetable.pairNumber }"/></td>
                    <td><c:out value="${ timetable.subject.name }"/></td>
                    <td><c:out value="${ timetable.classType.getName() }"/></td>
                    <td><c:out value="${ timetable.classroom.number }"/></td>
                    <td><c:out value="${ requestScope.groupList.get(index-1).groupNumber }"/></td
                </tr>
                <c:set var="index" value="${index + 1}"/>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${requestScope.timetableList.size() == 0}">
        <fmt:message key="address"/>!<br>
    </c:if>
</div>
</div>

<%@ include file="../footer/footer.jsp" %>

<%--<ctg:footer address="${sessionScope.address}"/>--%>
</body>
</html>
