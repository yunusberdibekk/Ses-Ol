<?php
    class Iban{
        private $conn;
        private $db_table = "kurum_iban";
        private $iban_id;
        private $iban_account_id;
        private $iban_title;
        private $iban;

        public function __construct($db){
            $this->conn = $db;
        }

        public function getIbanId(){
            return $this->iban_id;
        }

        public function setIbanId($iban_id){
            $this->iban_id = $iban_id;
        }

        public function getIbanAccount(){
            return $this->iban_account_id;
        }

        public function setIbanAccountId($iban_account_id){
            $this->iban_account_id = $iban_account_id;
        }

        public function getIbanTittle(){
            return $this->iban_title;
        }

        public function setIbanTittle($iban_title){
            $this->iban_title = $iban_title;
        }

        public function getIban(){
            return $this->iban;
        }

        public function setIban($iban){
            $this->iban = $iban;
        }

        public function createIban(){
            $sqlQuery = "INSERT INTO ". $this->db_table ." 
                (hesap_kurum_id,
                iban_baslik,
                iban)
                VALUES
                (:user_account_id, :iban_title, :iban)";
                $stmt = $this->conn->prepare($sqlQuery);
                $stmt->bindParam(":user_account_id", $this->iban_account_id);
                $stmt->bindParam(":iban_title", $this->iban_title);
                $stmt->bindParam(":iban", $this->iban);

                if ($stmt->execute()) {
                    return array('status'=>'ok', 'msg'=>'success');
                }
    
                return array('status'=>'error', 'msg'=>'db error');
        }

        public function readIban(){
            $sqlQuery = "SELECT * FROM ". $this->db_table ." WHERE hesap_kurum_id = :iban_account_id";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam("iban_account_id", $this->iban_account_id);
            $stmt->execute();
            $dataRows = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $result = array();
            foreach ($dataRows as $dataRow) {
                $result[] = array("iban_id"=>$dataRow['iban_id'], "user_account_id"=>$dataRow['hesap_kurum_id'], "iban_title"=>$dataRow['iban_baslik'], "iban"=>$dataRow['iban']);
            }
            if($result != null){
                return $result;
            }
            return array("iban_id"=>null, "user_account_id"=>null, "iban_title"=>null, "iban"=>null);
        }

        public function updateIban(){
            $sqlQuery = "UPDATE ". $this->db_table ." SET iban_baslik = :iban_title, iban = :iban WHERE iban_id = :iban_id";
            
                $stmt = $this->conn->prepare($sqlQuery);
                $stmt->bindParam(":iban_id", $this->iban_id);
                $stmt->bindParam(":iban_title", $this->iban_title);
                $stmt->bindParam(":iban", $this->iban);

            if ($stmt->execute()) {
                return array('status'=>'ok', 'msg'=>'success');
            }

            return array('status'=>'error', 'msg'=>'db error');
        }

        public function deleteIban(){
            $sqlQuery = "DELETE FROM kurum_iban WHERE iban_id = :iban_id";
        
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":iban_id", $this->iban_id);
            if ($stmt->execute()) {
                return array('status'=>'ok', 'msg'=>'success');
            }

            return array('status'=>'error', 'msg'=>'db error');
            }
    }    
?>