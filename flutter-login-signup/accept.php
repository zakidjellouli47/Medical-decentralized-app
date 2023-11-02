<?php
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
 header("Access-Control-Allow-Origin: *");
    include('functions.php');
    
    $id = isset($_GET['email']);
    $query = "select * from `requests` where `email` = '$id'; ";
    if(count(fetchAll($query)) > 0){
        foreach(fetchAll($query) as $row){
            $firstname = $row['firstname'];
            $lastname = $row['lastname'];
            $age = $row['age'];
            $role =$row['role'];
            $email = $row['email'];
            $password = $row['pass'];

            $query = "INSERT INTO `users` (`UID`, `firstname`, `lastname`, `age`, `role`, `email`,`pass`) VALUES (NULL, '$firstname', '$lastname', '$age', 'patient','$email', '$password');";
        }
        $query .= "DELETE FROM `requests` WHERE `requests`.`UID` = '$id';";
        if(performQuery($query)){
            $result['acceptStatus']=true;
            echo "Account has been accepted.";
        }else{
            echo "Unknown error occured. Please try again.";
        }
    }else{
        echo "Error occured.";
    }
    
?>
