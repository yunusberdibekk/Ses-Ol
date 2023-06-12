<?php
    class VoluntarilyPitchTent{
        private $conn;
        private $db_table = "gonullu_cadir_kuran";
        private $voluntarily_account_id;
        private $voluntarily_union_id;
        private $voluntarily_vehicle_status;
        private $voluntarily_desc;
        private $voluntarily_approve_status;

        public function __construct($db){
            $this->conn = $db;
        }

        public function getVoluntarilyAccountId(){
            return $this->voluntarily_account_id;
        }

        public function setVoluntarilyAccountId($voluntarily_account_id){
            $this->voluntarily_account_id = $voluntarily_account_id;
        }

        public function getVoluntarilyUnionId(){
            return $this->voluntarily_union_id;
        }

        public function setVoluntarilyUnionId($voluntarily_union_id){
            $this->voluntarily_union_id = $voluntarily_union_id;
        }

        public function getVoluntarilyVehicleStatus(){
            return $this->voluntarily_vehicle_status;
        }

        public function setVoluntarilyVehicleStatus($voluntarily_vehicle_status){
            $this->voluntarily_vehicle_status = $voluntarily_vehicle_status;
        }

        public function getVoluntarilyDesc(){
            return $this->voluntarily_desc;
        }

        public function setVoluntarilyDesc($voluntarily_desc){
            $this->voluntarily_desc = $voluntarily_desc;
        }

        public function getVoluntarilyApproveStatus(){
            return $this->voluntarily_approve_status;
        }

        public function setVoluntarilyApproveStatus($voluntarily_approve_status){
            $this->voluntarily_approve_status = $voluntarily_approve_status;
        }

        public function createVoluntarily(){
            $sqlQuery = "SELECT gonullu_hesap_id FROM ". $this->db_table ." WHERE gonullu_hesap_id = :voluntarily_account_id";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":voluntarily_account_id", $this->voluntarily_account_id);
            $stmt->execute();
            $checkUserExist = $stmt->fetch(PDO::FETCH_ASSOC);
            $checkUserExist = $checkUserExist["gonullu_hesap_id"] ?? null;
            if ($checkUserExist == null) {
                $sqlQuery = "INSERT INTO
                    ". $this->db_table ."
                    (gonullu_hesap_id,
                    gonullu_kurum_talep_id,
                    gonullu_vasita_durumu, 
                    gonullu_aciklama)
                    VALUES
                    (:voluntarily_account_id, :voluntarily_union_id, :voluntarily_vehicle_status,
                    :voluntarily_desc)";
                
                $stmt = $this->conn->prepare($sqlQuery);
                $stmt->bindParam(":voluntarily_account_id", $this->voluntarily_account_id);
                $stmt->bindParam(":voluntarily_union_id", $this->voluntarily_union_id);
                $stmt->bindParam(":voluntarily_vehicle_status", $this->voluntarily_vehicle_status);
                $stmt->bindParam(":voluntarily_desc", $this->voluntarily_desc);
                    
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
            if ($isAUnion == 1) {
                $sqlQuery = "SELECT gonullu_hesap_id, kullanici_adi, kullanici_soyadi, gonullu_kurum_talep_id, kurum_adi, kullanici_tel,
                gonullu_vasita_durumu, gonullu_aciklama, adres_id, adres_ilce, adres_sehir, adres_ulke, kullanici_acik_adres, gonullu_onay_durumu FROM kurum
                INNER JOIN (SELECT * FROM kullanici_adres 
                            INNER JOIN (SELECT * FROM giris_bilgi INNER JOIN 
                                (SELECT * FROM kullanicilar INNER JOIN 
                                    (SELECT * FROM gonullu_cadir_kuran WHERE gonullu_cadir_kuran.gonullu_kurum_talep_id = :user_account_id AND gonullu_onay_durumu = :voluntarily_approve_status) as gonullu_kul ON gonullu_kul.gonullu_hesap_id = kullanicilar.kullanici_giris_bilgi_id) as gonullu_kul_bilgi 
                                        ON giris_bilgi.giris_id = gonullu_kul_bilgi.kullanici_giris_bilgi_id) as gonullu_kul_iletisim 
                                            ON kullanici_adres.adres_kullanici_hesap_id = gonullu_kul_iletisim.kullanici_giris_bilgi_id) as gonullu
                                                ON gonullu.gonullu_kurum_talep_id = kurum.kurum_giris_bilgi_id;";
            } else {
                $sqlQuery = "SELECT gonullu_hesap_id, kullanici_adi, kullanici_soyadi, gonullu_kurum_talep_id, kurum_adi, kullanici_tel,
                gonullu_vasita_durumu, gonullu_aciklama, adres_id, adres_ilce, adres_sehir, adres_ulke, kullanici_acik_adres, gonullu_onay_durumu FROM kurum
                INNER JOIN (SELECT * FROM kullanici_adres 
                            INNER JOIN (SELECT * FROM giris_bilgi INNER JOIN 
                                (SELECT * FROM kullanicilar INNER JOIN 
                                    (SELECT * FROM gonullu_cadir_kuran WHERE gonullu_cadir_kuran.gonullu_hesap_id = :user_account_id AND gonullu_onay_durumu = :voluntarily_approve_status) as gonullu_kul ON gonullu_kul.gonullu_hesap_id = kullanicilar.kullanici_giris_bilgi_id) as gonullu_kul_bilgi 
                                        ON giris_bilgi.giris_id = gonullu_kul_bilgi.kullanici_giris_bilgi_id) as gonullu_kul_iletisim 
                                            ON kullanici_adres.adres_kullanici_hesap_id = gonullu_kul_iletisim.kullanici_giris_bilgi_id) as gonullu
                                                ON gonullu.gonullu_kurum_talep_id = kurum.kurum_giris_bilgi_id;";
            }

            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":user_account_id", $this->voluntarily_account_id);
            $stmt->bindParam(":voluntarily_approve_status", $this->voluntarily_approve_status);
            $stmt->execute();
            $dataRows = $stmt->fetchAll(PDO::FETCH_ASSOC);
            
            if($dataRows != null){
                $result = array();
                foreach ($dataRows as $dataRow) {
                    $result[] = array("voluntarily_account_id"=>$dataRow['gonullu_hesap_id'], "user_name"=>$dataRow['kullanici_adi'],
                    "user_surname"=>$dataRow['kullanici_soyadi'], "union_id"=>$dataRow["gonullu_kurum_talep_id"], "union_name"=>$dataRow["kurum_adi"], "user_tel"=>$dataRow['kullanici_tel'],
                    "voluntarily_vehicle_status"=>$dataRow['gonullu_vasita_durumu'], "voluntarily_desc"=>$dataRow['gonullu_aciklama'],
                    "address_id"=>$dataRow['adres_id'], "address_district"=>$dataRow['adres_ilce'], "address_city"=>$dataRow['adres_sehir'],
                    "address_country"=>$dataRow['adres_ulke'], "full_address"=>$dataRow['kullanici_acik_adres'], "voluntarily_approve_status"=>$dataRow['gonullu_onay_durumu']);
                }
                if($result != null){
                    return $result;
                }
            }
            return array("voluntarily_account_id"=>null, "user_name"=>null,
            "user_surname"=>null, "union_id"=>null, "union_name"=>null, "user_tel"=>null,
            "voluntarily_vehicle_status"=>null, "voluntarily_desc"=>null,
            "address_id"=>null, "address_district"=>null, "address_city"=>null,
            "address_country"=>null, "full_address"=>null, "voluntarily_approve_status"=>null);
        }

        public function updateVoluntarily(){
            $sqlQuery = "UPDATE ". $this->db_table ."
                SET gonullu_onay_durumu = :voluntarily_approve_status
                WHERE gonullu_hesap_id = :user_account_id";

            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":voluntarily_approve_status", $this->voluntarily_approve_status);
            $stmt->bindParam(":user_account_id", $this->voluntarily_account_id);

            if ($stmt->execute()) {
                return array('status'=>'ok', 'msg'=>'success');
            }

            return array('status'=>'error', 'msg'=>'db error');
        }

        public function deleteVoluntarily(){
            $sqlQuery = "DELETE FROM ". $this->db_table ."
            WHERE gonullu_hesap_id = :user_account_id";

            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":user_account_id", $this->voluntarily_account_id);

            if ($stmt->execute()) {
                return array('status'=>'ok', 'msg'=>'success');
            }

            return array('status'=>'error', 'msg'=>'db error');
        }

    }
    
?>