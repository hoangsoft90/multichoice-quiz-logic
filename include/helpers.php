<?php
//make str inline
function str_inline($str){return preg_replace("#(\n\r|\n|\r)+#","",$str);}
//json output
function json_output($json,$tag='data'){
    header('content-type:text');
    echo '<'.$tag.'>'.$json.'</'.$tag.'>';
}
/**
* get session data
* 
* @param mixed $name
* @return mixed
*/
function get_session($name){
    if(isset($_SESSION[APPNAME.$name])) {
        return $_SESSION[APPNAME.$name];
    }
}
//set session
function set_session($name,$value){
    $_SESSION[APPNAME.$name]=$value;
}
//del session
function del_session($name){
    if(isset($_SESSION[APPNAME.$name])) unset($_SESSION[APPNAME.$name]);    //destroy session
}
/*--------------------------------database-------------------------------------*/
//update
function do_update($new_data,$old_data,$table,$opt=false)
{
    global $conn;
    $sqls1=fields_sql($new_data);    //filter fields for new data
    $sqls2=fields_sql($old_data);    //filter fields for old data
    //do update
    $sql='UPDATE '.$table.' SET '.$sqls1['fields_sqlUpdate'].' WHERE '.$sqls2['fields_sqlCond'];
	//_print($sql);echo '<hr/>';
    $q= mysql_query($sql,$conn);
    
    if($q && $opt==true){
        $updatefields=array_merge($old_data,$new_data);    //return recent updated
        $updatefields=fields_sql($updatefields);    //convert array data to sql query
        
        return mysql_fetch_array(mysql_query('select * from '.$table.' where '.$updatefields['fields_sqlCond'],$conn));    //return recent record
    }
    return $q; //default return result of sql query
}
//delete rows
function do_delete($where,$table,$used_field=''){    //default used field
    global $conn;
    $sqls=fields_sql($where,$used_field);    //filter fields for new data
    return mysql_query('delete from '.$table.' where '.$sqls['fields_sqlOR'],$conn);    //return result of query
}
//do sql
function sql_query($sql){
    global $conn;
    return mysql_query($sql,$conn) or error_log(mysql_error(),3,'/cache/log.txt');    //don't show mysql_error() this will expose to hacker
}
//valid value
function valid_value($value){
    //$value=preg_replace('#([\w]+)(")#','$1/$2',$value);
    $value=preg_replace('#\\{1,}#','\\',$value);
    return $value;
}
//fields sql
function fields_sql($fields,$default_field='',$opts=array())
{
    if(!is_array($fields)) $fields=array();    //valid
    
    $fields_sql2insert="";    //prep string of fields & values
    $fields_sqlUpdate="";    //prep sql of update statement
    $fields_sqlCond="";    //prep string of sql condition of fields
    $_fields="";    //prep string of fields that separate by comas
    $fields_sqlOR="";    //sql of OR condition to get more records
    
    foreach($fields as $field=>$value)
    {
        if(is_numeric($field)) $field=$default_field;    //get default field for all value
        $_fields.=$field.',';    //list fields
        //detect of operator
        $operator='=';    //default equal operator
        
        if(is_string($value)){
            $value=str_replace('"','\"',$value);
            $value='"'.mysql_real_escape_string(valid_value($value)).'"';	//mysql_real_escape_string
        }
        if(is_array($value)){    //final entrust for array
            if(isset($value['operator'])) $operator=$value['operator'];
            if(isset($value['value'])) $value='"'.mysql_real_escape_string(valid_value($value['value'])).'"';
        }
        $fields_sqlUpdate.=$field.' '.$operator.' '.$value.',';        //set sql of update, alway sensitive
        $fields_sql2insert.=$value.',';    //prep sql of insert,trim($value,'"')
        
        if(isset($opts['sensitive']) && $opts['sensitive']==false) {
            $field='LCASE('.$field.')';
            $value=strtolower($value);
        }
        $fields_sqlCond.=$field.' '.$operator.' '.($value).' AND ';        //set sql of fields condition
        $fields_sqlOR.=$field.' '.$operator.' '.($value).' OR ';    //sql of OR condition
    }
    
    return array(
        'fields'=>substr($_fields,0,strlen($_fields)-1),    //pure
        'fields_sql2insert'=>substr($fields_sql2insert,0,strlen($fields_sql2insert)-1),    //pure
        'fields_sqlUpdate'=>substr($fields_sqlUpdate,0,strlen($fields_sqlUpdate)-1),    //pure
        'fields_sqlCond'=>substr($fields_sqlCond,0,strlen($fields_sqlCond)-5),    //pure
        'fields_sqlOR'=>substr($fields_sqlOR,0,strlen($fields_sqlOR)-4)    //pure
    );
}
//insert
function do_insert($data,$table,$opt=false)
{
    global $conn;
    $fields='';    //fields
    $rows2insert='';    //fields to insert
    $fields_sqlCond='';    //where
    if(!is_array(reset($data))) $data=array($data);    //aschronize to multi rows 
    foreach($data as $row){
        $sqls=fields_sql($row);    //filter fields into sql data
        if(!$fields) $fields=$sqls['fields'];    //get fields
        if(!$fields_sqlCond) $fields_sqlCond=$sqls['fields_sqlCond'];
        $rows2insert.='('.$sqls['fields_sql2insert'].'),';    //multi rows
    }
    $rows2insert=substr($rows2insert,0,strlen($rows2insert)-1);    //pure
    
    $query_insert='INSERT INTO '.$table.'('.$fields.') VALUES'.$rows2insert;//var_dump( $query_insert);
    $rs=mysql_query($query_insert,$conn);
    if($opt==true)
    {
        $recent_post=mysql_query('SELECT * FROM '.$table.' WHERE '.$fields_sqlCond,$conn);    //get recent user that registry
        return mysql_fetch_array($recent_post);    //return this user
    }
    return $rs;
}
//set total results into sql
function sql_totalresults_var($sql){
    $new_sql=preg_replace('#limit[\s\d,]+|(order|ORDER)\s+(by|BY)\s+\w+\s+(desc|DESC|asc|ASC)#','',$sql);    //remove limit & order
    $total='('.preg_replace('#(?<=^select|SELECT)(.+?)(?=from|FROM)#',' count(*) ',$new_sql).') as total_results';    //count results
    return preg_replace('#(?<=select|SELECT)(\s+)#',' '.$total.', ',$sql);
}
//limit string
function limit($str,$n=50)
{
    if(is_string($str))
    {
        return (strlen($str)>$n)? mb_substr($str,0,$n,'UTF-8').'..' : $str;
    }
}
//string to json
function str2json($str){
    $s= preg_replace('#(?<=:)(.+?)(?=,)#','"$1"',$str);    //for value
    $s=preg_replace('#(?<=,)(.+?)(?=:)#','"$1"',$s);    //for key
    $s=preg_replace('/^(\s+|)([^,]+?)(?=:)/','"$2"',$s);    //fix begin key
    $s=preg_replace('#(?<=,)([^:]+?)(?=,)#','"$1"',$s);//for no key at center
    $s=preg_replace('#^(\s+|)([^:]+?)(?=,)#','"$2"',$s);    //for no key at begin
    $s=preg_replace('#([^:,]+$)#','"$1"',$s);    //for no key at end
    
    $s=trim($s,',');    //trim
    $s=preg_replace('#[\n\r|\n|\r|\s]+#','',$s);    //valid json
    return (array)json_decode('{'.$s.'}');
}
//object to array
function objectToArray($d) {
    if (is_object($d)) {
        // Gets the properties of the given object
        // with get_object_vars function
        $d = get_object_vars($d);
    }

    if (is_array($d)) {
        /*
        * Return array converted to object
        * Using __FUNCTION__ (Magic constant)
        * for recursive call
        */
        return array_map(__FUNCTION__, $d);
    }
    else {
        // Return array
        return $d;
    }
}
//$_GET
function _GET($key){
    $t=isset($_GET[$key])? htmlspecialchars($_GET[$key]) : '';//htmlentities($clean['name'], ENT_QUOTES, 'UTF-8');
	$t=str_replace("\'","'",$t);
	$t=str_replace('\"','"',$t);	
	$t=str_replace('\&quot;','"',$t);
	return $t;
}
//$_POST
function _POST($key){
    $t=isset($_POST[$key])? htmlspecialchars($_POST[$key]) : '';//htmlentities($clean['name'], ENT_QUOTES, 'UTF-8');
	$t=str_replace("\'","'",$t);
	$t=str_replace('\"','"',$t);
	$t=str_replace('\&quot;','"',$t);
	return $t;
}
//get number items on page
function get_num_on_page($default=10){
    if(isset($_GET['count'])) $num=$_GET['count'];
    if(isset($_POST['count'])) $num=$_POST['count'];
    if(!isset($num) || !$num) $num=$default;    //default
    return $num;
}
//valid page
function get_page_segment($total_pages=null,$opt=false){
    //valid page
    if(isset($_GET['page'])) $page=$_GET['page'];
    if(isset($_POST['page']) && $_POST['page']!='') $page=$_POST['page'];
    if(!isset($page)) $page=$opt? 1 :0;    //page start from 0 || 1
    if(is_numeric($total_pages) && $page>$total_pages) $page=$total_pages;
    return $page;
}
//get total pages
function total_pages($total,$num){
    $remain=$total%$num;
    return ($total-$remain)/$num+($remain>0? 1 : 0);
}
//get page by item index
function get_page_byItemIndex($totalpages,$num,$index){    //index start at 1
    for($i=1;$i<=$totalpages;$i++){
        if($i*$num == $index) return i-1;    //assume segment start from 0
        if($i*$num>$index) 
        {
            return i-1;    //segment start from 0
        }
    }
}
//valid json
function valid_js_json($data){
	if(is_array($data)) $data=json_encode($data,JSON_UNESCAPED_UNICODE);
	return rawurldecode(html_entity_decode($data));
}
//get current page
function get_current_page() {

    $pageURL = (@$_SERVER["HTTPS"] == "on") ? "https://" : "http://";
    if ($_SERVER["SERVER_PORT"] != "80")
    {
        $pageURL .= $_SERVER["SERVER_NAME"].":".$_SERVER["SERVER_PORT"].$_SERVER["REQUEST_URI"];
    } 
    else 
    {
        $pageURL .= $_SERVER["SERVER_NAME"].$_SERVER["REQUEST_URI"];
    }
    return strtok($pageURL,'?');		//to remove URI (querystring)
}
?>
