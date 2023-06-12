<?php
    if (isset($_GET["method"])) {
        include_once '../config/database.php';
        include_once '../class/UnionPost.php';

        $database = new Database();
        $db = $database->getConnection();
        $unionPost = new UnionPost($db);

        $method = $_GET["method"];

        switch ($method) {
            case 'create_post':
                if (isset($_GET["post_publisher_id"]) && isset($_GET["post_content"])) {
                    $unionPost->setPostPublisherId($_GET["post_publisher_id"]);
                    $unionPost->setPostContent($_GET["post_content"]);
                    echo json_encode($unionPost->createPost());
                } else {
                    echo json_encode(array('status'=>'error', 'msg'=>'Invalid param'));
                }
                break;
            case 'read_post':
                echo json_encode($unionPost->readPost());
                break;
            case 'delete_post':
                if (isset($_GET["post_id"])) {
                    $unionPost->setPostId($_GET["post_id"]);
                    $unionPost->deletePost($_GET["post_id"]);
                    echo json_encode($unionPost->deletePost());
                } else {
                    echo json_encode(array('status'=>'error', 'msg'=>'Invalid param'));
                }
                break;
            default:
                echo json_encode(array('status' => 'error', 'msg' => 'Invalid Param'));
                break;
        }
    }
