<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="ctg" uri="customTags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="${cookie['language'].value}" scope="session"/>
<fmt:setBundle basename="text"/>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student.css"/>
    <title><fmt:message key="newTutor"/></title>
</head>
<body>

<%@ include file="../header/adminHeader.jsp" %>

<div class="content">
    <c:url value="/students/addTutor.html" var="addUrl"/>
    <form class="add-form" name="addTutorForm" method="POST" action="${addUrl}">
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
            <fmt:message key="position"/> <br>
            <select name="position">
                <option value="ассистент">ассистент</option>
                <option value="преподаватель">преподаватель</option>
                <option value="старший преподаватель">страший преподаватель</option>
                <option value="доцент">доцент</option>
                <option value="профессор">профессор</option>
                <option value="">другое</option>
            </select>
        </label> <br>
        <label>
            <fmt:message key="degree"/> <br>
            <select name="degree">
                <option value="кандидат наук">кандидат наук</option>
                <option value="доктор наук">доктор наук</option>
                <option value="магистр">магистр</option>
                <option value="">другое</option>
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
