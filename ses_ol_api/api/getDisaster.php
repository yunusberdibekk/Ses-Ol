<?php
include_once '../config/database.php';
$sqlQuery = "SELECT * FROM afet;";
 $database = new Database();
$stmt = $database->getConnection()->prepare($sqlQuery);
$stmt->execute();
$result = $stmt ->fetchAll();
$lists = array();
foreach ($result as $r) {
     array_push($lists, array("disaster_id"=>$r["afet_id"], "disaster_name"=>$r["afet_adi"]));
}
echo  json_encode($lists);
?>