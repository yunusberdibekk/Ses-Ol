<?php
    include_once '../config/database.php';
    class Unions{
        private $conn;
        private $db_table = "kurum";
        private $user_account_id;
        private $union_name;
        private $union_email;
        private $union_web_site;
        private $union_approve_file_location;

        public function __construct($db){
            $this->conn = $db;
        }

        public function getUserAccountId(){
            return $this->user_account_id;
        }

        public function setUserAccountId($user_account_id){
            $this->user_account_id = $user_account_id;
        }

        public function getUnionName(){
            return $this->union_name;
        }

        public function setUnionName(string $union_name){
            $this->union_name = $union_name;
        }
        
        public function getUnionEmail(){
            return $this->union_email;
        }

        public function setUnionEmail(String $union_email){
            $this->union_email = $union_email;
        }

        public function getUnionWebSite(){
            return $this->union_web_site;
        }

        public function setUnionWebSite(String $union_web_site){
            $this->union_web_site = $union_web_site;
        }

        public function getUnionFileLocation(){
            return $this->union_approve_file_location;
        }

        public function setUnionFileLocation(String $union_approve_file_location){
            $this->union_approve_file_location = $union_approve_file_location;
        }

        public function getUnion(){
            $sqlQuery = "SELECT giris_id, kurum_adi, kullanici_tel, kullanici_sifre, kurum_email, kurum_web_site, hesap_onay_durumu FROM giris_bilgi
                            INNER JOIN (SELECT * FROM kurum WHERE kurum_giris_bilgi_id = :user_account_id) as kurum_bilgi
                                ON kurum_bilgi.kurum_giris_bilgi_id = giris_bilgi.giris_id";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":user_account_id", $this->user_account_id);
            $stmt->execute();
            $dataRow = $stmt->fetch(PDO::FETCH_ASSOC);
            if($dataRow != null){
                return array("user_account_id"=>$dataRow["giris_id"], "union_name"=>$dataRow["kurum_adi"], "union_tel"=>$dataRow["kullanici_tel"],"union_password"=>$dataRow["kullanici_sifre"],"union_email"=>$dataRow["kurum_email"], "union_web_site"=>$dataRow["kurum_web_site"]);
            }
            return array("user_account_id"=>null, "union_name"=>null, "union_tel"=>null,"union_password"=>null,"union_email"=>null, "union_web_site"=>null);
        }

        public function createUnion(){
            $sqlQuery = "INSERT INTO ". $this->db_table ."                    
            (kurum_giris_bilgi_id,
            kurum_adi,
            kurum_email,
            kurum_web_site,
            kurum_onay_belgesi)
            VALUES
            (:user_account_id, :union_name,
             :union_email, :union_web_site, :unionFileLocation)";
        
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":user_account_id", $this->user_account_id);
            $stmt->bindParam(":union_name", $this->union_name);
            $stmt->bindParam(":union_email", $this->union_email);
            $stmt->bindParam(":union_web_site", $this->union_web_site);
            $stmt->bindParam(":unionFileLocation", $this->union_approve_file_location);

            if ($stmt->execute()) {
                return array('status'=>'ok', 'msg'=>'success');
            }

            return array('status'=>'error', 'msg'=>'db error');
        }

        public function getUnionId(){
            $sqlQuery = "SELECT kurum_giris_bilgi_id FROM ". $this->db_table ." WHERE kurum_giris_bilgi_id = :user_account_id";

            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":user_account_id", $this->user_account_id);

            if($stmt->execute()){
                $result = $stmt->fetch(PDO::FETCH_ASSOC);
                if ($result != null) {
                    return array("user_account_id"=>$result["kurum_giris_bilgi_id"], "is_union_account"=>1);
                }
                return array("user_account_id"=>null, "is_union_account"=>null);
            }
            echo "b";
            return array("user_account_id"=>null, "is_union_account"=>null);
        }

        public function getAllUnions(){
            $sqlQuery = "SELECT kurum_giris_bilgi_id, kurum_adi FROM ". $this->db_table;

            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->execute();
            $dataRows = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $result = array();
            foreach ($dataRows as $dataRow) {
                $result[] = array("union_id"=>$dataRow["kurum_giris_bilgi_id"], "union_name"=>$dataRow["kurum_adi"]);
            }
            if($result != null){
                return $result;
            }
            return array("union_id"=>null, "union_name"=>null);
        }
}
?>