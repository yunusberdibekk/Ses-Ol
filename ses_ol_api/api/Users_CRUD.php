<?php
if(isset($_GET["method"])){
    include_once '../config/database.php';
    include_once '../class/Users.php';
    include_once '../class/LoginInfo.php';
    include_once '../class/Address.php';

    $database = new Database();
    $db = $database->getConnection();
    $user = new Users($db);
    
    $method = $_GET["method"];

    switch ($method) {
        case 'create_user':
            if(isset($_GET["user_tel"]) && isset($_GET["user_password"]) && isset($_GET["user_name"]) && isset($_GET["user_surname"]) &&
            isset($_GET["address_district"]) && isset($_GET["address_city"]) && isset($_GET["address_country"]) && isset($_GET["user_full_address"])){
                
                $loginInfo = new LoginInfo($db);
                $loginInfo->setUserTel($_GET["user_tel"]);
                $loginInfo->setUserPassword(md5($_GET["user_password"]));
                $userAccountId = $loginInfo->createLoginInfo();

                if ($userAccountId != null) {
                    $address = new Address($db);
                    $address->setUserAccountId($userAccountId);
                    $address->setAddressDistrict($_GET["address_district"]);
                    $address->setAddressCity($_GET["address_city"]);
                    $address->setAddressCountryCity($_GET["address_country"]);
                    $address->setFullAddress($_GET["user_full_address"]);
                    $userAddressId = $address->createAddress();
                    
                    $user = new Users($db);
                    $user->setUserAccountId($userAccountId);
                    $user->setUserName($_GET["user_name"]);
                    $user->setUserSurame($_GET["user_surname"]);
                    $user->setUserAddressId($userAddressId);
                    
                    echo json_encode($user->createUser($userAddressId));
                }else{
                    echo json_encode(array("status"=>"error", "msg"=>"Boyle bir kullanici olabilir ya da db de sorun var"));
                }
            }else {
                echo json_encode(array("status"=>"error", "msg"=>"Invalid param"));
            }
            break;
        case 'read_user':
            if (isset($_GET["user_account_id"])) {
                $user->setUserAccountId($_GET["user_account_id"]);
                
                echo json_encode($user->readUser());
            }else{
                echo json_encode(array(null));
            }
            break;
        default:
            # code...
            break;
    }
}
?>
