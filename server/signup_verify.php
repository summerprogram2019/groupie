<?php
session_start();
$email=$_POST["email"];
require ("system/dbConn.php");
$con=connect();
$sql="select * from account_user where email='$email'";
$res=mysqli_query($con,$sql);
if(mysqli_num_rows($res)){
    echo "ERROR Account with the email '$email' already exists";
    exit;
}
