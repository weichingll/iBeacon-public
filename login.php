<?php
// 提供 Airtable API 金鑰和 URL
$apiKey = 'patUj5oLB517zr16T.24c0a004222f170f7d7642dd83bc9022d28a67dc6d4da0487153e22fe48656e1';
$apiURL = 'https://api.airtable.com/v0/app5fKBa04lBdINdG/User';
session_start(); // 啟動session
// 從 POST 請求中接收使用者名稱
$username = $_POST['username'];
$password = $_POST['password'];
// 在 Airtable 中查找匹配的用戶名
$ch = curl_init($apiURL . '?filterByFormula=' . urlencode("user='{$username}'"));
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
    'Authorization: Bearer ' . $apiKey,
    'Content-Type: application/json',
));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$response = curl_exec($ch);
curl_close($ch);

// 分析回應並檢查是否找到匹配的用戶名
$data = json_decode($response, true);

if (!empty($data['records'])) {
    // 獲取用戶信息
    $record = $data['records'][0];
    $storedPassword = $record['fields']['password'];
    if($storedPassword==$password){
        $_SESSION["username"] = $username;
        echo "<script>alert('登入成功!3秒後將自動跳轉頁面')</script>";
        echo "<a href='list.php'>未成功跳轉頁面請點擊此</a>";
        header("refresh:3;url=list.php", true);
    }else {
        // 密碼不匹配
        echo "<script>alert('密碼錯誤!3秒後將自動跳轉頁面')</script>";
        echo "<a href='index.php'>未成功跳轉頁面請點擊此</a>";
        header("refresh:3;url=index.php", true);
    }
} else {
    // 帳號不存在
    echo "<script>alert('帳號不存在!3秒後將自動跳轉頁面')</script>";
    echo "<a href='index.php'>未成功跳轉頁面請點擊此</a>";
    header("refresh:3;url=index.php", true);
}
?>
