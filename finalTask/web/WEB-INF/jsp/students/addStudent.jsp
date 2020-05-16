<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="ctg" uri="customTags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="${cookie['language'].value}" scope="session"/>
<fmt:setBundle basename="text"/>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <title><fmt:message key="newStudent"/></title>
</head>
<body>

<%@ include file="../header/adminHeader.jsp" %>

<div class="content">
    <c:url value="/students/addStudent.html" var="addUrl"/>
    <form class="add-form" name="addStudentForm" method="POST" action="${addUrl}">
        <label>
            <fmt:message key="surname"/> <br>
            <input type="text" name="surname">
        </label> <br>
        <label>
            <fmt:message key="name"/> <br>
            <input type="text" name="name">
        </label> <br>
        <label>
            <fmt:message key="patronymic"/> <br>
            <input type="text" name="patronymic">
        </label> <br>
        <label>
            <fmt:message key="subgroup"/> <br>
            <select name="subgroup">
                <option value="a">a</option>
                <option value="b">b</option>
            </select>
        </label> <br>
        <label>
            <fmt:message key="login"/> <br>
            <input type="text" name="login">
        </label> <br>
        <input type="submit" value="<fmt:message key="add"/>">
    </form>
    ${requestScope.message}
</div>

<%@ include file="../footer/footer.jsp" %>

<%--<ctg:footer address="${sessionScope.address}"/>--%>
</body>
</html>
