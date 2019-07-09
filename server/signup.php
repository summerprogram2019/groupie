<?php
session_start();
$email=$_POST["email"];
$password=$_POST["password"];
$verified=0;
$creation_time=date('Y-m-d H:i:s');
require ("system/dbConn.php");
$con=connect();
$sql="select * from account_user where email='$email'";
$res=mysqli_query($con,$sql);
if(mysqli_num_rows($res)){
    echo "ERROR Account with the email '$email' already exists";
    exit;
}
$sql1="insert into account_user(email, password, verified, creation_time) values('$email','".md5($password)."','$verified','$creation_time')";
//echo $sql1;
if (mysqli_query($con, $sql1)) {
    $res = mysqli_query($con, $sql);
    if (mysqli_num_rows($res)) {
    	$row=mysqli_fetch_array($res);
	echo $row['account_id'];
    } else {
	echo "ERROR Something went wrong, unable to find user";
    }
} else {
    echo "ERROR " . $sql1 . "<br/>" .  mysqli_error($con);
}
?>

