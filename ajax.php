<?php
require('include/functions.php');
/**
* get questions
*/
function vcn_question_data(){    //cmd/vcn_question_data.html
    $q=get(null,$_GET['group']);
   //json_output(html_entity_decode(json_encode($q)));
   foreach($q as &$r){
		$r['question']=str_replace('&quot;','"',$r['question']);
   }
   //$q=htmlspecialchars(json_encode($q), ENT_QUOTES, 'UTF-8');
	json_output(html_entity_decode(json_encode($q)));
}
/**
* load faq
*/
function vcn_load_faq(){    //cmd/vcn_load_faq.html
    $faq=vcn_faq(array('group_'=>$_GET['gfaq']));    //get faq
    json_output(json_encode($faq));
}
/**
* show customer form
*/
function final_customerform(){    //cmd/final_customerform.html
    final_customer_form();    //get form
}
//save customer info & their history
function save_customerwork(){    //cmd/save_customerwork.html
    $customerdata=get_session('customerdata');    //customer data
    if(!$customerdata) {    //not login
        json_output('requireLogin');
        return '';
    }
    //history
    preg_match('#[^-]+$#',$_POST['history'],$r);    //final result
    $history=array(
        'customer_id'=>$customerdata->id,
        'company'=>$_POST['company'],
        'salary'=>$_POST['sal'],
        'save_history'=>$_POST['history'],
        'result'=>$r[0],
        'post_date'=>date("Y-m-d"),
        'post_time'=>date('H:i:s a'),
        'loan'=>preg_replace('#\.#','',$_POST['loan']),
        'note'=>'Mục đích sử dụng:'.PHP_EOL.$_POST['usedfor'].PHP_EOL.',Thời gian chúng tôi liên hệ:'.$_POST['contacttime']
    );
    if(isset($_POST['modify'])){    //update history
        do_update($history,array('id'=>$_POST['modify']),'vcn_histories');
        $hid=$_POST['modify'];
    }
    else {
        do_insert($history,'vcn_histories');
        $hid=mysql_insert_id();    //history id
    }
    //update histories1 that save answer text
    $history_text=array();    //multi rows
    $historyt=json_decode($_POST['historyt']);    //decode answers_text
    foreach($historyt as $answer_id=>$text){
        $history_t=array('answer_id'=>$answer_id,'answer_text'=>$text,'hid'=>$hid);
        $history_text[]=$history_t;
        if(isset($_POST['modify'])){    //update single  answer text
            do_update($history_t,array('hid'=>$_POST['modify']),'vcn_histories1');
        }
    }
    if(!isset($_POST['modify'])){
        do_insert($history_text,'vcn_histories1');
    }
    
    json_output($hid);    //return new history
}
//load news
function vcn_load_news(){    //cmd/vcn_load_news.html
    ?>
    <ul class='list-news'>
    <?php
    $news=get_news(array('status'=>'1','type_'=>array('operator'=>'!=','value'=>'alert-news')),array('limit'=>'5'));var_dump($news);
    while($result=mysql_fetch_array($news)){
        ?>
        <li><?php if($result['is_new']){?><img src='http://www.vietcombank.com.vn/images/icons/new.gif'/><?php }?><a target='_blank' href='<?php //echo vcn_Url('view-news',$result)?>'><?php echo $result['title']?></a> - <font color='#808080'><i><?php echo $result['post_time']?></i></font></li>
        <?php
    }
    ?>
    </ul>
    <?php
}
//delete multichoice
function delete_question($id){    //cmd/delete_question/1.html
    //if(!vcn_is_admin()) return;    //only for admin
    delete_qdata($id);
}
/*delete faq
function delete_faq($id){    //cmd/delete_faq/1.html
    //if(!vcn_is_admin()) return;    //for admin
    delete_faq($id);
}*/
#start
$method=isset($_GET['f'])? $_GET['f']:'';
unset($_GET['f']);
if($method && function_exists($method)) call_user_func($method,$_GET);
?>