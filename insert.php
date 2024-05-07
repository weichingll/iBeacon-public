<?php
// 提供 Airtable API 金鑰和 URL
$apiKey = 'patUj5oLB517zr16T.24c0a004222f170f7d7642dd83bc9022d28a67dc6d4da0487153e22fe48656e1';
$apiURL = 'https://api.airtable.com/v0/app5fKBa04lBdINdG/User';

// 使用者輸入的資料
$username = $_POST['username'];
$password = $_POST['password'];
$name = $_POST['name'];
$date = $_POST['date'];
$email = $_POST['email'];

// 檢查是否有重複的使用者名稱
$ch = curl_init($apiURL . '?filterByFormula=' . urlencode("user='{$username}'"));
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
    'Authorization: Bearer ' . $apiKey,
    'Content-Type: application/json',
));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$response = curl_exec($ch);
curl_close($ch);

// 分析回應並檢查是否有重複
$data = json_decode($response, true);
if (!empty($data['records'])) {
    // 如果有重複的使用者名稱
    echo "<script>alert('該帳號已有人使用!5秒後將自動跳轉頁面')</script>";
    echo "<a href='register.html'>未成功跳轉頁面請點擊此</a>";
    header("refresh:5;url=register.html", true);
    exit;
} else {
    // 如果沒有重複，則插入資料
    $data = array(
        'fields' => array(
            'user' => $username,
            'password' => $password,
            'name' => $name,
            'date' => $date,
            'email' => $email
        ),
    );
    $data_json = json_encode($data);

    $ch = curl_init($apiURL);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array(
        'Authorization: Bearer ' . $apiKey,
        'Content-Type: application/json',
    ));
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data_json);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    // 執行請求並取得回應
    $response = curl_exec($ch);

    if ($response === false) {
        echo '錯誤：' . curl_error($ch);
    } else {
        echo "<script>alert('註冊成功!5秒後將自動跳轉頁面')</script>";
        echo "<a href='index.php'>未成功跳轉頁面請點擊此</a>";
        header("refresh:5;url=index.php");
        exit;
    }

    // 關閉 cURL 連接
    curl_close($ch);
}
?>
