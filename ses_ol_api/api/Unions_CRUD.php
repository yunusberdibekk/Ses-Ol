<?php
if (isset($_GET["method"])) {
    include_once '../config/database.php';
    include_once '../class/Unions.php';
    include_once '../class/LoginInfo.php';
    $method = $_GET["method"];

    $database = new Database();
    $db = $database->getConnection();
    $union = new Unions($db);

    switch ($method) {
        case 'create':
            if (
                isset($_GET["union_name"]) && isset($_GET["union_tel"]) && isset($_GET["union_email"])
                && isset($_GET["union_web_site"]) && isset($_GET["union_password"])
            ) {

                $loginInfo = new LoginInfo($db);
                $loginInfo->setUserTel($_GET["union_tel"]);
                $loginInfo->setUserPassword(md5($_GET["union_password"]));
                $userAccountId = $loginInfo->createLoginInfo();

                if ($userAccountId != null) {
                    $union->setUserAccountId($userAccountId);
                    $union->setUnionName($_GET["union_name"]);
                    $union->setUnionEmail($_GET["union_email"]);
                    $union->setUnionWebSite($_GET["union_web_site"]);

                    /*$fileName  =  $_FILES['file']['name'];
                    $tempPath  =  $_FILES['file']['tmp_name'];
                    $fileSize  =  $_FILES['file']['size'];*/

                   /* if (empty($fileName)) {
                        echo json_encode(array('status' => 'error', 'msg' => 'failed'));
                    } else {*/
                       // $result = move_uploaded_file($_FILES["file"]["tmp_name"], "../uploads/unionApproveFile/" . $_FILES["file"]["name"]);
                        $union->setUnionFileLocation("../uploads/unionApproveFile/");
                        echo json_encode($union->createUnion());
                    //}
                } else {
                    echo json_encode(array("status" => "error", "msg" => "Boyle bir kullanici olabilir ya da db de sorun var"));
                }
            } else {
                echo json_encode(array('status' => 'error', 'msg' => 'Invalid Param42'));
            }
            break;
        case 'read_union':
            if (isset($_GET["user_account_id"])) {
                $union->setUserAccountId($_GET["user_account_id"]);

                echo json_encode($union->getUnion());
            } else {
                echo json_encode(null);
            }
            break;
        case 'get_all_unions':
                echo json_encode($union->getAllUnions());
            break;
        default:
            echo json_encode(array('status' => 'error', 'msg' => 'Invalid Para1m'));
            break;
    }
}
