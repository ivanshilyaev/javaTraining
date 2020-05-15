<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="ctg" uri="customTags" %>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
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
                <th scope="col">День</th>
                <th scope="col">Номер пары</th>
                <th scope="col">Предмет</th>
                <th scope="col">Тип</th>
                <th scope="col">Аудитория</th>
                <th scope="col">Группа</th>
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
        Список пуст!<br>
    </c:if>
</div>
</div>

<%@ include file="../footer/footer.jsp" %>

<%--<ctg:footer address="${sessionScope.address}"/>--%>
</body>
</html>
