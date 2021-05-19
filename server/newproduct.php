<?php

include_once("dbconnect.php");
$prname = $_POST['prname'];
$prtype = $_POST['prtype'];
$prprice = $_POST['prprice'];
$prqty = $_POST['prqty'];
$encoded_string = $_POST['encoded_string'];

$sqlinsert="INSERT INTO tbl_products(prname,prtype,prprice,prqty) VALUES('$prname','$prtype','$prprice','$prqty')";
if($conn->query($sqlinsert)===true){
    $decoded_string=base64_decode($encoded_string);
    $filename=mysqli_insert_id($conn);
    $path= '../images/product_pictures/'.$filename.'.png';
    $is_written=file_put_contents($path,$decoded_string);
    echo "Success";
}else{
    echo "Failed";
}
?>