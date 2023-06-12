<?php
include_once '../config/database.php';
$sqlQuery = "SELECT * FROM ihtiyac_kategori;";
 $database = new Database();
$stmt = $database->getConnection()->prepare($sqlQuery);
$stmt->execute();
$result = $stmt ->fetchAll();
$lists = array();
foreach ($result as $r) {
     array_push($lists, array("category_id"=>$r["kategori_id"], "category_name"=>$r["kategori_adi"]));
}
echo  json_encode($lists);
?>