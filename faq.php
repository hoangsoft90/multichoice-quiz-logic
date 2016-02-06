<html>
<head>
    <title>FAQ</title>
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
<div id='vcn_wrap'>
	<div id="header"><h1>Vaycanhan.com</h1></div>
<?php
include('include/functions.php');
?>
<?php
$data=array();	//data
if(_POST('submitfaq')){	//add faq
	//answers
	$faqs=array();
	$new_faqs=array();	//new faq to be added
	
	if(_POST('modify_faqs')) {
		$faq_ids=explode(',',trim(_POST('modify_faqs'),','));	//pure
	}
	for($i=0;$i<_POST('faqcount');$i++){
		if(!_POST('faq-question-'.$i)) break;	//detect end data
		
		$faq=array();	//faq
		$faq['faq']=_POST('faq-question-'.$i);
		$faq['answer']=_POST('faq-answer-'.$i);
		$faq['group_']=_POST('group');
		
		$faqs[]=$faq;	//add to faqs data
		//update faq
		if(_POST('modify') && is_numeric(_POST('modify'))){
			$faq['group_']=_POST('modify');
			if(isset($faq_ids[$i])) do_update($faq,array('id'=>$faq_ids[$i]),'vcn_faq');
			else{	//new faq to be added
				$new_faqs[]=$faq;
			}
		}
	}
	do_update(array('has_faq'=>'1'),array('id'=>_POST('group')),'vcn_data');	//turn on faq for this question
	if(count($new_faqs) && _POST('modify') && is_numeric(_POST('modify'))){	//new faq to be added when update
		do_insert($new_faqs,'vcn_faq');
	}
	//add faq
	if(!_POST('modify') || !is_numeric(_POST('modify'))) {
		do_insert($faqs,'vcn_faq');
		push_messages('Thêm faq thành công.');
	}
	else push_messages('Cập nhật faq thành công.');
	
	//delete answers
	if(_POST('deletes')){
		do_delete(explode(',',trim(_POST('deletes'),',')),'vcn_faq','id');	//delete old answers
	}
}
if(_GET('del')){	//del faq item
	delete_faq(_GET('del'));
}
if(_GET('edit')){
	$data['result']=vcn_faq(_GET('edit'));	//get specify faq
}
extract($data);
?>
<?php
//message
show_messages();
?>
<h2>FAQ</h2>
<?php if(isset($result[0])){?>
<p>
<a class="button_silver_square radius-1 padding3" onclick="if(confirm('Are you sure ?')) location.href='?del=<?php echo $result[0]['id']?>'" href="javascript:;">Xoá FAQ</a>
</p>
<hr/>
<?php }?>
<form method='POST' onsubmit='return faq_frm_submit(this)' name='faqfrm' accept-charset="utf-8">
<!-- hidden -->
<input type='hidden' name='modify' value='<?php echo isset($result[0]['group_'])? $result[0]['group_'] : ''?>'/>
<input type='hidden' name='faqcount'/>
<input type='hidden' name='modify_faqs' value=''/>
<input type='hidden' name='deletes'><!-- delete exists answers -->

	<label>Question</label>
	<input type='text' name='group' onclick='focus_txt.input_focus_evt(this)' <?php if(isset($_GET['edit'])){?>readonly='readonly' <?php }?> value='<?php echo isset($_GET['edit'])? $_GET['edit'] : '0'?>'/><br/>
	
	<div id='tool1'><div id='tool1_content'></div></div><!-- tool -->
	<div id='faq'></div>
	<label></label>
	<input type='submit' name='submitfaq' value='Save'/>
</form>
<script>
var faq_frm;	//faq form
var faq_inst=new VCN_Faq();	//instance VNC_Faq
var focus_txt=new input_manager();	//input text manager
$(document).ready(readydoc);

/**
 *event
*/
//faq delete event
function faq_delete_event(data){
	if(!data) return;	//add new faq of case
	if(jQuery.inArray(data.id,faq_frm.deletes.value.split(','))==-1) faq_frm.deletes.value+=data.id+',';
}
//faq form submit event
function faq_frm_submit(frm){
	frm.faqcount.value=faq_inst.count();	//get total questions
}
//ready doc
function readydoc(){
	faq_frm=document.forms['faqfrm'];	//get faq form
	//set autofixed feature to tool
	autofixedTop(document.getElementById('tool1'),$('#main1')[0]);
	
	//set tool
	faq_inst.get_instance().set_tool($('#tool1_content')[0]);
	$('#faq').append(faq_inst.get_instance().get());
	//show specify faq
	<?php if(isset($result) && is_array($result) && count($result)){
	foreach($result as $faq){
	?>
	faq_frm.modify_faqs.value+='<?php echo $faq['id']?>,';	//answer id to modify
	faq_inst.get_instance().add_faq(<?php echo str_inline(json_encode($faq))?>);
	<?php }}else{?>
	faq_inst.get_instance().add_faq();	//default add one
	<?php }?>
}
//get question id
function get_qid(id){
	focus_txt.set_text(id);	//set id to current focus input text
}
//delete faq
/*
function vcn_delete(id,obj){
	obj.innerHTML='<img src="images/loading.gif"/>';
	loadAjax("/cmd/delete_faq/"+id,function(){
		window.location.reload();	//refresh page
	});
}*/
</script>
</div>
</body>
</html>