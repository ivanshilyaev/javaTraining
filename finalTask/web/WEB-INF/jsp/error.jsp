<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="ctg" uri="customTags" %>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <title>Error page</title>
</head>
<body>
<%@page isErrorPage="true" %>

<div class="content">
    <c:choose>
        <c:when test="${not empty requestScope.error}">
            ${requestScope.error}
        </c:when>
        <c:when test="${not empty pageContext.errorData.requestURI}">
            Request from ${pageContext.errorData.requestURI} is failed <br/>
            Servlet name or type: ${pageContext.errorData.servletName} <br/>
            Status code: ${pageContext.errorData.statusCode} <br/>
            Exception: ${pageContext.errorData.throwable}
        </c:when>
        <c:otherwise>Unknown error</c:otherwise>
    </c:choose>
</div>

</body>
</html>
