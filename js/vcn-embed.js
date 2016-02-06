//http://hn.tindung24h.com/embedquiz/
jQuery(function($){
	var open=1;
	$('#vcn_embed_ifrm').bind('load',function(){
		setInterval(function(){
			if(open){
				document.getElementById('vcn_embed_ifrm').contentWindow.postMessage('connect to child','*');
				open=0;		//locked
			}
		},500);
	});
	/*listen message from child*/
	var eventMethod = window.addEventListener ? "addEventListener" : "attachEvent";
	var eventer = window[eventMethod];

	// Now...
	// if 
	//    "attachEvent", then we need to select "onmessage" as the event. 
	// if 
	//    "addEventListener", then we need to select "message" as the event

	var messageEvent = eventMethod == "attachEvent" ? "onmessage" : "message";

	// Listen to message from child IFrame window
	eventer(messageEvent, function (e) {
		   //alert('parent:'+e.data);
		   $('#vcn_embed_ifrm').css({height:e.data});
		   //unlock
		   open=1;
	}, false);  

});