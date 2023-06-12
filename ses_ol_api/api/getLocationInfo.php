<?php
include_once '../config/database.php';
//$sqlQuery = "SELECT ulke_id, ulke_adi FROM ulke";
$sqlQuery = 'SELECT ulke_id, ulke_adi, "" as sehir_id, "" as sehir_adi, "" as ulke_id_fk, "" as ilce_id, "" as ilce_adi, "" as sehir_id_fk FROM ulke
UNION ALL
SELECT "", "", sehir_id, sehir_adi, ulke_id, "", "", "" FROM sehir
UNION ALL
SELECT "", "", "", "", "", ilce_id, ilce_adi, sehir_id FROM ilce';
$database = new Database();
$stmt = $database->getConnection()->prepare($sqlQuery);
$stmt->execute();
$result = $stmt ->fetchAll();
$countryArr = array();
$cityArr = array();
$districtArr = array();
foreach ($result as $r) {
     // array_push($lists, array(array("ulke_id"=>$r["ulke_id"], "ulke_adi"=>$r["ulke_adi"])));
     if ($r["ulke_id"] != "" && $r["ulke_adi"] != "") {
          array_push($countryArr, array("ulke_id"=>$r["ulke_id"], "ulke_adi"=>$r["ulke_adi"]));
     }else if ($r["sehir_id"] != "" && $r["sehir_adi"] != "" && $r["ulke_id_fk"] != ""){
          array_push($cityArr, array("sehir_id"=>$r["sehir_id"], "sehir_adi"=>$r["sehir_adi"], "ulke_id_fk"=>$r["ulke_id_fk"]));
     }else if ($r["ilce_id"] != "" && $r["ilce_adi"] != "" && $r["sehir_id_fk"] != "") {
          array_push($districtArr, array("ilce_id"=>$r["ilce_id"], "ilce_adi"=>$r["ilce_adi"], "sehir_id_fk"=>$r["sehir_id_fk"]));
     }
     
 }

echo  json_encode(array($countryArr, $cityArr, $districtArr));
?>