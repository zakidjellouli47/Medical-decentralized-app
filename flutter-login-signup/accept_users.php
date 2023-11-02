<?php

 header("Access-Control-Allow-Origin: *");
    include('functions.php');
    
    if(isset($_POST["UID"])){
        $id = $_POST["UID"];
       }
        else return;
    
    $query = "select * from `requests` where  UID  ='$id' ; ";
    if(count(fetchAll($query)) > 0){
        foreach(fetchAll($query) as $row){
            $firstname = $row['firstname'];
            $lastname = $row['lastname'];
            $age = $row['age'];
            $role =$row['role'];
            $email = $row['email'];
            $password = $row['pass'];
            $ethereumAddress= $row['ethereumAddress'];

            $query = "INSERT INTO `users` (`UID`, `firstname`, `lastname`, `age`, `role`, `email`,`pass`,`ethereumAddress`) VALUES (NULL, '$firstname','$lastname', '$age', '$role','$email','$password','$ethereumAddress');";
        }
        $query .= "DELETE FROM `requests` WHERE `requests`.`UID` = '$id';";
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
