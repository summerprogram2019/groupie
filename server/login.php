<?php
session_start();
$email=$_POST["email"];
$password=$_POST["password"];
$hashed_password = md5($password);
  $sql="SELECT * FROM account_user WHERE email = '" . $email . "' AND password = '".$hashed_password."'";
  require ("system/dbConn.php");
  $con=connect();
    $rs=mysqli_query($con,$sql);
if (mysqli_num_rows($rs)){
$row=mysqli_fetch_array($rs);
echo $row['account_id'];
} else {
  echo "ERROR: account doesn't exist or password doesn't match";
}
?>

