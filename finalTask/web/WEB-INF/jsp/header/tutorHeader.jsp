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
</head>
<body>

<header id="appHeader">
    <div class="navbar">
        <a href="https://bsu.by/"><fmt:message key="bsu"/></a>
        <c:url value="/tutorCabinet.html" var="cabinetUrl"/>
        <form style="margin-left: auto" class="menu-form" name="findAllStudentsFromTheGroup" method="POST"
              action="${cabinetUrl}">
            <input type="submit" value="<fmt:message key="myProfile"/>">
        </form>
        <c:url value="/search/listClasses.html" var="listClassesUrl"/>
        <form class="menu-form" name="listClassesForm" method="POST" action="${listClassesUrl}">
            <input type="submit" value="<fmt:message key="listOfAllClasses"/>">
        </form>
        <c:url value="/password.html" var="passwordUrl"/>
        <form class="menu-form" name="changePasswordForm" method="POST" action="${passwordUrl}">
            <input type="submit" value="<fmt:message key="changePassword"/>">
        </form>
        <c:url value="/index.html" var="indexUrl"/>
        <form class="menu-form" name="changePasswordForm" method="POST" action="${indexUrl}">
            <c:if test="${cookie['language'].value.equals('en_US')}">
                <c:set var="cookieLocaleVar" value="ru_BY"/>
            </c:if>
            <c:if test="${cookie['language'].value.equals('ru_BY')}">
                <c:set var="cookieLocaleVar" value="en_US"/>
            </c:if>
            <input type="hidden" name="cookieLocale" value="${cookieLocaleVar}">
            <input type="submit" value="<fmt:message key="changeLanguage"/>">
        </form>
        <c:url value="/logout.html" var="logoutUrl"/>
        <form class="menu-form" name="logoutForm" method="POST" action="${logoutUrl}">
            <input type="submit" value="<fmt:message key="signOut"/>">
        </form>
    </div>
</header>

</body>
</html>