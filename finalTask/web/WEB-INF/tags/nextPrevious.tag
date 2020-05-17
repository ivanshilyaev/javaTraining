<%@tag language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<fmt:setLocale value="${cookie['language'].value}" scope="session"/>
<fmt:setBundle basename="text"/>
<%@attribute name="pageNumber" required="true" rtexprvalue="true"
             type="java.lang.Integer" %>
<%@attribute name="numberOfPages" required="true" rtexprvalue="true"
             type="java.lang.Integer" %>
<%@attribute name="page" required="true" rtexprvalue="true"
             type="java.lang.String" %>

<div class="button-group-horizontal">
    <%--For displaying Previous link --%>
    <c:if test="${pageNumber gt 1}">
        <c:url value="${page}.html" var="listUrl"/>
        <form class="content-form" method="POST" action="${listUrl}">
            <input type="hidden" name="pageNumber" value="${requestScope.pageNumber - 1}">
            <input type="submit" value="<fmt:message key="previous"/>">
        </form>
    </c:if>
    <c:forEach begin="1" end="${numberOfPages}" var="i">
        <c:choose>
            <c:when test="${i!=pageNumber}">
                <c:url value="${page}.html" var="listUrl"/>
                <form class="content-form" method="POST" action="${listUrl}">
                    <input type="hidden" name="pageNumber" value="${i}">
                    <input type="submit" value="${i}">
                </form>
            </c:when>
            <c:otherwise>
                <form class="content-form">
                    <input type="hidden" name="pageNumber" value="${i}">
                    <input type="submit" value="${i}">
                </form>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <%--For displaying Next link --%>
    <c:if test="${pageNumber lt numberOfPages}">
        <c:url value="${page}.html" var="listUrl"/>
        <form class="content-form" method="POST" action="${listUrl}">
            <input type="hidden" name="pageNumber" value="${requestScope.pageNumber + 1}">
            <input type="submit" value="<fmt:message key="next"/>">
        </form>
    </c:if>
</div>