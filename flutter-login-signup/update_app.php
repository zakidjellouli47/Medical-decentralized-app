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

              
                   
                    if(isset($_POST["email"])){
                        $email = $_POST["email"];
                       }
                        else return;
                        if(isset($_POST["ilnessdescription"])){
                            $ilnessdescription = $_POST["ilnessdescription"];
                           }
                            else return;
                            if(isset($_POST["date"])){
                                $date = $_POST["date"];
                               }
                                else return;
                                if(isset($_POST["doctors"])){
                                    $doctors = $_POST["doctors"];
                                   }
                                    else return;

    $query = "UPDATE `requested_appointements` SET `firstname` = '$firstname' ,`lastname` = '$lastname',`age` = '$age',`email` = '$email',`ilnessdescription` = '$ilnessdescription',`date` = '$date' ,`doctors` = '$doctors' WHERE `UID` = '$id' ";

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
