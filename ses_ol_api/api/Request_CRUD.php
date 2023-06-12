<?php
    if (isset($_GET["method"])) {
        include_once '../config/database.php';
        include_once '../class/RequestHelp.php';

        $database = new Database();
        $db = $database->getConnection();
        $requestHelp = new RequestHelp($db);

        $method = $_GET["method"];

        switch ($method) {
            case 'read_request_approved':
                if (isset($_GET["request_account_id"]) && isset($_GET["is_a_union"])) {
                    $requestHelp->setRequestAccountId($_GET["request_account_id"]);
                    $requestHelp->setRequestStatus(1);
                    echo json_encode($requestHelp->readRequest($_GET["is_a_union"]));
                } else {
                    echo json_encode(array(null));
                }                
                break;
            case 'read_request_waiting':
                if (isset($_GET["request_account_id"]) && isset($_GET["is_a_union"])) {
                    $requestHelp->setRequestAccountId($_GET["request_account_id"]);
                    $requestHelp->setRequestStatus(-1);
                    echo json_encode($requestHelp->readRequest($_GET["is_a_union"]));
                } else {
                    echo json_encode(array(null));  
                }   
                break;
            case 'read_request_rejected':
                if (isset($_GET["request_account_id"]) && isset($_GET["is_a_union"])) {
                    $requestHelp->setRequestAccountId($_GET["request_account_id"]);
                    $requestHelp->setRequestStatus(0);
                    echo json_encode($requestHelp->readRequest($_GET["is_a_union"]));
                } else {
                    echo json_encode(array(null));
                } 
                break;
            case 'update_request_status':
                if (isset($_GET["request_id"]) && isset($_GET["request_status"]) && isset($_GET["is_a_union"])) {
                    if ($_GET["is_a_union"] == 1) {
                        $requestHelp->setRequestId($_GET["request_id"]);
                        $requestHelp->setRequestStatus($_GET["request_status"]);
                        echo json_encode($requestHelp->updateRequestStatus());
                    }else{
                        array('status'=>'error', 'msg'=>'Invalid param');
                    }
                } else {
                    echo json_encode(array(null));
                } 
                break;
            case 'create_request':
                if (isset($_GET["request_account_id"]) && isset($_GET["num_of_person"]) &&
                    isset($_GET["request_disaster_id"]) && isset($_GET["request_union_id"]) &&
                    isset($_GET["request_category"]) && isset($_GET["request_desc"])) {
                    $requestHelp->setRequestAccountId($_GET["request_account_id"]);
                    $requestHelp->setNumOfPerson($_GET["num_of_person"]);
                    $requestHelp->setDisasterId($_GET["request_disaster_id"]);
                    $requestHelp->setUnionId($_GET["request_union_id"]);
                    $requestHelp->setCategory($_GET["request_category"]);
                    $requestHelp->setRequestDesc($_GET["request_desc"]);
                    
                    echo json_encode($requestHelp->createRequest());
                } else {
                    echo json_encode(array('status' => 'error', 'msg' => 'Invalid Param'));
                }
                break;
            case 'create_request_as_union':
                if (isset($_GET["request_account_id"]) && isset($_GET["num_of_person"]) &&
                    isset($_GET["request_disaster_id"]) && isset($_GET["request_category"]) && 
                    isset($_GET["request_desc"])) {
                    $requestHelp->setRequestAccountId($_GET["request_account_id"]);
                    $requestHelp->setNumOfPerson($_GET["num_of_person"]);
                    $requestHelp->setDisasterId($_GET["request_disaster_id"]);
                    $requestHelp->setUnionId($_GET["request_account_id"]);
                    $requestHelp->setCategory($_GET["request_category"]);
                    $requestHelp->setRequestDesc($_GET["request_desc"]);
                    
                    echo json_encode($requestHelp->createRequest());
                } else {
                    echo json_encode(array('status' => 'error', 'msg' => 'Invalid Param'));
                }
                break;
            case 'delete_request':
                if (isset($_GET["request_id"])) {
                    $requestHelp->setRequestId($_GET["request_id"]);
                    
                    echo json_encode($requestHelp->deleteRequest());
                } else {
                    echo json_encode(array('status' => 'error', 'msg' => 'Invalid Param'));
                }
                break;
            default:
                    echo json_encode(array('status' => 'error', 'msg' => 'Invalid Param'));
                break;
        }
    }
