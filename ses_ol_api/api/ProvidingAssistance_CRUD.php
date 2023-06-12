<?php
if (isset($_GET["method"])) {
    include_once '../config/database.php';
    include_once '../class/ProvidingAssistance.php';
    $database = new Database();
    $db = $database->getConnection();
    $assistance = new ProvidingAssistance($db);
    $method = $_GET["method"];

    switch ($method) {
        case 'create_assistance':
            if (
                isset($_GET["user_assistance_account_id"]) && isset($_GET["assistance_title"]) && isset($_GET["assistance_sent_union_id"]) &&
                 isset($_GET["assistance_num_of_person"]) && isset($_GET["assistance_category_id"]) && 
                 isset($_GET["assistance_desc"]) && isset($_GET["assistance_address_id"]) && isset($_GET["is_a_union"])
            ) {
                $assistance->setUserAccountId($_GET["user_assistance_account_id"]);
                $assistance->setAssistanceTitle($_GET["assistance_title"]);
                $assistance->setAssistanceSentUnionId($_GET["assistance_sent_union_id"]);
                $assistance->setAssistanceNumOfPerson($_GET["assistance_num_of_person"]);
                $assistance->setAssistanceCategoryId($_GET["assistance_category_id"]);
                $assistance->setAssistanceStatus($_GET["is_a_union"] == 0 ? -1 : 1);
                $assistance->setAssistanceDesc($_GET["assistance_desc"]);
                $assistance->setAssistanceAddressId($_GET["assistance_address_id"]);

                echo json_encode($assistance->createAsistance());
            } else {
                echo json_encode(array('status' => 'error', 'msg' => 'Invalid param'));
            }
            break;
        case 'read_my_assistance':
            if (isset($_GET["user_assistance_account_id"]) && isset($_GET["is_a_union"])) {
                $assistance->setUserAccountId($_GET["user_assistance_account_id"]);
                echo json_encode($assistance->readMyAsistance($_GET["is_a_union"]));
            } else {
                echo json_encode(array('status' => 'error', 'msg' => 'Invalid param'));
            }
            break;
        case 'read_waiting_providing':
            if (isset($_GET["user_assistance_account_id"]) && isset($_GET["is_a_union"])) {
                $assistance->setUserAccountId($_GET["user_assistance_account_id"]);
                $assistance->setAssistanceStatus(-1);
                echo json_encode($assistance->readMyAsistance($_GET["is_a_union"]));
            } else {
                echo json_encode(array(null));  
            } 
            break;
        case 'read_approved_providing':
            if (isset($_GET["user_assistance_account_id"]) && isset($_GET["is_a_union"])) {
                $assistance->setUserAccountId($_GET["user_assistance_account_id"]);
                $assistance->setAssistanceStatus(1);
                echo json_encode($assistance->readMyAsistance($_GET["is_a_union"]));
            } else {
                echo json_encode(array(null));  
            } 
        break;
        case 'read_rejected_providing':
            if (isset($_GET["user_assistance_account_id"]) && isset($_GET["is_a_union"])) {
                $assistance->setUserAccountId($_GET["user_assistance_account_id"]);
                $assistance->setAssistanceStatus(0);
                echo json_encode($assistance->readMyAsistance($_GET["is_a_union"]));
            } else {
                echo json_encode(array(null));  
            } 
        break;
        case 'delete_my_assistance':
            if (isset($_GET["assistance_id"])) {
                $assistance->setAssistanceId($_GET["assistance_id"]);
                echo json_encode($assistance->deleteMyAssistance());
            } else {
                echo json_encode(array('status' => 'error', 'msg' => 'Invalid param'));
            }
            break;
        case 'read_assistance':
            echo json_encode($assistance->readAsistance());
            break;
        case 'update_my_assistance':
            if (isset($_GET["assistance_id"]) && isset($_GET["assistance_status"])) {
                $assistance->setAssistanceId($_GET["assistance_id"]);
                $assistance->setAssistanceStatus($_GET["assistance_status"]);
                echo json_encode($assistance->updateMyAssistance());
            } else {
                echo json_encode(array('status' => 'error', 'msg' => 'Invalid param'));
            }
            break;
        default:
            echo json_encode(array('status' => 'error', 'msg' => 'Invalid param'));
            break;
    }
}
