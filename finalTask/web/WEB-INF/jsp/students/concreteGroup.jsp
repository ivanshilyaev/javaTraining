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
    <title>${requestScope.courseNum} <fmt:message key="course"/> ${requestScope.groupNum} <fmt:message
            key="group"/></title>
</head>
<body>

<%@ include file="../header/adminHeader.jsp" %>

<div class="content">
    <div class="button-group-horizontal">
        <c:url value="/students/addStudent.html" var="addUrl"/>
        <form class="content-form" name="addStudent" method="POST" action="${addUrl}">
            <input type="hidden" name="groupNum" value="${requestScope.groupNum}">
            <input type="hidden" name="courseNum" value="${requestScope.courseNum}">
            <input type="submit" value="<fmt:message key="addStudent"/>">
        </form>
        <c:url value="/students/deleteStudent.html" var="deleteUrl"/>
        <form class="content-form" name="deleteStudent" method="POST" action="${deleteUrl}">
            <input type="hidden" name="groupNum" value="${requestScope.groupNum}">
            <input type="hidden" name="courseNum" value="${requestScope.courseNum}">
            <input type="submit" value="<fmt:message key="deleteStudent"/>">
        </form>
    </div>
    <br>
    ${requestScope.message}
    <br>
    <c:if test="${requestScope.groupList.size() != 0}">
        <table>
            <thead>
            <c:set var="index" value="1"/>
            <tr>
                <th scope="col">№</th>
                <th scope="col"><fmt:message key="surname"/></th>
                <th scope="col"><fmt:message key="name"/></th>
                <th scope="col"><fmt:message key="patronymic"/></th>
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
        <fmt:message key="emptyList"/>!<br>
    </c:if>
</div>

<%@ include file="../footer/footer.jsp" %>

<%--<ctg:footer address="${sessionScope.address}"/>--%>
</body>
</html>
