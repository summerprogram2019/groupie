<?php
session_start();
$activity_id=$_GET["activity_id"];
$sql="SELECT * FROM participations WHERE activity_id = '" . $activity_id . "' ";
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

