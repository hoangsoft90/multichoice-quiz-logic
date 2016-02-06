<html>
<head>
    <title>Tu van truc tuyen</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="js/myjs.js"></script>
    <script src="js/jquery-1.5.2.min.js"></script>
    <script src="js/js.js"></script>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/style1.css">
    <script src="js/jquery-ui.min.1.8.23.js"></script>
    <link rel="stylesheet" type="text/css" href="css/jquery-ui.1.8.23.css">
</head>
<body>
<div id='vcn_wrap'><div id="header"><h1>Vaycanhan.com</h1></div>
<?php
include('include/functions.php');
?>
<?php
//record to google doc
$post_fields=array(
    'entry.54041991'=>trim($_POST['fullname']), //fullname
    'entry.80188193'=>trim($_POST['birth']),  //birth
    'entry.28073789'=>trim($_POST['phone']),
    'entry.1764449362'=>trim($_POST['cmt']),//cmt
    'entry.1483357970'=>trim($_POST['company']),   
    'entry.1720984416'=>trim($_POST['salary']),
    'entry.1183000412'=>trim($_POST['loan']),
    'entry.2094086132'=>trim($_POST['usedfor']),
    'entry.419637744'=>$_POST['besttimecontact'],
    'entry.463926200'=>$_POST['result'],
    'entry.430765846'=>$_POST['histories']
);
print_r($post_fields);
$ch=curl_init();
curl_setopt($ch,CURLOPT_URL,'https://docs.google.com/forms/d/1pV8C1qbj3835iAf4zaI-DkCkTrxVUSSP8elXgpQwNWU/formResponse');
curl_setopt($ch,CURLOPT_SSL_VERIFYHOST,false);
curl_setopt($ch,CURLOPT_SSL_VERIFYPEER,false);
curl_setopt($ch,CURLOPT_POST,true);
curl_setopt($ch,CURLOPT_POSTFIELDS,$post_fields);
curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
if(curl_error($ch)) echo curl_error($ch);
curl_exec($ch);

?>
Saved form !
</div>
</body>
</html>
