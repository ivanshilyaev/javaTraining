<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="ctg" uri="customTags" %>
<%@taglib tagdir="/WEB-INF/tags" prefix="u" %>
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
        <c:set var="groupList" value="${requestScope.groupList}"/>
        <c:set var="rowsPerPage" value="20"/>
        <c:set var="pageNumber" value="${requestScope.pageNumber}"/>
        <c:set var="a">
            <fmt:formatNumber value="${groupList.size()/rowsPerPage}" maxFractionDigits="0"/>
        </c:set>
        <c:set var="b" value="${groupList.size()/rowsPerPage}"/>
        <%--Считаем количество страниц--%>
        <c:choose>
            <c:when test="${a==0}">
                <c:set var="numberOfPages" value="1" scope="request"/>
            </c:when>
            <c:when test="${b>a}">
                <c:set var="xxx" value="${b%a}"/>
                <c:if test="${xxx>0}">
                    <c:set var="numberOfPages" value="${b-xxx+1}" scope="request"/>
                </c:if>
            </c:when>
            <c:when test="${a>=b}">
                <c:set var="numberOfPages" value="${a}" scope="request"/>
            </c:when>
        </c:choose>

        <c:set var="start" value="${(pageNumber-1)*rowsPerPage}"/>
        <c:set var="stop" value="${pageNumber*rowsPerPage-1}"/>
        <table>
            <thead>
            <tr>
                <th scope="col">№</th>
                <th scope="col"><fmt:message key="surname"/></th>
                <th scope="col"><fmt:message key="name"/></th>
                <th scope="col"><fmt:message key="patronymic"/></th>
            </tr>
            </thead>

            <c:set var="index" value="${1 + (pageNumber-1)*rowsPerPage}"/>

            <c:forEach items="${groupList}" var="student" begin="${start}" end="${stop}">
                <tr>
                    <td><c:out value="${index}"/></td>
                    <td><c:out value="${ student.user.surname }"/></td>
                    <td><c:out value="${ student.user.name }"/></td>
                    <td><c:out value="${ student.user.patronymic }"/></td>
                </tr>
                <c:set var="index" value="${index + 1}"/>
            </c:forEach>
        </table>

        <u:nextPrevious pageNumber="${pageNumber}" numberOfPages="${numberOfPages}"
                        page="/students/concreteGroup"/>
    </c:if>
    <c:if test="${requestScope.groupList.size() == 0}">
        <fmt:message key="emptyList"/>!<br>
    </c:if>
</div>

<%@ include file="../footer/footer.jsp" %>

<%--<ctg:footer address="${sessionScope.address}"/>--%>
</body>
</html>
