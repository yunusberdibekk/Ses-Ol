<?php
    class ProvidingAssistance{
        private $conn;
        private $db_table = "yardim_saglayan";
        private $assistance_id;
        private $user_assistance_account_id;
        private $assistance_title;
        private $assistance_sent_union_id;
        private $assistance_num_of_person;
        private $assistance_category_id;
        private $assistance_status;
        private $assistance_desc;
        private $assistance_address_id;

        public function __construct($db){
            $this->conn = $db;
        }

        public function getAssistanceId(){
            return $this->assistance_id;
        }

        public function setAssistanceId(int $assistance_id){
            $this->assistance_id = $assistance_id;
        }

        public function getUserAccountId(){
            return $this->user_assistance_account_id;
        }

        public function setUserAccountId(int $user_assistance_account_id){
            $this->user_assistance_account_id = $user_assistance_account_id;
        }

        public function getAssistanceSentUnionId(){
            return $this->assistance_title;
        }

        public function setAssistanceSentUnionId(int $assistance_sent_union_id){
            $this->assistance_sent_union_id = $assistance_sent_union_id;
        }

        public function getAssistanceTitle(){
            return $this->assistance_title;
        }

        public function setAssistanceTitle(String $assistance_title){
            $this->assistance_title = $assistance_title;
        }

        public function getAssistanceNumOfPerson(){
            return $this->assistance_num_of_person;
        }

        public function setAssistanceNumOfPerson(int $assistance_num_of_person){
            $this->assistance_num_of_person = $assistance_num_of_person;
        }

        public function getAssistanceCategoryId(){
            return $this->assistance_category_id;
        }

        public function setAssistanceCategoryId(int $assistance_category_id){
            $this->assistance_category_id = $assistance_category_id;
        }

        public function getAssistanceStatus(){
            return $this->assistance_status;
        }

        public function setAssistanceStatus(int $assistance_status){
            $this->assistance_status = $assistance_status;
        }

        public function getAssistanceDesc(){
            return $this->assistance_desc;
        }

        public function setAssistanceDesc(String $assistance_desc){
            $this->assistance_desc = $assistance_desc;
        }

        public function getAssistanceAddressId(){
            return $this->assistance_address_id;
        }

        public function setAssistanceAddressId(String $assistance_address_id){
            $this->assistance_address_id = $assistance_address_id;
        }

        public function createAsistance(){
            $sqlQuery = "INSERT INTO ". $this->db_table ."
                (yardim_hesap_id,
                yardim_baslik,
                yardim_iletilen_kurum_id,
                yardim_kisi_sayisi,
                yardim_kategori,
                yardim_durumu,
                yardim_aciklama,
                yardim_adres_id)
                VALUES
                (:user_assistance_account_id, :assistance_title, :assistance_sent_union_id, :assistance_num_of_person,
                :assistance_category_id, :assistance_status, :assistance_desc, :assistance_address)";

                $stmt = $this->conn->prepare($sqlQuery);
                $stmt->bindParam(":user_assistance_account_id", $this->user_assistance_account_id);
                $stmt->bindParam(":assistance_title", $this->assistance_title);
                $stmt->bindParam(":assistance_sent_union_id", $this->assistance_sent_union_id);
                $stmt->bindParam(":assistance_num_of_person", $this->assistance_num_of_person);
                $stmt->bindParam(":assistance_category_id", $this->assistance_category_id);
                $stmt->bindParam(":assistance_status", $this->assistance_status);
                $stmt->bindParam(":assistance_desc", $this->assistance_desc);
                $stmt->bindParam(":assistance_address", $this->assistance_address_id);
                
                if ($stmt->execute()) {
                    return array('status'=>'ok', 'msg'=>'success');
                }
                return array('status'=>'error', 'msg'=>'db error');
        }

        public function readAsistance(){
            $sqlQuery = "(
                SELECT yardim_id, yardim_hesap_id, yardim_baslik, yardim_kisi_sayisi, yardim_kategori, yardim_durumu, yardim_aciklama,
                        kullanici_bilgi.kurum_adi as tam_isim, adres_id, adres_ilce, adres_sehir, adres_ulke, kullanici_acik_adres
                    FROM kullanici_adres 
                        INNER JOIN (    SELECT *
                                            FROM yardim_saglayan
                                            INNER JOIN kurum
                                                ON kurum.kurum_giris_bilgi_id = yardim_saglayan.yardim_hesap_id) AS kullanici_bilgi
                        ON kullanici_bilgi.kurum_giris_bilgi_id = kullanici_adres.adres_kullanici_hesap_id
            )
            UNION ALL
            (
                SELECT yardim_id, yardim_hesap_id, yardim_baslik, yardim_kisi_sayisi, yardim_kategori, yardim_durumu, yardim_aciklama,
                        (CONCAT(kullanici_bilgi.kullanici_adi,' ', kullanici_bilgi.kullanici_soyadi)) as tam_isim, adres_id, adres_ilce, adres_sehir, adres_ulke, kullanici_acik_adres
                    FROM kullanici_adres
                        INNER JOIN (      SELECT *
                                            FROM yardim_saglayan
                                                INNER JOIN kullanicilar
                                                    ON kullanicilar.kullanici_giris_bilgi_id = yardim_saglayan.yardim_hesap_id) AS kullanici_bilgi
                                                ON kullanici_bilgi.kullanici_giris_bilgi_id = kullanici_adres.adres_kullanici_hesap_id
            );";

            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":user_assistance_account_id", $this->user_assistance_account_id);

            $stmt->execute();
            $dataRows = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $result = array();
            foreach ($dataRows as $dataRow) {
                $result[] = array("assistance_id"=>$dataRow['yardim_id'], "assistance_user_account_id"=>$dataRow['yardim_hesap_id'],
                 "assistance_num_of_person"=>$dataRow['yardim_kisi_sayisi'], "assistance_category"=>$dataRow['yardim_kategori'], "asistance_status"=>$dataRow['yardim_durumu'],
                 "assistance_description"=>$dataRow['yardim_aciklama'], "fullname"=>$dataRow['tam_isim'],
                 "address_id"=>$dataRow['adres_id'], "address_district"=>$dataRow['adres_ilce'],
                 "address_city"=>$dataRow['adres_sehir'], "address_country"=>$dataRow['adres_ulke'],
                 "full_address"=>$dataRow['kullanici_acik_adres'], "assistance_status"=>$dataRow['yardim_durumu']);
            }
            if($result != null){
                return $result;
            }
            return array("assistance_id"=>null, "assistance_user_account_id"=>null,
            "assistance_num_of_person"=>null, "assistance_category"=>null, "asistance_status"=>null,
            "assistance_description"=>null, "fullname"=>null,
            "address_id"=>null, "address_district"=>null,
            "address_city"=>null, "address_country"=>null,
            "full_address"=>null, "assistance_status"=>null);

        }

        public function readMyAsistance($isAUnion){
            $sqlQuery = "";
            if ($isAUnion == 0) {
                $sqlQuery = "SELECT yardim_id, yardim_hesap_id, yardim_baslik, yardim_iletilen_kurum_id, kurum_adi, kullanici_tel, yardim_kisi_sayisi, yardim_kategori, kategori_adi, yardim_durumu, yardim_aciklama, (CONCAT(kul_yardim.kullanici_adi,' ', kul_yardim.kullanici_soyadi)) as tam_isim, adres_id, adres_ilce, adres_sehir, adres_ulke, kullanici_acik_adres FROM kurum
                    INNER JOIN (SELECT * FROM ihtiyac_kategori
                    INNER JOIN (SELECT * FROM kullanici_adres
                    INNER JOIN (SELECT * FROM yardim_saglayan
                    INNER JOIN (SELECT * FROM kullanicilar 
                    INNER JOIN giris_bilgi 
                                ON giris_bilgi.giris_id = kullanicilar.kullanici_giris_bilgi_id) as kul
                        ON kul.kullanici_giris_bilgi_id = yardim_saglayan.yardim_hesap_id HAVING kul.kullanici_giris_bilgi_id = :user_assistance_account_id) as kullanici_bilgi
                                                        ON kullanici_bilgi.yardim_adres_id = kullanici_adres.adres_id HAVING yardim_durumu = :assistance_status) as kul_ihtiyac
                                                            ON kul_ihtiyac.yardim_kategori = ihtiyac_kategori.kategori_id) as kul_yardim
                                                                ON kul_yardim.yardim_iletilen_kurum_id = kurum.kurum_giris_bilgi_id;";
            } else {
                $sqlQuery = "SELECT yardim_id, yardim_hesap_id, yardim_baslik, yardim_iletilen_kurum_id, kurum_adi, kullanici_tel, yardim_kisi_sayisi, yardim_kategori, kategori_adi, yardim_durumu, yardim_aciklama, (CONCAT(kullanicilar.kullanici_adi,' ', kullanicilar.kullanici_soyadi)) as tam_isim, adres_id, adres_ilce, adres_sehir, adres_ulke, kullanici_acik_adres FROM kullanicilar
                INNER JOIN (SELECT * FROM ihtiyac_kategori
                                INNER JOIN (SELECT * FROM kullanici_adres 
                                INNER JOIN (SELECT * FROM yardim_saglayan
                                INNER JOIN (SELECT * FROM kurum 
                                INNER JOIN giris_bilgi ON kurum.kurum_giris_bilgi_id = giris_bilgi.giris_id HAVING kurum.kurum_giris_bilgi_id = :user_assistance_account_id) as kurum_bil 
                                            ON kurum_bil.kurum_giris_bilgi_id = yardim_saglayan.yardim_iletilen_kurum_id HAVING yardim_saglayan.yardim_hesap_id != kurum_bil.kurum_giris_bilgi_id AND yardim_saglayan.yardim_durumu = :assistance_status) AS kullanici_bilgi 
                                                                    ON kullanici_bilgi.yardim_adres_id = kullanici_adres.adres_id) as kurum_yardim 
                                                                        ON kurum_yardim.yardim_kategori = ihtiyac_kategori.kategori_id)
                                                                         as yardim ON yardim.yardim_hesap_id = kullanicilar.kullanici_giris_bilgi_id;";
            }
            

            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":user_assistance_account_id", $this->user_assistance_account_id);
            $stmt->bindParam(":assistance_status", $this->assistance_status);

            $stmt->execute();
            $dataRows = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $result = array();
            foreach ($dataRows as $dataRow) {
                $result[] = array("assistance_id"=>$dataRow['yardim_id'], "assistance_title"=>$dataRow["yardim_baslik"], "assistance_sent_union_id"=>$dataRow["yardim_iletilen_kurum_id"], "assistance_sent_union_name"=>$dataRow["kurum_adi"], "assistance_user_account_id"=>$dataRow['yardim_hesap_id'],
                "user_tel"=>$dataRow["kullanici_tel"],"assistance_num_of_person"=>$dataRow['yardim_kisi_sayisi'], "assistance_category_id"=>$dataRow['yardim_kategori'], "assistance_category_name"=>$dataRow['kategori_adi'], "asistance_status"=>$dataRow['yardim_durumu'],
                 "assistance_description"=>$dataRow['yardim_aciklama'], "fullname"=>$dataRow['tam_isim'],
                 "address_id"=>$dataRow['adres_id'], "address_district"=>$dataRow['adres_ilce'],
                 "address_city"=>$dataRow['adres_sehir'], "address_country"=>$dataRow['adres_ulke'],
                 "full_address"=>$dataRow['kullanici_acik_adres'], "assistance_status"=>$dataRow['yardim_durumu']);
            }
            if($result != null){
                
                return $result;
            }
            return array("assistance_id"=>null, "assistance_title"=>null, "assistance_sent_union_id"=>null, "assistance_sent_union_name"=>null, "assistance_user_account_id"=>null,
            "user_tel"=>null,"assistance_num_of_person"=>null, "assistance_category_id"=>null, "assistance_category_name"=>null, "asistance_status"=>null,
             "assistance_description"=>null, "fullname"=>null,
             "address_id"=>null, "address_district"=>null,
             "address_city"=>null, "address_country"=>null,
             "full_address"=>null, "assistance_status"=>null);

        }

        public function deleteMyAssistance(){
            $sqlQuery = "DELETE FROM ". $this->db_table ." WHERE yardim_id = :assistance_id";
           
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":assistance_id", $this->assistance_id);

            if ($stmt->execute()) {
                return array('status'=>'ok', 'msg'=>'success');
            }
            return array('status'=>'error', 'msg'=>'db error');            
        }

        public function updateMyAssistance(){
            $sqlQuery = "UPDATE ". $this->db_table ." SET yardim_durumu = :assistance_status WHERE yardim_id = :assistance_id";

            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(":assistance_status", $this->assistance_status);
            $stmt->bindParam(":assistance_id", $this->assistance_id);

            if ($stmt->execute()) {
                return array('status'=>'ok', 'msg'=>'success');
            }
            return array('status'=>'error', 'msg'=>'db error');    
        }

    }
