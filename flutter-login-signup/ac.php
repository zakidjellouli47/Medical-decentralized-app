<?php
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
header("Access-Control-Allow-Origin: *");
    include("dbcon.php");

   if(isset($_POST["UID"])){
    $id = $_POST["UID"];
   }
    else return;

    $query = "DELETE FROM `requests` WHERE  UID  ='$id' ";

    $exe = mysqli_query($conn, $query);

    $arr = [];

    
    if($exe){

        $arr["success"] = "true";
    }
    else{

        $arr["success"] = "false";
    }

    print(json_encode($arr));
?>
