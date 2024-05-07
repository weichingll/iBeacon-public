<?php
// Initialize the session
session_start();

// Check if the user is already logged in, if yes then redirect him to welcome page
if(isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] === true){
    header("location: welcome.php");
    exit;  
}
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登入介面</title>
    <style>
        body {
            background-color: #f5f5f5;
            font-family: Arial, sans-serif;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-top: 50px;
        }

        h2 {
            text-align: center;
            color: #666;
            margin-top: 20px;
        }

        form {
            margin: 0 auto;
            width: 50%;
            max-width: 400px;
            padding: 20px;
            border: 2px solid #ccc;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        input[type="text"],
        input[type="password"],
        input[type="submit"] {
            display: block;
            width: 100%;
            margin-top: 10px;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        input[type="submit"] {
            margin-top: 20px;
            background-color: #333;
            color: #fff;
            border-color: #333;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #fff;
            color: #333;
        }

        a {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #666;
            text-decoration: none;
        }

        a:hover {
            color: #333;
        }
    </style>
</head>
<body>
    <h1>Log In</h1>
    <h2>你可以選擇登入或是註冊帳號~</h2>
    <form name="loginForm" method="post" action="login.php" onsubmit="return validateForm()" method="post">
        <label for="username">帳號：</label>
        <input type="text" id="username" name="username" required>

        <label for="password">密碼：</label>
        <input type="password" id="password" name="password" required>

        <input type="submit" value="登入" name="submit">
    </form>
    <a href="register.html">還沒有帳號？現在就註冊！</a>
</body>
</html>
