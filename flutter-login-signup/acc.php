<?php
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
 header("Access-Control-Allow-Origin: *");
    $HostName = "localhost";
 
    //Define your MySQL Database Name here.
    $DatabaseName = "hospital";
     
    //Define your Database User Name here.
    $HostUser = "root";
     
    //Define your Database Password here.
    $HostPass = ""; 
     
    // Creating MySQL Connection.
    $con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);
     
    // Storing the received JSON into $json variable.
    $json = file_get_contents('php://input');
     
    // Decode the received JSON and Store into $obj variable.
    $obj = json_decode($json,true);

    if(isset($obj["firstname"]) && isset($obj["lastname"]) && isset($obj["age"])&& isset($obj["role"])&& isset($obj["email"])&& isset($obj["pass"])){
     
    // Getting name from $obj object.
    $name = mysqli_real_escape_string($con,$obj['firstname']);

    $last_name = mysqli_real_escape_string($con,$obj['lastname']);

    $age = mysqli_real_escape_string($con,$obj['age']);

    $role = mysqli_real_escape_string($con,$obj['role']);

     
    // Getting Email from $obj object.
    $email = mysqli_real_escape_string($con,$obj['email']);
     
    // Getting Password from $obj object.
    $password = mysqli_real_escape_string($con,$obj['pass']);
     
    // Checking whether Email is Already Exist or Not in MySQL Table.
    $CheckSQL = "SELECT * FROM requests WHERE email='$email'";

     
    // Executing Email Check MySQL Query.
    $check = mysqli_fetch_array(mysqli_query($con,$CheckSQL));
    
     
     
    if(isset($check)){
     
         $emailExist = 'Email Already Exist, Please Try Again With New Email Address..!';
         
         // Converting the message into JSON format.
        $existEmailJSON = json_encode($emailExist);
         
        // Echo the message on Screen.
         echo $existEmailJSON ; 
     
      }
     else{


     
         // Creating SQL query and insert the record into MySQL database table.
         $Sql_Query = "insert into users (firstname,lastname,age,role,email,pass) values ('$name','$last_name','$age','patient','$email','$password')";
         
         
         if(mysqli_query($con,$Sql_Query)){
         
             // If the record inserted successfully then show the message.
           
             $result['registrationStatus']=true;
            $result['message']="Your account request is now pending for approval. Please wait for confirmation. Thank you.";
            
         }
         else{
         
            
      $result['registrationstatus']=false;
      $result['message']="unknown error";
         
         }
     }
     $json_data=json_encode($result);
      
    // Echo the $json.
    echo $json_data;
    }
     mysqli_close($con);
    
    ?>