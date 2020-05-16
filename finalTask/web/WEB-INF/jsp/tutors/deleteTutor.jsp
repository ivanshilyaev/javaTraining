<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="ctg" uri="customTags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="${cookie['language'].value}" scope="session"/>
<fmt:setBundle basename="text"/>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student.css"/>
    <title><fmt:message key="deleteTutor"/></title>
</head>
<body>

<%@ include file="../header/adminHeader.jsp" %>

<div class="content">
    <c:if test="${requestScope.listTutors.size() != 0}">
        <table>
            <thead>
            <c:set var="index" value="1"/>
            <tr>
                <th scope="col">№</th>
                <th scope="col"><fmt:message key="surname"/></th>
                <th scope="col"><fmt:message key="name"/></th>
                <th scope="col"><fmt:message key="patronymic"/></th>
                <th scope="col"><fmt:message key="position"/></th>
                <th scope="col"><fmt:message key="degree"/></th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="tutor" items="${requestScope.listTutors}">
                <tr>
                    <td><c:out value="${ index}"/></td>
                    <td><c:out value="${ tutor.user.surname }"/></td>
                    <td><c:out value="${ tutor.user.name }"/></td>
                    <td><c:out value="${ tutor.user.patronymic }"/></td>
                    <td><c:out value="${ tutor.position }"/></td>
                    <td><c:out value="${ tutor.degree }"/></td>
                    <td>
                        <c:url value="/tutors/deleteTutor.html" var="deleteUrl"/>
                        <form class="content-form" name="deleteTutor" method="POST" action="${deleteUrl}">
                            <input type="hidden" name="tutorId" value="${tutor.id}">
                            <input type="submit" style="color: #489CE8" value="<fmt:message key="delete"/>">
                        </form>
                    </td>
                </tr>
                <c:set var="index" value="${index + 1}"/>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${requestScope.listTutors.size() == 0}">
        <fmt:message key="emptyList"/>!<br>
    </c:if>
    ${requestScope.message}
</div>

<%@ include file="../footer/footer.jsp" %>

<%--<ctg:footer address="${sessionScope.address}"/>--%>
</body>
</html>
