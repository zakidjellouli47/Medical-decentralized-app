<?php

 header("Access-Control-Allow-Origin: *");
    include('functions.php');
    
    if(isset($_POST["UID"])){
        $id = $_POST["UID"];
       }
        else return;
    
    $query = "select * from `requested_appointements` where  UID  ='$id' ; ";
    if(count(fetchAll($query)) > 0){
        foreach(fetchAll($query) as $row){
            $firstname = $row['firstname'];
            $lastname = $row['lastname'];
            $age = $row['age'];
            $email = $row['email'];
            $ilnessdescription = $row['ilnessdescription'];
            $date= $row['date'];
            $doctors= $row['doctors'];


            $query = "INSERT INTO `approved_appointments` (`UID`, `firstname`, `lastname`, `age`,  `email`,`ilnessdescription`,`date`,`doctors`) VALUES (NULL, '$firstname','$lastname', '$age','$email','$ilnessdescription','$date','$doctors');";
        }
        
        $arr = [];
        if(performQuery($query)){
            $arr["success"] = "true";
            echo "Appointement has been accepted.";
        }else{
            $arr["success"] = "false";
            echo "Unknown error occured. Please try again.";
        }
    }else{
        echo "Error occured.";
    }
    print(json_encode($arr));
    
?>
