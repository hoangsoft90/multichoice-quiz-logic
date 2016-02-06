/****************************************************************************************
 * @ajax
*/
//load ajax
function loadAjax(url,func,method,postdata,header)
{
	if(method==undefined) method='GET';	//valid method
	var xmlhttp;
	if (window.XMLHttpRequest)
	{// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	}
	else
	{// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			if(typeof func=='function') func(xmlhttp.responseText);
		}
	}
	xmlhttp.open(method,url,true);
	if(method.toUpperCase()=='POST' && postdata!=null){	//modify header with post method
		xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		//xmlhttp.setRequestHeader("Content-length", postdata.length);
		//xmlhttp.setRequestHeader("Connection", "close");
	}
	if(header){
		for(var i in header){
			xmlhttp.setRequestHeader(i,header[i]);
		}
	}
	xmlhttp.send(postdata);
}
//get ajax json result
function ajax_json_result(json,_var){
	return json.match(/<data>(.+)<\/data>/m)? json.match(/<data>(.+)<\/data>/m)[1] : '';	//filter json result
}
/**************************************************************************************
 *@Size, position
*/
//set auto fixed top to element
function autofixedTop(obj,getwidth){
if(!obj || !obj.tagName) return;	//not element
return new function(){
	var p=this;	//this instance
	if(!getwidth) getwidth=obj;	//get size
	
	p.top=obj.offsetTop;	//save first top element, this may be change
	p.width=$(getwidth).width();	//save first width obj
	p.reach_top='0px';	//default reach to top 0
	
	$(window).scroll(function(){
		if($(getwidth).width()!=p.width)	p.width=$(getwidth).width();	//update width
		//do this first
		if($(window).scrollTop()<p.top) {
			$(obj).css({position:'',top:''});	//remove fixed
			return;	//stop
		}
		if($(window).scrollTop()>=obj.offsetTop){
			$(obj).css({position:'fixed',top:p.reach_top,width:p.width});	//fixed
		}
	});
}}

//insert at caret
function insertAtCaret(txtf,value){
 if(document.selection){
  txtf.focus();
  sel=document.selection.createRange();
  sel.text=value;
  return;
 }if(txtf.selectionStart||txtf.selectionStart=="0"){
  var t_start=txtf.selectionStart;
  var t_end=txtf.selectionEnd;
  var val_start=txtf.value.substring(0,t_start);
  var val_end=txtf.value.substring(t_end,txtf.value.length);
  txtf.value=val_start+value+val_end;
 }else{
  txtf.value+=value;
 }
}
//usage: <input onkeypress='allow_input_numberonly(event)'/>
function allow_input_numberonly(evt) {
  var theEvent = evt || window.event;
  var key = theEvent.keyCode || theEvent.which;
  key = String.fromCharCode( key );
  var regex = /[0-9]|\./;
  if( !regex.test(key) ) {
    theEvent.returnValue = false;
    if(theEvent.preventDefault) theEvent.preventDefault();
  }
}
//format currency
function format_currency(n){
	n=n.toString().replace(/\./g,'');	//pure remove '.' of char
	var j=0;
	for(var i=n.length-1;i>=0;i--){
		if(j++==2 && i!=0){ n=n.insert(i,'.');j=0;}
	}
	return n;
}