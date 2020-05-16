<%@tag language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="${cookie['language'].value}" scope="session"/>
<fmt:setBundle basename="text"/>
<%@attribute name="user" required="true" rtexprvalue="true"
             type="ft.training.by.bean.User" %>

<h2><fmt:message key="welcome"/>, ${user.surname} ${user.name} ${user.patronymic}!</h2>