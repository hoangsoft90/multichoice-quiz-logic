<?php
session_start();
?>
<html>
<head>
    <title>Nhap cau hoi</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="js/myjs.js"></script>
    <script src="js/jquery-1.5.2.min.js"></script>
    <script src="js/js.js"></script>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/style1.css">
</head>
<body>
<?php
include('include/functions.php');
//save_current_group(1);exit();
//set group
if(isset($_GET['set_group']) && is_numeric($_GET['set_group'])) {
	change_group($_GET['set_group'],(isset($_GET['active']) && $_GET['active']));
}
$current_group=get_current_group();	//current group
?>
<div id='vcn_wrap'>
	<div id="header"><h1>Vaycanhan.com</h1></div>
	<div class="topbar">
	<table>
		<tr>
			<td>|</td>
			<td><?php if($current_group){?><span><strong>Nhóm câu hỏi hiện tại:</strong> <?php echo $current_group->group_title; ?>(ID=<?php echo $current_group->id?>)</span><?php }?>(<a class="button" href="<?php echo get_current_page()?>?change_group">Change group</a>)</td>
		</tr>
	</table>
	</div>
<?php

//group picker
if(!get_session('vcn-question-group') || isset($_REQUEST['change_group'])){
?>
<div class="main">
<h2>Please chose a questions group bellow:</h2>
<div class="groups">
<?php 
	$groups=get_question_group();
	$default_img='/images/group-image.jpg';	//default image
	foreach($groups as $item){
		?>
		<div class="vcn-group-box"><img src="<?php echo $item['group_image']? $item['group_image']:$default_img?>" alt="<?php echo $item['group_title']?>"/>
		<div class="topright">ID=<?php echo $item['id']?></div>
		<div><?php echo $item['group_title']?></div>
		<div class="btns"><a href="?set_group=<?php echo $item['id']?>">Change group</a>|
		<a href="?set_group=<?php echo $item['id']?>&active=1">Change & active</a></div>
		</div>
		<?php
	}
?>
</div>
<?php
}else{
echo '<div class="main-left1">';
//show message
show_messages();
?>
<h2>Nhập dữ liệu câu hỏi</h2>
<?php
$data=array();
/**
 *action form
*/
if(_POST('submit')){    //save data
    //add question
    $data_q=array(
		'group_id'=>$current_group->id,
        'question'=>_POST('question'),
        'action'=>_POST('action'),
        'link_question'=>_POST('link_question'),
        'default_question_css'=>(_POST('default_question_css')? '1':'0')
    );
    if(_POST('modify') && is_numeric(_POST('modify'))){    //modify question
        do_update($data_q,array('id'=>_POST('modify')),'vcn_data');    //update question
        push_messages('Cập nhật thành công !');
    }
    else {
        do_insert($data_q,'vcn_data');    //add question
        push_messages('Đã thêm thành công !');
    }
    //answers
    $answers=array();
    $new_answers=array();    //new answer to be added
    
    if(_POST('modify_answers')) {
        $answer_ids=explode(',',trim(_POST('modify_answers'),','));
    }
    for($i=0;$i<_POST('qcount');$i++){
        if(!_POST('answer-'.$i)) break;    //detect end data
        
        $answer=array();    //answer
        //question id
        if(mysql_insert_id()) $answer['question']=mysql_insert_id(); 
        
        $answer['answer']=_POST('answer-'.$i);
        $answer['answer_link_question']=_POST('link2q-answer-'.$i);
        $answer['text2next_question']=_POST('text2nextq-'.$i);
        $answer['answer_object_type']=_POST('answer-obj-type-'.$i)? 1 : 0;
        $answer['link_object_type']=_POST('link-obj-type-'.$i)? 1 : 0;
        $answers[]=$answer;    //add to answers data
        //update answer
        if(_POST('modify') && is_numeric(_POST('modify'))){
            $answer['question']=_POST('modify');    //qid
            if(isset($answer_ids[$i])) do_update($answer,array('id'=>$answer_ids[$i]),'vcn_answers');
            else{    //new answer to be added
                $new_answers[]=$answer;
            }
        }
    }
    if(count($new_answers) && _POST('modify') && is_numeric(_POST('modify'))){    //new answers to be added
        do_insert($new_answers,'vcn_answers');
    }
    //add answers to question
    if(!_POST('modify') || !is_numeric(_POST('modify'))) {
        do_insert($answers,'vcn_answers');
    }
    //delete answers
    if(_POST('deletes')){
        do_delete(explode(',',trim(_POST('deletes'),',')),'vcn_answers','id');    //delete old answers
    }
}
//delete question
if(_GET('del')){
    delete_qdata(_GET('del'));
}
//data
if(_GET('edit')){
    $data['result']=get(_GET('edit'));    //get question answers
	if(!count($data['result'])) show_error('Not found','Không tồn tại dữ liệu.');
}
extract($data);//print_r($result);

?>
<?php if(isset($result)){?>
<p>
<a href='javascript:;' class='button_silver_square radius-1 padding3' onclick='if(confirm("Are you sure?")) location.href="<?php echo vcn_Url('delete-qdata',$result[0]['id'])?>"'>Xoá câu hỏi này</a>
</p><hr/>
<?php }?>
<form method='POST' name='vcn_qform' class='vcn_qform frmlayout' action="nhap-cau-hoi.php" onsubmit='return submit_vcn_form(this)' accept-charset="utf-8">
<!-- hidden -->
<input type='hidden' name='qcount'/>
<input type='hidden' name='modify' value='<?php echo isset($result)? $result[0]['id'] : ''?>'/>
<input type='hidden' name='modify_answers' value=''/>
<input type='hidden' name='deletes'><!-- delete exists answers -->
    <label>Câu hỏi <?php if(isset($result)){?>(ID=<?php echo $result[0]['id']?>)<?php }?></label>
    <textarea rows='4' cols='50' name='question' ><?php echo isset($result)? $result[0]['question'] : ''?></textarea><br/>
    <label>CSS</label>
    <div>
    <input type='checkbox' name='default_question_css' <?php if(isset($result) && $result[0]['default_question_css']){?>checked='checked'<?php }?>/>Default question CSS<br/>
    <input type='checkbox' name='default_answer_css' />Default answer CSS
    </div>
    <!-- <label>Action</label>
    <textarea name='action'><?php echo isset($result)? $result[0]['action'] : ''?></textarea><br/> -->
    <label>Link question</label>
    <textarea name='link_question'><?php echo isset($result)? $result[0]['link_question'] : 0?></textarea><br/>
    <div id='tool1'><div id='tool1_content'></div></div><!-- tool -->
    <div id='answers'></div><!-- answers holder -->
    <label></label>
    <input type='submit' name='submit' class='button_silver_square radius-1 padding3' value='Save'/>
</form>
<script>
var vcn_frm;    //data form
var focus_txt=new input_manager();    //input text manager
var answers_frm=new VCN_Answers();    //instance VCN_Answers class

var keep_view;
//ready doc
$(document).ready(readydoc);
/**
 *event
*/
//answer deletes event
function answer_delete_event(data){
    if(!data) return;    //add new answer of case
    if(jQuery.inArray(data.answer_id,vcn_frm.deletes.value.split(','))==-1) vcn_frm.deletes.value+=data.answer_id+',';
}
//ready doc evt
function readydoc(){
    //set autofixed feature to tool
    keep_view=autofixedTop(document.getElementById('tool1'),$('#main1')[0]);
    
    vcn_frm=document.forms['vcn_qform'];    //vcn form
    for(var i=0;i<vcn_frm.elements.length;i++){
        if(vcn_frm.elements[i].type!='submit' || vcn_frm.elements[i].type!='reset') focus_txt.input_focus_evt(vcn_frm.elements[i]);
    }
    //vcn answer
    answers_frm.set_tool($('#tool1_content')[0]);
    $('#answers').append(answers_frm.get());
    //layout
    <?php if(isset($result)){
    foreach($result as $answer){
    ?>
    vcn_frm.modify_answers.value+='<?php echo $answer['answer_id']?>,';    //answer id to modify
    answers_frm.add_answer(<?php echo str_inline(json_encode($answer,JSON_UNESCAPED_UNICODE))?>);	//publish on hosting: remove JSON_UNESCAPED_UNICODE
	
    <?php }}else{?>
    answers_frm.add_answer();    //default add one
    <?php }?>
}
//form submit
function submit_vcn_form(frm){
    var requires=[];
    frm.qcount.value=answers_frm.count();    //get total questions
}
//get question id
function get_qid(id){
    focus_txt.set_caret_text(id);    //set id to current focus input text
}
//delete question & answers
function vcn_delete(id,obj){
    obj.innerHTML='<img src="images/loading.gif"/>';
    loadAjax("?del="+id,function(){
        window.location.reload();    //refresh page
    });
}
</script>
<?php
}
?>
	</div>
	<?php if(get_session('vcn-question-group') && !isset($_REQUEST['change_group'])){?>
	<div class="right">
<div class='listquestion' id='listquestion'>
<?php
$data=get_questions();    //get all data
$index=0;    //count
while($result=mysql_fetch_array($data)){
    $current=(isset($_GET['edit']) && $_GET['edit']==$result['id']);
    vcn_question_bar($result,$index++,$current);
}
?>
</div>
<script>
$(document).ready(function(){
    //auto fixed listquestion
    autofixedTop(document.getElementById('listquestion'),$('#right')[0]);
});
</script>
	</div>
	<?php }//else echo 'Please pick up a group.';?>
	<div style="clear:both"></div>
</div>
</body>
</html>