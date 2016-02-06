<?php
//select tag
function selectTag($data,$field_value,$field_text,$name='',$nullline=false){
    $attrs='';    //select attributes tag
    
    if(is_string($name)) $attrs='name="'.$name.'"';    //name attribute
    if(is_array($name)){
        foreach($name as $key=>$val){
            $attrs.=$key.'='.$val.' ';    //more attributes
            if($key=='selected' && $val!==''){ $selected=$val;}    //get item selected
        }
    }
    $tag='<select '.$attrs.'>';
    if($nullline!==false) $tag.='<option value="">'.(is_string($nullline)? $nullline : '-- choose --').'</option>';    //add null line
    foreach($data as $t=>$val){
        if(isset($selected) && $selected ===($field_value? $val[$field_value] : $t)) $optselected=true;    //check item selected
        else{
            if(is_array($val) && isset($val['selected'])) $optselected=true;
            else $optselected=false;
        }
        
        $tag.='<option '.($optselected? 'selected' : '').' value="'.($field_value? $val[$field_value] : $t).'">'.($field_text? $val[$field_text] : $val).'</option>';
    }
    $tag.='</select>';
    return $tag;
}
//auto number select tag
function number_selectTag($start,$end='',$name='',$focus='',$nullline=false){
    $tag='<select '.($name? 'name="'.$name.'"' : '').'>';
    $jump=1;    //jump
    
    if($nullline!=false) $tag.='<option value>'.$nullline.'</option>';    //add null line
    if(!is_numeric($end) && !is_array($end)){ $end=$start;$start=1;}
    if(is_array($end)){
        $jump=$end['jump'];
        $end=$end['segment_count']*$start;
    }
    
    for($i=$start;$i<=$end;$i+=$jump){
        $tag.='<option '.(($focus!='' && $focus==$i)? 'selected' : '').' value="'.$i.'">'.$i.'</option>';
    }
    $tag.='</select>';
    return $tag;
}
//show paging
function show_pages_segment($jump=2,$opt=false,$params=array()){
    global $page,$total_pages,$num;
?>
<div class='pages'>
    <!-- show pages -->
    Trang&nbsp;
    <?php
    $beginIndex=$opt? 1 : 0;    //page start 0 or 1
    if(!is_numeric($page) || !is_numeric($total_pages) || !is_numeric($num)) return;    //no data found
    
    $start=($page>$jump)? $page-$jump : 0+$beginIndex;    //start page, page start at 0, match with parameter on URL
    $end=$page+$jump;
    //valid end point
    if($end>$total_pages) $end=$total_pages;

    for($i=$start;($opt==true? $i<=$end : $i<$end);$i++){
    ?>
        <a title='Trang <?php echo $i;?>' class='<?php //echo element_css(($i==$page+$beginIndex? 'button_disabled':'button'),'keypad radius-1')?>' style="padding-left:8px;padding-right:8px;" href="?<?php echo http_build_query(array_merge(array('page'=>$i,'count'=>$num),$params));?>"><?php echo $i?></a>
    <?php
    }
    ?>
</div>
    <?php
}
//show error
function show_error($header,$content=''){
    ?>
    <div style="background: pink;border:1px solid red;padding:10px;"><h2><?php echo $header?></h2><p><?php echo $content?></p></div>
    <?php
    exit();
}
//list url
function vcn_Url($type,$data=array()){
    if($type=='edit') return ('du-lieu/them-cau-hoi').'?edit='.$data['id'];//'?edit='.$data['id'];
    
    if($type=='edit-faq') return ('du-lieu/them-faq').'?edit='.$data['id'];    //faq
    if($type=='view-history') return ('history.php?id='.$data['id']);    //view history
    if($type=='delete-history') return ('admin/delete_history/'.$data['id']);    //delete history
    if($type=='delete-qdata') return ('nhap-cau-hoi.php?del='.$data);    //delete question & their answers
    if($type=='delete-faq') return ('du-lieu/delete_faq/'.$data);    //delete faq
}
function vcn_uri($params=array(),$inherit_uri=true,$_exclude=array()){
	$uri=$_GET;
	$exclude=array_merge(array('set_group'),$_exclude);
	foreach($exclude as $p){
		if(isset($uri[$p])) unset($uri[$p]);
	}
	return http_build_query(array_merge($uri,$params));
}
//short question bar
function vcn_question_bar($result,$index=0,$current=0){
	if(is_null($index)){ static $index=0;$index++;}
    ?>
    <div class='<?php echo $current? 'current' : 'vcn_qbar'?>' onclick='get_qid("<?php echo $result['id']?>")'>
    <div class='qbar-short'><strong><?php echo $index?></strong>-<?php echo limit(strip_tags($result['question']),'40')?></div>
    <a  href='javascript:;' onclick='location.href="?edit=<?php echo $result['id'] ?><?php //echo vcn_Url('edit',$result)?>"' title='Sửa ID-<?php echo $result['id']?>'><img alt='Sửa ID-<?php echo $result['id']?>'  class='icon' src='images/icon_edit.gif'/></a>
    <a href='javascript:;' onclick='if(confirm("Do you want to delete ?") && typeof vcn_delete=="function") vcn_delete("<?php echo $result['id']?>",this)' title="Xoá ID-<?php echo $result['id']?>"><img alt="xoá ID-<?php echo $result['id']?>" class='icon' src='images/icon_delete.gif'/></a>
    </div>
    <?php
}
//question group item
function vcn_group_item($result,$current=0){
	static $index=0;
	?>
	<div class='<?php echo $current? 'current' : 'vcn_qbar'?>'>
		<div class='qbar-short'><strong><?php echo $index++?></strong>-<?php echo limit(strip_tags($result['group_title']),'40')?></div>
		<a  href='javascript:;' onclick='location.href="?group=<?php echo $result['id'] ?><?php //echo vcn_Url('edit',$result)?>"' title='Sửa ID-<?php echo $result['id']?>'><img alt='Sửa ID-<?php echo $result['id']?>'  class='icon' src='images/icon_edit.gif'/></a>
		<a href='javascript:;' rel='nofollow' href='javascript:;' onclick='if(confirm("Are you sure to delete this group \"<?php echo $result['group_title']?>\"?")) location.href="?del=<?php echo $result['id']?>"' title="Xoá ID-<?php echo $result['id']?>"><img alt="xoá ID-<?php echo $result['id']?>" class='icon' src='images/icon_delete.gif'/></a>
	</div>
	<?php
}
//vcn faq item
function vcn_faq_item($result){
    ?>
    <div class='faq_item'>
    <div class='faq'><?php echo $result['faq']?></div>
    <div><?php echo $result['answer']?></div>
    </div>
    <?php
}
//history report
function vcn_history_answer_report($result){
	get_history($result['id'],$result['save_history']);
   while($result=mysql_fetch_array($history_rs)){
   $s=PHP_EOL.'--------------------------'.PHP_EOL;
   $s.=strip_tags($result['question']).PHP_EOL;
   
	if($result['answer_text']) {
		$s.=$result['answer_text'].PHP_EOL;
		$s.=partner_logo($result['answer_text'],0).PHP_EOL;
	
	}else{
		$s.=$result['answer'];
	}
	}
	$s=PHP_EOL.'--------------------------'.PHP_EOL;
	return $s;
}
//final customer form
function final_customer_form(){
    //if(!get_session('customerdata')) {echo 'Mất kết nối vui lòng đăng nhập lại...';return;}
    ?>
    <div class='customer_send_info'>
    <h2>Thông tin khách hàng</h2>
    <form name='final_customer_frm' id='final_customer_frm' class='final_customer_form' onsubmit='return submit_customer_evt(this);' action="success.php" method="POST">
	<textarea style="visibility:hidden;position:absolute;" name="histories"></textarea>
	<textarea style="visibility:hidden;position:absolute;" name="histories1"></textarea>
	<input type="hidden" name="result" value=""/>
	<input type="hidden" name="location" value=""/>
	<table>
		<tr>
			<td><label>Họ & tên:</label></td>
			<td><input type='text' name='fullname' value=""/></td>
		</tr>
		<tr>
			<td><label>Ngày sinh:</label></td>
			<td><input type='text' name='birth' style='cursor:pointer;' readonly='readonly' autocomplete='off' value=""/></td>
		</tr>
		<tr>
			<td><label>SĐT:</label></td>
			<td><input type='text' name='phone' onkeypress='allow_input_numberonly(event)' value=""/></td>
		</tr>
        <tr>
			<td><label>Số CMND:</label></td>
			<td><input type='text' name='cmt' onkeypress='allow_input_numberonly(event)' value=""/></td>
		</tr>
		<tr>
			<td><label>Tên công ty làm việc:</label></td>
			<td><input type='text' name='company' value=""/></td>
		</tr>
		<tr>
			<td><label>Mức lương:</label></td>
			<td><input type='text' name='salary' value=""/></td>
		</tr>
		<tr>
			<td><label>Số tiền cần vay:</label></td>
			<td><input type='text' name='loan' value='' onkeypress='allow_input_numberonly(event)' onblur="this.value=format_currency(this.value);"/>(VNĐ)</td>
		</tr>
		<tr>
			<td><label>Mục đích sử dụng:</label></td>
			<td><textarea name='usedfor' style='width: 248px; height: 68px;'></textarea></td>
		</tr>
        <tr>
			<td><label></label></td>
			<td>
			<div class='contacttime'>
				<div>Thời gian chúng tôi liên hệ:</div><input type='hidden' name='besttimecontact'/>
				<ul class='v-menu'>
					<li><label><input type='radio' name='contacttime' onclick='this.form.besttimecontact.value=this.value;' value='8h - 11h'/>&nbsp;8h - 11h</label></li>
					<li><label><input type='radio' name='contacttime' onclick='this.form.besttimecontact.value=this.value;' value='11h - 13h'/>&nbsp;11h - 13h</label></li>
					<li><label><input type='radio' name='contacttime' onclick='this.form.besttimecontact.value=this.value;' value='13h - 16h'/>&nbsp;13h - 16h</label></li>
					<li><label><input type='radio' name='contacttime' onclick='this.form.besttimecontact.value=this.value;' value='16h - 18h'/>&nbsp;16h - 18h</label></li>
					<li><label><input type='radio' name='contacttime' onclick='this.form.besttimecontact.value=this.value;' value='18h - 21h'/>&nbsp;18h - 21h</label></li>
				</ul>
			</div>
			</td>
		</tr>
		<tr>
			<td><label></label></td>
			<td><input type='submit' name='submit_but' value='Gửi đi'/></td>
		</tr>
    </form>
    <p style='font-size:11px'>(<font color='red'>*</font>) Quý khách vui lòng nhập chính xác thông tin cá nhân để chúng tôi hỗ trợ.</p>
    <script>
    /**
     *event
    */
    //ready doc
    $(document).ready(function()
    {
        var customerfrm=document.forms['final_customer_frm'];
        $( customerfrm.birth ).datepicker({onSelect:function(dateText, inst){},changeMonth: true,changeYear: true});    //datepicker
        $(customerfrm.birth).datepicker( "option", 'dateFormat', 'yy-mm-dd' );
        if(0<?php //echo get_session('customerdata')->birth? '1':'0'?>) $(customerfrm.birth).datepicker("setDate", "<?php //echo get_session('customerdata')->birth?>");
    });
    </script>
    </div>
    <?php
}
//report date select tag
function report_date_selectTag($data,$selected=false){
    return selectTag($data,null,null,array_merge(array('name'=>'report_date','onchange'=>''),$selected? array('selected'=>$selected) : array()),'Lọc ngày');
}
//other filter
function vcn_report_filter_selectTag($selected=null){
    $data=array(
        ''=>'Tất cả',
        'miss'=>'Không đủ điều kiện',
        'meet'=>'Đủ điều kiện'
        );
    return selectTag($data,null,null,array_merge(array('name'=>'customer_result'),$selected? array('selected'=>$selected) : array()));
}
//parner logo
function partner_logo($name,$output=1){
    $logo=array(
        'VPBank'=>'images/partners/vpbank.jpg',
        'Prudential'=>'images/partners/prudential.gif'
    );
    foreach(explode(',',$name) as $partner){
        if(isset($logo[$partner])){
			$img.= '<img class="smallpartner-logo" src="'.$logo[$partner].'"/>';
        }
    }
	if($output) echo $img;else return $img;
}
//admin data
function vcn_admin_data($selected=null){
    $data=array(
        'history'=>'Lịch sử giao dịch',
        'customer'=>'Danh sách khách hàng'
    );
    return selectTag($data,null,null,array_merge(array('name'=>'admin_data'),$selected? array('selected'=>$selected) : array()));
}
//print
function _print($txt){echo '<textarea>';print_r($txt);echo '</textarea>';}
?>