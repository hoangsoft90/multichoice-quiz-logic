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
global $num,$page,$total_pages;
$common_filter=array();    //common filter
$page_num=30;
$paging=(object)array();
$num=get_num_on_page($page_num);
$page=get_page_segment();
$paging->begin_index=$page*$num;
$paging->end_index=$num;
$opts=array('limit'=>$paging->begin_index.','.$paging->end_index);

if(!isset($_GET['admin_data'])) $_GET['admin_data']='history';    //default
//filter
if(isset($_GET['report_date']) && $_GET['report_date']) {
    if($_GET['admin_data']=='history') $common_filter['vcn_histories.post_date']=$_GET['report_date'];
    if($_GET['admin_data']=='customer') $common_filter['vcn_customers.post_date']=$_GET['report_date'];
}
//for history data
if(isset($_GET['customer_result']) && $_GET['customer_result']&& $_GET['admin_data']=='history'){
    if($_GET['customer_result']=='miss') $common_filter['result']=0;    //miss
    if($_GET['customer_result']=='meet') $common_filter['result']=1;    //customer meet condition
}
if(isset($_GET['search_text']) && $_GET['search_text']){    //search by query controll by GET
    if(!str2json($_GET['search_text'])){
        $filter['fullname']=$_GET['search_text'];
        $filter['phone']=$_GET['search_text'];
    }
    else $filter=objectToArray(str2json($_GET['search_text']));
    
    if($_GET['admin_data']=='history') $rs=vcn_report_search($filter,null,true,array_merge(array('bind'=>'OR'),$opts));
    if($_GET['admin_data']=='customer') $rs=vcn_customers_search($filter,null,true,array_merge(array('bind'=>'OR'),$opts));
}
//final
if(!isset($rs) ){
    if($_GET['admin_data']=='history') $rs=vcn_report($common_filter,$opts);    //filter reports
    if($_GET['admin_data']=='customer') $rs=get_customers($common_filter,$opts);    //get filter customers
}
//segment
$totals=mysql_fetch_array($rs);
if(mysql_num_rows($rs)) mysql_data_seek ($rs,0);    //reset mysql
$total_pages=isset($totals['total_results'])? total_pages($totals['total_results'],$num) : 0;    //get total pages

push_messages('Tìm thấy <b>'.(isset($totals['total_results'])? $totals['total_results'] : 0).'</b> kết quả.');    //result

$data['rs']=$rs;
extract($data);
?>
<?php
//show messages
show_messages();
if(is_resource($rs) && mysql_num_rows($rs)){
    $first=mysql_fetch_array($rs);mysql_data_seek($rs,0);    //reset
    if(isset($first['today_trans'])){
?>
<div>Ngày hôm naycó: <strong><?php echo $first['today_trans']? $first['today_trans'] : 0?></strong> giao dịch.</div>
<?php }
}
?>
<!-- tool -->
<div id='admin_tool1'>
<ul class='h-menu'>
<form method='GET'>
    <li>Dữ liệu:&nbsp;<?php echo vcn_admin_data($_GET['admin_data'])?></li>
    <li>Page:&nbsp; <?php echo number_selectTag(0,$total_pages,'page',$page)?></li>
    <li>Count:&nbsp;<?php echo number_selectTag(10,array('jump'=>10,'segment_count'=>10),'count',$num)?></li>
    <li>Ngày: &nbsp;<?php 
        if($_GET['admin_data']=='history') 
            echo report_date_selectTag(vcn_report_date(),isset($_GET['report_date'])? $_GET['report_date']:'');
        else
            echo report_date_selectTag(vcn_customer_report_date(),isset($_GET['report_date'])? $_GET['report_date']:'');
        ?>
        </li>
    <?php if($_GET['admin_data']=='history'){?><li>Lọc: &nbsp;<?php echo vcn_report_filter_selectTag(isset($_GET['customer_result'])? $_GET['customer_result']:'');}?>
    </li>
    <li>|&nbsp;Tìm kiếm <input type='text' name='search_text' value='<?php echo isset($_GET['search_text'])? $_GET['search_text']:''?>' placeholder='Tìm kiếm'/></li>
    <li><input type='submit' name='task' value='Submit'/></li>
</form>
</ul>
</div>
<!-- list -->
<?php if($_GET['admin_data']=='history'){?>
<table cellpadding='1' border='1' width='100%' class='customerslist'>
<tr class='table-title'>
    <td><input type='checkbox'/></td>
    <td>ID</td>
    <td>Họ & Tên</td>
    <td>Ngày sinh</td>
    <td>SĐT</td>
    <td>CMND</td>
    <td>Công ty</td>
    <td>Lương <a href='#'><img style='cursor:pointer' src='images/bullet_arrow_down1.png'/></a></td>
    <td>Lịch sử</td>
    <td>Kết quả</td>
    <td>Ngày <a href='#'><img style='cursor:pointer' src='images/bullet_arrow_down1.png'/></a></td>
    <td>Xoá</td>
</tr>
<?php
if(is_resource($rs) && mysql_num_rows($rs))
{
/*$page--;    //page start 0
$count_=0;    //count all records
*/
while($result=mysql_fetch_array($rs)){
    /*$count_++;
    if($page==0){
        if($count_>$page+$num) break;
    }
    if($page>0){
        if($count_<=$page*$num) continue;    //out of range
        if($count_>$page*$num+$num) break;
    }*/
    ?>
    <tr <?php echo $result['post_date']==date('Y-m-d')? 'bgcolor="#E1E8EA"' : ''?>>
        <td><input type='checkbox'/></td>
        <td><?php echo $result['id']?></td>
        <td><?php echo $result['fullname']?></td>
        <td><?php echo $result['birth']?></td>
        <td><span class='phone'><?php echo $result['phone']?></span></td>
        <td><?php echo $result['CMT']?></td>
        <td><?php echo $result['company']?></td>
        <td><?php echo is_numeric($result['salary'])? number_format($result['salary']) : $result['salary']?></td>
        <td><a target='_blank' href='<?php echo vcn_Url('view-history',$result)?>'>Xem</a></td>
        <td class='result'>
        <a target='_blank' href='<?php echo vcn_Url('view-history',$result)?>'><?php partner_logo($result['result']);?>
        <?php if($result['result']){
            echo '<br/>('.$result['result'].')';
            }else{
            ?><img src='images/unverified_icon.png'/>
            <?php }?>
            </a>
        </td>
        <td><?php echo $result['post_date'].' '.$result['post_time']?></td>
        <td><a href='javascript:if(confirm("Bạn có chắc chắn ?")) window.location.href="<?php echo vcn_Url('delete-history',$result)?>";'>Xoá</a></td>
    </tr>
    <?php
}
}
?>
</table>
<?php
}else{ 
?>
<table cellpadding='1' border='1' width='100%' class='customerslist'>
<tr class='table-title'>
    <td><input type='checkbox'/></td>
    <td>ID</td>
    <td>Họ & Tên</td>
    <td>Ngày sinh</td>
    <td>SĐT</td>
    <td>CMND</td>
    <td>Công ty</td>
    <td>Lương <a href='#'><img style='cursor:pointer' src='images/bullet_arrow_down1.png'/></a></td>
    <td>Ngày <a href='#'><img style='cursor:pointer' src='images/bullet_arrow_down1.png'/></a></td>
    <td>Xoá</td>
</tr>
<?php
if(is_resource($rs) && mysql_num_rows($rs))
{
/*$page--;    //page start 0
$count_=0;    //count all records
*/
while($result=mysql_fetch_array($rs)){
    /*$count_++;
    if($page==0){
        if($count_>$page+$num) break;
    }
    if($page>0){
        if($count_<=$page*$num) continue;    //out of range
        if($count_>$page*$num+$num) break;
    }*/
    ?>
    <tr <?php 
    //background
    $bg= ($result['post_date']==date('Y-m-d'))? '#E1E8EA' : '';
    if($result['phone']=='huyhoang1990') $bg='pink';
    ?>
        bgcolor="<?php echo $bg?>"
        >
        <td><input type='checkbox'/></td>
        <td><?php echo $result['id']?></td>
        <td><?php echo $result['fullname']?></td>
        <td><?php echo $result['birth']?></td>
        <td><span class='phone'><?php echo $result['phone']?></span></td>
        <td><?php echo $result['CMT']?></td>
        <td><?php echo $result['company']?></td>
        <td><?php echo is_numeric($result['salary'])? number_format($result['salary']) : $result['salary']?></td>
        <td><?php echo $result['post_date'].' '.$result['post_time']?></td>
        <td><a href='#'>X</a></td>
    </tr>
    <?php
}
}
}
?>
</table>
<?php
//show pages
show_pages_segment(5);
?>
</div>
</body>
</html>