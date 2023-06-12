<?php
    class UnionPost{
        private $conn;
        private $db_table = "kurum_gonderi";
        private $post_id;
        private $post_publisher_id;
        private $post_content;
        
        public function __construct($db){
            $this->conn = $db;
        }

        public function getPostId(){
            return $this->post_id;
        }

        public function setPostId($post_id){
            $this->post_id = $post_id;
        }

        public function getPostPublisherId(){
            return $this->post_publisher_id;
        }

        public function setPostPublisherId($post_publisher_id){
            $this->post_publisher_id = $post_publisher_id;
        }

        public function getPostContent(){
            return $this->post_content;
        }

        public function setPostContent($post_content){
            $this->post_content = $post_content;
        }

        public function readPost(){
            $sqlQuery = "SELECT * FROM kurum INNER JOIN (SELECT * FROM ". $this->db_table ." ORDER BY gonderi_zaman DESC) as post ON post.yayinlayan_kurum_id = kurum.kurum_giris_bilgi_id";

            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->execute();
            $dataRows = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $result = array();

            foreach ($dataRows as $dataRow) {
                $result[] = array("post_id"=>$dataRow['gonderi_id'], "publisher_union_id"=>$dataRow['yayinlayan_kurum_id'], "post_publisher_name"=>$dataRow['kurum_adi'], "post_content"=>$dataRow['gonder_icerik'], "post_time"=>substr(explode(" ",$dataRow["gonderi_zaman"])[1], 0, 5));
            }
            if($result != null){
                return $result;
            }
            return array("post_id"=>null, "publisher_union_id"=>null, "post_publisher_name"=>null, "post_content"=>null, "post_time"=>null);
        }

        public function deletePost(){
            $sqlQuery = "DELETE FROM ". $this->db_table ." WHERE gonderi_id = :post_id";
        
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":post_id", $this->post_id);
            if ($stmt->execute()) {
                return array('status'=>'ok', 'msg'=>'success');
            }

            return array('status'=>'error', 'msg'=>'db error');
        }

        public function createPost(){
            $sqlQuery = "INSERT INTO ". $this->db_table ." 
                (yayinlayan_kurum_id,
                gonder_icerik)
                VALUES
                (:post_publisher_id, :post_content)";

            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam("post_publisher_id", $this->post_publisher_id);
            $stmt->bindParam("post_content", $this->post_content);

            if ($stmt->execute()) {
                return array('status'=>'ok', 'msg'=>'success');
            }

            return array(null);
        }

    }    
?>