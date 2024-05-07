<?php
// 提供 Airtable API 金鑰和 URL
$apiKey = 'patUj5oLB517zr16T.24c0a004222f170f7d7642dd83bc9022d28a67dc6d4da0487153e22fe48656e1';
$apiURL = 'https://api.airtable.com/v0/app5fKBa04lBdINdG/people';

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

// 確保請求成功
if ($response === false) {
    echo 'cURL 錯誤: ' . curl_error($ch);
    curl_close($ch);
    exit;
}

// 關閉 cURL 連接
curl_close($ch);

// 解析 JSON 響應
$data = json_decode($response, true);

// 遍歷所有記錄，提取 count 欄位的值
if (!empty($data['records'])) {
    foreach ($data['records'] as $record) {
        if (isset($record['fields']['count'])) {
            $count = $record['fields']['count'];
            echo "<div id='count-display'>目前人數: $count</div>";
        } 
    }
} 
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>設定beacon</title>
    <style>
    #count-display {
    position: fixed; /* 使用固定定位 */
    top: 50%; /* 垂直置中 */
    left: 50%; /* 水平置中 */
    transform: translate(-50%, -50%); /* 使用 transform 屬性調整元素位置 */
    color: #333; /* 字體顏色 */
    font-size: 24px; /* 字體大小調大 */
    background-color: #f0f0f0; /* 背景顏色 */
    padding: 10px; /* 內部填充調大 */
    border-radius: 5px; /* 圓角 */
}
    </style>
  </head>
</html>

