<?php
if (isset($_GET["method"])) {
    include_once '../config/database.php';
    include_once '../class/VoluntarilyPitchTent.php';

    $database = new Database();
    $db = $database->getConnection();
    $voluntarily = new VoluntarilyPitchTent($db);

    $method = $_GET["method"];

    switch ($method) {
        case 'create_voluntarily':
            if (
                isset($_GET["user_account_id"]) && isset($_GET["voluntarily_union_id"]) && isset($_GET["voluntarily_vehicle_status"]) &&
                isset($_GET["voluntarily_desc"])
            ) {
                $voluntarily->setVoluntarilyAccountId($_GET["user_account_id"]);
                $voluntarily->setVoluntarilyUnionId($_GET["voluntarily_union_id"]);
                $voluntarily->setVoluntarilyVehicleStatus($_GET["voluntarily_vehicle_status"]);
                $voluntarily->setVoluntarilyDesc($_GET["voluntarily_desc"]);

                echo json_encode($voluntarily->createVoluntarily());
            } else {
                return array('status' => 'error', 'msg' => 'Invalid param');
            }
            break;
        case 'read_waiting_providing':
            if (isset($_GET["user_account_id"]) && isset($_GET["is_a_union"])) {
                $voluntarily->setVoluntarilyAccountId($_GET["user_account_id"]);
                $voluntarily->setVoluntarilyApproveStatus(-1);
                echo json_encode($voluntarily->readVoluntarily($_GET["is_a_union"]));
            } else {
                echo json_encode(array(null));
            }
            break;
        case 'read_rejected_providing':
            if (isset($_GET["user_account_id"]) && isset($_GET["is_a_union"])) {
                $voluntarily->setVoluntarilyAccountId($_GET["user_account_id"]);
                $voluntarily->setVoluntarilyApproveStatus(0);
                echo json_encode($voluntarily->readVoluntarily($_GET["is_a_union"]));
            } else {
                echo json_encode(array(null));
            }
            break;
        case 'read_approved_providing':
            if (isset($_GET["user_account_id"]) && isset($_GET["is_a_union"])) {
                $voluntarily->setVoluntarilyAccountId($_GET["user_account_id"]);
                $voluntarily->setVoluntarilyApproveStatus(1);
                echo json_encode($voluntarily->readVoluntarily($_GET["is_a_union"]));
            } else {
                echo json_encode(array(null));
            }
            break;
        case 'update_voluntarily':
            if (isset($_GET["user_account_id"]) && isset($_GET["voluntarily_approve_status"])) {
                $voluntarily->setVoluntarilyAccountId($_GET["user_account_id"]);
                $voluntarily->setVoluntarilyApproveStatus($_GET["voluntarily_approve_status"]);
                echo json_encode($voluntarily->updateVoluntarily());
            } else {
                echo json_encode(array('status' => 'error', 'msg' => 'Invalid param'));
            }
            break;
        case 'delete_volantarily':
            if (isset($_GET["user_account_id"])) {
                $voluntarily->setVoluntarilyAccountId($_GET["user_account_id"]);
                echo json_encode($voluntarily->deleteVoluntarily());
            } else {
                echo json_encode(array('status' => 'error', 'msg' => 'Invalid param'));
            }
            break;
        default:
            echo json_encode(array('status' => 'error', 'msg' => 'Invalid param'));
            break;
    }
}
