<html>
<head>
    <title>FUll FAQ</title>
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
<div id='vcn_wrap'><div id="header"><h1>Vaycanhan.com</h1></div>&quot;
<?php
include('include/functions.php');
?>
<?php
$faqs=vcn_faq();
foreach($faqs as $faq){
    vcn_faq_item($faq);    //show faq
}
?>
<div style="clear: both;"></div>
</div>
</body>
</html>