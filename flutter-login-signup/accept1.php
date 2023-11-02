<?php
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
header("Access-Control-Allow-Origin: *");
    include('dbcon.php');
    
    
  if(isset($_POST["UID"])){
 $id = $_POST["UID"];
}
 else return;

    $result = mysqli_query($conn, "SELECT * FROM requests  WHERE UID ='$id' ; ");
    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
    if(count(($rows)) > 0){
        foreach(($rows) as $row){
            $id = $row['UID'];
            $firstname = $row['firstname'];
            $lastname = $row['lastname'];
            $age = $row['age'];
            $role = $row['role'];

            $email = $row['email'];
            $pass = $row['pass'];
            $query = "INSERT INTO `users` (`UID`, `firstname`,`lastname`,`age`, `role`,`email`,`pass`) VALUES (NULL, '$firstname', '$lastname', '$age', 'patient', '$email','$pass');";
        }
       
        if(mysqli_query($conn,$query)){
            echo "Account has been accepted.";
        }else{
            echo("Error description: " );
        }
    }else{
        echo "Error occured.";
    }
    
?>
