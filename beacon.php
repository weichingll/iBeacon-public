<?php
session_start(); // 啟動session
$username = $_SESSION["username"];
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>設定beacon</title>
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
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      }

      input[type="text"],
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
        border-color: #333;
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

      /* 新增樣式 */
      #user-name {
        position: absolute;
        top: 10px;
        right: 10px;
        color: #333;
        font-size: 16px;
      }
    </style>
  </head>
  <body>
    <!-- 在右上角顯示用户名 -->
    <div id="user-name">
        <?php echo "歡迎，" . htmlspecialchars($username); ?>
    </div>

    <h1>設定beacon</h1>
    <form
      name="beaconForm"
      method="post"
      action="setbeacon.php"
      onsubmit="return validateForm()"
    >
      <label for="uuid">UUID：</label>
      <input type="text" name="uuid" id="uuid" />

      <label for="major">Major：</label>
      <input type="text" name="major" id="major" />

      <label for="minor">Minor：</label>
      <input type="text" name="minor" id="minor" />

      <input type="submit" value="確定" name="submit" />
      <input type="reset" value="重設" name="reset" />
    </form>
  </body>
</html>
