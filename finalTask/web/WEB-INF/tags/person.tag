<%@tag language="java" pageEncoding="UTF-8" %>
<%@attribute name="user" required="true" rtexprvalue="true"
             type="ft.training.by.bean.User" %>

<h2>Добро пожаловать, ${user.surname} ${user.name} ${user.patronymic}!</h2>