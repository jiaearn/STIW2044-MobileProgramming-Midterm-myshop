<?php

include_once("dbconnect.php");
$sqlload = "SELECT * FROM tbl_products ORDER BY prid";
$result = $conn->query($sqlload);

if ($result->num_rows > 0){
    $response["products"] = array();
    while ($row = $result -> fetch_assoc()){
        $prlist = array();
        $prlist[prid] = $row['prid'];
        $prlist[prname] = $row['prname'];
        $prlist[prtype] = $row['prtype'];
        $prlist[prprice] = $row['prprice'];
        $prlist[prqty] = $row['prqty'];
        $prlist[datecreated] = $row['datecreated'];
        array_push($response["products"],$prlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>