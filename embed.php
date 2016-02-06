<!DOCTYPE html>
<html>
<head>
	<title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script src="js/jquery-1.5.2.min.js"></script>
	<!-- jquery ui -->
	<script src="js/jquery-ui.min.1.8.23.js"></script> 
	<link rel="stylesheet" type="text/css" href="css/jquery-ui.1.8.23.css">
	
	<script src="js/myjs.js"></script>
    <script src="js/js.js"></script>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/style1.css">
	<style>
	body{background:#fff;}
	*{margin:0px;padding:0px;}
	</style>
</head>
<body > <!-- onload='parent.resizeIframe(document.body.scrollHeight)' -->
<?php
include('include/functions.php');
?>
<h1>Tư vấn trực tuyến</h1>
<div id='vcn'></div><!-- object -->
<div id='faq'></div><!-- FAQ -->
<script>
/**
 *global vars
*/
var qview=new qChain();    //instance qChain class
qview.auto_next=true;
//$(qview.get(1).prev_btn).hide();
qview.load();    //load questions

$(document).ready(readydoc);    //ready doc
/**
 *private
*/
/**
 *event
*/

//ready doc
function readydoc(){
    //qview.faq=document.getElementById('faq');    //faq container
    $('#vcn').append(qview.get());    //desploy app
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
	/*jQuery('#vcn').block({ 
                message:$('#loading'),
                css: {border:0,background:'none'} ,
                overlayCSS: { opacity:'0.1' }
            });*/
    frm.submit_but.value='Đang lưu..';
	frm.histories1.value=qview.get_history().history+'\n'+JSON.stringify(qview.get_history().answers_text); 
   frm.histories.value=qview.get_full_histories();
   frm.result.value=qview.history.result?'true':'false';
	
    return true;
}

</script>
<script>
/*adjust iframe size as content changes*/
jQuery(function($){
    var eventMethod = window.addEventListener ? "addEventListener" : "attachEvent";
    var eventer = window[eventMethod];
    var messageEvent = eventMethod == "attachEvent" ? "onmessage" : "message";
    // Listen to message from parent IFrame window
    eventer(messageEvent, function (e) {
           //alert('child:'+e.data);
           //e.source.postMessage('inside frame', e.origin);
           /*adjust iframe size as content changes*/
        if(e.data)
        jQuery(function($){
          var lastHeight = 0, curHeight = 0, $frame = $(e.data);//$('iframe:eq(0)');
          
            //curHeight = $frame.contents().find('body').height()+40;
            curHeight=$(document).find('body').height()+0;	//every element like h1,h2..should be padding,margin to 0px
            if ( curHeight != lastHeight ) {
                e.source.postMessage((lastHeight = curHeight)+'px', e.origin);
                
              //$frame.css('height', (lastHeight = curHeight) + 'px' );
            }
        });
           //just test
           if (e.origin == 'http://iframe.example.com') {
                alert(e.data); 
            }
    }, false);
});
</script>
</body>
</html>