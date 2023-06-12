<?php
if(isset($_GET["method"])){
    include_once '../config/database.php';
    include_once '../class/VoluntarilyTransporter.php';

    $database = new Database();
    $db = $database->getConnection();
    $voluntarily = new VoluntarilyTransporter($db);
    
    $method = $_GET["method"];

    switch ($method) {
        case 'create_voluntarily':
            if (isset($_GET["user_account_id"]) && isset($_GET["union_id"]) && isset($_GET["voluntarily_from_location"]) &&
            isset($_GET["voluntarily_to_location"]) && isset($_GET["voluntarily_num_of_vehicle"]) &&
            isset($_GET["voluntarily_num_of_driver"]) && isset($_GET["voluntarily_description"])) {
               $voluntarily->setUserAccountId($_GET["user_account_id"]);
               $voluntarily->setVoluntarilyUnionId($_GET["union_id"]);
               $voluntarily->setVoluntarilyFromLocation($_GET["voluntarily_from_location"]);
               $voluntarily->setVoluntarilyToLocation($_GET["voluntarily_to_location"]);
               $voluntarily->setVoluntarilyNumVehicle($_GET["voluntarily_num_of_vehicle"]);
               $voluntarily->setVoluntarilyNumDriver($_GET["voluntarily_num_of_driver"]);
               $voluntarily->setVoluntarilyDec($_GET["voluntarily_description"]);

               echo json_encode($voluntarily->createVoluntarily());

            } else {
                echo json_encode(array('status'=>'error', 'msg'=>'Invalid param'));
            }
            
            break;
            case 'read_waiting_providing':
                if (isset($_GET["user_account_id"]) && isset($_GET["is_a_union"])) {
                    $voluntarily->setUserAccountId($_GET["user_account_id"]);
                    $voluntarily->setVoluntarilyStatus(-1);
                    echo json_encode($voluntarily->readVoluntarily($_GET["is_a_union"]));
                } else {
                    echo json_encode(array(null));
                }
                break;
            case 'read_rejected_providing':
                if (isset($_GET["user_account_id"]) && isset($_GET["is_a_union"])) {
                    $voluntarily->setUserAccountId($_GET["user_account_id"]);
                    $voluntarily->setVoluntarilyStatus(0);
                    echo json_encode($voluntarily->readVoluntarily($_GET["is_a_union"]));
                } else {
                    echo json_encode(array(null));
                }
                break;
            case 'read_approved_providing':
                if (isset($_GET["user_account_id"]) && isset($_GET["is_a_union"])) {
                    $voluntarily->setUserAccountId($_GET["user_account_id"]);
                    $voluntarily->setVoluntarilyStatus(1);
                    echo json_encode($voluntarily->readVoluntarily($_GET["is_a_union"]));
                } else {
                    echo json_encode(array(null));
                }
                break;
        case 'update_voluntarily':
            if (isset($_GET["user_account_id"]) && isset($_GET["voluntarily_approve_status"])) {
                $voluntarily->setUserAccountId($_GET["user_account_id"]);
                $voluntarily->setVoluntarilyStatus($_GET["voluntarily_approve_status"]);

                echo json_encode($voluntarily->updateVoluntarily());
            } else {
                echo json_encode(array('status'=>'error', 'msg'=>'Invalid param'));
            }
            break;
        case 'delete_voluntarily':
            if (isset($_GET["user_account_id"])) {
                $voluntarily->setUserAccountId($_GET["user_account_id"]);

                echo json_encode($voluntarily->deleteVoluntarily());
            } else {
                echo json_encode(array('status'=>'error', 'msg'=>'Invalid param'));
            }
            break;
        default:
            echo json_encode(array('status'=>'error', 'msg'=>'Invalid param'));
            break;
    }
}
?>