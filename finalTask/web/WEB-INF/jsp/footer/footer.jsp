<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="ctg" uri="customTags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="${cookie['language'].value}" scope="session"/>
<fmt:setBundle basename="text"/>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/main.js"></script>
</head>
<body>

<div class="links">
    <a href="https://vk.com/bsu_by">VK</a>
    <a href="https://www.instagram.com/official.bsu/?hl=ru">Instagram</a>
    <a href="https://www.facebook.com/bsuby">Facebook</a>
    <a href="https://twitter.com/BSU_official">Twitter</a>
    <a href="https://www.linkedin.com/school/belarusian-state-university/">Linked-in</a>
</div>

<div class="footer">
    <span class="copyright">&copy; Copyright 2020</span>
    <p><fmt:message key="address"/></p>
</div>

<script>
    window.onscroll = function () {
        scrollFunction()
    };
    var header = document.getElementById("appHeader");
    var sticky = header.offsetTop;
</script>

</body>
</html>