<?php
session_start();
$picture_id=$_GET["id"];
$sql="SELECT image FROM pictures WHERE picture_id = '" . $picture_id . "' ";
require ("system/dbConn.php");
$con=connect();
$rs=mysqli_query($con,$sql);

if (mysqli_num_rows($rs)){
    $row=mysqli_fetch_object($rs);
    echo  json_encode($row);
} else {
    echo "ERROR No profile picture found";
}
?>

