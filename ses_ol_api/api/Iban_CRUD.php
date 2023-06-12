<?php
    if (isset($_GET["method"])) {
        include_once '../config/database.php';
        include_once '../class/Iban.php';

        $database = new Database();
        $db = $database->getConnection();
        $iban = new Iban($db);

        $method = $_GET["method"];

        switch ($method) {
            case 'create_iban':
                if (isset($_GET["user_account_id"]) && isset($_GET["iban_title"]) &&
                    isset($_GET["iban"])) {
                    $iban->setIbanAccountId($_GET["user_account_id"]);
                    $iban->setIbanTittle($_GET["iban_title"]);
                    $iban->setIban($_GET["iban"]);

                    echo json_encode($iban->createIban());
                } else {
                    echo json_encode(array('status'=>'error', 'msg'=>'Invalid param'));
                }                
                break;
            case 'read_iban':
                if (isset($_GET["user_account_id"])) {
                    $iban->setIbanAccountId($_GET["user_account_id"]);

                    echo json_encode($iban->readIban());
                } else {
                    echo json_encode(array(null));
                }  
                break;
            case 'update_iban':
                if (isset($_GET["iban_id"]) && isset($_GET["iban_title"]) && isset($_GET["iban"])) {
                    $iban->setIbanId($_GET["iban_id"]);
                    $iban->setIbanTittle($_GET["iban_title"]);
                    $iban->setIban($_GET["iban"]);

                    echo json_encode($iban->updateIban());
                } else {
                    echo json_encode(array('status'=>'error', 'msg'=>'Invalid param'));
                }  
                break;
            case 'delete_iban':
                if (isset($_GET["iban_id"])) {
                    $iban->setIbanId($_GET["iban_id"]);

                    echo json_encode($iban->deleteIban());
                } else {
                    echo json_encode(array('status'=>'error', 'msg'=>'Invalid Param'));
                }  
                break;
            default:
                    echo json_encode(array('status' => 'error', 'msg' => 'Invalid Param'));
                break;
        }
    }
