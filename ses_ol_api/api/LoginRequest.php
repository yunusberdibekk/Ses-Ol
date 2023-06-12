<?php
include_once '../config/database.php';
include_once '../class/Unions.php';
include_once '../class/Users.php';
if (isset($_GET["user_tel"]) && isset($_GET["user_password"])) {
    $user_tel = $_GET["user_tel"];
    $user_password = md5($_GET["user_password"]);
    $database = new Database();
    $db = $database->getConnection();

    $sqlQuery = "SELECT giris_id FROM giris_bilgi WHERE kullanici_tel = :user_tel AND kullanici_sifre = :user_password";
    $stmt = $db->prepare($sqlQuery);
    $stmt->bindParam(":user_tel", $user_tel);
    $stmt->bindParam(":user_password", $user_password);
    $stmt->execute();
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    $accountId = null;
    if ($data["giris_id"] != null) {
        $accountId = $data["giris_id"];
        
        $userAccount = new Users($db);
        $userAccount->setUserAccountId($accountId);
        
        $unionAccount = new Unions($db);
        $unionAccount->setUserAccountId($accountId);

        $isAUser = $userAccount->getUserId();
        $isAUnion = $unionAccount->getUnionId();
        if($isAUser["user_account_id"] != null){
            echo json_encode($isAUser);
        }else if($isAUnion["user_account_id"] != null){
            echo json_encode($isAUnion);
        }else{
            echo json_encode(array('status'=>'error', 'msg'=>'Hesap bulunamadi ve onaylanmamis olabilir.'));
        }
    } else {
        echo json_encode(array('status'=>'error', 'msg'=>'Hesap bulunamadi.'));
    }
}
?>