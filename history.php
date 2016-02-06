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
$id=_GET('id');
//URL: ?id=x
if(!isset($id) || !$id) {
    show_error('Error','Không chỉ định lịch sử khách hàng ?');
}
$rs=vcn_report($id);    //get history
if(!mysql_num_rows($rs)) show_error('Page Not Found','Không tìm thấy lịch sử này !');
$result=mysql_fetch_assoc($rs);
$data['history_rs']=get_history($result['id'],$result['save_history']);    //get history
$data['result']=$result;

extract($data);
?>
<h2>Thông tin khách hàng</h2><br/>
<table border='1' cellpadding='5'>
    <tr>
        <td>Họ & tên</td>
        <td><strong><?php echo $result['fullname']?></strong></td>
    </tr>
    <tr>
        <td>Ngày sinh</td>
        <td><strong><?php echo $result['birth']?></strong></td>
    </tr>
    <tr>
        <td>SĐT</td>
        <td><strong><?php echo $result['phone']?></strong></td>
    </tr>
    <tr>
        <td>CMND</td>
        <td><?php echo $result['CMT']?></td>
    </tr>
    <tr>
        <td>Tên công ty</td>
        <td><?php echo $result['company']?></td>
    </tr>
    <tr>
        <td>Mức lương</td>
        <td><?php echo is_numeric($result['salary'])? number_format($result['salary']):$result['salary']?>&nbsp;(VND)</td>
    </tr>
    <tr>
        <td>Cần vay</td>
        <td><?php echo is_numeric($result['loan'])? number_format($result['loan']):$result['loan']?>&nbsp;(VND)</td>
    </tr>
    <tr>
        <td>Kết quả tư vấn</td>
        <td><?php if($result['result']){?>Bạn được hỗ trợ bởi <?php echo $result['result'];}else{?>Không hỗ trợ<?php }?><br/><?php partner_logo($result['result'])?></td>
    </tr>
</table>
<hr/>
<h2>Lịch sử tư vấn&nbsp;(<?php echo $result['post_date'].' '.$result['post_time']?>)</h2><br/>

<strong>Lời nhắn từ khách hàng:</strong><p><?php echo $result['note']?></p>
<?php
$index=1;
while($result=mysql_fetch_array($history_rs)){
    ?>
    <div class='answer_history_report'>
        <div class='label radius-2'><?php echo $index?></div>
        <div class='question <?php echo $index%2? 'bg1':''?>'>
        <p><strong><?php echo strip_tags($result['question'])?></strong></p>
        <div>
        <?php if($result['answer_text']) {?>
        <p><?php echo $result['answer_text']?></p>
        <?php partner_logo($result['answer_text'],0);?>
        <?php 
        }else{
            echo  $result['answer'];
        }?>
        </div>
        </div>
    </div>
    <?php
    $index++;
}
?>
</div>
</body>
</html>