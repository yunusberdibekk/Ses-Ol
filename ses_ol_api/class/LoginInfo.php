<?php
    class LoginInfo{
        private $conn;
        private $db_table = "giris_bilgi";
        private $user_tel;
        private $user_password;

        public function __construct($db){
            $this->conn = $db;
        }

        public function getUserTel(){
            return $this->user_tel;
        }

        public function setUserTel($user_tel){
            $this->user_tel = $user_tel;
        }

        public function getUserPassword(){
            return $this->user_password;
        }

        public function setUserPassword($user_password){
            $this->user_password = $user_password;
        }

        public function createLoginInfo(){
            $sqlQuery = "SELECT * FROM ". $this->db_table ." WHERE kullanici_tel = :user_tel";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam("user_tel", $this->user_tel);

            if ($stmt->execute()) {
                if ($stmt->fetch(PDO::FETCH_ASSOC) == null ) {
                    $sqlQuery = "INSERT INTO ". $this->db_table ." 
                    (kullanici_tel,
                    kullanici_sifre)
                    VALUES
                    (:user_tel, :user_password)";
                    $stmt = $this->conn->prepare($sqlQuery);
                    $stmt->bindParam("user_tel", $this->user_tel);
                    $stmt->bindParam("user_password", $this->user_password);
                
                    if ($stmt->execute()) {
                        $stmt = $this->conn->query("SELECT LAST_INSERT_ID()");
                        return $stmt->fetchColumn();
                    }
                }
                return null;
            }

            return null;
        }

    }
    
?>