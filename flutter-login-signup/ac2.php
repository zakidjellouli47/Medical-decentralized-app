<?php
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
header("Access-Control-Allow-Origin: *");
    include("dbcon.php");

   if(isset($_POST["UID"])){
    $id = $_POST["UID"];
   }
    else return;

    if(isset($_POST["firstname"])){
        $firstname = $_POST["firstname"];
       }
        else return;

        if(isset($_POST["lastname"])){
            $lastname = $_POST["lastname"];
           }
            else return;

            if(isset($_POST["age"])){
                $age = $_POST["age"];
               }
                else return;

                if(isset($_POST["role"])){
                    $role = $_POST["role"];
                   }
                    else return;
                    if(isset($_POST["email"])){
                        $email = $_POST["email"];
                       }
                        else return;
                        if(isset($_POST["pass"])){
                            $pass = $_POST["pass"];
                           }
                            else return;
                            if(isset($_POST["ethereumAddress"])){
                                $ethereumAddress = $_POST["ethereumAddress"];
                               }
                                else return;

    $query = "UPDATE `users` SET `firstname` = '$firstname' ,`lastname` = '$lastname',`age` = '$age',`role` = '$role',`email` = '$email',`pass` = '$pass',`ethereumAddress` = '$ethereumAddress' WHERE `UID` = '$id' ";

    $exe = mysqli_query($conn, $query);

    $arr = [];

    
    if($exe){

        $arr["success"] = "true";
        $arr['message']="Updated Successfully";
    }
    else{

        $arr["success"] = "false";
    }

    print(json_encode($arr));
?>
