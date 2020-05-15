<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="ctg" uri="customTags" %>
<%@taglib tagdir="/WEB-INF/tags" prefix="u" %>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <title>Кабинет преподавателя</title>
</head>
<body>

<%@ include file="header/tutorHeader.jsp" %>

<div class="content">
    <u:person user="${sessionScope.authorizedUser}"></u:person>
</div>

<%@ include file="footer/footer.jsp" %>

</body>
</html>
