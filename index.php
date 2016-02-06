<html>
<head>
    <title>Tu van truc tuyen</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="js/jquery-1.5.2.min.js"></script>
	<script src="js/jquery-ui.min.1.8.23.js"></script> 
	<script src="js/jquery.blockUI.js"></script>
    <link rel="stylesheet" type="text/css" href="css/jquery-ui.1.8.23.css">
	<script src="js/myjs.js"></script>
    <script src="js/js.js"></script>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/style1.css">
    
	<script>
	
	</script>
</head>
<body>
<?php
require_once('include/functions.php');
?>

<div id='vcn_wrap'>
<div class='vcn'><!-- #header -->
    <h1>Tư vấn trực tuyến</h1>
    <div id='vcn'></div>
</div>
<div class='main-left' >
    <div class='widget radius-1'><!-- #faq -->
    <h2>Những câu hỏi thường gặp</h2>
    <div id='faq'></div><!-- faq -->
        <div style='text-align:right'><a href='<?php echo ('huong-dan/hoi-dap')?>' target='_blank'>Xem tất cả >></a></div>
    </div>
    
    <div class='widget radius-1'><!-- news widget -->
    <h2>Thông tin mới</h2>
    <div id='news'><img src='images/loading.gif'/></div>
        <div style='text-align:right'><a href='<?php echo ('tin-tuc')?>' target='_blank'>Xem tất cả >></a></div>
    </div>
</div>
<div style="clear:both"></div>
</div>
<script>
/**
 *global vars
*/
var today="<?php echo date('Y-m-d')?>";
var qview=new qChain();    //instance qChain class
qview.auto_next=true;
qview.group='<?php echo config('main_questions_group')?>';	//question group
//$(qview.get(1).prev_btn).hide();
qview.load();    //load questions

$(document).ready(readydoc);    //ready doc
/**
 *private
*/
//enable form
function enable_form(frm,opt){
    if(opt==undefined) opt=1;    //valid
  
	if(opt==0){
	jQuery(frm).block({
                message:$('#loading'),
                css: {border:0,background:'none' } ,
                overlayCSS: { opacity:'0.1' }
            });
	}
}
/**
 *event
*/
//ready doc
function readydoc(){
    qview.faq=document.getElementById('faq');    //faq container
    $('#vcn').append(qview.get());    //desploy app
    $('#news').load('ajax.php?f=vcn_load_news');    //load news
}
//customer submit event
function submit_customer_evt(frm){
    var requires=[frm.fullname,frm.birth,frm.cmt,frm.company,frm.salary,frm.loan,frm.usedfor,frm.besttimecontact];    //require fields
    for(var i=0; i< requires.length;i++){
        if(requires[i].value.replace(/\s+/g,'')==''){
            alert('Vui lòng nhập đầy đủ thông tin !');
            requires[i].focus();    //focus on field
            return false;
        }
    }
    //enable_form(frm,0);    //disabled form
	jQuery('#vcn').block({ 
                message:$('#loading'),
                css: {border:0,background:'none'} ,
                overlayCSS: { opacity:'0.1' }
            });
    frm.submit_but.value='Đang lưu..';
   /* 
	//post data
    var postdata='company='+frm.company.value+'&sal='+frm.salary.value+'&history='+qview.get_history().history+'&historyt='+JSON.stringify(qview.get_history().answers_text);
    postdata+='&usedfor='+frm.usedfor.value+'&contacttime='+frm.besttimecontact.value+'&loan='+frm.loan.value;

	//continue
    if(submit_customer_evt.modify) postdata+='&modify='+submit_customer_evt.modify;    //update tasking
	*/	
	frm.histories1.value=qview.get_history().history+'\n'+JSON.stringify(qview.get_history().answers_text); 
   frm.histories.value=qview.get_full_histories();
   frm.result.value=qview.history.result?'true':'false';
	
    /*loadAjax('ajax.php?f=save_customerwork',function(r){
        var id=ajax_json_result(r);    //parse
        if(id) submit_customer_evt.modify=id;    //do update in next time
        
        enable_form(frm);    //enabled form
        frm.submit_but.value='Sửa';    //resume but label
        alert('Thông tin của quý vị đã được gửi đến chúng tôi !');
    },'POST',postdata);*/
    return true;
}

</script>
</body>
</html>