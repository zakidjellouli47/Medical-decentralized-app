<?php

 header("Access-Control-Allow-Origin: *");
    include('functions.php');
    
    if(isset($_POST["id"])){
        $id = $_POST["id"];
       }
        else return;
    
    $query = "select * from `requested_appointements` where  id  ='$id' ; ";
    if(count(fetchAll($query)) > 0){
        foreach(fetchAll($query) as $row){
            $firstname = $row['firstname'];
            $lastname = $row['lastname'];
            $age = $row['age'];
            $email = $row['email'];
            $description = $row['ilness_description'];
            $date = $row['date'];
            $doctors = $row['doctors'];

            $query = "INSERT INTO `approved_appointments` (`id`, `firstname`, `lastname`, `age`, `email`, `ilness_description`,`date`,`doctors`) VALUES (NULL, '$firstname', '$lastname', '$age','$email', '$description','$date','$doctors');";
        }
        $query .= "DELETE FROM `requested_appointements` WHERE `requested_appointements`.`id` = '$id';";
        $arr = [];
        if(performQuery($query)){
            $arr["success"] = "true";
            echo "Account has been accepted.";
        }else{
            $arr["success"] = "false";
            echo "Unknown error occured. Please try again.";
        }
    }else{
        echo "Error occured.";
    }
    print(json_encode($arr));
    
?>
