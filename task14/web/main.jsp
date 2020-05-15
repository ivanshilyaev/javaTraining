<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="u" %>
<u:html title="Main page" message="Hello">
    <h2>Hello, world</h2>
    <form method="post">
        <label for="login">Имя пользователя:</label>
        <input type="text" id="login" name="login">
        <label for="password">Пароль:</label>
        <input type="password" id="password" name="password">
        <button type="submit">Войти</button>
    </form>
</u:html>
