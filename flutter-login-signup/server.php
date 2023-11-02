<?php
 
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "hospital";
    $table = "users"; // lets create a table named Employees.
 
    // we will get actions from the app to do operations in the database...
    $action = isset($_POST["action"]);
     
    // Create Connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check Connection
    if($conn->connect_error){
        die("Connection Failed: " . $conn->connect_error);
        return;
    }
 
    // If connection is OK...
 
    // If the app sends an action to create the table...
    if("CREATE_TABLE" == $action){
        $sql = "CREATE TABLE IF NOT EXISTS $table ( 
            UID INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            firstname VARCHAR(45) NOT NULL,
            lastname VARCHAR(45) NOT NULL,
            age VARCHAR(45) NOT NULL,
            role VARCHAR(45) NOT NULL,
            email VARCHAR(45) NOT NULL,
            pass VARCHAR(45) NOT NULL,

            )";
 
        if($conn->query($sql) === TRUE){
            // send back success message
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
 
    // Get all employee records from the database
    if("GET_ALL" == $action){
        $db_data = array();
        $sql = "SELECT UID, firstname, lastname,age,role,email,pass from $table ORDER BY id DESC";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            // Send back the complete records as a json
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
 
    // Add an Employee
    if("ADD_EMP" == $action){
        // App will be posting these values to this server
        $firstname = $_POST["firstname"];

        $lastname = $_POST["lastname"];
        $age = $_POST["age"];
        $role = $_POST["role"];
        $email = $_POST["email"];
        $pass = $_POST["pass"];

        $sql = "INSERT INTO $table (firstname, lastname,age,role,email,pass) VALUES ('$firstname', '$lastname', '$age', '$role', '$email', '$pass')";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }
 
    // Remember - this is the server file.
    // I am updating the server file.
    // Update an Employee
    if("UPDATE_EMP" == $action){
        // App will be posting these values to this server
        $UID = $_POST['UID'];
        $firstname = $_POST["firstname"];
        $lastname = $_POST["lastname"];
        $age = $_POST["age"];
        $role = $_POST["role"];
        $email = $_POST["email"];
        $pass = $_POST["pass"];
        $sql = "UPDATE $table SET firstname = '$firstname',lastname = '$lastname',age = '$age',role= '$role',email= '$email',pass= '$pass' WHERE UID = $UID";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
 
    // Delete an Employee
    if('DELETE_EMP' == $action){
        $emp_id = $_POST['UID'];
        $sql = "DELETE FROM $table WHERE UID = $emp_id"; // don't need quotes since id is an integer.
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
 
?>



