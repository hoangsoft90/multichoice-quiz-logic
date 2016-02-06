<html>
<head>
    <title>Question group input</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="js/myjs.js"></script>
    <script src="js/jquery-1.5.2.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <link rel="stylesheet" type="text/css" href="css/style1.css">
</head>
<body>
<div id='vcn_wrap'>
    <div id="header"><h1>Vaycanhan.com</h1></div>
    <div class="main-left1">
<?php
include('include/functions.php');
?>
<?php
if(isset($_POST['submit_group'])){  //submit group
    $post=array(
        'group_title'=>($_POST['group_title']),
        'group_desc'=>($_POST['group_desc']),
        'group_image'=>$_POST['group_img'],
        'active'=>isset($_POST['active'])? '1':'0'
    );
    if(isset($_POST['group']) && $_POST['group']){ //update group
        save_question_group($post,$_POST['group']);
        push_messages('updated group with id='.$_POST['group']);
    }
    else{   //add new group
        save_question_group($post);
        push_messages('Added new group !');
    }
    
}
if(isset($_GET['del'])){    //del group
    del_group($_GET['del']);
}
if(isset($_GET['group'])){  //edit group
    $edit_group=get_question_group($_GET['group']);
    if(!$edit_group) show_error('Not Found Group','Khong tim thay group id='.$_GET['group']);
}
//message
show_messages();
?>
<h2>Question Group</h2>
<form method="post" action="group.php" accept-charset="utf-8">
<input type="hidden" name="group" value="<?php echo isset($edit_group)? $edit_group->id:''?>"/>
<table>
    <tr>
        <td>Group Title</td>
        <td><input type="text" name="group_title" value="<?php echo isset($edit_group)? $edit_group->group_title:''?>"/></td>
    </tr>
    <tr>
        <td>Group Description</td>
        <td><textarea cols="40" rows="6" name="group_desc"><?php echo isset($edit_group)? $edit_group->group_desc:''?></textarea></td>
    </tr>
    <tr>
        <td>Group Image</td>
        <td><input type="text" name="group_img" value="<?php echo isset($edit_group)? $edit_group->group_image:''?>"/></td>
    </tr>
    <tr>
        <td>Active</td>
        <td><input type="checkbox" name="active" <?php echo isset($edit_group) && $edit_group->active? 'checked="checked"':''?>/></td>
    </tr>
    <tr>
        <td></td>
        <td><input type="submit" name="submit_group" value="Save"/></td>
    </tr>
</table>
</form>
    </div>
    <div class="right">
    <div id="question_group_box" class="">
<?php
    $groups=get_question_group();
    foreach($groups as $g){
        $current=(isset($_GET['group']) && isset($edit_group) && $_GET['group']==$edit_group->id);
        vcn_group_item($g,$current);
    }
?>    
    </div>
    </div>
</div>
</body>
</html>