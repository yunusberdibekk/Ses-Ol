<?php
    class VoluntarilyTransporter{
        private $conn;
        private $db_table = "gonullu_tasimacilik";
        private $user_account_id;
        private $voluntarily_union_id;
        private $voluntarily_from_location;
        private $voluntarily_to_location;
        private $voluntarily_num_vehicle;
        private $voluntarily_num_driver;
        private $voluntarily_dec;
        private $voluntarily_approve_status;

        public function __construct($db){
            $this->conn = $db;
        }

        public function getUserAccountId(){
            return $this->user_account_id;
        }

        public function setUserAccountId(int $user_account_id){
            $this->user_account_id = $user_account_id;
        }
        
        public function getVoluntarilyUnionId(){
            return $this->voluntarily_union_id;
        }

        public function setVoluntarilyUnionId($voluntarily_union_id){
            $this->voluntarily_union_id = $voluntarily_union_id;
        }

        public function getVoluntarilyFromLocation(){
            return $this->voluntarily_from_location;
        }

        public function setVoluntarilyFromLocation($voluntarily_from_location){
            $this->voluntarily_from_location = $voluntarily_from_location;
        }

        public function getVoluntarilyToLocation(){
            return $this->voluntarily_to_location;
        }

        public function setVoluntarilyToLocation($voluntarily_to_location){
            $this->voluntarily_to_location = $voluntarily_to_location;
        }

        public function getVoluntarilyNumVehicle(){
            return $this->voluntarily_num_vehicle;
        }

        public function setVoluntarilyNumVehicle(int $voluntarily_num_vehicle){
            $this->voluntarily_num_vehicle = $voluntarily_num_vehicle;
        }

        public function getVoluntarilyNumDriver(){
            return $this->voluntarily_num_driver;
        }

        public function setVoluntarilyNumDriver(int $voluntarily_num_driver){
            $this->voluntarily_num_driver = $voluntarily_num_driver;
        }

        public function getVoluntarilyDec(){
            return $this->voluntarily_dec;
        }

        public function setVoluntarilyDec($voluntarily_dec){
            $this->voluntarily_dec = $voluntarily_dec;
        }

        public function getVoluntarilyStatus(){
            return $this->voluntarily_approve_status;
        }

        public function setVoluntarilyStatus(int $voluntarily_approve_status){
            $this->voluntarily_approve_status = $voluntarily_approve_status;
        }

        public function createVoluntarily(){
            $sqlQuery = "SELECT gonullu_tasimaci_hesap_id FROM ". $this->db_table ." WHERE gonullu_tasimaci_hesap_id = :voluntarily_account_id";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":voluntarily_account_id", $this->user_account_id);
            $stmt->execute();
            $checkUserExist = $stmt->fetch(PDO::FETCH_ASSOC);
            $checkUserExist = $checkUserExist["gonullu_tasimaci_hesap_id"] ?? null;
            if ($checkUserExist == null) {
                $sqlQuery = "INSERT INTO
                ". $this->db_table ."
                (gonullu_tasimaci_hesap_id,
                gonullu_kurum_talep_id,
                gonullu_alinacak_konum, 
                gonullu_birakilacak_konum,
                gonullu_vasita_sayisi,
                gonullu_sofor_sayisi,
                gonullu_aciklama)
                VALUES
                (:user_account_id, :voluntarily_union_id, :voluntarily_from_location, :voluntarily_to_location,
                :voluntarily_num_vehicle, :voluntarily_num_driver, :voluntarily_dec)";
        
                $stmt = $this->conn->prepare($sqlQuery);
                $stmt->bindParam(":user_account_id", $this->user_account_id);
                $stmt->bindParam(":voluntarily_union_id", $this->voluntarily_union_id);
                $stmt->bindParam(":voluntarily_from_location", $this->voluntarily_from_location);
                $stmt->bindParam(":voluntarily_to_location", $this->voluntarily_to_location);
                $stmt->bindParam(":voluntarily_num_vehicle", $this->voluntarily_num_vehicle);
                $stmt->bindParam(":voluntarily_num_driver", $this->voluntarily_num_driver);
                $stmt->bindParam(":voluntarily_dec", $this->voluntarily_dec);
                
                if ($stmt->execute()) {
                    return array('status'=>'ok', 'msg'=>'success');
                }

                return array('status'=>'error', 'msg'=>'db error');
            }
            return array('status'=>'error', 'msg'=>'Zaten basvuruldu.');
        }

        public function readVoluntarily($isAUnion){
            $sqlQuery = "";
            $stmt = null;
            if ($isAUnion == 0) {
                $sqlQuery = "SELECT giris_id, kullanici_adi, kullanici_soyadi, kullanici_tel, gonullu_kurum_talep_id, kurum_adi, gonullu_alinacak_konum,
                gonullu_birakilacak_konum, gonullu_sofor_sayisi, gonullu_vasita_sayisi, gonullu_aciklama,
                adres_id, adres_ilce, adres_sehir, adres_ulke, kullanici_acik_adres, tasimacilik_onay_durumu FROM kurum 
                    INNER JOIN (SELECT * FROM kullanici_adres 
                                INNER JOIN (SELECT * FROM giris_bilgi INNER JOIN 
                                    (SELECT * FROM kullanicilar INNER JOIN 
                                        (SELECT * FROM gonullu_tasimacilik WHERE gonullu_tasimaci_hesap_id = :user_account_id AND tasimacilik_onay_durumu = :voluntarily_approve_status) as gonullu_kul ON gonullu_kul.gonullu_tasimaci_hesap_id = kullanicilar.kullanici_giris_bilgi_id) as gonullu_kul_bilgi 
                                            ON giris_bilgi.giris_id = gonullu_kul_bilgi.kullanici_giris_bilgi_id) as gonullu_kul_iletisim 
                                                ON kullanici_adres.adres_kullanici_hesap_id = gonullu_kul_iletisim.kullanici_giris_bilgi_id) as gonullu
                                                    ON gonullu.gonullu_kurum_talep_id = kurum.kurum_giris_bilgi_id;";
                
            } else {
                $sqlQuery = "SELECT giris_id, kullanici_adi, kullanici_soyadi, kullanici_tel, gonullu_kurum_talep_id, kurum_adi, gonullu_alinacak_konum,
                gonullu_birakilacak_konum, gonullu_sofor_sayisi, gonullu_vasita_sayisi, gonullu_aciklama,
                adres_id, adres_ilce, adres_sehir, adres_ulke, kullanici_acik_adres, tasimacilik_onay_durumu FROM kurum 
                    INNER JOIN (SELECT * FROM kullanici_adres 
                                INNER JOIN (SELECT * FROM giris_bilgi INNER JOIN 
                                    (SELECT * FROM kullanicilar INNER JOIN 
                                        (SELECT * FROM gonullu_tasimacilik WHERE gonullu_kurum_talep_id = :user_account_id AND tasimacilik_onay_durumu = :voluntarily_approve_status) as gonullu_kul ON gonullu_kul.gonullu_tasimaci_hesap_id = kullanicilar.kullanici_giris_bilgi_id) as gonullu_kul_bilgi 
                                            ON giris_bilgi.giris_id = gonullu_kul_bilgi.kullanici_giris_bilgi_id) as gonullu_kul_iletisim 
                                                ON kullanici_adres.adres_kullanici_hesap_id = gonullu_kul_iletisim.kullanici_giris_bilgi_id) as gonullu
                                                    ON gonullu.gonullu_kurum_talep_id = kurum.kurum_giris_bilgi_id;";
                
            }
            
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam("user_account_id", $this->user_account_id);
            $stmt->bindParam("voluntarily_approve_status", $this->voluntarily_approve_status);
            $stmt->execute();
            $dataRows = $stmt->fetchAll(PDO::FETCH_ASSOC);
           
            if($dataRows != null){
                $result = array();
                foreach ($dataRows as $dataRow) {
                    $result [] = array("voluntarily_account_id"=>$dataRow['giris_id'], "user_name"=>$dataRow['kullanici_adi'],
                "user_surname"=>$dataRow['kullanici_soyadi'], "user_tel"=>$dataRow['kullanici_tel'], "union_id"=>$dataRow["gonullu_kurum_talep_id"], "union_name"=>$dataRow["kurum_adi"],
                "voluntarily_from_location"=>$dataRow['gonullu_alinacak_konum'], "voluntarily_to_location"=>$dataRow['gonullu_birakilacak_konum'],
                "voluntarily_num_driver"=>$dataRow['gonullu_sofor_sayisi'], "voluntarily_num_vehicle"=>$dataRow['gonullu_vasita_sayisi'], "voluntarily_dec"=>$dataRow['gonullu_aciklama'],
                "address_id"=>$dataRow['adres_id'], "address_district"=>$dataRow['adres_ilce'], "address_city"=>$dataRow['adres_sehir'], "address_country"=>$dataRow['adres_ulke'],
                "full_address"=>$dataRow['kullanici_acik_adres'], "voluntarily_approve_status"=>$dataRow['tasimacilik_onay_durumu']);
                }
                if($result != null){
                    return $result;
                }
            }
            return array("voluntarily_account_id"=>null, "user_name"=>null,
            "user_surname"=>null, "user_tel"=>null, "union_id"=>null, "union_name"=>null,
            "voluntarily_from_location"=>null, "voluntarily_to_location"=>null,
            "voluntarily_num_driver"=>null, "voluntarily_num_vehicle"=>null, "voluntarily_dec"=>null,
            "address_id"=>null, "address_district"=>null, "address_city"=>null, "address_country"=>null,
            "full_address"=>null, "voluntarily_approve_status"=>null);
        }

        public function updateVoluntarily(){
            $sqlQuery = "UPDATE ". $this->db_table ."
                SET tasimacilik_onay_durumu = :voluntarily_approve_status
                WHERE gonullu_tasimaci_hesap_id = :user_account_id";

            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":voluntarily_approve_status", $this->voluntarily_approve_status);
            $stmt->bindParam(":user_account_id", $this->user_account_id);

            if ($stmt->execute()) {
                return array('status'=>'ok', 'msg'=>'success');
            }

            return array('status'=>'error', 'msg'=>'db error');
        }

        public function deleteVoluntarily(){
            $sqlQuery = "DELETE FROM ". $this->db_table ."
            WHERE gonullu_tasimaci_hesap_id = :user_account_id";

            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":user_account_id", $this->user_account_id);

            if ($stmt->execute()) {
                return array('status'=>'ok', 'msg'=>'success');
            }

            return array('status'=>'error', 'msg'=>'db error');
        }

    }
