<?php
session_start();
if (empty($_SESSION["permit"]) && empty($_SESSION["admin_id"])) {
    header("Location: http://localhost/sesolAdminPanel/login.php");
}
include_once 'config/database.php';
$database = new Database();
$db = $database->getConnection();
$admin_id = $_SESSION["admin_id"];
?>

<!DOCTYPE html>
<html lang="tr">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Ses Ol | Admin</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.php">
                <div class="sidebar-brand-text mx-3">Ses Ol</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="index.php">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Ana sayfa</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Kurum İşlemleri
            </div>
            <!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">
                    <i class="far fa-building" style="color: #ffffff;"></i>
                    <span>Kurum Onay Durumu</span>
                </a>
                <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="unions-waiting-approve.php">Onay Bekleyen Kurumlar</a>
                        <a class="collapse-item" href="unions-approved.php">Onay Kabul Edilen Kurumlar</a>
                        <a class="collapse-item" href="unions-rejected-approve.php">Onay Reddedilen Kurumlar</a>
                    </div>
                </div>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">
                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <?php
                                $sqlQuery = "SELECT * FROM kullanicilar WHERE kullanici_giris_bilgi_id = :admin_id";
                                $stmt = $db->prepare($sqlQuery);
                                $stmt->bindParam(":admin_id", $admin_id);
                                if ($stmt->execute()) {
                                    $res = $stmt->fetch(PDO::FETCH_ASSOC);
                                ?>
                                    <span class="mr-2 d-none d-lg-inline text-gray-600 small"><?php echo 'Hoş geldin, ' . $res["kullanici_adi"] . ' ' . $res["kullanici_soyadi"]; ?></span>
                                <?php }
                                ?>
                                <img class="img-profile rounded-circle" src="img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>
                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">Onaylanmış Kurum Raporları</h1>
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Kurum Adı</th>
                                            <th>Kurum Onay Raporu</th>
                                            <th>Kurum Onay Durumu</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php
                                        $sqlQuery = "SELECT * FROM kurum WHERE hesap_onay_durumu = 1;";
                                        $stmt = $db->prepare($sqlQuery);
                                        if ($stmt->execute()) {
                                            $dataRows = $stmt->fetchAll(PDO::FETCH_ASSOC);
                                            $result = array();
                                            foreach ($dataRows as $dataRow) { ?>
                                                <tr>
                                                    <td><?php echo $dataRow['kurum_adi']; ?></td>
                                                    <td>
                                                        <a href="<?php echo "http://192.168.0.4/" . "ses_ol_api" . substr($dataRow['kurum_onay_belgesi'], 2, strlen($dataRow['kurum_onay_belgesi'])); ?>" target="_blank">
                                                            <p>Belgeyi göster</p>
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <p>Onaylandı</p>
                                                    </td>
                                                    <td style="display: inline-flex; justify-content: center; align-items: center; padding: 12px;">
                                                        <form method="get" action="unions-approved.php" style="float: right; margin-left:35px;">
                                                            <input type="hidden" name="status" value="0" id="">
                                                            <input type="hidden" name="union_id" value="<?php echo $dataRow['kurum_giris_bilgi_id']; ?>" id="">
                                                            <input type="submit" class="btn btn-danger btn-circle" value="X">
                                                        </form>
                                                    </td>
                                                </tr>
                                        <?php }
                                        }
                                        ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Ses Ol 2023</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="js/demo/datatables-demo.js"></script>

</body>

</html>
<?php
if (isset($_GET["status"]) && isset($_GET["union_id"])) {
    $status = $_GET["status"];
    $union_id = $_GET["union_id"];

    $sqlQuery = "UPDATE kurum SET hesap_onay_durumu = :status WHERE kurum_giris_bilgi_id = :union_id";
    $stmt = $db->prepare($sqlQuery);
    $stmt->bindParam(":status", $status);
    $stmt->bindParam(":union_id", $union_id);
    if ($stmt->execute()) { ?>
        <script>window.location.href = "http://192.168.0.4/sesolAdminPanel/unions-approved.php"; </script>
    <?php } else {
        echo "failed";
    }
}
?>