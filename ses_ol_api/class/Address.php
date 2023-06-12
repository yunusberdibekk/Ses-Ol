<?php
    class Address{
        private $conn;
        private $db_table = "kullanici_adres";
        private $address_id;
        private $address_user_account_id;
        private $address_district;
        private $address_city;
        private $address_country;
        private $full_address;

        public function __construct($db){
            $this->conn = $db;
        }

        public function getAddressId(){
            return $this->address_id;
        }

        public function setAddressId($address_id){
            $this->address_id = $address_id;
        }

        public function getUserAccountId(){
            return $this->address_user_account_id;
        }

        public function setUserAccountId($address_user_account_id){
            $this->address_user_account_id = $address_user_account_id;
        }

        public function getAddressDistrict(){
            return $this->address_district;
        }

        public function setAddressDistrict($address_district){
            $this->address_district = $address_district;
        }

        public function getAddressCity(){
            return $this->address_city;
        }

        public function setAddressCity($address_city){
            $this->address_city = $address_city;
        }

        public function getAddressCountryCity(){
            return $this->address_country;
        }

        public function setAddressCountryCity($address_country){
            $this->address_country = $address_country;
        }

        public function getFullAddress(){
            return $this->full_address;
        }

        public function setFullAddress($full_address){
            $this->full_address = $full_address;
        }

        public function createAddress(){
            $sqlQuery = "INSERT INTO ". $this->db_table ." 
                (adres_kullanici_hesap_id,
                adres_ilce,
                adres_sehir,
                adres_ulke,
                kullanici_acik_adres)
                VALUES
                (:address_user_account_id, :address_district, :address_city, :address_country, :full_address)";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam("address_user_account_id", $this->address_user_account_id);
            $stmt->bindParam("address_district", $this->address_district);
            $stmt->bindParam("address_city", $this->address_city);
            $stmt->bindParam("address_country", $this->address_country);
            $stmt->bindParam("full_address", $this->full_address);
            
            if ($stmt->execute()) {
                $stmt = $this->conn->query("SELECT LAST_INSERT_ID()");
                return $stmt->fetchColumn();
            }

            return null;
        }

    }
?>