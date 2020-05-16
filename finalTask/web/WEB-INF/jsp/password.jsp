<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="ctg" uri="customTags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="${cookie['language'].value}" scope="session"/>
<fmt:setBundle basename="text"/>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <title><fmt:message key="changePassword"/></title>
</head>
<body>

<%@ page import="ft.training.by.bean.enums.Role" %>
<c:if test="${sessionScope.authorizedUser.role.equals(Role.STUDENT)}">
    <%@ include file="header/studentHeader.jsp" %>
</c:if>
<c:if test="${sessionScope.authorizedUser.role.equals(Role.ADMINISTRATOR)}">
    <%@ include file="header/adminHeader.jsp" %>
</c:if>
<c:if test="${sessionScope.authorizedUser.role.equals(Role.TUTOR)}">
    <%@ include file="header/tutorHeader.jsp" %>
</c:if>

<div class="content">
    <c:url value="/password.html" var="passwordUrl"/>
    <form class="add-form" name="updatePasswordForm" method="POST" action="${passwordUrl}"
          onsubmit="return validateChangePassword(this)">
        <input type="hidden" name="command" value="change_password">
        <input type="password" name="old_password" placeholder="<fmt:message key="oldPassword"/>">
        <br>
        <input type="password" name="new_password" placeholder="<fmt:message key="newPassword"/>">
        <br>
        <input type="password" name="new_password_again" placeholder="<fmt:message key="newPasswordAgain"/>">
        <br>
        <input type="submit" class="fadeIn fifth" value="<fmt:message key="save"/>">
    </form>
    ${requestScope.passwordMessage}
</div>

<%@ include file="footer/footer.jsp" %>

<%--<ctg:footer address="${sessionScope.address}"/>--%>
</body>
</html>
