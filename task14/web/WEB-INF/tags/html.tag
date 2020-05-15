<%@tag language="java" pageEncoding="UTF-8"%>
<%@attribute name="title" required="true" rtexprvalue="true" type="java.lang.String"%>
<%@attribute name="message" required="false" rtexprvalue="true" type="java.lang.String"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="u"%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${title}</title>
    <c:url value="/css/start.css" var="cssUrl"/>
    <link rel="stylesheet" type="text/css" href="${cssUrl}">
</head>
<BODY>
<DIV id="formFooter">
    <jsp:doBody/>
</DIV>
</BODY>
</html>