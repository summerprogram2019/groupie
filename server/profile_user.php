<?php
session_start();
$account_id=$_GET["account_id"];
$sql="SELECT * FROM profile_user WHERE account_id = '" . $account_id . "' ";
require ("system/dbConn.php");
$con=connect();
$rs=mysqli_query($con,$sql);

if (mysqli_num_rows($rs)){
    $row=mysqli_fetch_object($rs);
    echo  json_encode($row);
} else {
    echo "ERROR";
}
?>

