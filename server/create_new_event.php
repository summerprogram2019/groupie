<?php
session_start();

$activity_id = $_POST["activity_id"];
$initiator_id = $_POST["initiator_id"];
$name = $_POST["name"];
$activity_name = $_POST["activity_name"];
$location = $_POST["location"];
$description = $_POST["description"];
$start_time = $_POST["start_time"];
$finish_time = $_POST["finish_time"];
$picture_id = $_POST["picture_id"];
$minimum_age = $_POST["minimum_age"];
$maximum_age = $_POST["maximum_age"];
$minimum_participants_number = $_POST["minimum_participants_number"];
$maximum_participants_number = $_POST["maximum_participants_number"];
$price = $_POST["price"];
$verified = 1;
$creation_time = date('Y-m-d H:i:s');
require("system/dbConn.php");
$con = connect();
$sql = "select * from events where name='$name'";
$res = mysqli_query($con, $sql);
if (mysqli_num_rows($res)) {
    echo "ERROR Event with the name '$name' already exists";
    exit;
}

$sql1 = "insert into events(activity_id, initiator_id, \name, activity_name, location, description, start_time, finish_time, picture_id, minimum_age, maximum_age, minimum_participants_number, maximum_participants_number, price, verified, creation_time)
values('$activity_id','$initiator_id','$name','$activity_name','$location','$description','$start_time','$finish_time','$picture_id','$minimum_age','$maximum_age','$minimum_participants_number','$maximum_participants_number','$price','$verified','$creation_time')";

if (mysqli_query($con, $sql1)) {
    $res = mysqli_query($con, $sql);
    if (mysqli_num_rows($res)) {
        $row = mysqli_fetch_array($res);
        echo $row['event_id'];
    } else {
        echo "ERROR Something went wrong, unable to find event";
    }
} else {
    echo "ERROR " . $sql1 . "<br/>" . mysqli_error($con);
}
?>

