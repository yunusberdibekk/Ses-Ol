<?php
    class Users{
        private $conn;
        private $db_table = "kullanicilar";
        private $user_account_id;
        private $user_name;
        private $user_surname;
        private $user_address_id;

        public function __construct($db){
            $this->conn = $db;
        }

        public function getUserAccountId(){
            return $this->user_account_id;
        }

        public function setUserAccountId(int $user_account_id){
            $this->user_account_id = $user_account_id;
        }

        public function getUserName(){
            return $this->user_name;
        }

        public function setUserName(string $user_name){
            $this->user_name = $user_name;
        }

        public function getUserSurname(){
            return $this->user_name;
        }

        public function setUserSurame(string $user_surname){
            $this->user_surname = $user_surname;
        }

        public function getUserAddressId(){
            return $this->user_address_id;
        }

        public function setUserAddressId(string $user_address_id){
            $this->user_address_id = $user_address_id;
        }

        public function createUser(){
            $sqlQuery = "INSERT INTO
                        ". $this->db_table ."
                    
                    (kullanici_giris_bilgi_id,
                    kullanici_adi, 
                    kullanici_soyadi, 
                    kullanici_adres_id)
                    VALUES
                    (:user_account_id, :user_name,
                    :user_surname, :user_address_id)";
        
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":user_account_id", $this->user_account_id);
            $stmt->bindParam(":user_name", $this->user_name);
            $stmt->bindParam(":user_surname", $this->user_surname);
            $stmt->bindParam(":user_address_id", $this->user_address_id);
            
            if ($stmt->execute()) {
                return array('status'=>'ok', 'msg'=>'success');
            }

            return array('status'=>'error', 'msg'=>'db error');
        }

        public function readUser(){
            $sqlQuery = "SELECT giris_id, kullanici_adi, kullanici_soyadi, kullanici_tel, kullanici_sifre, adres_id, adres_ilce, adres_sehir, adres_ulke, kullanici_acik_adres FROM kullanici_adres 
                        INNER JOIN (SELECT * FROM giris_bilgi
                            INNER JOIN (SELECT * FROM kullanicilar WHERE kullanici_giris_bilgi_id = :user_account_id) as kullanici_bilgi
                                ON kullanici_bilgi.kullanici_giris_bilgi_id = giris_bilgi.giris_id) as kullanici_tel
                                    ON kullanici_tel.kullanici_giris_bilgi_id = kullanici_adres.adres_kullanici_hesap_id";

            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":user_account_id", $this->user_account_id);

            if($stmt->execute()){
                $result = $stmt->fetch(PDO::FETCH_ASSOC);
                if ($result != null) {
                    return array("user_account_id"=>$result["giris_id"], "user_name"=>$result["kullanici_adi"],
                    "user_surname"=>$result["kullanici_soyadi"], "user_tel"=>$result["kullanici_tel"], "user_password"=>$result["kullanici_sifre"],
                    "address_id"=>$result["adres_id"], "address_district"=>$result["adres_ilce"], "address_city"=>$result["adres_sehir"],
                    "address_country"=>$result["adres_ulke"], "full_address"=>$result["kullanici_acik_adres"]);
                }
                return array("user_account_id"=>null, "user_name"=>null,
                "user_surname"=>null, "user_tel"=>null, "user_password"=>null,
                "address_id"=>null, "address_district"=>null, "address_city"=>null,
                "address_country"=>null, "full_address"=>null);
            }

            return array("user_account_id"=>null, "user_name"=>null,
            "user_surname"=>null, "user_tel"=>null, "user_password"=>null,
            "address_id"=>null, "address_district"=>null, "address_city"=>null,
            "address_country"=>null, "full_address"=>null);
        }

        public function getUserId(){
            $sqlQuery = "SELECT kullanici_giris_bilgi_id FROM ". $this->db_table ." WHERE kullanici_giris_bilgi_id = :user_account_id";

            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":user_account_id", $this->user_account_id);

            if($stmt->execute()){
                $result = $stmt->fetch(PDO::FETCH_ASSOC);
                if ($result != null) {
                    return array("user_account_id"=>$result["kullanici_giris_bilgi_id"], "is_union_account"=>0);
                }
                return array("user_account_id"=>null, "is_union_account"=>null);
            }

            return array("user_account_id"=>null, "is_union_account"=>null);
        }
    }
?>