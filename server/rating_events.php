<?php
session_start();
$account_id=$_GET["account_id"];
$sql="SELECT * FROM rating_events WHERE account_id = '" . $account_id . "' ";
require ("system/dbConn.php");
$con=connect();
$rs=mysqli_query($con,$sql);

if (mysqli_num_rows($rs)){
    $row=mysqli_fetch_array($rs);
    echo  json_encode($row);
} else {
    echo "ERROR";
}
?>

