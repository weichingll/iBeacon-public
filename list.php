<?php
session_start(); // 啟動session
$username = $_SESSION["username"];
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>功能列表</title>
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

      button {
        display: block;
        width: 50%;
        margin: 20px auto;
        padding: 10px;
        font-size: 16px;
        border-radius: 5px;
        border: 1px solid #ccc;
        background-color: #333;
        color: #fff;
        text-align: center;
        cursor: pointer;
      }

      button:hover {
        background-color: #fff;
        color: #333;
        border: 1px solid #333;
      }
    </style>
  </head>
  <body>
    <h1>功能列表</h1>
    <button onclick="window.location.href='people.php'">人流管控</button>
    <button onclick="window.location.href='beacon.php'">設定beacon</button>
    <button onclick="window.location.href='imformation.php'">更改資訊</button>
  </body>
</html>
