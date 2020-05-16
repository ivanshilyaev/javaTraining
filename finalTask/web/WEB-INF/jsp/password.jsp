<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="ctg" uri="customTags" %>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <title>Сменить пароль</title>
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
        <input type="password" name="old_password" placeholder="Старый пароль">
        <br>
        <input type="password" name="new_password" placeholder="Новый пароль">
        <br>
        <input type="password" name="new_password_again" placeholder="Новый пароль ещё раз">
        <br>
        <input type="submit" class="fadeIn fifth" value="Сохранить">
    </form>
    ${requestScope.passwordMessage}
</div>

<%@ include file="footer/footer.jsp" %>

<%--<ctg:footer address="${sessionScope.address}"/>--%>
</body>
</html>
