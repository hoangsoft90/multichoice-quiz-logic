/**
 *@VCN_Faq class
*/
function VCN_Faq(){
	var p=this;	//this instance
	var faq=new VCN_Answers();	//instance VNC_Answers
	//add faq but
	faq.get(1).add_but.value='+ Thêm hỏi đáp';
	faq.get(1).add_but.onclick=add_faq_evt;
	//object
	
	/**
	 *data
	*/
	var faqs=[];	//answers data
	var current_index=0;	//current answer index
	
	/**
	 *private
	*/
	//add faq event
	function add_faq_evt(){
		faq.add_faq();
	}
	//reset answers
	function reset_faqs(){
		var index=0;
		for(var i=0;i<faqs.length;i++){
			if(!faqs[i]) continue;	//ignore null
			faqs[i].label.innerHTML=index;
			faqs[i].faq_question.name='faq-question-'+index;
			faqs[i].faq_answer.name='faq-answer-'+index;
			index++;	//next index
		}
	}
	/**
	 *event
	*/
	
	/**
	 *public
	*/
	//build add_faq method
	faq.add_faq=function(data){
		//var
		var id;	//this answer index
		
		var main=document.createElement('div');	//surround
		main.className='answer';	//inherit this css
		//label
		var label=document.createElement('div');
		label.innerHTML=current_index;
		label.className='label';
		main.appendChild(label);
		
		var body=document.createElement('div');	//around answer
		body.className='body';
		main.appendChild(body);
		//close answer but
		var close=document.createElement('img');
		close.className='fright close_but';
		close.src='images/icon_delete.gif';
		close.onclick=remove_faq_evt;
		body.appendChild(close);
		
		var label_faq_question=document.createElement('div');	//label faq question
		label_faq_question.innerHTML='Hỏi';
		body.appendChild(label_faq_question);
		
		var faq_question=document.createElement('textarea');	//text input
		faq_question.name='faq-question-'+(current_index);
		faq_question.rows='4';
		faq_question.cols='40';
		if(data && typeof data.faq=='string') faq_question.value=data.faq;	//answer content
		body.appendChild(faq_question);
		if(typeof focus_txt!='undefined' && focus_txt instanceof input_manager) focus_txt.input_focus_evt(faq_question);	//set focus input evt
		
		var label_faq_answer=document.createElement('div');	//label faq answer
		label_faq_answer.innerHTML='Đáp';
		body.appendChild(label_faq_answer);
		
		var faq_answer=document.createElement('textarea');
		faq_answer.name='faq-answer-'+current_index;
		if(data && typeof data.answer=='string') faq_answer.value=data.answer;	//link question string
		body.appendChild(faq_answer);
		if(typeof focus_txt!='undefined' && focus_txt instanceof input_manager) focus_txt.input_focus_evt(faq_answer);	//set focus input evt
		
		faqs.push({label:label,faq_question:faq_question,faq_answer:faq_answer,object:main});	//add to manager
		id=faqs.length-1;	//get this answer index
		faq.get(1).container.appendChild(main);	//add to gui
		current_index++;	//next answer
		/**
		 *event
		*/
		//remove faq
		function remove_faq_evt(){
			if(confirm('Bạn có chắc chắn ?')){
			delete faqs[id];	//delete from manager
			current_index--;
			faq.get(1).container.removeChild(main);
			reset_faqs();	//reset elements
			if(typeof faq_delete_event=='function') faq_delete_event(data); //callback
			}
		}
	}
	//get instance
	p.get_instance=function(){
		return faq;
	}
	//return question count
	p.count=function(){
		return current_index;
	}
}
/**
 *@VCN_Answers class
*/
function VCN_Answers(){
	var p=this;	//this instance
	/**
	 *object
	*/
	var around=document.createElement('div');	//around
	around.className='vcn_answers';
	
	var tool=document.createElement('div');	//tool
	around.appendChild(tool);
	//answer container
	var answers_container=document.createElement('div');	
	answers_container.className='answers_holder';
	around.appendChild(answers_container);
	
	//buts
	var add_question=c_but1('+Thêm trả lời');
	add_question.onclick=add_answer_evt;
	tool.appendChild(add_question);
	/**
	 *data
	*/
	var answers=[];	//answers data
	var current_index=0;	//current answer index
	/**
	 *private
	*/
	function c_checkbox(label){
		var div=document.createElement('div');
		var c=document.createElement('input');
		c.type='checkbox';
		div.appendChild(c);
		if(typeof label=='string') div.appendChild(document.createTextNode(label));
		return {object:div,checkbox:c};
	}
	//reset answers
	function reset_answers(){
		var index=0;
		for(var i=0;i<answers.length;i++){
			if(!answers[i]) continue;	//ignore null
			answers[i].label.innerHTML=index;
			answers[i].txt_answer.name='answer-'+index;
			answers[i].txt_link2q.name='link2q-answer-'+index;
			answers[i].c_answer_tobj.checkbox.name='answer-obj-type-'+index;
			answers[i].c_link_tobj.checkbox.name='link-obj-type-'+index;
			index++;	//next index
		}
	}
	/**
	 *event
	*/
	//add answer event
	function add_answer_evt(){
		p.add_answer();
	}
	/**
	 *public
	*/
	//set tool to container
	p.set_tool=function(container){
		if(container && container.appendChild) container.appendChild(tool);
	}
	//add answer
	p.add_answer=function(data){
		//var
		var id;	//this answer index
		
		var main=document.createElement('div');	//surround
		main.className='answer';
		//label
		var label=document.createElement('div');
		label.innerHTML=current_index;
		if(data && data.answer_id) label.innerHTML+='\n<span>(ID='+data.answer_id+')</span>';
		label.className='label';
		main.appendChild(label);
		
		var body=document.createElement('div');	//around answer
		body.className='body';
		main.appendChild(body);
		//close answer but
		var close=document.createElement('img');
		close.className='fright close_but';
		close.src='images/icon_delete.gif';
		close.onclick=remove_answer_evt;
		body.appendChild(close);
		
		var c_answer_tobj=c_checkbox('Answer object type');	//check box answer object type
		c_answer_tobj.checkbox.name='answer-obj-type-'+current_index;
		if(data && parseInt(data.answer_object_type)) c_answer_tobj.checkbox.checked=true;	//set check
		body.appendChild(c_answer_tobj.object);
		
		var txt_answer=document.createElement('textarea');	//text input
		txt_answer.name='answer-'+(current_index);
		txt_answer.rows='4';
		txt_answer.cols='40';
		if(data && typeof data.answer=='string') txt_answer.value=data.answer;	//answer content
		body.appendChild(txt_answer);
		if(typeof focus_txt!='undefined' && focus_txt instanceof input_manager) focus_txt.input_focus_evt(txt_answer);	//set focus input evt
		
		var c_link_tobj=c_checkbox('Link object type')	//checkbox link object type
		c_link_tobj.checkbox.name='link-obj-type-'+current_index;
		if(data && parseInt(data.link_object_type)) c_link_tobj.checkbox.checked=true;	//set check
		body.appendChild(c_link_tobj.object);
		
		var txt_link2q=document.createElement('textarea');
		txt_link2q.name='link2q-answer-'+current_index;
		if(data && typeof data.answer_link_question=='string') txt_link2q.value=data.answer_link_question;	//link question string
		body.appendChild(txt_link2q);
		if(typeof focus_txt!='undefined' && focus_txt instanceof input_manager) focus_txt.input_focus_evt(txt_link2q);	//set focus input evt
		
		var label_text2next=document.createElement('div');//text2next label
		label_text2next.innerHTML='Giải thích đến câu sau';	
		body.appendChild(label_text2next);
		
		var text2next_question=document.createElement('textarea');	//addition text to next question, work as explaining
		text2next_question.name='text2nextq-'+current_index;
		if(data && typeof data.text2next_question=='string') text2next_question.value=data.text2next_question;	//set text
		body.appendChild(text2next_question);
		
		answers.push({label:label,txt_answer:txt_answer,txt_link2q:txt_link2q,c_answer_tobj:c_answer_tobj,c_link_tobj:c_link_tobj,object:main});	//add to manager
		id=answers.length-1;	//get this answer index
		answers_container.appendChild(main);	//add to gui
		current_index++;	//next answer
		/**
		 *event
		*/
		//remove answer
		function remove_answer_evt(){
			if(confirm('Bạn có chắc chắn ?')){
			delete answers[id];	//delete from manager
			current_index--;
			answers_container.removeChild(main);
			reset_answers();	//reset elements
			if(typeof answer_delete_event=='function') answer_delete_event(data); //callback
			}
		}
	}
	//get
	p.get=function(opt){
		return opt? {add_but:add_question,container:answers_container} :around;
	}
	//return question count
	p.count=function(){
		return current_index;
	}
}
/**
 *@question class
*/
function vcn_question(){
	var p=this;
	//object
	var obj=document.createElement('div');
	obj.className='qsingle';
	var question=document.createElement('div');	//question
	question.className='question';
	obj.appendChild(question);
	var answer_container=document.createElement('div');	//answers holder
	obj.appendChild(answer_container);
	
	var moreInfo=document.createElement('div');	//more text
	moreInfo.className='moreInfo';
	$(moreInfo).hide();	//default to hide
	obj.appendChild(moreInfo);
	
	//data
	var answers=[];	//answers data
	p.container;	//container
	p.qdata;	//question data from ref
	p.current_question;	//current question
	var current_answer;	//current answer
	var faq;	//faq
	/**
	 *private
	*/
	//go to question
	function next_question(next_id,answer_id){
		if(p.qdata[next_id]){	//ready to next
			//appendText
			var textref=p.ref.current? p.ref.current.text_refdata[answer_id+'-'+next_id] : p.text_refdata[answer_id+'-'+next_id];
			p.qdata[next_id].append_text(textref);	//more info
			p.qdata[next_id].init();	//init question
			//add to gui
			p.container.appendChild(p.qdata[next_id].get());	//cover on scence
			$(p.qdata[next_id].get()).show();	//visible
			p.ref.focus_current=p.qdata[next_id];	//get focus current
		
			p.ref.previous=p;	//current question obj
			if(p.ref.current){	
				if(p.ref.current.current_question.id!== next_id.toString()){ 
					$(p.ref.current.get()).hide();
				}
			}
			if(p.current_question.id!=next_id.toString()) {
				$(obj).hide();	//hide this current question, if not go this
			}
			p.ref.current=p.qdata[next_id];	//save new current questions
			p.ref.navigation(next_id,p.qdata[next_id]);	//add to nav
		}
	}
	//load faq
	function load_faq(qid,has_faq){
		/*check opt, because this is real current question
		if(p.auto_dlg_mode){
			p.ref.show_customer_form();	//show customer dialog
		}*/
		if(p.dlg_answers_trigger && p.auto_dlg_mode){
			for(var id in p.dlg_answers_trigger){
				if(!p.dlg_type_showing || p.dlg_type_showing=='popup') {	//popup is default
					p.ref.show_customer_form();	//showing dialog as popup
				}
				else if(p.dlg_type_showing=='page') p.ref.show_customer_form(p.dlg_answers_trigger[id]);
			}
		}
		//call all answers callback when go this question
		for(var i in answers){
			if(typeof answers[i].callback=='function') answers[i].callback(answers[i].data);	//callback
		}
		if(!p.ref.faq) return;
		if(!faq && has_faq){
			p.ref.faq.innerHTML='<img src="images/loading.gif"/>';	//loading status
			faq=document.createElement('div');	//faq container
			loadAjax('ajax.php?f=vcn_load_faq&gfaq='+qid,function(r){
				if(qid==p.current_question.id){	//still on current
					var result=JSON.parse(ajax_json_result(r));	//parse json
					for(var i in result){
						faq.appendChild(faq_ui(result[i]));	//add to container
					}
					p.ref.faq.innerHTML='';	//clear container
					p.ref.faq.appendChild(faq);
				}
			});
		}
		else {
			p.ref.faq.innerHTML='';	//clear container
			if(has_faq) p.ref.faq.appendChild(faq);
		}
	}
	//create faq
	function faq_ui(data){
		var t=document.createElement('div');
		t.className='faq_item';
		var faq1=document.createElement('div');
		faq1.className='faq';
		faq1.innerHTML=data.faq;	//faq content
		t.appendChild(faq1);
		var faq_answer=document.createElement('div');	//faq answer
		faq_answer.className='faq_answer';
		faq_answer.innerHTML=data.answer;
		t.appendChild(faq_answer);
		return t;
	}
	//create answer tick
	function c_answer_tick(data){
		if(!data.answer.replace(/\s+/g,'')) return document.createTextNode('');	//empty string
		
		var obj=document.createElement('div');
		var group=document.createElement('label');	//group
		obj.appendChild(group);
		var c=document.createElement('input');	//radio
		c.type='radio';
		c.name='answer-radio';	//common name
		c.onclick=radio_click_evt;
		group.appendChild(c);
		
		var txt=document.createElement('span');	//label
		txt.innerHTML=data.answer;
		group.appendChild(txt);
		/**
		 *event
		*/
		function radio_click_evt(){
			if(current_answer){
				$(current_answer).removeClass('current_answer');	//remove current answer class
			}
			if(!p.ref.auto_next) $(p.ref.get(1).next_btn).show().css({display:''});	//show next but if auto next is turn off
			//next_question_listener(data.answer_link_question,data.answer_id);	//set next question listener
			next_question_listener(parseInt(data.link_question)? data.link_question:data.answer_link_question,[data.answer_id,data.answer,data.question]);	//purpose of adding answer content,question content to history
			$(obj).addClass('current_answer');	//set current answer by css
			current_answer=obj;	//set current answer obj
			//addition click event
			if(typeof answers[data.answer_id].click_event=='function'){
				answers[data.answer_id].click_event();
			}
			//turn auto next question
			if(p.ref.auto_next){
				setTimeout(function(){p.next_question();},200);
			}
		}
		return obj;
	}
	//next question listener
	function next_question_listener(qid,answer_id){
		set_history(answer_id)	//save work before get next
		p.ref.focus_current=p;	//get focus current
		p.next_question=function(){
			next_question(qid,(jQuery.isArray(answer_id)? answer_id[0] : answer_id));	//purpose of answer text [answer_id,'text']
		}	//define func
	}
	//set history
	function set_history(answer_id){
		p.ref.history[p.current_question.id]=answer_id? answer_id : 0;	//save work
	}
	//get real current
	function get_current(){
		return p.ref.current? p.ref.current : p;
	}
	/**
	 *event
	*/
	/**
	 *public
	*/
	//enabled default question css
	p.anable_question_css=function(opt){
		if(opt==false) $(question).removeClass('question'); else $(question).addClass('question');
	}
	//add question
	p.add_question=function(txt){
		question.innerHTML=txt;
	}
	//add answer
	p.add_answer=function(data){
		var answer=document.createElement('div');	//answer
		answer.className='answer';
		
		answers[data.answer_id]={object:answer,data:data};	//first to add answer to manager
		//decide content
		var code='';
		if(parseInt(data.answer_object_type)) code+=data.answer	//parse string to object
		else{
			answer.appendChild(c_answer_tick(data));	//content
		}
		if(parseInt(data.link_object_type)) code+=data.answer_link_question;	//more code
		//parse code
		if(code) eval($('<div/>').html(code).text());
		
		answer_container.appendChild(answer);	//add to gui
		/**
		 *private
		*/
		//show next button
		function show_next_button(){
			$(p.ref.get(1).next_btn).show().css({display:''});
		}
		//get answer data
		function answer_data(){
			return answers[data.answer_id];
		}
		//answer callback
		function answer_callback(callback){
			answers[data.answer_id].callback=callback;
		}
		//answer choose event
		function answer_picker(cb){
			answers[data.answer_id].click_event=cb;
		}
		//set question history
		function set_question_history(text){
			//p.ref.history[p.current_question.id]=[data.answer_id,(text? text :'X')];	//save work
			p.ref.history[p.current_question.id]=[data.answer_id,(text? text :'X'),data.question];	//modify to add answer content,question content to p.history
		}
		//set history result
		function set_history_result(r){
			p.ref.history.result=r;
		}
		//set text2text
		function set_text2next(next_id,text){
			p.text_refdata[data.answer_id+'-'+next_id]=text;
		}
		//append to answer
		function append(obj){
			if(typeof obj=='object' && obj.tagName) answer.appendChild(obj);
			if(typeof obj=='string') answer.innerHTML=obj;
		}
		//set customer dlg
		function dlg_opt(setups){
			if(setups.auto){	//turn auto mode use sharing mode for all answers
				p.auto_dlg_mode=1;
			}
			if(typeof setups.type=='string') p.dlg_type_showing=setups.type;
			if(!p.dlg_answers_trigger) p.dlg_answers_trigger=[];
			p.dlg_answers_trigger[data.answer_id]=answer;	//save answers for dialog trigger
			//if not dlg not in auto mode, then show button trigger
			if(!p.auto_dlg_mode){
				//append trigger button of dlg to container
				append(p.ref.get_customerfrm_but((typeof setups.button=='object' && setups.button.tagName? setups.button : '')));
			}
		}
		//get question in history
		function get_quest_history(id){
			if(p.ref.history[id]!=null){
				return p.ref.history[id];
			}
		}
	}
	//init
	p.init=function(){
		//load faq
		load_faq(p.current_question.id,parseInt(p.current_question.has_faq));
	}
	//go back
	p.back=function(qid){
		var current=p.ref.current? p.ref.current:p;	//real current question
		if(p.ref.history[current.current_question.id]!=undefined) delete p.ref.history[current.current_question.id];	//delete current question history before get back
		
		next_question(qid? qid : p.current_question.id);	//back to current. p.current_question.id
		$(obj).show();	//show this class object
	}
	//next question
	p.next_question;
	//go question
	p.go_question=function(id){
		next_question(id);
	}
	//append addition text from previous question
	p.append_text=function(str){
		if(str && typeof str=='string') {
			moreInfo.innerHTML=str;
			$(moreInfo).css({display:'inline-block'}).show();	//show more info
		}
		else $(moreInfo).hide();	//hide more info
	}
	//get data
	p.get=function(opt){
		return opt? {answers:answers} : obj;
	}
}
/**
 *@qChain class
*/
function qChain(){
	var p=this;
	//object
	var around=document.createElement('div');	//surround object
	around.className='qchain';
	//nav
	var nav=document.createElement('div');	//nav
	nav.className='navigation';
	around.appendChild(nav);
	
	var viewport=document.createElement('div');	//viewport
	viewport.className='focus-qviewport';
	around.appendChild(viewport);
	
	var dlg=document.createElement('div');	//customer form dialog
	dlg.title='Thông tin khách hàng';	//dialog title
	//$(dlg).dialog();	//build dialog
	
	p.faq;	//faq
	
	//tool
	var tool=document.createElement('div');
	tool.className='tool';
	around.appendChild(tool);
	
	var reset=c_but1('Tư vấn lại');	//default reset all
	//reset.onclick=resetall;
	$(reset).bind('click',resetall);
	tool.appendChild(reset);
	
	var prev=c_but1('Quay lại');	//default previous
	prev.onclick=back_btn_evt;
	tool.appendChild(prev);
	
	var next=c_but1('Tiếp tục');	//default next question but
	next.onclick=next_question_evt;
	$(next).hide();	//hide default
	tool.appendChild(next);
	
	//data
	var data=[];	//questions manager
	p.previous;	//previous question
	var first;	//first question
	var dbtable=[];	//work as database table
	var nav_path=[];	//navigation
	p.history=[];	//save customer history do job
	
	/**
	 *private
	*/
	//create step oval
	function c_step_status(txt,key,inst){
		var t=document.createElement('div');
		t.className='step radius-2 noSelect';
		t.innerHTML=txt;
		t.title=inst.inst.current_question.question+'-'+inst.inst.current_question.id;//.question
		/*t.onclick=function(){
			jump_step(key);
		}*/
		return t;
	}
	//step click event
	function jump_step(key){
		if(p.focus_current){ 
			splice_step(key);	//split in first
			go_question(key);	//go any question
		}
	}
	//go any question
	function go_question(qid){
		if(p.focus_current.current_question.id==qid.toString()){ p.focus_current.back(qid);}	//go itself
		else {	//jump from other
			p.focus_current.go_question(qid);//alert('go_question');
		}	
	}
	//cut navigation
	function splice_step(key){
		var meet_step=0;
		for(var i in nav_path){
			if(i==key){ meet_step=1;continue;}
			if(meet_step){	//segment after
				nav.removeChild(nav_path[i].step_but);	//remove step but
				delete nav_path[i];	//remove right segment
			}
		}
	}
	/**
	 *event
	*/
	//go back
	function back_btn_evt(){
		if(p.previous) {
			splice_step(p.previous.current_question.id);	//change navigator at first
			p.previous.back();	//go back
		}
	}
	//next question event
	function next_question_evt(){
		$(next).hide();	//hide next but
		if(p.focus_current) p.focus_current.next_question();
	}
	//reset
	function resetall(){
		if(confirm('Bạn có muốn tư vấn lại không ?')){
			jump_step(first.current_question.id);
			p.history=[];	//clear history
		}
	}
	/**
	 *public
	*/
	//nav manager
	p.navigation=function(key,inst){
		if(!nav_path[key]) nav_path[key]={inst:inst};	//new step
		nav.innerHTML='';	//reset navigator
		var count=1,last;	//index step
		
		for(var i in nav_path){
			if(nav_path[i]==undefined) continue; //ignore null
			
			nav_path[i].step_but=c_step_status(count,i,nav_path[i]);	//c step but
			nav.appendChild(nav_path[i].step_but);	//add to container
			last=nav_path[i];	//last step
			count++;
		}
		last.step_but.className='current_step radius-2';
	}
	//load data
	p.load=function(){
		viewport.innerHTML='<img src="images/loading.gif"/>';	//loading
		//load data
		loadAjax('ajax.php?f=vcn_question_data&group='+p.group,function(r){
			var result=JSON.parse(ajax_json_result(r));	//question data
			var q;	//q instance
			
			for(var i in result){
				if(!data[result[i].id]) {	//next question
					q=new vcn_question();	//instance question object
					//external
					q.qdata=data;
					q.ref=p;	//referer
					q.container=viewport;	//container
					q.current_question=result[i];	//get first row of question
					q.text_refdata=[];
					
					q.anable_question_css(parseInt(result[i].default_question_css));	//enabled default question css?
					q.add_question(result[i].question);	//add question
					
					data[result[i].id]=q;	//get into manager
				}
				if(first==undefined){ first=q;}	//first question
				if(result[i].answer_link_question.toString().match(/\d+/g)) {
					q.text_refdata[result[i].answer_id+'-'+result[i].answer_link_question]=result[i].text2next_question;	//add text ref data if answer_link_question is number
				}
				q.add_answer(result[i]);	//add answer to question
			}
			//add first question to container
			if(first) {
				first.init();	//init first question
				//add to container
				viewport.innerHTML='';
				viewport.appendChild(first.get());
				
				p.navigation(first.current_question.id,first);	//add to navigation
			}
		});
	}
	//show customer form
	p.show_customer_form=function(obj){		//obj=answer object
		//#display form in container
		if(typeof obj=='object'){
			var cont=$('<div/>');
			cont.html('<img src="images/loading.gif"/>');	//append loading gif
			$(obj).html('').append(cont);	
			$.ajax({
				url:'ajax.php?f=final_customerform',
				success:function(data){
					//dlg.innerHTML=r;
					cont.html(data);
				}
			});
		}
		else{
			//#show dialog form
			$(dlg).dialog({width:500,height:520});
			dlg.innerHTML='<img src="images/loading.gif"/>';	//loading status
			$(dlg).load('ajax.php?f=final_customerform',function(r){
				//dlg.innerHTML=r;
			});
		}
	}
	//create history button
	p.get_customerfrm_but=function(but){
		if(!but || typeof but!='object') var but=c_but1('Lưu lại');	//default but
		but.onclick=function(){
			p.show_customer_form();
		}
		return but;
	}
	//get history
	p.get_history=function(){
		var r='';
		var answers_text={};	//answer text
		var aid;	//answer id
		for(var i in p.history){
			if(p.history[i]==undefined) continue;	//ignore null
			if(jQuery.isArray(p.history[i]) ) {
				aid=p.history[i][0];	//get answer id
				answers_text[p.history[i][0]]=p.history[i][1];	//push to answer text
			}
			else {aid=p.history[i];}
			if(i!=='result') r+=i+'-'+aid+',';
		}
		return {history:r.replace(/[\s,]+$/g,''),answers_text:answers_text};
	}
	//get ui histories
	p.get_full_histories=function(){
		var r='';
		for(var i in p.history){//$('#final_customer_frm')[0].usedfor.value+='['+p.history[i]+']-';
			if(!p.history[i] || !p.history[i][2]) continue;	//ignore null
			if(jQuery.isArray(p.history[i]) ) {
				r+=p.history[i][2]+'\n';
				r+=p.history[i][1]+'\n-----------------\n';	//get answer id
			}
			//else {aid=p.history[i];}
			//if(i!=='result') r+=i+'-'+aid+',';
		}
		return r;
	}
	//get
	p.get=function(opt){
		return opt? {dbtable:dbtable,next_btn:next,prev_btn:prev,reset_btn:reset} : around;
	}
	//for buttons init
	p.init=function(opts){
		if(opts.prev_btn) {
			$(opts.prev_btn).bind('click',back_btn_evt);	//back btn
			back=opts.prev_btn;	//link to btn
		}
		if(opts.next_btn){
			$(opts.next_btn).bind('click',next_question_evt);	//next btn
			next=opts.next_btn;	//reference to btn
		}
		if(opts.reset_btn){
			$(opts.reset_btn).bind('click',resetall);	//next btn
			reset=opts.reset_btn;	//link to btn
		}
	}
}
/**
 *focus text input manager
*/
function input_manager(){
	var p=this;	//this instance
	//data
	var current_input;	//current focus input text
	/**
	 *public
	*/
	//input click event
	p.input_focus_evt=function(obj,opt){
		if(opt) {
			current_input=obj;	//going on input click event
			return;
		}
		obj.onclick=function(){	//add click input event
			current_input=this;
		}
	}
	//set string at caret
	p.set_caret_text=function(str){
		if(current_input) insertAtCaret(current_input,str);
	}
	//set input text
	p.set_text=function(str){
		if(current_input) current_input.value=str;
	}
}

/**
 *utilities
*/
//create but type form
function c_but1(txt){
	var b=document.createElement('input');
	b.className='button_silver_square radius-1 padding3';
	b.type='button';
	b.value=txt;
	return b;
}
//create image
function c_img(src){
	var img=document.createElement('img');
	img.src=src;
	return img;
}