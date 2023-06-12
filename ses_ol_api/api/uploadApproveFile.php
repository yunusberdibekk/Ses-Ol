<?php
include_once '../config/database.php';
include_once '../class/Unions.php';
/*$fileName  =  $_FILES['file']['name'];
$tempPath  =  $_FILES['file']['tmp_name'];
$fileSize  =  $_FILES['file']['size'];

if (empty($fileName)) {
	echo json_encode(array('status' => 'no', 'msg' => 'failed'));
} else {
	$result = move_uploaded_file($_FILES["file"]["tmp_name"], "../uploads/unionApproveFile/" . $_FILES["file"]["name"]);
	echo json_encode(array('status' => 'ok', 'msg' => 'success'));
}*/
if(isset($_POST["image"])){

$image = $_POST["image"];
$data = str_replace(" ", "+", $image);
$data = base64_decode($data);
$image = imagecreatefromstring($data);
imagejpeg($image);
file_put_contents("../uploads/unionApproveFile/image.jpeg", $image);
echo json_encode(array("status"=>"ok", "msg"=>"uploads/unionApproveFile icerisine bak"));
}else{
  echo json_encode(array("status"=>"no", "msg"=>"parametre gelmedi post olarak image gelmeliydi"));
}
?>