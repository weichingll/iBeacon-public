<?php
// 提供 Airtable API 金鑰和 URL
$apiKey = 'patUj5oLB517zr16T.24c0a004222f170f7d7642dd83bc9022d28a67dc6d4da0487153e22fe48656e1';
$apiURL = 'https://api.airtable.com/v0/app5fKBa04lBdINdG/beacon';

// 使用者輸入的資料
$uuid = $_POST['uuid'];
$major = $_POST['major'];
$minor = $_POST['minor'];

// 將 $major $minor 轉換為整數
$major = intval($major);
$minor = intval($minor);

// 檢查是否有重複的使用者名稱
$ch = curl_init($apiURL . '?filterByFormula=' . urlencode("uuid='{$uuid}'"));
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
    echo "<script>alert('該UUID已使用!5秒後將自動跳轉頁面')</script>";
    echo "<a href='beacon.php'>未成功跳轉頁面請點擊此</a>";
    header("refresh:5;url=beacon.php", true);
    exit;
} else {
    // 如果沒有重複，則插入資料
    $data = array(
        'fields' => array(
            'uuid' => $uuid,
            'major' => $major,
            'minor' => $minor
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
        echo "<script>alert('成功!3秒後將自動跳轉頁面')</script>";
        echo "<a href='list.php'>未成功跳轉頁面請點擊此</a>";
        header("refresh:3;url=list.php");
        exit;
    }

    // 關閉 cURL 連接
    curl_close($ch);
}
?>
