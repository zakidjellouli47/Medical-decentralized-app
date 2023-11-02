<?php
 
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "hospital";
    $table = "users"; // lets create a table named Employees.
 
    // we will get actions from the app to do operations in the database...
    if(isset($_POST["action"])){
        
    $action = ($_POST["action"]);
    
    // Create Connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check Connection
    if($conn->connect_error){
        die("Connection Failed: " . $conn->connect_error);
        return;
    }

    if("UPDATE_EMP" == $action){
        // App will be posting these values to this server
        $emp_id = $_POST['UID'];
        $firstname = $_POST["firstname"];
        $lastname = $_POST["lastname"];
        $age = $_POST["lastname"];
        $role = $_POST["role"];
        $email = $_POST["email"];
        $pass = $_POST["pass"];
        $ethereumAddress = $_POST["ethereumAddress"];
        $sql = "UPDATE $table SET firstname = '$firstname', lastname = '$lastname', age = '$age', role = '$role', email = '$email', pass = '$pass', ethereumAddress = '$ethereumAddress' WHERE UID = $emp_id";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        
        $conn->close();
        return;
    }
}
    }
    ?>
 