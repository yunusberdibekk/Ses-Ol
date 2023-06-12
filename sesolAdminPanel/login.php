<?php
session_start();
if (!empty($_SESSION["permit"]) && !empty($_SESSION["admin_id"])) {
    header("Location: http://localhost/sesolAdminPanel/index.php");
}
?>
<!DOCTYPE html>
<html lang="tr">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Ses Ol Admin - Login</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-8 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row justify-content-center align-items-center">
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Hoş geldin !</h1>
                                    </div>
                                    <form method="POST" action="login.php" class="user">
                                        <div class="form-group">
                                            <input type="tel" class="form-control form-control-user" id="exampleInputEmail" name="admin_tel" aria-describedby="emailHelp" placeholder="Telefon numarası giriniz">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user" id="exampleInputPassword" name="admin_pass" placeholder="Şifre">
                                        </div>
                                        <input class="btn btn-primary btn-user btn-block" type="submit" value="Giriş yap" />
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src=" vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

</body>

</html>

<?php
if (isset($_POST["admin_tel"]) && isset($_POST["admin_pass"])) {
    include_once 'config/database.php';
    $database = new Database();
    $db = $database->getConnection();
    $sqlQuery = "SELECT * FROM giris_bilgi WHERE kullanici_tel = :admin_tel AND kullanici_sifre = :admin_pass";
    $stmt = $db->prepare($sqlQuery);
    $stmt->bindParam(":admin_tel", $_POST["admin_tel"]);
    $stmt->bindParam(":admin_pass", $_POST["admin_pass"]);

    if ($stmt->execute()) {
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($result != null) {
            $_SESSION["permit"] = "1";
            $_SESSION["admin_id"]= $result["giris_id"];
            header("Location: http://localhost/sesolAdminPanel/index.php");
            die();
        } else {
            echo "kullanici bulunamadı";
        }
    } else {
        echo "failed92";
    }
}
?>