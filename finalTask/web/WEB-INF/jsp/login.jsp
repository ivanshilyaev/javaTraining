<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <link rel="stylesheet" href="start.css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>

<body>
<div class="wrapper fadeInDown">
    <div id="formContent">
        <!-- Tabs Titles -->

        <!-- Icon -->
        <div class="fadeIn first">
            <img src="http://icons.iconarchive.com/icons/graphicloads/100-flat/256/home-icon.png" id="icon"
                 alt="User Icon"/>
        </div>

        <!-- Login Form -->
        <form name="loginForm" method="POST" action="controller">
            <input classroomType="hidden" name="command" value="login">
            <input classroomType="text" id="login" class="fadeIn second" name="login" placeholder="login">
            <input classroomType="text" id="password" class="fadeIn third" name="password" placeholder="password">
            <input classroomType="submit" class="fadeIn fourth" value="Log In">
        </form>

        <br>
        ${errorLoginPasswordMessage}<br>
        ${wrongAction}<br>
        ${nullPage}<br>

        <!-- Remind Passowrd -->
        <div id="formFooter">
            <a class="underlineHover" href="#">Forgot Password?</a>
        </div>

    </div>
</div>
</body>
</html>
