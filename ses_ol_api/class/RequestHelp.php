<?php
    class RequestHelp{
        private $conn;
        private $db_table = "yardim_talebi";
        private $request_id;
        private $request_account_id;
        private $num_of_person;
        private $request_disaster_id;
        private $request_union_id;
        private $request_category;
        private $request_desc;
        private $request_status;

        public function __construct($db){
            $this->conn = $db;
        }

        public function getRequestId(){
            return $this->request_id;
        }

        public function setRequestId($request_id){
            $this->request_id = $request_id;
        }

        public function getRequestAccountId(){
            return $this->request_account_id;
        }

        public function setRequestAccountId($request_account_id){
            $this->request_account_id = $request_account_id;
        }

        public function getNumOfPerson(){
            return $this->num_of_person;
        }

        public function setNumOfPerson($num_of_person){
            $this->num_of_person = $num_of_person;
        }

        public function getDisasterId(){
            return $this->request_disaster_id;
        }

        public function setDisasterId($request_disaster_id){
            $this->request_disaster_id = $request_disaster_id;
        }

        public function getUnionId(){
            return $this->request_union_id;
        }

        public function setUnionId($request_union_id){
            $this->request_union_id = $request_union_id;
        }

        public function getCategory(){
            return $this->request_category;
        }

        public function setCategory($request_category){
            $this->request_category = $request_category;
        }

        public function getRequestDesc(){
            return $this->request_desc;
        }

        public function setRequestDesc($request_desc){
            $this->request_desc = $request_desc;
        }

        public function getRequestStatus(){
            return $this->request_status;
        }

        public function setRequestStatus($request_status){
            $this->request_status = $request_status;
        }

        public function readRequest($isAUnion){ 
            $sqlQuery = "SELECT talep_id, talep_hesap_id, kullanici_adi, kullanici_soyadi, kullanici_tel, talep_edilen_kurum, kurum_adi,
                        afet_id, afet_adi, talep_kategori, kategori_adi, talep_kisi_sayisi, talep_aciklama,
                        adres_id, adres_ilce, adres_sehir, adres_ulke, kullanici_acik_adres, talep_onay_durum
                        FROM kurum
                            INNER JOIN (SELECT * FROM afet
                            INNER JOIN (SELECT 	* FROM ihtiyac_kategori
                            INNER JOIN (SELECT * FROM kullanici_adres
                            INNER JOIN (SELECT * FROM giris_bilgi
                            INNER JOIN (SELECT * FROM kullanicilar
                            INNER JOIN (SELECT * FROM yardim_talebi WHERE talep_edilen_kurum = :user_account_id AND talep_onay_durum = :request_approve_status) as yardim_bilgi
                                ON yardim_bilgi.talep_hesap_id = kullanicilar.kullanici_giris_bilgi_id) as yardim_kisi_bilgi
                                ON yardim_kisi_bilgi.talep_hesap_id = giris_bilgi.giris_id) as yardim_kisi_adres
                                ON yardim_kisi_adres.kullanici_adres_id = kullanici_adres.adres_id) as yardim_kisi_adres_bilgi
                                ON yardim_kisi_adres_bilgi.talep_kategori = ihtiyac_kategori.kategori_id) as yardim_ihtiyac_bilgi
                                    ON yardim_ihtiyac_bilgi.talep_afet_id = afet.afet_id) as yardim_afet_bilgi
                                    ON yardim_afet_bilgi.talep_edilen_kurum = kurum.kurum_giris_bilgi_id;";
            
            if ($isAUnion == 0) {
                $sqlQuery = str_replace("WHERE talep_edilen_kurum","WHERE talep_hesap_id", $sqlQuery);
            }

            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":user_account_id", $this->request_account_id);
            $stmt->bindParam(":request_approve_status", $this->request_status);
            
            $stmt->execute();
            $dataRow = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $rows = array();
            if($dataRow != null){

                foreach ($dataRow as $row) {
                        $rows[] = array("request_id"=>$row["talep_id"], "request_account_id"=>$row["talep_hesap_id"],
                        "user_name"=>$row["kullanici_adi"], "user_surname"=>$row["kullanici_soyadi"], "user_tel"=>$row["kullanici_tel"],
                        "request_union_id"=>$row["talep_edilen_kurum"], "request_union_name"=>$row["kurum_adi"],
                        "request_disaster_id"=>$row["afet_id"], "request_disaster_name"=>$row["afet_adi"],
                        "request_category_id"=>$row["talep_kategori"], "request_category_name"=>$row["kategori_adi"],
                        "request_num_of_person"=>$row["talep_kisi_sayisi"], "request_desc"=>$row["talep_aciklama"],
                        "request_address_id"=>$row["adres_id"], "request_district"=>$row["adres_ilce"],
                        "request_city"=>$row["adres_sehir"], "request_country"=>$row["adres_ulke"],
                        "request_full_address"=>$row["kullanici_acik_adres"], "request_approve_status"=>$row["talep_onay_durum"]);
                }
            }
            if($rows != null){
                return $rows;
            }
            return array("request_id"=>null, "request_account_id"=>null,
            "user_name"=>null, "user_surname"=>null, "user_tel"=>null,
            "request_union_id"=>null, "request_union_name"=>null,
            "request_disaster_id"=>null, "request_disaster_name"=>null,
            "request_category_id"=>null, "request_category_name"=>null,
            "request_num_of_person"=>null, "request_desc"=>null,
            "request_address_id"=>null, "request_district"=>null,
            "request_city"=>null, "request_country"=>null,
            "request_full_address"=>null, "request_approve_status"=>null);
        }

        public function updateRequestStatus(){
            $sqlQuery = "UPDATE ". $this->db_table ." SET talep_onay_durum = :request_status
                WHERE talep_id = :request_id";
            
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":request_status", $this->request_status);
            $stmt->bindParam(":request_id", $this->request_id);
            
            if ($stmt->execute()) {
                return array('status'=>'ok', 'msg'=>'success');
            }

            return array('status'=>'error', 'msg'=>'db error');
        }

        public function createRequest(){
            $sqlQuery = "INSERT INTO ". $this->db_table ."
            (talep_hesap_id,
            talep_kisi_sayisi,
            talep_afet_id,
            talep_edilen_kurum,
            talep_kategori,
            talep_aciklama)
            VALUES
            (:request_account_id, :num_of_person, :request_disaster_id, :request_union_id,
            :request_category, :request_desc)";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":request_account_id", $this->request_account_id);
            $stmt->bindParam(":num_of_person", $this->num_of_person);
            $stmt->bindParam(":request_disaster_id", $this->request_disaster_id);
            $stmt->bindParam(":request_union_id", $this->request_union_id);
            $stmt->bindParam(":request_category", $this->request_category);
            $stmt->bindParam(":request_desc", $this->request_desc);
            if ($stmt->execute()) {
                return array('status'=>'ok', 'msg'=>'success');
            }

            return array('status'=>'error', 'msg'=>'db error');
        }

        public function deleteRequest(){
            $sqlQuery = "DELETE FROM ". $this->db_table ." WHERE talep_id = :request_id";
        
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":request_id", $this->request_id);
            if ($stmt->execute()) {
                return array('status'=>'ok', 'msg'=>'success');
            }

            return array('status'=>'error', 'msg'=>'db error');
        }


}
