<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>更改密碼</title>
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
      input[type="submit"],
      input[type="reset"] {
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

      input[type="reset"] {
        margin-top: 10px;
        background-color: #f5f5f5;
        color: #333;
        border-color: #333;
        cursor: pointer;
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
    <h1>更改密碼</h1>
    <form
      name="registerForm"
      method="post"
      action="imformation.php"
      onsubmit="return validateForm()"
    >

      <label for="username">帳號：</label>
      <input type="text" name="username" id="username" />

      <label for="password">新密碼：</label>
      <input type="password" name="password" id="password" />
      <input type="submit" value="確定" name="submit" />
      <input type="reset" value="重設" name="submit" />
    </form>
  </body>
</html>

<?php
// 提供 Airtable API 金鑰和 URL
$apiKey = 'patUj5oLB517zr16T.24c0a004222f170f7d7642dd83bc9022d28a67dc6d4da0487153e22fe48656e1';
$apiURL = 'https://api.airtable.com/v0/app5fKBa04lBdINdG/User';

// 使用者輸入的資料
$username = $_POST['username'];
$password = $_POST['password'];


// 設置 cURL
$ch = curl_init($apiURL);

// 設置 HTTP 標頭，包括授權使用 API 金鑰
$headers = [
    'Authorization: Bearer ' . $apiKey,
    'Content-Type: application/json'
];
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

// 發送 cURL 請求
$response = curl_exec($ch);

// 檢查請求是否成功
if ($response === false) {
    echo 'cURL 錯誤: ' . curl_error($ch);
    curl_close($ch);
    exit;
}

// 關閉 cURL 連接
curl_close($ch);

// 解析 JSON 響應
$data = json_decode($response, true);

// 找到匹配的用戶記錄並更新密碼
if (!empty($data['records'])) {
    foreach ($data['records'] as $record) {
        if (isset($record['fields']['user']) && $record['fields']['user'] === $username) {
            // 找到匹配的用戶，進行更新
            $recordId = $record['id'];
            $updateURL = $apiURL . '/' . $recordId;

            // 更新密碼字段
            $updateData = [
                'fields' => [
                    'password' => $password,
                ],
            ];

            // 使用 cURL 發送 PATCH 請求更新密碼
            $ch = curl_init($updateURL);
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PATCH'); // 使用 PATCH 方法
            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($updateData)); // 傳遞 JSON 資料

            $updateResponse = curl_exec($ch);

            if ($updateResponse === false) {
                echo "<script>alert('更新失敗')</script>";
            } else {
                echo "<script>alert('密碼更新成功')</script>";
            }
            curl_close($ch);
            break;
        }
    }
}
?>

