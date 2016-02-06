<?php
define('APPNAME','vcn-');
global $conn;
global $messages;
global $config;
$messages=array();
require('helpers.php');
require('templates.php');
//set main group
config('main_questions_group','3');

//connect to mysql
function connectDB(){
    global $conn;
    if(!$conn){
        $conn=mysql_connect('localhost','root','') or die("can not connect to database");
        mysql_set_charset('utf8',$conn);
        mysql_select_db('test');
    }
    return $conn;
}
//config
function config($item,$val=''){
	global $config;
	if(!is_array($config)) $config=array();
	if(is_string($item) && !empty($val)) $config[$item]=$val;
	if(isset($config[$item])) return $config[$item];
}
//get question group
function get_current_group(){
	global $conn;
	static $result;
	if($result && $result->id!=get_session('vcn-question-group')) $result=null;	//change new group
	if(!$result){
		if(config('questions_group')) $group= config('questions_group');
		elseif(get_session('vcn-question-group')) $group=get_session('vcn-question-group');
		
		$sql='select * from vcn_question_group';
		if(isset($group)) $sql.=' where id="'.$group.'"';
		else $sql.=' where active=1';	//or get active group
		
		$rs=mysql_query($sql,$conn);
		if(mysql_num_rows($rs)) {
			$result=(object)mysql_fetch_assoc($rs);
			return $result;
		}
	}
	return $result;
}
//add/update group to questions
function save_question_group($data,$group=''){
	global $conn;
	if($group) do_update($data,array('id'=>$group),'vcn_question_group');
	else do_insert($data,'vcn_question_group');
	
}
//save current group
function save_current_group($group){
	global $conn;
	$rs=mysql_query('update vcn_question_group set active="1" where id="'.$group.'"',$conn);
	if(mysql_affected_rows()){
		mysql_query('update vcn_question_group set active="0" where id!="'.$group.'"',$conn);
	}
	//do_update(array('active'=>'1'),array('id'=>$group),'vcn_question_group');
}
//change questions group
function change_group($group_id,$active=0){
	config('questions_group',$group_id);
	if($active) save_current_group($group_id); //active group
	set_session('vcn-question-group',$group_id);
}
//get group
function get_question_group($id=''){
	global $conn;
	$sql='select * from vcn_question_group';
	if($id) $sql.=' where id="'.$id.'"';
	$rs=mysql_query($sql);
	if(mysql_num_rows($rs)){
		while($result=mysql_fetch_assoc($rs)){
			$data[]=$result;
		}
		return count($data)==1 && $id? (object)$data[0]:$data;
	}
}
//delete question group
function del_group($id){
	global $conn;
	mysql_query('delete from vcn_question_group where id="'.$id.'"',$conn);
}
//get questions answers data
function get($id='',$group=''){
	global $conn;
	$data=array();	//rows
	if(!$group){//->chỉ để 1 chế độ edit/run chọn edit vì sử dụng nhiều hàm này.
		//if(config('main_questions_group')) $group=config('main_questions_group');		//get first main group
		//else
		if(($group=get_current_group())) $group=get_current_group()->id;	//else current group in editor
	}
	//select vcn_data.*,vcn_answers.content from vcn_data inner join vcn_answers on vcn_answers.question=vcn_data.id=>inner join alternate by left join
	$sql='select vcn_data.*,vcn_answers.id as answer_id,vcn_answers.answer,vcn_answers.answer_link_question,vcn_answers.text2next_question,vcn_answers.answer_object_type,vcn_answers.link_object_type from vcn_data left join vcn_answers on vcn_data.id=vcn_answers.question';
	if($group) $sql.=' where group_id="'.$group.'"';
	
	if(is_numeric($id)) $sql.=(strpos($sql,' where ')===false?' where ':' ').' and vcn_data.id="'.$id.'"';
	$sql.=' order by id';	//order by question id
	//$sql=sql_totalresults_var($sql);	//total results
	//echo $sql;
	$rs=mysql_query($sql);
	while($result=mysql_fetch_assoc($rs)){
		$data[]=$result;
	}
	return $data;
}
//get only questions
function get_questions(){
	global $conn;
	$sql='select * from vcn_data'.(get_current_group()? ' where group_id="'.get_current_group()->id.'"':'');
	$rs=mysql_query($sql);
	return $rs;
}
//get customers
function get_customers($id,$opts=array()){
	global $conn;
	$sql='select vcn_customers.*,customer_trans.* from vcn_customers';
	//get today transaction
	$totay_trans=' left join (select max(case when post_date="'.date('Y-m-d').'" then (@i:=@i+1) else 0 end) as today_trans from vcn_customers) customer_trans on customer_trans.today_trans>=0';
	
	//add total result field
	$sql=sql_totalresults_var($sql);
	$sql.=$totay_trans;	//inner join
	
	if(is_numeric($id)){
		$sql.=(preg_match('#where(\s+|)\S#',$sql)? ' and ':' where ').'id="'.$id.'"';
	}
	if(is_array($id)){	//filter
		$filter=fields_sql($id);
		if($filter['fields_sqlCond']) $sql.=(preg_match('#where(\s+|)\S#',$sql)? ' and ':' where ').$filter['fields_sqlCond'];
	}
	$sql.=' order by post_date DESC';	//final
	if(isset($opts['limit'])) $sql.=' limit '.$opts['limit'];	//limit
	//echo '['.$sql.']';
	mysql_query('set @i:=0;');	//set variables
	return mysql_query($sql);
}
//record customer
function login_customer($data){
	global $conn;
	$now = time();	//current time
	if(!get_session('login_timeout')) set_session('login_timeout',time() + 60 * 60 * 24 * 7);
	if($now>get_session('login_timeout')) show_error('Login thất bại !');

	//exists customer ?
	$sql='select * from vcn_customers where phone="'.mysql_real_escape_string(str_replace('-','',$data['phone'])).'"';//remove sql comment
	$rs=mysql_query($sql);
	$exists=mysql_num_rows($rs);
	if($exists) {
		$customer=mysql_fetch_array($rs);	//save on session
		set_session('customerdata',(object)$customer);
		return 1;
	}	//add new customer
	return 0;
}
//update customer
function update_customer($data){
	if(!get_session('customerdata')) return;	//not login
	$user=get_session('customerdata');	//customer
	do_update($data,array('id'=>$user->id),'vcn_customers');	//update user
	foreach($data as $k=>$v){
		$user->$k=$v;	//update item
	}
	set_session('customerdata',$user);	//update customer session
}
//vacanhan faq
function vcn_faq($id=''){
	global $conn;
	$sql='select * from vcn_faq';
	//filter
	if(is_numeric($id)) $sql.=' where group_="'.$id.'"';	//filter by faq id
	if(is_array($id)){
		$id=fields_sql($id);
		if($id['fields_sqlCond']) $sql.=(strpos(' where ',$sql)!=false? ' and ':' where ').$id['fields_sqlCond'];
	}
	//echo $sql;
	$rs=mysql_query($sql);
	$data=array();
	while($result=mysql_fetch_assoc($rs)){
		$data[]=$result;
	}
	return $data;
}
//report
function vcn_report($filter=array(),$opts=array()){
	global $conn;
	$sql='select vcn_histories.*,report_trans.*,vcn_customers.fullname,vcn_customers.birth,vcn_customers.phone,vcn_customers.CMT,vcn_histories1.answer_text as result from vcn_histories inner join vcn_customers on vcn_customers.id=vcn_histories.customer_id left join vcn_histories1 on vcn_histories.id=vcn_histories1.hid and vcn_histories.result=vcn_histories1.answer_id';
	//today transaction
	$totay_trans=' left join (select max(case when post_date="'.date('Y-m-d').'" then (@i:=@i+1) else 0 end) as today_trans from vcn_histories) report_trans on report_trans.today_trans>=0';
	
	$sql=sql_totalresults_var($sql);
	$sql.=$totay_trans;	//inner join
	
	if(is_numeric($filter)){
		$sql.=(preg_match('#where(\s+|)\S#',$sql)? ' and ':' where ').'vcn_histories.id="'.$filter.'"';
	}
	if(is_array($filter)){	//filter
		$filter=fields_sql($filter);
		if($filter['fields_sqlCond']) $sql.=(preg_match('#where(\s+|)\S#',$sql)? ' and ':' where ').$filter['fields_sqlCond'];
	}
	$sql.=' order by vcn_histories.post_date DESC';	//final,vcn_histories.post_date DESC,vcn_histories.post_time DESC
	if(isset($opts['limit'])) $sql.=' limit '.$opts['limit'];
	mysql_query('set @i:=0;');
	//echo $sql;
	return mysql_query($sql);
}
//history date list
function vcn_report_date(){
	global $conn;
	$data=array();	//rows
	$rs=mysql_query('select distinct post_date from vcn_histories');
	while($result=mysql_fetch_assoc($rs)){
		$data[$result['post_date']]=$result['post_date'];
	}
	return $data;
}
//customer date list
function vcn_customer_report_date(){
	global $conn;
	$data=array();
	$rs=mysql_query('select distinct post_date from vcn_customers');
	while($result=mysql_fetch_array($rs)){
		$data[$result['post_date']]=$result['post_date'];
	}
	return $data;
}
//mananger searching
function vcn_report_search($_query,$filter=array(),$opt=true,$opt1=array()){
	$sql='SELECT vcn_histories . * , vcn_customers.fullname, vcn_customers.birth, vcn_customers.phone, vcn_customers.CMT FROM vcn_histories INNER JOIN vcn_customers ON vcn_customers.id = vcn_histories.customer_id where';
	$opt1['sql']=$sql;
	$opt1['table']='vcn_customers';	//table name
	return search1($_query,$filter,$opt,$opt1);
}
//customer search
function vcn_customers_search($_query,$filter=array(),$opt=true,$opt1=array()){
	$sql='select vcn_customers.* from vcn_customers where';
	$opt1['sql']=$sql;
	$opt1['table']='vcn_customers';	//table name
	return search1($_query,$filter,$opt,$opt1);
}
//vcn get history
function get_history($history_id,$history_tag){	//history tag such as 1-1,2-0,4-9
	global $conn;
	$qid=array();	//questions id
	$aid=array();	//answers id
	$t=explode(',',$history_tag);
	foreach($t as $v){
		$s=explode('-',$v);
		if(count($s)<2) show_error('Lịch sử có lỗi.');
		$qid[]=$s[0];
		$aid[]=$s[1];
	}
	
	$sql='select vcn_data.*,vcn_answers.id as answer_id,vcn_answers.answer,vcn_histories1.answer_text  from vcn_data inner join vcn_answers on vcn_data.id=vcn_answers.question left join vcn_histories1 on vcn_histories1.hid="'.$history_id.'" and vcn_answers.id=vcn_histories1.answer_id where vcn_data.id in ('.join($qid,',').') and vcn_answers.id in ('.join($aid,',').') group by id';
	//echo $sql;
	return mysql_query($sql);
}
//delete history
function del_history($id){
	global $conn;
	$rs=mysql_query('select id,result from vcn_histories where id="'.$id.'"');
	if(!mysql_num_rows($rs)) {
		push_messages('Không tìm thấy history này (Delete task).');
		return;	//not found this history
	}
	$result=mysql_fetch_array($rs);	//history data
	
	mysql_query('delete from vcn_histories where id="'.$id.'"');	//delete history branch1
	mysql_query('delete from vcn_histories1 where hid="'.$id.'" and answer_id="'.$result['result'].'"');	//delete history branch2
}
//vcn admin login
function vcn_is_admin(){
	if(get_session('customerdata') && get_session('customerdata')->phone=='huyhoang1990') return true;
}
function get_authorize_access_data(){
	if(!vcn_is_admin() && in_array(sub_mod(),array('nhap-cau-hoi','faq','admincp','nhap-tin-tuc'))) {
		//show_error('Bạn không có quyền truy cập');
		header('Location:'.('customer/dang-nhap'));
	}
}
/*news */
//get news
function get_news($id='',$opts=array()){
	global $conn;
	$where='';	//filter
	if(is_numeric($id)) $where.=(preg_match('#where#',$where)? ' and ':' where ').'id="'.$id.'"';
	if(is_array($id)){
		$filter=fields_sql($id);
		if($filter['fields_sqlCond']) $where.=(preg_match('#where#',$where)? ' and ':' where ').$filter['fields_sqlCond'];
	}
	$sql='select vcn_news.*,(case when DATEDIFF(DATE_FORMAT(NOW(),"%Y-%m-%d"),post_time)<5 then "*" else "" end) as is_new from vcn_news '.$where;
	if(isset($opts['order'])) $sql.=' order by '.$opts['order'];else $sql.=' order by id DESC';
	if(isset($opts['limit'])) $sql.=' limit '.$opts['limit'];
	$sql=sql_totalresults_var($sql);//echo $sql;
	return mysql_query($sql);
}
//delete multi-choice
function delete_qdata($id){
    global $conn;//echo 'delete from vcn_data where id="'.$id.'"';
    mysql_query('delete from vcn_data where id="'.$id.'"');    //delete question
    mysql_query('delete from vcn_answers where question="'.$id.'"');    //delete answers for question
}
function delete_faq($id){
    global $conn;
    mysql_query('delete from vcn_faq where group_="'.$id.'"');
}
function search1($_query,$filter=array(),$opt=true,$opt1=array()){
	global $conn;
	//get bind
	$bind=isset($opt1['bind'])? $opt1['bind'] : 'AND';
	$where=search($_query,
		array(
			'field_alias'=>array('desc'=>'description'),
			'table_fields'=>array(),
			'filter'=>$filter,
			'bind'=>$bind
		)
		);
	$sql=isset($opt1['sql'])? $opt1['sql'] : show_error('Miss params','Miss "sql" key in $opt1 params of search1 function');
	//table to look up
	$table=isset($opt1['table'])? $opt1['table'] : show_error('Miss params','Miss "table" key in $opt1 params of search1 function');
	if($where[0]) $sql.=(preg_match('#where(\s+|)\S#',$sql)? ' AND ':' ').'('.$where[0].')';
	if($where[1]['fields_sqlCond']) $sql.=(preg_match('#where(\s+|)\S#',$sql)? ' AND ':' ').$where[1]['fields_sqlCond'];
	//valid sql
	if(preg_match('#where(\s+|)$#',$sql)) $sql=preg_replace('#where(\s+|)$#','',$sql);
	
	if(isset($opt1['order'])) $sql.=' order by '.$opt1['order'];	//order by
	if(isset($opt1['limit'])) $sql.=' limit '.$opt1['limit'];	//limit
	$sql=sql_totalresults_var($sql);	//complete sql
	//echo $sql;
	if($opt==true){
		$rs=mysql_query($sql);
		return $rs;	//return resource
	}
	else return $sql;
}

/*########################################################
 * messages
*/
//show messages
function show_messages()
{
    global $messages;
    if(!count($messages)) return '';    //no any messages
    echo '<div class="module-message">';
    echo '<ul>';
    foreach($messages as $message) echo '<li>'.$message.'</li>';
    echo '</ul>';
    echo '</div>';
}
//push messages
function push_messages($message)
{
    global $messages;
    $messages=array_merge((array)$message,$messages);    //merge messages
}

//connect database
connectDB();
?>