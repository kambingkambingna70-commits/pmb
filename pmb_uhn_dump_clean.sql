-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: pmb_uhn
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin_messages`
--

DROP TABLE IF EXISTS `admin_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `admission_form_id` bigint DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `message_content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `message_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `read_at` datetime(6) DEFAULT NULL,
  `replied_at` datetime(6) DEFAULT NULL,
  `status` enum('READ','REPLIED','UNREAD') COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_message_id` bigint DEFAULT NULL,
  `recipient_id` bigint NOT NULL,
  `sender_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKgun96t6scc2n1kiulom4yho1u` (`parent_message_id`),
  KEY `FKq4k4vhq1i4j94xof991eyug1c` (`recipient_id`),
  KEY `FKk49hxm904n7h1hm2rquf5kvy5` (`sender_id`),
  CONSTRAINT `FKgun96t6scc2n1kiulom4yho1u` FOREIGN KEY (`parent_message_id`) REFERENCES `admin_messages` (`id`),
  CONSTRAINT `FKk49hxm904n7h1hm2rquf5kvy5` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKq4k4vhq1i4j94xof991eyug1c` FOREIGN KEY (`recipient_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_messages`
--

LOCK TABLES `admin_messages` WRITE;
/*!40000 ALTER TABLE `admin_messages` DISABLE KEYS */;
INSERT INTO `admin_messages` VALUES (1,NULL,'2026-04-27 14:46:49.857367','aaaaaaaaaaaaa','QUESTION','2026-04-27 14:46:56.361915',NULL,'READ',NULL,1,8),(2,NULL,'2026-04-27 14:46:59.496727','apaaaaaaaaaaa','ANSWER','2026-04-27 14:47:04.726886',NULL,'READ',NULL,8,1),(3,NULL,'2026-04-30 09:13:29.209643','halo pemerintah','QUESTION',NULL,NULL,'UNREAD',NULL,1,9);
/*!40000 ALTER TABLE `admin_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admission_forms`
--

DROP TABLE IF EXISTS `admission_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admission_forms` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `additional_info` text COLLATE utf8mb4_unicode_ci,
  `address_medan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birth_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birth_place` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `certificate_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `district` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_birth_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_education` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_income` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_nik` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_occupation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_type` enum('MEDICAL','NON_MEDICAL') COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `information_source` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_seleksi_id` bigint DEFAULT NULL,
  `mother_birth_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_education` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_income` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_nik` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_occupation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nik` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nilai_file_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nisn` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_province` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_subdistrict` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` enum('MANUAL','SIMULATION') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo_id_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `program_studi_1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `program_studi_2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `program_studi_3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `province` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ranking_file_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `religion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `residence_info` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_major` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_origin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_province` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_year` int DEFAULT NULL,
  `selection_type_id` bigint DEFAULT NULL,
  `status` enum('DRAFT','REJECTED','SUBMITTED','VERIFIED','WAITING_PAYMENT') COLLATE utf8mb4_unicode_ci NOT NULL,
  `subdistrict` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `submitted_at` datetime(6) DEFAULT NULL,
  `transcript_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `period_id` bigint DEFAULT NULL,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKn83sdaby7b61v6w80wtmpmu4y` (`period_id`),
  KEY `FK3jsi8cxl04gjxkstlhl2xpb2n` (`student_id`),
  CONSTRAINT `FK3jsi8cxl04gjxkstlhl2xpb2n` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `FKn83sdaby7b61v6w80wtmpmu4y` FOREIGN KEY (`period_id`) REFERENCES `registration_periods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admission_forms`
--

LOCK TABLES `admission_forms` WRITE;
/*!40000 ALTER TABLE `admission_forms` DISABLE KEYS */;
INSERT INTO `admission_forms` VALUES (1,NULL,'Jln. Gatot Subroto No. 42, Medan','2005-03-15','Jakarta','uploads/admission-forms/1/certificate_1776609736131.png','Medan','2026-04-19 14:42:16.133589','Medan Timur','budi@example.com','1975-06-20','S1','','Slamet Riyanto','1234567890123400','Pegawai Negeri Sipil','081234567800','MASIH_HIDUP','MEDICAL','Budi Santoso','LAKI_LAKI','website',2,'1978-08-25','SMA','kurang_500k','Siti Rahayu','1234567890123401','','081234567801','MASIH_HIDUP','1234567890123456',NULL,'0012345678','Medan','12123123','Sumatera Utara','Sudirejo, Medan Timur','SIMULATION','081234567890','uploads/admission-forms/1/photoId_1776609736128.png','3','8','9','Sumatera Utara',NULL,'KRISTEN_PROTESTAN','tinggal_dengan_orang_tua','Kota Medan','Ilmu Pengetahuan Alam','SMAN 3 MEDAN','Prov. Sumatera Utara',2023,2,'VERIFIED','Sudirejo','2026-04-19 14:42:16.128493',NULL,'2026-04-19 14:42:16.133589',1,1),(2,NULL,'Jln. Gatot Subroto No. 42, Medan','2005-03-15','Jakarta','uploads/admission-forms/2/certificate_1776610819647.jpg','Medan','2026-04-19 15:00:19.648887','Medan Timur','budi@example.com','1975-06-20','S1','','Slamet Riyanto','1234567890123400','Pegawai Negeri Sipil','081234567800','MASIH_HIDUP','MEDICAL','Budi Santoso','LAKI_LAKI','website',2,'1978-08-25','SMA','kurang_500k','Siti Rahayu','1234567890123401','','081234567801','MASIH_HIDUP','1234567890123456',NULL,'0012345678','Medan','12123123','Sumatera Utara','Sudirejo, Medan Timur','SIMULATION','081234567890','uploads/admission-forms/2/photoId_1776610819642.jpg','3','8','9','Sumatera Utara',NULL,'KRISTEN_PROTESTAN','tinggal_dengan_orang_tua','Kota Medan','Ilmu Pengetahuan Alam','SMAN 3 MEDAN','Prov. Sumatera Utara',2023,2,'VERIFIED','Sudirejo','2026-04-19 15:00:19.642235','uploads/admission-forms/2/transcript_1776610819648.pdf','2026-04-19 15:16:32.063762',2,2),(3,NULL,'Jln. Gatot Subroto No. 42, Medan','2005-03-15','Jakarta','uploads/admission-forms/3/certificate_1776653398896.jpg','Medan','2026-04-20 02:49:58.902515','Medan Timur','budi@example.com','1975-06-20','S1','','Slamet Riyanto','1234567890123400','Pegawai Negeri Sipil','081234567800','MASIH_HIDUP','MEDICAL','Budi Santoso','LAKI_LAKI','website',2,'1978-08-25','SMA','kurang_500k','Siti Rahayu','1234567890123401','','081234567801','MASIH_HIDUP','1234567890123456',NULL,'0012345678','Medan','12123123','Sumatera Utara','Sudirejo, Medan Timur','SIMULATION','081234567890','uploads/admission-forms/3/photoId_1776653398895.jpg','13','14','9','Sumatera Utara',NULL,'KRISTEN_PROTESTAN','tinggal_dengan_orang_tua','Kota Medan','Ilmu Pengetahuan Alam','sma','Prov. Sumatera Utara',2023,2,'VERIFIED','Sudirejo','2026-04-20 02:49:58.895486','uploads/admission-forms/3/transcript_1776653398897.png','2026-04-20 02:49:58.902515',1,3),(4,NULL,'Jln. Gatot Subroto No. 42, Medan','2005-03-15','Jakarta','uploads/admission-forms/4/certificate_1777277547570.png','Medan','2026-04-27 08:12:27.575326','Medan Timur','budi@example.com','1975-06-20','S1','','Slamet Riyanto','1234567890123400','Pegawai Negeri Sipil','081234567800','MASIH_HIDUP','MEDICAL','Budi Santoso','LAKI_LAKI','website',2,'1978-08-25','SMA','kurang_500k','Siti Rahayu','1234567890123401','','081234567801','MASIH_HIDUP','1234567890123456',NULL,'0012345678','Medan','12123123','Sumatera Utara','Sudirejo, Medan Timur','SIMULATION','081234567890','uploads/admission-forms/4/photoId_1777277547568.png','13','14','9','Sumatera Utara',NULL,'KRISTEN_PROTESTAN','tinggal_dengan_orang_tua','Kab. Sleman','Ilmu Pengetahuan Alam','SMA BUDI MULIA DUA','Prov. D.I. Yogyakarta',2023,2,'VERIFIED','Sudirejo','2026-04-27 08:12:27.568526','uploads/admission-forms/4/transcript_1777277547572.png','2026-04-27 08:12:27.575326',2,4),(5,NULL,'Jln. Gatot Subroto No. 42, Medan','2005-03-15','Jakarta','uploads/admission-forms/5/certificate_1777301155822.png','Medan','2026-04-27 14:45:55.824584','Medan Timur','budi@example.com','1975-06-20','S1','','Slamet Riyanto','1234567890123400','Pegawai Negeri Sipil','081234567800','MASIH_HIDUP','MEDICAL','Budi Santoso','LAKI_LAKI','website',2,'1978-08-25','SMA','kurang_500k','Siti Rahayu','1234567890123401','','081234567801','MASIH_HIDUP','1234567890123456',NULL,'0012345678','Medan','12123123','Sumatera Utara','Sudirejo, Medan Timur','SIMULATION','081234567890','uploads/admission-forms/5/photoId_1777301155821.png','13','14','9','Sumatera Utara',NULL,'KRISTEN_PROTESTAN','tinggal_dengan_orang_tua','Kab. Simalungun','Ilmu Pengetahuan Alam','SMA NEGERI 1 PEMATANG BANDAR','Prov. Sumatera Utara',2023,2,'SUBMITTED','Sudirejo','2026-04-27 14:45:55.821582','uploads/admission-forms/5/transcript_1777301155822.png','2026-04-30 10:18:40.125347',2,5),(6,NULL,'Jln. Gatot Subroto No. 42, Medan','2005-03-15','Jakarta','uploads/admission-forms/6/certificate_1777540499736.jpg','Medan','2026-04-30 09:14:59.736016','Medan Timur','budi@example.com','1975-06-20','S1','','Slamet Riyanto','1234567890123400','Pegawai Negeri Sipil','081234567800','MASIH_HIDUP','MEDICAL','Budi Santoso','LAKI_LAKI','website',1,'1978-08-25','SMA','kurang_500k','Siti Rahayu','1234567890123401','','081234567801','MASIH_HIDUP','1234567890123456',NULL,'0012345678','Medan','12123123','Sumatera Utara','Sudirejo, Medan Timur','SIMULATION','081234567890','uploads/admission-forms/6/photoId_1777540499732.png','27','2','2','Sumatera Utara',NULL,'KRISTEN_PROTESTAN','tinggal_dengan_orang_tua','Kab. Simalungun','Ilmu Pengetahuan Alam','SMA NEGERI 1 PEMATANG BANDAR','Prov. Sumatera Utara',2023,1,'VERIFIED','Sudirejo','2026-04-30 09:14:59.736016','uploads/admission-forms/6/transcript_1777540499736.jpg','2026-04-30 09:14:59.736016',2,6),(7,NULL,'Jln. Gatot Subroto No. 42, Medan','2005-03-15','Jakarta','uploads/admission-forms/8/certificate_1777545239074.jpg','Medan','2026-04-30 10:33:59.081280','Medan Timur','budi@example.com','1975-06-20','S1','','Slamet Riyanto','1234567890123400','Pegawai Negeri Sipil','081234567800','MASIH_HIDUP','MEDICAL','Budi Santoso','LAKI_LAKI','website',2,'1978-08-25','SMA','kurang_500k','Siti Rahayu','1234567890123401','','081234567801','MASIH_HIDUP','1234567890123456',NULL,'0012345678','Medan','12123123','Sumatera Utara','Sudirejo, Medan Timur','SIMULATION','081234567890','uploads/admission-forms/8/photoId_1777545239067.jpg','14','2','2','Sumatera Utara',NULL,'KRISTEN_PROTESTAN','tinggal_dengan_orang_tua','Kab. Simalungun','Ilmu Pengetahuan Alam','sma n11','Prov. Sumatera Utara',2023,2,'VERIFIED','Sudirejo','2026-04-30 10:33:59.081280','uploads/admission-forms/8/transcript_1777545239074.jpg','2026-04-30 10:33:59.081280',2,8),(8,NULL,'Jln. Gatot Subroto No. 42, Medan','2005-03-15','Jakarta','uploads/admission-forms/11/certificate_1777546153056.jpg','Medan','2026-04-30 10:49:13.061069','Medan Timur','budi@example.com','1975-06-20','S1','','Slamet Riyanto','1234567890123400','Pegawai Negeri Sipil','081234567800','MASIH_HIDUP','MEDICAL','Budi Santoso','LAKI_LAKI','website',1,'1978-08-25','SMA','kurang_500k','Siti Rahayu','1234567890123401','','081234567801','MASIH_HIDUP','1234567890123456',NULL,'0012345678','Medan','12123123','Sumatera Utara','Sudirejo, Medan Timur','SIMULATION','081234567890','uploads/admission-forms/11/photoId_1777546153052.jpg','2','2','2','Sumatera Utara',NULL,'KRISTEN_PROTESTAN','tinggal_dengan_orang_tua','wdadwa','Ilmu Pengetahuan Alam','SMA N11 MEDAN','Sumatera Utara',2023,1,'VERIFIED','Sudirejo','2026-04-30 10:49:13.061069','uploads/admission-forms/11/transcript_1777546153056.png','2026-04-30 11:44:18.892217',2,11);
/*!40000 ALTER TABLE `admission_forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcements` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `announcement_type` enum('DEADLINE','EVENT','GENERAL','IMPORTANT','MAINTENANCE','UPCOMING') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `created_by_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` bit(1) NOT NULL,
  `priority` int NOT NULL,
  `published_at` datetime(6) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_announcement_created` (`created_at` DESC),
  KEY `idx_announcement_active` (`is_active` DESC)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcements`
--

LOCK TABLES `announcements` WRITE;
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
INSERT INTO `announcements` VALUES (1,'GENERAL','hati hati begal','2026-04-30 09:09:53.233918','admin@pmb.com','hati hati begal',_binary '',0,'2026-04-30 09:09:53.233918','hola','2026-04-30 09:09:53.233918');
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cicilan_request`
--

DROP TABLE IF EXISTS `cicilan_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cicilan_request` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `approved_at` datetime(6) DEFAULT NULL,
  `approved_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `briva` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catatan` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime(6) NOT NULL,
  `harga_cicilan_1` bigint NOT NULL,
  `harga_cicilan_2` bigint DEFAULT NULL,
  `harga_cicilan_3` bigint DEFAULT NULL,
  `harga_cicilan_4` bigint DEFAULT NULL,
  `harga_cicilan_5` bigint DEFAULT NULL,
  `harga_cicilan_6` bigint DEFAULT NULL,
  `harga_per_cicilan` bigint DEFAULT NULL,
  `harga_total` bigint NOT NULL,
  `jumlah_cicilan` int NOT NULL,
  `payment_method` enum('MANUAL','SIMULATION') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('APPROVED','PENDING','REJECTED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `admission_form_id` bigint NOT NULL,
  `program_studi_id` bigint NOT NULL,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK94xyryanybspmrrh69tgxk8oe` (`admission_form_id`),
  KEY `FKb3xa9s4jxkwce3hc33qcya3hv` (`program_studi_id`),
  KEY `FK8i8f9uddyb7wp7tgptkst6c32` (`student_id`),
  CONSTRAINT `FK8i8f9uddyb7wp7tgptkst6c32` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `FK94xyryanybspmrrh69tgxk8oe` FOREIGN KEY (`admission_form_id`) REFERENCES `admission_forms` (`id`),
  CONSTRAINT `FKb3xa9s4jxkwce3hc33qcya3hv` FOREIGN KEY (`program_studi_id`) REFERENCES `program_studi` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cicilan_request`
--

LOCK TABLES `cicilan_request` WRITE;
/*!40000 ALTER TABLE `cicilan_request` DISABLE KEYS */;
INSERT INTO `cicilan_request` VALUES (1,'2026-04-19 14:43:27.192891','Admin','1231231231',NULL,'2026-04-19 14:42:51.851263',0,1286867,1497767,0,0,0,4490000,8980000,2,'SIMULATION','APPROVED','2026-04-19 14:43:27.220277',1,3,1),(2,'2026-04-19 15:14:18.854945','Admin','21312312',NULL,'2026-04-19 15:10:34.245226',0,0,0,1439867,1439867,0,4490000,8980000,2,'SIMULATION','APPROVED','2026-04-19 15:14:18.892348',2,3,2),(3,'2026-04-26 16:40:09.417090','Admin','12312312',NULL,'2026-04-26 16:39:26.400779',1455583,691583,813083,925833,711833,0,1087600,5438000,5,'SIMULATION','APPROVED','2026-04-26 16:40:09.423065',3,13,3),(4,'2026-04-27 08:14:58.032097','Admin','1231312312',NULL,'2026-04-27 08:14:46.725125',2091167,1113167,1266167,1541167,1113167,0,1678200,8391000,5,'SIMULATION','APPROVED','2026-04-27 08:14:58.037596',4,14,4),(5,'2026-04-27 14:49:02.747284','Admin','12312312',NULL,'2026-04-27 14:48:51.716748',1455583,691583,813083,925833,0,0,1359500,5438000,4,'SIMULATION','APPROVED','2026-04-27 14:49:02.752283',5,13,5),(6,'2026-04-30 10:57:26.095180','Admin','123123',NULL,'2026-04-30 10:56:54.761061',1956567,1253567,1453567,0,0,0,1799800,8999000,5,'SIMULATION','APPROVED','2026-04-30 10:57:31.706896',8,2,11);
/*!40000 ALTER TABLE `cicilan_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_info`
--

DROP TABLE IF EXISTS `contact_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `operating_hours` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_info`
--

LOCK TABLES `contact_info` WRITE;
/*!40000 ALTER TABLE `contact_info` DISABLE KEYS */;
INSERT INTO `contact_info` VALUES (1,'Jalan Dr. Sutomo No. 4-A, Medan, Sumatera Utara.','2026-04-30 09:08:51.203518','pmb@uhn.ac.id','Senin sampai sabtu','9812313','2026-04-30 09:08:51.203518');
/*!40000 ALTER TABLE `contact_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_verification`
--

DROP TABLE IF EXISTS `document_verification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_verification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `document_type` enum('IJAZAH_SMA','KARTU_KELUARGA','KTP','NILAI_UTBK','SURAT_SEHAT','SURAT_TIDAK_BERHENTI_SEKOLAH') COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rejection_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('PENDING','REJECTED','VERIFIED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `upload_date` datetime(6) DEFAULT NULL,
  `verified_date` datetime(6) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `verified_by_admin_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4654u3viy8hjtajs8jxv3l9ub` (`user_id`),
  KEY `FKrnu6nf2qub24qkrbvhsoihg4e` (`verified_by_admin_id`),
  CONSTRAINT `FK4654u3viy8hjtajs8jxv3l9ub` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKrnu6nf2qub24qkrbvhsoihg4e` FOREIGN KEY (`verified_by_admin_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_verification`
--

LOCK TABLES `document_verification` WRITE;
/*!40000 ALTER TABLE `document_verification` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_verification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_log`
--

DROP TABLE IF EXISTS `email_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `attachment_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_type` enum('ADMIN_NOTIFICATION_NEW_DOCUMENT','CICILAN_PAYMENT_OVERDUE','CICILAN_PAYMENT_REMINDER','FORM_RECEIVED_CONFIRMATION','KARTU_UJIAN_FROM_PAYMENT','KARTU_UJIAN_NEW_REGISTRATION','NPM_ASSIGNMENT','PAYMENT_CONFIRMATION','VERIFICATION_COMPLETE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `error_message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recipient_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sent_date` datetime(6) DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `success_status` bit(1) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKij2strun7lyh9j91n67wvsblp` (`user_id`),
  CONSTRAINT `FKij2strun7lyh9j91n67wvsblp` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_log`
--

LOCK TABLES `email_log` WRITE;
/*!40000 ALTER TABLE `email_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_links`
--

DROP TABLE IF EXISTS `exam_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_links` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` bit(1) NOT NULL,
  `link_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link_url` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `period_id` bigint NOT NULL,
  `selection_type_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKak5jnf1vwyc6v0f4c9iygrckf` (`period_id`),
  KEY `FKoevip2csff60cl0ay1ou1rr06` (`selection_type_id`),
  CONSTRAINT `FKak5jnf1vwyc6v0f4c9iygrckf` FOREIGN KEY (`period_id`) REFERENCES `registration_periods` (`id`),
  CONSTRAINT `FKoevip2csff60cl0ay1ou1rr06` FOREIGN KEY (`selection_type_id`) REFERENCES `selection_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_links`
--

LOCK TABLES `exam_links` WRITE;
/*!40000 ALTER TABLE `exam_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_questions`
--

DROP TABLE IF EXISTS `exam_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_questions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `approval_status` enum('APPROVED','PENDING','REJECTED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `approved_at` datetime(6) DEFAULT NULL,
  `category` enum('BAHASA','IPA','IPS','PSIKOTES') COLLATE utf8mb4_unicode_ci NOT NULL,
  `correct_answer` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `difficulty` enum('EASY','HARD','MEDIUM') COLLATE utf8mb4_unicode_ci NOT NULL,
  `explanation` text COLLATE utf8mb4_unicode_ci,
  `optiona` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `optionb` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `optionc` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `optiond` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `optione` text COLLATE utf8mb4_unicode_ci,
  `question_text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `rejection_reason` text COLLATE utf8mb4_unicode_ci,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `approved_by_id` bigint DEFAULT NULL,
  `created_by_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKp2lnso9j1f0le9alsa9y4tm7k` (`approved_by_id`),
  KEY `FK7obogwvbi9no24x0wpl7c7wu7` (`created_by_id`),
  CONSTRAINT `FK7obogwvbi9no24x0wpl7c7wu7` FOREIGN KEY (`created_by_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKp2lnso9j1f0le9alsa9y4tm7k` FOREIGN KEY (`approved_by_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_questions`
--

LOCK TABLES `exam_questions` WRITE;
/*!40000 ALTER TABLE `exam_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_results`
--

DROP TABLE IF EXISTS `exam_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_results` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `admin_notes` text COLLATE utf8mb4_unicode_ci,
  `admission_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admission_password` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime(6) NOT NULL,
  `exam_validated_at` datetime(6) DEFAULT NULL,
  `exam_validation_status` enum('APPROVED','PENDING','REJECTED','REVISI') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generated_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gform_score` double DEFAULT NULL,
  `proof_photo_path` text COLLATE utf8mb4_unicode_ci,
  `published_at` datetime(6) DEFAULT NULL,
  `score` double NOT NULL,
  `status` enum('FAILED','PASSED','PENDING','PUBLISHED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_input_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `submission_date` datetime(6) DEFAULT NULL,
  `token_validated` bit(1) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `exam_id` bigint NOT NULL,
  `student_id` bigint DEFAULT NULL,
  `validated_by_admin_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKhy1l4dr680hoc7qhpk6xn3knq` (`exam_id`),
  KEY `FKr7qgl670f47u65kkdm8ex5119` (`student_id`),
  KEY `FKbqsbf8den183xv7vjbgytgwsg` (`validated_by_admin_id`),
  CONSTRAINT `FKbqsbf8den183xv7vjbgytgwsg` FOREIGN KEY (`validated_by_admin_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKr7qgl670f47u65kkdm8ex5119` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `FKtf85ht7yquiorwjx2xbdx3fxw` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_results`
--

LOCK TABLES `exam_results` WRITE;
/*!40000 ALTER TABLE `exam_results` DISABLE KEYS */;
INSERT INTO `exam_results` VALUES (1,'Γ£à Disetujui oleh validasi@pmb.com - wadawd',NULL,NULL,'2026-04-19 15:01:09.126365','2026-04-19 15:09:33.742235','APPROVED','UHN-TOKEN-CEDA7C',0,'/uploads/exam-proofs/exam-proof-2-1776611341570-9cdc8107-4d06-4e41-88fe-746b9693c1ff.jpg',NULL,0,'FAILED','UHN-TOKEN-CEDA7C','2026-04-19 15:09:01.590012',_binary '','2026-04-19 15:09:33.749221',1,2,2),(2,'Γ£à Disetujui oleh validasi@pmb.com - bagus',NULL,NULL,'2026-04-27 08:13:14.003899','2026-04-27 08:13:56.781535','APPROVED','UHN-TOKEN-8790A7',0,'/uploads/exam-proofs/exam-proof-4-1777277593966-5047d9d9-cef0-4a41-82f4-0b344c7f652d.jpg',NULL,0,'FAILED','UHN-TOKEN-8790A7','2026-04-27 08:13:14.002902',_binary '','2026-04-27 08:13:56.793768',2,4,2),(3,'Γ£à Disetujui oleh validasi@pmb.com - wadadawdaw',NULL,NULL,'2026-04-27 14:47:34.512875','2026-04-27 14:48:00.237198','APPROVED','UHN-TOKEN-8611FE',0,'/uploads/exam-proofs/exam-proof-5-1777301254495-34c3e997-f9ee-49b8-9862-474143d732bd.jpg',NULL,0,'FAILED','UHN-TOKEN-8611FE','2026-04-27 14:47:34.511875',_binary '','2026-04-27 14:48:00.241198',3,5,2),(4,'≡ƒÜ¿ TOKEN MISMATCH DETECTED - Possible fraud attempt',NULL,NULL,'2026-04-30 09:17:03.682642','2026-04-30 09:17:03.682642','REJECTED','UHN-TOKEN-FD9528',0,'/uploads/exam-proofs/exam-proof-6-1777540623668-d5baaf86-91cf-4bdc-b140-6b473aaf6863.jpg',NULL,0,'FAILED','UHN-TOKEN-DFA9E6','2026-04-30 09:17:03.682642',_binary '\0','2026-04-30 09:17:03.682642',4,6,NULL),(5,'≡ƒÜ¿ TOKEN MISMATCH DETECTED - Possible fraud attempt',NULL,NULL,'2026-04-30 10:34:32.183442','2026-04-30 10:34:32.183442','REJECTED','UHN-TOKEN-5B221E',0,'/uploads/exam-proofs/exam-proof-8-1777545272172-292688f9-147b-4792-91c5-aafc7dc2adf7.jpg',NULL,0,'FAILED','UHN-TOKEN-D721FD','2026-04-30 10:34:32.183442',_binary '\0','2026-04-30 10:34:32.183442',5,8,NULL),(6,'adadad',NULL,NULL,'2026-04-30 10:49:56.297104','2026-04-30 10:50:37.776841','APPROVED','UHN-TOKEN-9D1028',0,'/uploads/exam-proofs/exam-proof-11-1777546196281-e7c9780c-e0cd-4630-8fcb-eb39f27b386e.jpg',NULL,0,'FAILED','UHN-TOKEN-43A34A','2026-04-30 10:49:56.297104',_binary '\0','2026-04-30 10:50:37.811583',6,11,NULL);
/*!40000 ALTER TABLE `exam_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_submissions`
--

DROP TABLE IF EXISTS `exam_submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_submissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `google_form_response_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `passed` bit(1) DEFAULT NULL,
  `score` int DEFAULT NULL,
  `score_synced_at` datetime(6) DEFAULT NULL,
  `status` enum('CANCELLED','COMPLETED','FAILED','PENDING') COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_data` longtext COLLATE utf8mb4_unicode_ci,
  `submitted_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `token_id` bigint DEFAULT NULL,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKoe0rsdfdgj3w3xqqq0gqky098` (`token_id`),
  KEY `FKg9k1eim8xh3x3ws1wxqa4pnwk` (`student_id`),
  CONSTRAINT `FKg9k1eim8xh3x3ws1wxqa4pnwk` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `FKoe0rsdfdgj3w3xqqq0gqky098` FOREIGN KEY (`token_id`) REFERENCES `exam_tokens` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_submissions`
--

LOCK TABLES `exam_submissions` WRITE;
/*!40000 ALTER TABLE `exam_submissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_submissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_tokens`
--

DROP TABLE IF EXISTS `exam_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_tokens` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `approved_form_id` bigint DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `expires_at` datetime(6) NOT NULL,
  `revoked_at` datetime(6) DEFAULT NULL,
  `status` enum('ACTIVE','EXPIRED','REVOKED','USED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `token_value` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `used_at` datetime(6) DEFAULT NULL,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKny7s2y7nmm2nvy6bmagf724sj` (`token_value`),
  KEY `FKmyheqpe0m9cgb0ifknbqr0b2q` (`student_id`),
  CONSTRAINT `FKmyheqpe0m9cgb0ifknbqr0b2q` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_tokens`
--

LOCK TABLES `exam_tokens` WRITE;
/*!40000 ALTER TABLE `exam_tokens` DISABLE KEYS */;
INSERT INTO `exam_tokens` VALUES (1,2,'2026-04-19 15:00:34.055227','2026-04-19 17:00:34.055227',NULL,'ACTIVE','UHN-TOKEN-CEDA7C',NULL,2),(2,4,'2026-04-27 08:12:46.279731','2026-04-27 10:12:46.279731',NULL,'ACTIVE','UHN-TOKEN-8790A7',NULL,4),(3,5,'2026-04-27 14:47:11.789241','2026-04-27 16:47:11.789241',NULL,'ACTIVE','UHN-TOKEN-8611FE',NULL,5),(4,6,'2026-04-30 09:15:28.315756','2026-04-30 11:15:28.315756',NULL,'ACTIVE','UHN-TOKEN-DFA9E6',NULL,6),(5,6,'2026-04-30 09:15:35.352221','2026-04-30 11:15:35.352221',NULL,'ACTIVE','UHN-TOKEN-FD9528',NULL,6),(6,6,'2026-04-30 09:15:39.641578','2026-04-30 11:15:39.641578',NULL,'ACTIVE','UHN-TOKEN-4CC8C4',NULL,6),(7,7,'2026-04-30 10:34:15.787303','2026-04-30 12:34:15.787303',NULL,'ACTIVE','UHN-TOKEN-D721FD',NULL,8),(8,7,'2026-04-30 10:34:20.099724','2026-04-30 12:34:20.099724',NULL,'ACTIVE','UHN-TOKEN-5B221E',NULL,8),(9,8,'2026-04-30 10:49:31.220921','2026-04-30 12:49:31.220921',NULL,'ACTIVE','UHN-TOKEN-43A34A',NULL,11),(10,8,'2026-04-30 10:49:35.631851','2026-04-30 12:49:35.631851',NULL,'ACTIVE','UHN-TOKEN-9D1028',NULL,11);
/*!40000 ALTER TABLE `exam_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exams`
--

DROP TABLE IF EXISTS `exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exams` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `admin_notes` text COLLATE utf8mb4_unicode_ci,
  `completed_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `exam_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gform_response_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gform_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `started_at` datetime(6) DEFAULT NULL,
  `status` enum('COMPLETED','GRADED','NOT_STARTED','PENDING','STARTED','SUBMITTED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `period_id` bigint NOT NULL,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKg8b7ssuj4vevtrwebet3x439l` (`exam_number`),
  KEY `FKdn0sb8u89ewssgvy2kga78155` (`period_id`),
  KEY `FKg8t292c0nfvmltp1gsudhg78m` (`student_id`),
  CONSTRAINT `FKdn0sb8u89ewssgvy2kga78155` FOREIGN KEY (`period_id`) REFERENCES `registration_periods` (`id`),
  CONSTRAINT `FKg8t292c0nfvmltp1gsudhg78m` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exams`
--

LOCK TABLES `exams` WRITE;
/*!40000 ALTER TABLE `exams` DISABLE KEYS */;
INSERT INTO `exams` VALUES (1,NULL,'2026-04-19 15:09:01.610039','2026-04-19 15:01:09.119935','UJI6911929917',NULL,NULL,'2026-04-19 15:01:09.119935','COMPLETED','2026-04-19 15:09:01.628028',2,2),(2,NULL,'2026-04-27 08:13:14.008720','2026-04-27 08:13:13.994306','UJI9399158841',NULL,NULL,'2026-04-27 08:13:13.993308','COMPLETED','2026-04-27 08:13:14.026829',2,4),(3,NULL,'2026-04-27 14:47:34.516880','2026-04-27 14:47:34.503874','UJI5450135903',NULL,NULL,'2026-04-27 14:47:34.502874','COMPLETED','2026-04-27 14:47:34.530878',2,5),(4,NULL,'2026-04-30 09:17:03.682642','2026-04-30 09:17:03.675831','UJI2367544167',NULL,NULL,'2026-04-30 09:17:03.675831','COMPLETED','2026-04-30 09:17:03.689599',2,6),(5,NULL,'2026-04-30 10:34:32.183442','2026-04-30 10:34:32.179878','UJI7217746842',NULL,NULL,'2026-04-30 10:34:32.179878','COMPLETED','2026-04-30 10:34:32.187036',2,8),(6,NULL,'2026-04-30 10:49:56.305567','2026-04-30 10:49:56.289711','UJI9628716973',NULL,NULL,'2026-04-30 10:49:56.289711','COMPLETED','2026-04-30 10:49:56.309299',2,11);
/*!40000 ALTER TABLE `exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_repair_status`
--

DROP TABLE IF EXISTS `form_repair_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_repair_status` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `status` enum('BELUM_PERBAIKAN','SUDAH_PERBAIKAN') COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `form_validation_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK5k4g15bmjf9q9gmx6ppgqb92y` (`form_validation_id`),
  CONSTRAINT `FK5k4g15bmjf9q9gmx6ppgqb92y` FOREIGN KEY (`form_validation_id`) REFERENCES `form_validations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_repair_status`
--

LOCK TABLES `form_repair_status` WRITE;
/*!40000 ALTER TABLE `form_repair_status` DISABLE KEYS */;
INSERT INTO `form_repair_status` VALUES (1,'2026-04-19 14:42:16.142650',NULL,'BELUM_PERBAIKAN','2026-04-19 14:42:16.142650',1),(2,'2026-04-19 15:00:19.662731',NULL,'SUDAH_PERBAIKAN','2026-04-19 15:16:15.998360',2),(3,'2026-04-20 02:49:58.930444',NULL,'BELUM_PERBAIKAN','2026-04-20 02:49:58.930444',3),(4,'2026-04-27 08:12:27.608289',NULL,'BELUM_PERBAIKAN','2026-04-27 08:12:27.608289',4),(5,'2026-04-27 14:45:55.838917',NULL,'BELUM_PERBAIKAN','2026-04-30 10:18:40.125347',5),(6,'2026-04-30 09:14:59.742937',NULL,'BELUM_PERBAIKAN','2026-04-30 09:14:59.742937',6),(7,'2026-04-30 10:33:59.081280',NULL,'BELUM_PERBAIKAN','2026-04-30 10:33:59.081280',7),(8,'2026-04-30 10:49:13.085039',NULL,'SUDAH_PERBAIKAN','2026-04-30 11:43:48.036083',8);
/*!40000 ALTER TABLE `form_repair_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_validations`
--

DROP TABLE IF EXISTS `form_validations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_validations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `exam_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_amount` bigint DEFAULT NULL,
  `payment_date` datetime(6) DEFAULT NULL,
  `payment_status` enum('PAID','PENDING','VERIFIED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `rejected_at` datetime(6) DEFAULT NULL,
  `rejection_reason` text COLLATE utf8mb4_unicode_ci,
  `rejection_topic` text COLLATE utf8mb4_unicode_ci,
  `revision_number` int DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `validated_at` datetime(6) DEFAULT NULL,
  `validation_status` enum('APPROVED','PENDING','REJECTED','REVISION_NEEDED','SUSPENDED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `virtual_account_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admission_form_id` bigint NOT NULL,
  `student_id` bigint NOT NULL,
  `admin_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4j26p0pg4l8cc7vt53oxbd231` (`admission_form_id`),
  KEY `FKompk9ni2fax7wgf5eq87cefjy` (`student_id`),
  KEY `FKcir4qamaqdld3kmyk68gdn44x` (`admin_id`),
  CONSTRAINT `FK4j26p0pg4l8cc7vt53oxbd231` FOREIGN KEY (`admission_form_id`) REFERENCES `admission_forms` (`id`),
  CONSTRAINT `FKcir4qamaqdld3kmyk68gdn44x` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKompk9ni2fax7wgf5eq87cefjy` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_validations`
--

LOCK TABLES `form_validations` WRITE;
/*!40000 ALTER TABLE `form_validations` DISABLE KEYS */;
INSERT INTO `form_validations` VALUES (1,'2026-04-19 14:42:16.138607',NULL,750000,NULL,'PENDING',NULL,NULL,NULL,NULL,'2026-04-19 14:42:22.422788','2026-04-19 14:45:06.117334','APPROVED','8860742403200297',1,1,2),(2,'2026-04-19 15:00:19.655535','UHN-TOKEN-CEDA7C',750000,'2026-04-19 15:00:34.034511','PAID',NULL,'2. Bukti UJIAN: kurang kuat','Perbaiki Data',1,'2026-04-19 15:00:34.034511','2026-04-19 15:16:32.046821','APPROVED','8860824827963713',2,2,2),(3,'2026-04-20 02:49:58.922515',NULL,750000,NULL,'PENDING',NULL,NULL,NULL,NULL,'2026-04-26 16:38:39.758339',NULL,'PENDING','8860519741062382',3,3,NULL),(4,'2026-04-27 08:12:27.595622','UHN-TOKEN-8790A7',750000,'2026-04-27 08:12:46.253690','PAID',NULL,NULL,NULL,NULL,'2026-04-27 08:12:46.253690','2026-04-27 08:16:09.145476','APPROVED','8860552841052180',4,4,2),(5,'2026-04-27 14:45:55.832581','UHN-TOKEN-8611FE',750000,'2026-04-27 14:47:11.776418','PAID',NULL,'4. Bukti Bayar Formulir: jelek bukti formulir anda','Perbaiki Data',1,'2026-04-27 14:47:11.776418','2026-04-30 10:18:40.085218','REVISION_NEEDED','8860161009017308',5,5,2),(6,'2026-04-30 09:14:59.742937','UHN-TOKEN-FD9528',1500000,'2026-04-30 09:15:35.347342','PAID',NULL,NULL,NULL,NULL,'2026-04-30 09:15:35.347342',NULL,'PENDING','8860505054379451',6,6,NULL),(7,'2026-04-30 10:33:59.081280','UHN-TOKEN-5B221E',750000,'2026-04-30 10:34:20.094573','PAID',NULL,NULL,NULL,NULL,'2026-04-30 10:34:20.094573',NULL,'PENDING','8860244347674821',7,8,NULL),(8,'2026-04-30 10:49:13.078056','UHN-TOKEN-9D1028',1500000,'2026-04-30 10:49:35.626359','PAID',NULL,'adawdawdawdaw','Perbaikan Diperlukan - Revisi ke 1',1,'2026-04-30 10:49:35.626359','2026-04-30 11:44:18.871341','APPROVED','8860158338267417',8,11,2);
/*!40000 ALTER TABLE `form_validations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formula_selections`
--

DROP TABLE IF EXISTS `formula_selections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formula_selections` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `features` text COLLATE utf8mb4_unicode_ci,
  `form_type` enum('MEDICAL','NON_MEDICAL') COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon_emoji` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` bit(1) NOT NULL,
  `price` decimal(38,2) NOT NULL,
  `sort_order` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKecd18ebtq0r6w05swabet7we1` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formula_selections`
--

LOCK TABLES `formula_selections` WRITE;
/*!40000 ALTER TABLE `formula_selections` DISABLE KEYS */;
INSERT INTO `formula_selections` VALUES (1,'MEDICAL','2026-04-19 16:54:28.518736','Program Studi Kedokteran dengan fasilitas praktik lengkap dan kurikulum internasional','Lab Lengkap,Tes Tulis,Wawancara,Assessment Psikologi,Simulasi Klinis','MEDICAL','≡ƒÅÑ',_binary '',1500000.00,1,'Kedokteran','2026-04-19 16:54:28.518736'),(2,'NON_MEDICAL','2026-04-19 16:54:28.519733','25+ Program Studi Non-Medis: Teknik, Pendidikan, Ekonomi, Hukum, Psikologi, Pertanian, dan Pascasarjana','Fasilitas Modern,Dosen Bersertifikat,Industri Ready,25+ Program Studi,Tools Canggih','NON_MEDICAL','≡ƒôÜ',_binary '',750000.00,2,'Program Non-Kedokteran','2026-04-19 16:54:28.519733');
/*!40000 ALTER TABLE `formula_selections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gelombang_link_ujian`
--

DROP TABLE IF EXISTS `gelombang_link_ujian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gelombang_link_ujian` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `exam_date` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exam_place` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exam_time` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_ujian` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `registration_period_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK60270j1lstsytnbgp5hcvj3pl` (`registration_period_id`),
  CONSTRAINT `FKojaqfwnwwwhpfx9foh8an3p3u` FOREIGN KEY (`registration_period_id`) REFERENCES `registration_periods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gelombang_link_ujian`
--

LOCK TABLES `gelombang_link_ujian` WRITE;
/*!40000 ALTER TABLE `gelombang_link_ujian` DISABLE KEYS */;
INSERT INTO `gelombang_link_ujian` VALUES (2,'2026-04-30 09:07:57.679575',NULL,NULL,NULL,'https://docs.google.com/forms/d/e/1FAIpQLSdnnGXubXoeA81ojr_m4Ks1v8OwvQlqsWjtiNPoqcqbh8H5Ug/viewform','2026-04-30 09:07:57.679575',2);
/*!40000 ALTER TABLE `gelombang_link_ujian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hasil_akhir`
--

DROP TABLE IF EXISTS `hasil_akhir`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hasil_akhir` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `briva_amount` decimal(15,2) DEFAULT NULL,
  `briva_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `jumlah_cicilan` int DEFAULT NULL,
  `ktm_sementara_file` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nomor_registrasi` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `npm_sementara_file` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `program_studi_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selection_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','CANCELLED','EXPIRED','PENDING','USED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `wave_type` enum('EARLY_NO_TEST','RANKING_NO_TEST','REGULAR_TEST') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selection_period_id` bigint DEFAULT NULL,
  `student_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_briva` (`briva_number`),
  UNIQUE KEY `uk_nomor_registrasi` (`nomor_registrasi`),
  UNIQUE KEY `uk_student_id` (`student_id`),
  UNIQUE KEY `UK36938om7my599jsy2b99dpw9s` (`user_id`),
  KEY `FKq97h14wrikluuo61an0ovrch4` (`selection_period_id`),
  CONSTRAINT `FKaotgkoo7uirak30crhexq7n91` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `FKq97h14wrikluuo61an0ovrch4` FOREIGN KEY (`selection_period_id`) REFERENCES `registration_periods` (`id`),
  CONSTRAINT `FKrtxg325we92gsvdc8f8q5ikgx` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hasil_akhir`
--

LOCK TABLES `hasil_akhir` WRITE;
/*!40000 ALTER TABLE `hasil_akhir` DISABLE KEYS */;
INSERT INTO `hasil_akhir` VALUES (1,NULL,'PENDING_1776609898607','2026-04-19 14:44:58.609260',1,NULL,'REG-20260419-000001',NULL,NULL,NULL,'PENDING','2026-04-19 14:44:58.609260',NULL,NULL,1,4),(2,NULL,'PENDING_1776611792021','2026-04-19 15:16:32.023895',1,NULL,'REG-20260419-000002','uploads/hasil-akhir/2/npm_sementara_1776611796379.pdf','3','Program Non-Kedokteran','ACTIVE','2026-04-19 15:16:36.394114','REGULAR_TEST',2,2,5),(3,NULL,'PENDING_1777277769121','2026-04-27 08:16:09.123674',1,NULL,'REG-20260427-000004','uploads/hasil-akhir/4/npm_sementara_1777277773304.pdf','13','Program Non-Kedokteran','ACTIVE','2026-04-27 08:16:13.313622','REGULAR_TEST',2,4,7),(4,8999000.00,'123123','2026-04-30 10:57:22.006915',1,NULL,'REG-20260430-000011','uploads/hasil-akhir/11/npm_sementara_1777549463743.pdf','2','Kedokteran','ACTIVE','2026-04-30 11:44:23.767690','REGULAR_TEST',2,11,14);
/*!40000 ALTER TABLE `hasil_akhir` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jenis_seleksi`
--

DROP TABLE IF EXISTS `jenis_seleksi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jenis_seleksi` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `fasilitas` text COLLATE utf8mb4_unicode_ci,
  `harga` decimal(38,2) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `logo_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` int NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKfk3ehw9c73b7l8gdwkqs7jo8u` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jenis_seleksi`
--

LOCK TABLES `jenis_seleksi` WRITE;
/*!40000 ALTER TABLE `jenis_seleksi` DISABLE KEYS */;
INSERT INTO `jenis_seleksi` VALUES (1,'KEDOKTERAN','2026-04-19 16:54:28.527274','Program Studi Kedokteran dengan fasilitas praktik lengkap','Lab Lengkap,Tes tulis,Wawancara,Assessment psikologi',1500000.00,_binary '','≡ƒÆë','Kedokteran',1,'2026-04-30 09:07:42.112927'),(2,'NON_KEDOKTERAN','2026-04-19 16:54:28.529567','Semua program studi non-kedokteran: Teknik, Pendidikan, Ekonomi, Hukum, Seni & Sastra, Pertanian, Psikologi, Sosial-Politik, & Pascasarjana','Fasilitas Modern,Dosen Bersertifikat,Industri Ready,25+ Program Studi',750000.00,_binary '','≡ƒÄô','Program Non-Kedokteran',2,'2026-04-19 16:54:28.529567');
/*!40000 ALTER TABLE `jenis_seleksi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` datetime(6) DEFAULT NULL,
  `sent_at` datetime(6) DEFAULT NULL,
  `status` enum('DELIVERED','FAILED','PENDING','SENT') COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('EXAM_READY','EXAM_REMINDER','PAYMENT_CONFIRMED','REENROLLMENT_REMINDER','REGISTRATION_CONFIRMATION','RESULT_PUBLISHED','SYSTEM_MESSAGE','VALIDATION_APPROVED','VALIDATION_REJECTED','VA_GENERATED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9y21adhxn0ayjhfocscqox7bh` (`user_id`),
  CONSTRAINT `FK9y21adhxn0ayjhfocscqox7bh` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `expiry_date` datetime(6) NOT NULL,
  `is_used` bit(1) NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK71lqwbwtklmljk3qlsugr1mig` (`token`),
  KEY `FKk3ndxg5xp6v7wd4gjyusp15gq` (`user_id`),
  CONSTRAINT `FKk3ndxg5xp6v7wd4gjyusp15gq` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_briva`
--

DROP TABLE IF EXISTS `payment_briva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_briva` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(38,2) NOT NULL,
  `briva_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `briva_reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `due_datetime` datetime(6) DEFAULT NULL,
  `paid_datetime` datetime(6) DEFAULT NULL,
  `purpose` enum('DAFTAR_ULANG_CICILAN_1','DAFTAR_ULANG_CICILAN_2','DAFTAR_ULANG_CICILAN_3','DAFTAR_ULANG_CICILAN_4','FORMULIR_REGISTRATION') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('EXPIRED','FAILED','PAID','PENDING') COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKibufe3qdrfgxnegpskps9tcr7` (`briva_code`),
  KEY `FKds8n5spr019xv8dyj796odg09` (`user_id`),
  CONSTRAINT `FKds8n5spr019xv8dyj796odg09` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_briva`
--

LOCK TABLES `payment_briva` WRITE;
/*!40000 ALTER TABLE `payment_briva` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_briva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `period_jenis_seleksi`
--

DROP TABLE IF EXISTS `period_jenis_seleksi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `period_jenis_seleksi` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `jenis_seleksi_id` bigint NOT NULL,
  `period_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKvc93rqdljqpcv04v8ntgs0s7` (`period_id`,`jenis_seleksi_id`),
  KEY `FKs4t4qjeok0wnnet4549ewx4hc` (`jenis_seleksi_id`),
  CONSTRAINT `FKmolekmabf81n51t1uoqa7ah8i` FOREIGN KEY (`period_id`) REFERENCES `registration_periods` (`id`),
  CONSTRAINT `FKs4t4qjeok0wnnet4549ewx4hc` FOREIGN KEY (`jenis_seleksi_id`) REFERENCES `jenis_seleksi` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `period_jenis_seleksi`
--

LOCK TABLES `period_jenis_seleksi` WRITE;
/*!40000 ALTER TABLE `period_jenis_seleksi` DISABLE KEYS */;
INSERT INTO `period_jenis_seleksi` VALUES (1,'2026-04-19 16:54:28.633375',_binary '','2026-04-19 16:54:28.633375',1,1),(2,'2026-04-19 16:54:28.635544',_binary '','2026-04-19 16:54:28.635544',2,1),(7,'2026-04-19 14:59:52.776469',_binary '','2026-04-19 14:59:52.776469',1,2),(8,'2026-04-19 14:59:52.783411',_binary '','2026-04-19 14:59:52.783411',2,2),(9,'2026-04-30 08:58:56.334911',_binary '','2026-04-30 08:58:56.334911',1,3),(10,'2026-04-30 08:58:56.369606',_binary '','2026-04-30 08:58:56.369606',2,3);
/*!40000 ALTER TABLE `period_jenis_seleksi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_studi`
--

DROP TABLE IF EXISTS `program_studi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program_studi` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cicilan_1` bigint DEFAULT NULL,
  `cicilan_2` bigint DEFAULT NULL,
  `cicilan_3` bigint DEFAULT NULL,
  `cicilan_4` bigint DEFAULT NULL,
  `cicilan_5` bigint DEFAULT NULL,
  `cicilan_6` bigint DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `fakultas` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `harga_total_per_tahun` bigint DEFAULT NULL,
  `is_active` bit(1) NOT NULL,
  `is_medical` bit(1) DEFAULT NULL,
  `kode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` int NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK3nm4chilsg16pan5vw2j36giv` (`kode`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_studi`
--

LOCK TABLES `program_studi` WRITE;
/*!40000 ALTER TABLE `program_studi` DISABLE KEYS */;
INSERT INTO `program_studi` VALUES (1,1226583,600083,691083,621983,545483,618283,'2026-04-19 16:54:28.536763','','FKIP',4305500,_binary '',_binary '\0','pend-fisika','Pend. Fisika',1,'2026-04-19 16:57:46.000000'),(2,1956567,1253567,1453567,1473167,1320167,1542167,'2026-04-19 16:54:28.539375','','FKIP',8999000,_binary '',_binary '\0','pend-bahasa-sastra-indonesia','Pend. B. Indonesia',2,'2026-04-19 16:57:46.000000'),(3,1939867,1286867,1497767,1439867,1439867,893533,'2026-04-19 16:54:28.540379','','FKIP',8980000,_binary '',_binary '\0','pend-biologi-inggris','Pend. B. Inggris',3,'2026-04-19 16:57:46.000000'),(4,1821267,1118267,1272967,1271267,1118267,1272967,'2026-04-19 16:54:28.540379','','FKIP',7875000,_binary '',_binary '\0','pend-pancasila-kewarganegaraan','Pend. PPKn',4,'2026-04-19 16:57:46.000000'),(5,1875867,1172867,1345767,1243967,1080967,1337567,'2026-04-19 16:54:28.541392','','FKIP',8057000,_binary '',_binary '\0','pend-ekonomi','Pend. Ekonomi',5,'2026-04-19 16:57:46.000000'),(6,1875867,1172867,1345767,1243967,1090967,1236567,'2026-04-19 16:54:28.542879','','FKIP',7966000,_binary '',_binary '\0','pend-matematika','Pend. Matematika',6,'2026-04-19 16:57:41.000000'),(7,1848567,1145567,1309367,1271267,1118267,1272967,'2026-04-19 16:54:28.543882','','FKIP',7966000,_binary '',_binary '\0','pend-agama-kristen','Pend. Agama Kristen',7,'2026-04-19 16:57:46.000000'),(8,1375083,600083,691083,825083,600083,691083,'2026-04-19 16:54:28.545385','','FKIP',4782500,_binary '',_binary '\0','pend-ipa','Pend. IPA',8,'2026-04-19 16:57:46.000000'),(9,1719967,1066967,1204567,1169967,1066967,1204567,'2026-04-19 16:54:28.546596','','FISIPOL',7433000,_binary '',_binary '\0','adm-bisnis','Adm. Bisnis',9,'2026-04-19 16:57:41.000000'),(10,1427475,800225,993425,877475,800225,813425,'2026-04-19 16:54:28.547788','','FISIPOL',5712250,_binary '',_binary '\0','adm-publik','Adm. Publik',10,'2026-04-19 16:57:41.000000'),(11,2280167,1302167,1618167,1811167,1383167,1626167,'2026-04-19 16:54:28.549833','','Teknik',9921000,_binary '',_binary '\0','teknik-sipil','Teknik Sipil',11,'2026-04-19 16:57:46.000000'),(12,2352167,1374167,1614167,1802167,1374167,1614167,'2026-04-19 16:54:28.550829','','Teknik',10131000,_binary '',_binary '\0','teknik-mesin','Teknik Mesin',12,'2026-04-19 16:57:46.000000'),(13,1455583,691583,813083,925833,711833,840083,'2026-04-19 16:54:28.551890','','Teknik',5438000,_binary '',_binary '\0','teknik-elektro','Teknik Elektro',13,'2026-04-19 16:57:46.000000'),(14,2091167,1113167,1266167,1541167,1113167,1266167,'2026-04-19 16:54:28.553322','','Teknik',8391000,_binary '',_binary '\0','informatika','Informatika',14,'2026-04-19 16:57:46.000000'),(15,1615125,875375,1003625,1065125,875375,1003625,'2026-04-19 16:54:28.553322','','Peternakan',6438250,_binary '',_binary '\0','prod-ternak','Prod. Ternak',15,'2026-04-19 16:57:41.000000'),(16,2111167,1383167,1626167,1561167,1383167,1626167,'2026-04-19 16:54:28.554606','','Ekonomi & Bisnis',9691000,_binary '',_binary '\0','akuntansi','Akuntansi',16,'2026-04-19 16:57:46.000000'),(17,2111167,1383167,1626167,1561167,1383167,1626167,'2026-04-19 16:54:28.555608','','Ekonomi & Bisnis',9991000,_binary '',_binary '\0','manajemen','Manajemen',17,'2026-04-19 16:57:46.000000'),(18,1981567,1253567,1453567,1431567,1253567,1453567,'2026-04-19 16:54:28.555608','','Ekonomi & Bisnis',8827000,_binary '',_binary '\0','ekonomi-pembangunan','Ekonomi Pembangunan',18,'2026-04-19 16:57:46.000000'),(19,1896567,1118567,1273367,1346567,1118567,1273367,'2026-04-19 16:54:28.558111','','Ekonomi & Bisnis',8027000,_binary '',_binary '\0','adm-pajak','Adm. Pajak',19,'2026-04-19 16:57:41.000000'),(20,1857967,1204967,1388567,1388567,1204967,1308067,'2026-04-19 16:54:28.559108','','Hukum',8353000,_binary '',_binary '\0','ilmu-hukum','Ilmu Hukum',20,'2026-04-19 16:57:41.000000'),(21,1833875,875375,1003625,1083875,875375,803625,'2026-04-19 16:54:28.560398','','Pertanian',6475750,_binary '',_binary '\0','agroteknologi','Agroteknologi',21,'2026-04-19 16:57:41.000000'),(22,1833875,875375,1003625,1083875,875375,803625,'2026-04-19 16:54:28.561606','','Pertanian',6475750,_binary '',_binary '\0','agribisnis','Agribisnis',22,'2026-04-19 16:57:41.000000'),(23,1248283,559283,636683,698283,559283,636683,'2026-04-19 16:54:28.561606','','Pertanian',4338500,_binary '',_binary '\0','thp','Teknologi Hasil Pertanian',23,'2026-04-19 16:57:41.000000'),(24,2411567,1361567,1597367,1881567,1381567,1557367,'2026-04-19 16:54:28.562711','','Bahasa & Seni',10191000,_binary '',_binary '\0','seni-musik','Seni Musik',24,'2026-04-19 16:57:41.000000'),(25,1860625,915875,1057625,1039625,916875,767625,'2026-04-19 16:54:28.563865','','Bahasa & Seni',6558250,_binary '',_binary '\0','sastra-inggris','Sastra Inggris',25,'2026-04-19 16:57:41.000000'),(26,1546200,881450,1011725,1039625,924875,1069625,'2026-04-19 16:54:28.565368','','Psikologi',6473500,_binary '',_binary '\0','psikologi','Psikologi',26,'2026-04-19 16:57:41.000000'),(27,1000000,1000000,1000000,1000000,1000000,1000000,'2026-04-30 09:06:46.610450','wdadwad',NULL,6000000,_binary '',_binary '\0','ww','wwada',0,'2026-04-30 09:06:46.610450');
/*!40000 ALTER TABLE `program_studi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publication_schedule`
--

DROP TABLE IF EXISTS `publication_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publication_schedule` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `created_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_published` bit(1) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `publish_date_time` datetime(6) NOT NULL,
  `published_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `period_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_pub_schedule_period` (`period_id`),
  CONSTRAINT `FK7a3e796406w859fw9f1cmbsfu` FOREIGN KEY (`period_id`) REFERENCES `registration_periods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publication_schedule`
--

LOCK TABLES `publication_schedule` WRITE;
/*!40000 ALTER TABLE `publication_schedule` DISABLE KEYS */;
INSERT INTO `publication_schedule` VALUES (1,'2026-04-30 09:09:31.165066','admin@pmb.com',_binary '','jadwal publikasi hasil','2026-04-30 09:09:00.000000','2026-04-30 09:09:31.164069','2026-04-30 09:09:31.165066',2);
/*!40000 ALTER TABLE `publication_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reenrollment_data`
--

DROP TABLE IF EXISTS `reenrollment_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reenrollment_data` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `approval_date` datetime(6) DEFAULT NULL,
  `cicilation_type` enum('CICILAN_2','CICILAN_3','CICILAN_4','FULL_PAYMENT') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `status` enum('ASSIGNED','FULLY_PAID','PARTIAL_PAID','PENDING','REJECTED','VERIFIED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `approved_by_admin_id` bigint DEFAULT NULL,
  `program_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2fciy4k3o99sb3hbc6euom5r6` (`approved_by_admin_id`),
  KEY `FK97ihx2uri8bn4js31kg7aou49` (`program_id`),
  KEY `FKcb09y8i8vyp5xhnn0ae3shpee` (`user_id`),
  CONSTRAINT `FK2fciy4k3o99sb3hbc6euom5r6` FOREIGN KEY (`approved_by_admin_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK97ihx2uri8bn4js31kg7aou49` FOREIGN KEY (`program_id`) REFERENCES `selection_types` (`id`),
  CONSTRAINT `FKcb09y8i8vyp5xhnn0ae3shpee` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reenrollment_data`
--

LOCK TABLES `reenrollment_data` WRITE;
/*!40000 ALTER TABLE `reenrollment_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `reenrollment_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reenrollment_documents`
--

DROP TABLE IF EXISTS `reenrollment_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reenrollment_documents` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `admin_notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime(6) NOT NULL,
  `document_type` enum('IJAZAH','KARTU_KELUARGA','KARTU_TANDA_PENDUDUK','KETERANGAN_BEBAS_NARKOBA','PAKTA_INTEGRITAS','PASPHOTO','SKCK') COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_mime_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_path` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_size` bigint DEFAULT NULL,
  `original_filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `upload_status` enum('COMPLETED','FAILED','INVALID','PENDING') COLLATE utf8mb4_unicode_ci NOT NULL,
  `uploaded_at` datetime(6) DEFAULT NULL,
  `validated_at` datetime(6) DEFAULT NULL,
  `validation_status` enum('APPROVED','PENDING','REJECTED','REVISION_NEEDED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `reenrollment_id` bigint NOT NULL,
  `validated_by_admin_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKb9eu45ndvs2sx9gt8rlk3oksk` (`reenrollment_id`),
  KEY `FKfp2irq3ekjsp38mi5h791mv0r` (`validated_by_admin_id`),
  CONSTRAINT `FKb9eu45ndvs2sx9gt8rlk3oksk` FOREIGN KEY (`reenrollment_id`) REFERENCES `reenrollments` (`id`),
  CONSTRAINT `FKfp2irq3ekjsp38mi5h791mv0r` FOREIGN KEY (`validated_by_admin_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reenrollment_documents`
--

LOCK TABLES `reenrollment_documents` WRITE;
/*!40000 ALTER TABLE `reenrollment_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `reenrollment_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reenrollment_validations`
--

DROP TABLE IF EXISTS `reenrollment_validations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reenrollment_validations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `rejected_at` datetime(6) DEFAULT NULL,
  `rejection_reason` text COLLATE utf8mb4_unicode_ci,
  `rejection_topic` text COLLATE utf8mb4_unicode_ci,
  `validated_at` datetime(6) DEFAULT NULL,
  `validation_status` enum('APPROVED','PENDING','REJECTED','SUSPENDED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `reenrollment_id` bigint NOT NULL,
  `student_id` bigint NOT NULL,
  `admin_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1j01hmu517ulopeuncg3skgec` (`reenrollment_id`),
  KEY `FK4nseaqiir9vovj0tn7jw8wqu4` (`student_id`),
  KEY `FKmp6nkorvoserf7wba68i7433u` (`admin_id`),
  CONSTRAINT `FK1j01hmu517ulopeuncg3skgec` FOREIGN KEY (`reenrollment_id`) REFERENCES `reenrollments` (`id`),
  CONSTRAINT `FK4nseaqiir9vovj0tn7jw8wqu4` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `FKmp6nkorvoserf7wba68i7433u` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reenrollment_validations`
--

LOCK TABLES `reenrollment_validations` WRITE;
/*!40000 ALTER TABLE `reenrollment_validations` DISABLE KEYS */;
/*!40000 ALTER TABLE `reenrollment_validations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reenrollments`
--

DROP TABLE IF EXISTS `reenrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reenrollments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `alumni_family` bit(1) DEFAULT NULL,
  `alumni_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alumni_relation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `current_address` text COLLATE utf8mb4_unicode_ci,
  `ijazah_file` text COLLATE utf8mb4_unicode_ci,
  `kartu_keluarga_file` text COLLATE utf8mb4_unicode_ci,
  `ktp_file` text COLLATE utf8mb4_unicode_ci,
  `pakta_integritas_file` text COLLATE utf8mb4_unicode_ci,
  `parent_address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pasphoto_file` text COLLATE utf8mb4_unicode_ci,
  `permanent_address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `skck_file` text COLLATE utf8mb4_unicode_ci,
  `status` enum('COMPLETED','INCOMPLETE','REJECTED','SUBMITTED','VALIDATED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `submitted_at` datetime(6) DEFAULT NULL,
  `surat_bebas_narkoba_file` text COLLATE utf8mb4_unicode_ci,
  `updated_at` datetime(6) DEFAULT NULL,
  `validated_at` datetime(6) DEFAULT NULL,
  `validation_notes` text COLLATE utf8mb4_unicode_ci,
  `exam_result_id` bigint DEFAULT NULL,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKd0ogite953e4iyoffrcgir968` (`exam_result_id`),
  KEY `FKkp54m0b8o8021j89udx0xhlmx` (`student_id`),
  CONSTRAINT `FKd0ogite953e4iyoffrcgir968` FOREIGN KEY (`exam_result_id`) REFERENCES `exam_results` (`id`),
  CONSTRAINT `FKkp54m0b8o8021j89udx0xhlmx` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reenrollments`
--

LOCK TABLES `reenrollments` WRITE;
/*!40000 ALTER TABLE `reenrollments` DISABLE KEYS */;
INSERT INTO `reenrollments` VALUES (1,_binary '\0',NULL,NULL,'2026-04-19 14:44:40.151969','wadawdaw','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\7c9c6a31-a38a-432c-bd28-b33091c2b00e_20260207_0243_Image_Generation_simple_compose_01kgt7mfzxf14vcxe6kbbe25f3.png','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\d13664b5-5902-4178-9b82-d07bd097c85c_20260207_0243_Image_Generation_simple_compose_01kgt7mfzxf14vcxe6kbbe25f3.png','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\5be923b5-c38a-4a9f-b667-635defc27c22_Brosur-2026-UHN.pdf','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\18fd682d-a812-45b7-907f-2d4b8824b495_60484-viralkan-tumbler-hilang-di-krl-anita-dewi-si-pemilik-dipecat-perusahan-instagram.jpg','J8W9+QGG, Way Huwi, Kec. Jati Agung, Kabupaten Lampung Selatan, Lampung 35365','admin@uhn.ac.id','Mychael Daniel N','083872746279','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\857ae187-be8a-421c-9510-e9bdcc6b902d_60484-viralkan-tumbler-hilang-di-krl-anita-dewi-si-pemilik-dipecat-perusahan-instagram.jpg','wadawdaw','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\2f05a608-52f2-4a4e-9d32-d1e9da5188a7_certificate_1774789258550.png','SUBMITTED','2026-04-19 14:44:40.150962','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\49e2ec76-b7b8-48ff-9620-a7ec91fe74c7_ChatGPT_Image_Feb_12__2026__06_30_12_PM.png','2026-04-19 14:44:40.199041',NULL,NULL,NULL,1),(2,_binary '\0',NULL,NULL,'2026-04-19 15:15:28.047195','wdawd','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\c9bd3843-b6f0-4785-b272-6c265ea54cac_20260207_0243_Image_Generation_simple_compose_01kgt7mfzxf14vcxe6kbbe25f3.png','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\f136bb38-8488-4596-9d19-ebc4823f0a11_20260207_0243_Image_Generation_simple_compose_01kgt7mfzxf14vcxe6kbbe25f3.png','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\adc59e73-b2cf-474d-a021-0edd03751789_20260207_0246_Image_Generation_simple_compose_01kgt7sgmrf8vs98wvk8n9z61h.png','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\e4419e03-d258-40a8-91ff-2413e170e744_60484-viralkan-tumbler-hilang-di-krl-anita-dewi-si-pemilik-dipecat-perusahan-instagram.jpg','J8W9+QGG, Way Huwi, Kec. Jati Agung, Kabupaten Lampung Selatan, Lampung 35365','admin@uhn.ac.id','Mychael Daniel N','083872746279','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\60bfd1ee-7df5-4c60-b696-755f3eacdeae_20260207_0246_Image_Generation_simple_compose_01kgt7sgmrf8vs98wvk8n9z61h.png','wdawd','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\23b2f952-c1d6-4647-afe0-8048f77383a3_20260207_0243_Image_Generation_simple_compose_01kgt7mfzxf14vcxe6kbbe25f3.png','SUBMITTED','2026-04-19 15:15:28.045140','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\87dc5066-a895-40c4-a223-00f0b12e2b2a_20260207_0246_Image_Generation_simple_compose_01kgt7sgmrf8vs98wvk8n9z61h.png','2026-04-19 15:15:28.100807',NULL,NULL,NULL,2),(3,_binary '\0',NULL,NULL,'2026-04-27 08:15:40.053451','awdawdaw','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\d219d23d-eb49-4eeb-8158-ae3fc35132dd_dfd-level2-proses1-1.png','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\82da4ef5-4474-4398-a276-318e5c8f503f_flowchart-daftar-ulang.png','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\929ce8ec-17d3-420a-8a79-2319747ffa3f_keyboard.jpg','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\e37e8223-226d-4821-98c6-7dd4019016a2_dfd-level2-proses1-2.png','AWDAWD','admin@uhn.ac.id','test student','083872746279','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\4c5babb2-cbd1-4937-bb34-09fa2f1b22f0_dfd-level2-proses1-2.png','awdawdaw','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\55372dbf-209c-4852-9a54-cf5e55284e3c_flowchart-registrasi-ujian.png','SUBMITTED','2026-04-27 08:15:40.053451','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\07e78908-5693-4564-b8d1-524315764802_flowchart-daftar-ulang.png','2026-04-27 08:15:40.078829',NULL,NULL,NULL,4),(4,_binary '','',NULL,'2026-04-27 14:49:47.877695','adawdawdaw','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\77cd9b8e-dd6c-45f1-98b8-69d9a4c430d9_dfd-level2-proses2-2.png','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\7bce264e-af3a-4cfb-9591-218b6732c007_sequence-pendaftaran-ujian.png','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\00d35f8e-0adf-4906-aaf9-cc1d204c2584_dfd-level2-proses2-2.png','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\c2218587-31a6-4e37-8444-8bb57dd431d0_lampiran-data-pendaftar.png','AWDAWD','admin@uhn.ac.id','mikel','083872746279','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\6207c377-a49e-4999-bf93-49cff30aa22c_sequence-pendaftaran-formulir.png','adawdawdaw','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\3dd5c7bc-5440-4934-827f-d5f5f11b2f96_lampiran-daftar-ulang.png','SUBMITTED','2026-04-27 14:49:47.877695','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\0ad250c2-8e7b-475d-bbc0-1ecda8623afc_lampiran-daftar-ulang.png','2026-04-27 14:49:47.902868',NULL,NULL,NULL,5),(5,_binary '\0',NULL,NULL,'2026-04-30 11:14:22.317207','adawd','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\3ea73222-221b-4e8d-857f-23b725c3bdfd_sequence-konfigurasi.png','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\479e22d4-3f8a-47fd-bf89-04a02570b5e7_sequence-pendaftaran-formulir.png','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\23aaf9e7-4067-4467-8ccb-35663bf23454_flowchart-registrasi-ujian.png','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\9b0e3fd7-5e0d-4337-a7da-d70e36ac9069_sequence-konfigurasi.png','J8W9+QGG, Way Huwi, Kec. Jati Agung, Kabupaten Lampung Selatan, Lampung 35365','admin@uhn.ac.id','Budi Santoso','083872746279','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\baaf0bd7-ac9e-48a8-92c1-d4741049c6ce_sequence-pendaftaran-formulir.png','adawd','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\9d8afe02-c23f-4188-8088-58afd06f3fb1_ui-status-daftar-ulang.png','SUBMITTED','2026-04-30 11:14:22.316211','D:\\all code\\aa\\tugasakhir\\uploads\\reenrollment\\52cb34f9-3627-4cb6-a794-5b86a1d17a9f_sequence-daftar-ulang.png','2026-04-30 11:14:22.341170',NULL,NULL,NULL,11);
/*!40000 ALTER TABLE `reenrollments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_periods`
--

DROP TABLE IF EXISTS `registration_periods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_periods` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `announcement_date` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `exam_date` datetime(6) NOT NULL,
  `exam_end_date` datetime(6) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reenrollment_end_date` datetime(6) NOT NULL,
  `reenrollment_start_date` datetime(6) NOT NULL,
  `reg_end_date` datetime(6) NOT NULL,
  `reg_start_date` datetime(6) NOT NULL,
  `requirements` text COLLATE utf8mb4_unicode_ci,
  `status` enum('ARCHIVED','CLOSED','OPEN') COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `wave_type` enum('EARLY_NO_TEST','RANKING_NO_TEST','REGULAR_TEST') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK9k6y81p7hhsdjy3vfakfcqe0o` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_periods`
--

LOCK TABLES `registration_periods` WRITE;
/*!40000 ALTER TABLE `registration_periods` DISABLE KEYS */;
INSERT INTO `registration_periods` VALUES (1,'2026-12-31 23:59:00.000000','2026-04-19 16:54:28.505245','Gelombang awal tanpa tes tertulis - Seleksi berdasarkan nilai rapor','2026-12-31 23:59:00.000000','2026-12-31 23:59:00.000000','Gelombang Awal','2026-12-31 23:59:00.000000','2026-12-31 23:59:00.000000','2026-04-30 23:59:00.000000','2026-04-01 00:00:00.000000',NULL,'OPEN','2026-04-19 16:54:28.505245','EARLY_NO_TEST'),(2,'2026-06-25 03:00:00.000000','2026-04-19 16:54:28.509258','Gelombang reguler dengan tes tertulis dan wawancara','2026-06-15 01:00:00.000000','2026-06-15 05:00:00.000000','Gelombang Reguler','2026-05-24 07:59:52.722000','2026-05-21 07:59:52.722000','2026-05-31 16:59:00.000000','2026-04-18 17:00:00.000000','','OPEN','2026-04-19 14:59:52.762650','REGULAR_TEST'),(3,'2026-07-10 03:00:00.000000','2026-04-19 16:54:28.511252','Gelombang ranking - Pendaftar tersisa dari gelombang sebelumnya','9999-12-31 09:59:59.000000','9999-12-31 09:59:59.000000','Gelombang Ranking','2026-06-04 01:58:56.272000','2026-06-01 01:58:56.272000','2026-06-30 16:59:00.000000','2026-04-29 17:00:00.000000','','OPEN','2026-04-30 08:58:56.314104','RANKING_NO_TEST');
/*!40000 ALTER TABLE `registration_periods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_status`
--

DROP TABLE IF EXISTS `registration_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_status` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `admin_notes` text COLLATE utf8mb4_unicode_ci,
  `admin_verified` bit(1) DEFAULT NULL,
  `can_edit` bit(1) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `data_json` text COLLATE utf8mb4_unicode_ci,
  `edit_count` int DEFAULT NULL,
  `edit_deadline` datetime(6) DEFAULT NULL,
  `stage` enum('COMPLETED','DAFTAR_ULANG','DOCUMENT_VERIFICATION','FORMULA_SELECTION','FORM_SUBMISSION','GELOMBANG_SELECTION','PAYMENT_BRIVA','PAYMENT_CICILAN_1','PSYCHO_EXAM') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('MENUNGGU_VERIFIKASI','REJECTED','SELESAI') COLLATE utf8mb4_unicode_ci NOT NULL,
  `submission_date` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `verification_date` datetime(6) DEFAULT NULL,
  `verified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1uf2iw9bgbt4dgkojt1y6g95n` (`user_id`),
  CONSTRAINT `FK1uf2iw9bgbt4dgkojt1y6g95n` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_status`
--

LOCK TABLES `registration_status` WRITE;
/*!40000 ALTER TABLE `registration_status` DISABLE KEYS */;
INSERT INTO `registration_status` VALUES (1,NULL,_binary '\0',_binary '','2026-04-19 14:20:14.363968','{\"gelombangId\":1,\"gelombangTitle\":\"Pendaftaran - Gelombang Awal\",\"waveType\":\"EARLY_NO_TEST\",\"selectedAt\":\"2026-04-19T14:41:52.176Z\"}',5,'2026-04-20 14:41:52.184391','GELOMBANG_SELECTION','SELESAI','2026-04-19 14:41:52.184391','2026-04-19 14:41:52.185387',NULL,NULL,4),(2,NULL,_binary '\0',_binary '','2026-04-19 14:21:54.925656','{\"waveType\":\"EARLY_NO_TEST\",\"waveTitle\":\"Gelombang Awal\",\"selectedAt\":\"2026-04-19\"}',1,'2026-04-20 14:21:54.929141','GELOMBANG_SELECTION','SELESAI','2026-04-19 14:21:54.929141','2026-04-19 14:21:54.930216',NULL,NULL,3),(3,NULL,_binary '\0',_binary '','2026-04-19 14:41:39.207318','{\"formulaId\":2,\"formulaTitle\":\"Program Non-Kedokteran\",\"price\":750000,\"jenisSeleksiId\":2,\"formType\":\"NON_KEDOKTERAN\",\"selectedAt\":\"2026-04-19T14:42:02.041Z\"}',2,'2026-04-20 14:42:02.048790','FORMULA_SELECTION','SELESAI','2026-04-19 14:42:02.048790','2026-04-19 14:42:02.048790',NULL,NULL,4),(4,NULL,_binary '\0',_binary '','2026-04-19 14:42:16.148709','Form submitted at 2026-04-19T21:42:16.146636300',1,'2026-04-20 14:42:16.149213','FORM_SUBMISSION','SELESAI','2026-04-19 14:42:16.149213','2026-04-19 14:42:16.150513',NULL,NULL,4),(5,NULL,_binary '\0',_binary '','2026-04-19 14:42:30.687051',NULL,0,NULL,'PAYMENT_BRIVA','SELESAI',NULL,'2026-04-19 14:42:30.687051',NULL,NULL,4),(6,NULL,_binary '\0',_binary '','2026-04-19 14:43:35.254305',NULL,0,NULL,'PAYMENT_CICILAN_1','SELESAI',NULL,'2026-04-19 14:43:35.254305',NULL,NULL,4),(7,NULL,_binary '\0',_binary '','2026-04-19 14:44:40.213942','Daftar ulang submitted at: 2026-04-19T14:44:40.207Z',0,NULL,'DAFTAR_ULANG','SELESAI','2026-04-19 14:44:40.215935','2026-04-19 14:44:40.216931',NULL,NULL,4),(8,NULL,_binary '\0',_binary '','2026-04-19 15:00:04.857009','{\"gelombangId\":2,\"gelombangTitle\":\"Pendaftaran - Gelombang Reguler\",\"waveType\":\"REGULAR_TEST\",\"selectedAt\":\"2026-04-30T09:49:43.261Z\"}',2,'2026-05-01 09:49:43.271458','GELOMBANG_SELECTION','SELESAI','2026-04-30 09:49:43.271458','2026-04-30 09:49:43.272687',NULL,NULL,5),(9,NULL,_binary '\0',_binary '','2026-04-19 15:00:07.597439','{\"formulaId\":2,\"formulaTitle\":\"Program Non-Kedokteran\",\"price\":750000,\"jenisSeleksiId\":2,\"formType\":\"NON_KEDOKTERAN\",\"selectedAt\":\"2026-04-30T09:49:46.421Z\"}',2,'2026-05-01 09:49:46.428363','FORMULA_SELECTION','SELESAI','2026-04-30 09:49:46.428363','2026-04-30 09:49:46.428363',NULL,NULL,5),(10,NULL,_binary '\0',_binary '','2026-04-19 15:00:19.669613','Form submitted at 2026-04-19T22:00:19.667939100',1,'2026-04-20 15:00:19.669613','FORM_SUBMISSION','SELESAI','2026-04-19 15:00:19.669613','2026-04-19 15:00:19.669613',NULL,NULL,5),(11,NULL,_binary '\0',_binary '','2026-04-19 15:00:28.213936',NULL,0,NULL,'PAYMENT_BRIVA','SELESAI',NULL,'2026-04-19 15:00:28.213936',NULL,NULL,5),(12,NULL,NULL,NULL,'2026-04-19 15:00:39.863527',NULL,NULL,NULL,'PSYCHO_EXAM','SELESAI','2026-04-19 15:09:01.634728','2026-04-19 15:09:01.635868',NULL,NULL,5),(13,NULL,_binary '\0',_binary '','2026-04-19 15:14:42.409373',NULL,0,NULL,'PAYMENT_CICILAN_1','SELESAI',NULL,'2026-04-19 15:14:42.409373',NULL,NULL,5),(14,NULL,_binary '\0',_binary '','2026-04-19 15:15:28.124604','Daftar ulang submitted at: 2026-04-19T15:15:28.113Z',0,NULL,'DAFTAR_ULANG','SELESAI','2026-04-19 15:15:28.127784','2026-04-19 15:16:32.077528',NULL,NULL,5),(15,NULL,_binary '\0',_binary '','2026-04-20 02:05:15.299564','{\"gelombangId\":1,\"gelombangTitle\":\"Pendaftaran - Gelombang Awal\",\"waveType\":\"EARLY_NO_TEST\",\"selectedAt\":\"2026-04-20T02:05:15.283Z\"}',1,'2026-04-21 02:05:15.301564','GELOMBANG_SELECTION','SELESAI','2026-04-20 02:05:15.301564','2026-04-20 02:05:15.301564',NULL,NULL,6),(16,NULL,_binary '\0',_binary '','2026-04-20 02:05:18.562631','{\"formulaId\":2,\"formulaTitle\":\"Program Non-Kedokteran\",\"price\":750000,\"jenisSeleksiId\":2,\"formType\":\"NON_KEDOKTERAN\",\"selectedAt\":\"2026-04-20T02:05:18.553Z\"}',1,'2026-04-21 02:05:18.563631','FORMULA_SELECTION','SELESAI','2026-04-20 02:05:18.563631','2026-04-20 02:05:18.563631',NULL,NULL,6),(17,NULL,_binary '\0',_binary '','2026-04-20 02:49:58.937444','Form submitted at 2026-04-20T09:49:58.935444700',1,'2026-04-21 02:49:58.940444','FORM_SUBMISSION','SELESAI','2026-04-20 02:49:58.940444','2026-04-20 02:49:58.940444',NULL,NULL,6),(18,NULL,_binary '\0',_binary '','2026-04-26 16:38:48.407719',NULL,0,NULL,'PAYMENT_BRIVA','SELESAI',NULL,'2026-04-26 16:38:48.407719',NULL,NULL,6),(19,NULL,_binary '\0',_binary '','2026-04-26 16:40:27.654462',NULL,0,NULL,'PAYMENT_CICILAN_1','SELESAI',NULL,'2026-04-26 16:40:27.654462',NULL,NULL,6),(20,NULL,_binary '\0',_binary '','2026-04-27 08:06:59.238653','{\"gelombangId\":2,\"gelombangTitle\":\"Pendaftaran - Gelombang Reguler\",\"waveType\":\"REGULAR_TEST\",\"selectedAt\":\"2026-04-27T08:07:13.527Z\"}',2,'2026-04-28 08:07:13.534196','GELOMBANG_SELECTION','SELESAI','2026-04-27 08:07:13.534196','2026-04-27 08:07:13.534196',NULL,NULL,7),(21,NULL,_binary '\0',_binary '','2026-04-27 08:07:18.048379','{\"formulaId\":2,\"formulaTitle\":\"Program Non-Kedokteran\",\"price\":750000,\"jenisSeleksiId\":2,\"formType\":\"NON_KEDOKTERAN\",\"selectedAt\":\"2026-04-27T08:07:18.041Z\"}',1,'2026-04-28 08:07:18.049376','FORMULA_SELECTION','SELESAI','2026-04-27 08:07:18.049376','2026-04-27 08:07:18.049376',NULL,NULL,7),(22,NULL,_binary '\0',_binary '','2026-04-27 08:12:27.624704','Form submitted at 2026-04-27T15:12:27.620113700',1,'2026-04-28 08:12:27.630583','FORM_SUBMISSION','SELESAI','2026-04-27 08:12:27.630583','2026-04-27 08:12:27.630583',NULL,NULL,7),(23,NULL,_binary '\0',_binary '','2026-04-27 08:12:39.805415',NULL,0,NULL,'PAYMENT_BRIVA','SELESAI',NULL,'2026-04-27 08:12:39.805415',NULL,NULL,7),(24,NULL,NULL,NULL,'2026-04-27 08:12:51.653495',NULL,NULL,NULL,'PSYCHO_EXAM','SELESAI','2026-04-27 08:13:14.031821','2026-04-27 08:13:14.032818',NULL,NULL,7),(25,NULL,_binary '\0',_binary '','2026-04-27 08:15:12.446468',NULL,0,NULL,'PAYMENT_CICILAN_1','SELESAI',NULL,'2026-04-27 08:15:12.446468',NULL,NULL,7),(26,NULL,_binary '\0',_binary '','2026-04-27 08:15:40.092798','Daftar ulang submitted at: 2026-04-27T08:15:40.085Z',0,NULL,'DAFTAR_ULANG','SELESAI','2026-04-27 08:15:40.095298','2026-04-27 08:16:09.191213',NULL,NULL,7),(27,NULL,_binary '\0',_binary '','2026-04-27 14:45:27.375301','{\"gelombangId\":1,\"gelombangTitle\":\"Pendaftaran - Gelombang Awal\",\"waveType\":\"EARLY_NO_TEST\",\"selectedAt\":\"2026-04-30T04:18:16.948Z\"}',2,'2026-05-01 04:18:16.987710','GELOMBANG_SELECTION','SELESAI','2026-04-30 04:18:16.987710','2026-04-30 04:18:16.994630',NULL,NULL,8),(28,NULL,_binary '\0',_binary '','2026-04-27 14:45:33.475917','{\"formulaId\":2,\"formulaTitle\":\"Program Non-Kedokteran\",\"price\":750000,\"jenisSeleksiId\":2,\"formType\":\"NON_KEDOKTERAN\",\"selectedAt\":\"2026-04-30T04:18:21.716Z\"}',2,'2026-05-01 04:18:21.725115','FORMULA_SELECTION','SELESAI','2026-04-30 04:18:21.725115','2026-04-30 04:18:21.725115',NULL,NULL,8),(29,NULL,_binary '\0',_binary '','2026-04-27 14:45:55.845917','Form submitted at 2026-04-27T21:45:55.843919900',1,'2026-04-28 14:45:55.846916','FORM_SUBMISSION','SELESAI','2026-04-27 14:45:55.846916','2026-04-27 14:45:55.846916',NULL,NULL,8),(30,NULL,_binary '\0',_binary '','2026-04-27 14:46:05.125858',NULL,0,NULL,'PAYMENT_BRIVA','SELESAI',NULL,'2026-04-27 14:46:05.125858',NULL,NULL,8),(31,NULL,NULL,NULL,'2026-04-27 14:47:15.652034',NULL,NULL,NULL,'PSYCHO_EXAM','SELESAI','2026-04-27 14:47:34.533874','2026-04-27 14:47:34.535874',NULL,NULL,8),(32,NULL,_binary '\0',_binary '','2026-04-27 14:49:14.669488',NULL,0,NULL,'PAYMENT_CICILAN_1','SELESAI',NULL,'2026-04-27 14:49:14.669488',NULL,NULL,8),(33,NULL,_binary '\0',_binary '','2026-04-27 14:49:47.917868','Daftar ulang submitted at: 2026-04-27T14:49:47.909Z',0,NULL,'DAFTAR_ULANG','SELESAI','2026-04-27 14:49:47.919064','2026-04-27 14:49:47.920073',NULL,NULL,8),(34,NULL,_binary '\0',_binary '','2026-04-30 09:14:23.534895','{\"gelombangId\":2,\"gelombangTitle\":\"Pendaftaran - Gelombang Reguler\",\"waveType\":\"REGULAR_TEST\",\"selectedAt\":\"2026-04-30T09:14:45.596Z\"}',2,'2026-05-01 09:14:45.602974','GELOMBANG_SELECTION','SELESAI','2026-04-30 09:14:45.602974','2026-04-30 09:14:45.602974',NULL,NULL,9),(35,NULL,_binary '\0',_binary '','2026-04-30 09:14:27.611484','{\"formulaId\":1,\"formulaTitle\":\"Kedokteran\",\"price\":1500000,\"jenisSeleksiId\":1,\"formType\":\"KEDOKTERAN\",\"selectedAt\":\"2026-04-30T09:14:49.260Z\"}',2,'2026-05-01 09:14:49.266899','FORMULA_SELECTION','SELESAI','2026-04-30 09:14:49.266899','2026-04-30 09:14:49.266899',NULL,NULL,9),(36,NULL,_binary '\0',_binary '','2026-04-30 09:14:59.749858','Form submitted at 2026-04-30T16:14:59.742937200',1,'2026-05-01 09:14:59.749858','FORM_SUBMISSION','SELESAI','2026-04-30 09:14:59.749858','2026-04-30 09:14:59.749858',NULL,NULL,9),(37,NULL,_binary '\0',_binary '','2026-04-30 09:15:08.821666',NULL,0,NULL,'PAYMENT_BRIVA','SELESAI',NULL,'2026-04-30 09:15:08.821666',NULL,NULL,9),(38,NULL,NULL,NULL,'2026-04-30 09:15:57.317045',NULL,NULL,NULL,'PSYCHO_EXAM','SELESAI','2026-04-30 09:17:03.688816','2026-04-30 09:17:03.689779',NULL,NULL,9),(39,NULL,_binary '\0',_binary '','2026-04-30 09:51:21.795318','{\"gelombangId\":1,\"gelombangTitle\":\"Pendaftaran - Gelombang Awal\",\"waveType\":\"EARLY_NO_TEST\",\"selectedAt\":\"2026-04-30T09:51:21.784Z\"}',1,'2026-05-01 09:51:21.799300','GELOMBANG_SELECTION','SELESAI','2026-04-30 09:51:21.799300','2026-04-30 09:51:21.799300',NULL,NULL,10),(40,NULL,_binary '\0',_binary '','2026-04-30 09:51:24.932953','{\"formulaId\":2,\"formulaTitle\":\"Program Non-Kedokteran\",\"price\":750000,\"jenisSeleksiId\":2,\"formType\":\"NON_KEDOKTERAN\",\"selectedAt\":\"2026-04-30T09:51:24.925Z\"}',1,'2026-05-01 09:51:24.934182','FORMULA_SELECTION','SELESAI','2026-04-30 09:51:24.934182','2026-04-30 09:51:24.934182',NULL,NULL,10),(41,NULL,_binary '\0',_binary '','2026-04-30 10:33:39.714352','{\"gelombangId\":2,\"gelombangTitle\":\"Pendaftaran - Gelombang Reguler\",\"waveType\":\"REGULAR_TEST\",\"selectedAt\":\"2026-04-30T10:33:39.707Z\"}',1,'2026-05-01 10:33:39.715380','GELOMBANG_SELECTION','SELESAI','2026-04-30 10:33:39.715380','2026-04-30 10:33:39.716530',NULL,NULL,11),(42,NULL,_binary '\0',_binary '','2026-04-30 10:33:43.285895','{\"formulaId\":2,\"formulaTitle\":\"Program Non-Kedokteran\",\"price\":750000,\"jenisSeleksiId\":2,\"formType\":\"NON_KEDOKTERAN\",\"selectedAt\":\"2026-04-30T10:33:43.279Z\"}',1,'2026-05-01 10:33:43.286897','FORMULA_SELECTION','SELESAI','2026-04-30 10:33:43.286897','2026-04-30 10:33:43.286897',NULL,NULL,11),(43,NULL,_binary '\0',_binary '','2026-04-30 10:33:59.081280','Form submitted at 2026-04-30T17:33:59.081279700',1,'2026-05-01 10:33:59.096904','FORM_SUBMISSION','SELESAI','2026-04-30 10:33:59.096904','2026-04-30 10:33:59.096904',NULL,NULL,11),(44,NULL,_binary '\0',_binary '','2026-04-30 10:34:08.618140',NULL,0,NULL,'PAYMENT_BRIVA','SELESAI',NULL,'2026-04-30 10:34:08.618140',NULL,NULL,11),(45,NULL,NULL,NULL,'2026-04-30 10:34:24.481057',NULL,NULL,NULL,'PSYCHO_EXAM','SELESAI','2026-04-30 10:34:32.187036','2026-04-30 10:34:32.187036',NULL,NULL,11),(46,NULL,_binary '\0',_binary '','2026-04-30 10:47:07.191414','{\"gelombangId\":2,\"gelombangTitle\":\"Pendaftaran - Gelombang Reguler\",\"waveType\":\"REGULAR_TEST\",\"selectedAt\":\"2026-04-30T10:47:07.183Z\"}',1,'2026-05-01 10:47:07.192591','GELOMBANG_SELECTION','SELESAI','2026-04-30 10:47:07.192591','2026-04-30 10:47:07.192591',NULL,NULL,14),(47,NULL,_binary '\0',_binary '','2026-04-30 10:47:58.437700','{\"formulaId\":1,\"formulaTitle\":\"Kedokteran\",\"price\":1500000,\"jenisSeleksiId\":1,\"formType\":\"KEDOKTERAN\",\"selectedAt\":\"2026-04-30T10:47:58.430Z\"}',1,'2026-05-01 10:47:58.449820','FORMULA_SELECTION','SELESAI','2026-04-30 10:47:58.449820','2026-04-30 10:47:58.449820',NULL,NULL,14),(48,NULL,_binary '\0',_binary '','2026-04-30 10:49:13.090563','Form submitted at 2026-04-30T17:49:13.088564700',1,'2026-05-01 10:49:13.092555','FORM_SUBMISSION','SELESAI','2026-04-30 10:49:13.092555','2026-04-30 10:49:13.093553',NULL,NULL,14),(49,NULL,_binary '\0',_binary '','2026-04-30 10:49:24.328563',NULL,0,NULL,'PAYMENT_BRIVA','SELESAI',NULL,'2026-04-30 10:49:24.328563',NULL,NULL,14),(50,NULL,NULL,NULL,'2026-04-30 10:49:40.211536',NULL,NULL,NULL,'PSYCHO_EXAM','SELESAI','2026-04-30 10:49:56.308085','2026-04-30 10:49:56.309299',NULL,NULL,14),(51,NULL,_binary '\0',_binary '','2026-04-30 11:13:56.065545',NULL,0,NULL,'PAYMENT_CICILAN_1','SELESAI',NULL,'2026-04-30 11:13:56.065545',NULL,NULL,14),(52,NULL,_binary '\0',_binary '','2026-04-30 11:14:22.372128','Daftar ulang submitted at: 2026-04-30T11:14:22.361Z',0,NULL,'DAFTAR_ULANG','SELESAI','2026-04-30 11:14:22.373154','2026-04-30 11:44:18.892217',NULL,NULL,14);
/*!40000 ALTER TABLE `registration_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `selection_program_studi`
--

DROP TABLE IF EXISTS `selection_program_studi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `selection_program_studi` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `jenis_seleksi_id` bigint NOT NULL,
  `program_studi_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKjdgednnekvhpjc74ybw5r9efk` (`jenis_seleksi_id`,`program_studi_id`),
  KEY `FK1i9cp8a1hov4s9twahvq2ujyn` (`program_studi_id`),
  CONSTRAINT `FK1i9cp8a1hov4s9twahvq2ujyn` FOREIGN KEY (`program_studi_id`) REFERENCES `program_studi` (`id`),
  CONSTRAINT `FKmwj6mbbvq18o3l82aiba2daik` FOREIGN KEY (`jenis_seleksi_id`) REFERENCES `jenis_seleksi` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `selection_program_studi`
--

LOCK TABLES `selection_program_studi` WRITE;
/*!40000 ALTER TABLE `selection_program_studi` DISABLE KEYS */;
INSERT INTO `selection_program_studi` VALUES (1,'2026-04-19 16:54:28.595738',_binary '','2026-04-19 16:54:28.595738',2,1),(2,'2026-04-19 16:54:28.598977',_binary '','2026-04-19 16:54:28.598977',2,2),(3,'2026-04-19 16:54:28.600027',_binary '','2026-04-19 16:54:28.600027',2,3),(4,'2026-04-19 16:54:28.601032',_binary '','2026-04-19 16:54:28.601032',2,4),(5,'2026-04-19 16:54:28.602152',_binary '','2026-04-19 16:54:28.602152',2,5),(6,'2026-04-19 16:54:28.602152',_binary '','2026-04-19 16:54:28.602152',2,6),(7,'2026-04-19 16:54:28.602152',_binary '','2026-04-19 16:54:28.602152',2,7),(8,'2026-04-19 16:54:28.603568',_binary '','2026-04-19 16:54:28.603568',2,8),(9,'2026-04-19 16:54:28.603568',_binary '','2026-04-19 16:54:28.603568',2,9),(10,'2026-04-19 16:54:28.605451',_binary '','2026-04-19 16:54:28.605451',2,10),(11,'2026-04-19 16:54:28.606628',_binary '','2026-04-19 16:54:28.606628',2,11),(12,'2026-04-19 16:54:28.607670',_binary '','2026-04-19 16:54:28.607670',2,12),(13,'2026-04-19 16:54:28.607670',_binary '','2026-04-19 16:54:28.607670',2,13),(14,'2026-04-19 16:54:28.609140',_binary '','2026-04-19 16:54:28.609140',2,14),(15,'2026-04-19 16:54:28.609140',_binary '','2026-04-19 16:54:28.609140',2,15),(16,'2026-04-19 16:54:28.610206',_binary '','2026-04-19 16:54:28.610206',2,16),(17,'2026-04-19 16:54:28.610206',_binary '','2026-04-19 16:54:28.610206',2,17),(18,'2026-04-19 16:54:28.611306',_binary '','2026-04-19 16:54:28.611306',2,18),(19,'2026-04-19 16:54:28.612658',_binary '','2026-04-19 16:54:28.612658',2,19),(20,'2026-04-19 16:54:28.613877',_binary '','2026-04-19 16:54:28.613877',2,20),(21,'2026-04-19 16:54:28.613877',_binary '','2026-04-19 16:54:28.613877',2,21),(22,'2026-04-19 16:54:28.615380',_binary '','2026-04-19 16:54:28.615380',2,22),(23,'2026-04-19 16:54:28.615380',_binary '','2026-04-19 16:54:28.615380',2,23),(24,'2026-04-19 16:54:28.616399',_binary '','2026-04-19 16:54:28.616399',2,24),(25,'2026-04-19 16:54:28.616399',_binary '','2026-04-19 16:54:28.616399',2,25),(26,'2026-04-19 16:54:28.617474',_binary '','2026-04-19 16:54:28.617474',2,26),(27,'2026-04-30 09:07:42.100330',_binary '','2026-04-30 09:07:42.100330',1,27),(28,'2026-04-30 09:07:42.103568',_binary '','2026-04-30 09:07:42.103568',1,1),(29,'2026-04-30 09:07:42.108942',_binary '','2026-04-30 09:07:42.108942',1,2),(30,'2026-04-30 09:07:42.111930',_binary '','2026-04-30 09:07:42.111930',1,3);
/*!40000 ALTER TABLE `selection_program_studi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `selection_types`
--

DROP TABLE IF EXISTS `selection_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `selection_types` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `form_type` enum('MEDICAL','NON_MEDICAL') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` bit(1) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(38,2) NOT NULL,
  `require_ranking` bit(1) DEFAULT NULL,
  `require_testing` bit(1) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `period_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKpltsppkwc6x4ou3q3kv2xyx8p` (`period_id`),
  CONSTRAINT `FKpltsppkwc6x4ou3q3kv2xyx8p` FOREIGN KEY (`period_id`) REFERENCES `registration_periods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `selection_types`
--

LOCK TABLES `selection_types` WRITE;
/*!40000 ALTER TABLE `selection_types` DISABLE KEYS */;
INSERT INTO `selection_types` VALUES (5,'2026-04-19 16:57:41.000000','Seleksi tanpa ujian tulis untuk program non-kedokteran. Berdasarkan dokumen akademik dan prestasi.','NON_MEDICAL',_binary '','Program Non-Kedokteran (Bebas Testing)',750000.00,_binary '\0',_binary '\0','2026-04-19 16:57:41.000000',1),(6,'2026-04-19 16:57:41.000000','Seleksi tanpa ujian tulis untuk program kedokteran. Berdasarkan ranking dan prestasi akademik.','MEDICAL',_binary '','Program Kedokteran (Bebas Testing)',2500000.00,_binary '',_binary '\0','2026-04-19 16:57:41.000000',1),(7,'2026-04-19 16:57:41.000000','Seleksi dengan ujian tulis untuk program non-kedokteran.','NON_MEDICAL',_binary '','Program Non-Kedokteran (Dengan Ujian)',750000.00,_binary '\0',_binary '','2026-04-19 16:57:41.000000',2),(8,'2026-04-19 16:57:41.000000','Seleksi berdasarkan ranking untuk program kedokteran.','MEDICAL',_binary '','Program Kedokteran (Ranking)',2500000.00,_binary '',_binary '\0','2026-04-19 16:57:41.000000',3);
/*!40000 ALTER TABLE `selection_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sma`
--

DROP TABLE IF EXISTS `sma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sma` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `bentuk` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `is_active` bit(1) NOT NULL,
  `kota` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `npsn` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provinsi` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sma_npsn` (`npsn`),
  KEY `idx_sma_nama` (`nama`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sma`
--

LOCK TABLES `sma` WRITE;
/*!40000 ALTER TABLE `sma` DISABLE KEYS */;
INSERT INTO `sma` VALUES (1,'SMA','2026-04-30 09:48:44.084629',_binary '','Kota Medan','SMA N 1 MEDAN','12123312','Sumatera Utara','2026-04-30 09:48:44.084629'),(2,'SMA','2026-04-30 09:53:06.534912',_binary '','kisaran','smmaa','122121','Sumatera Utara','2026-04-30 09:53:06.534912'),(3,'SMA','2026-04-30 09:55:18.137921',_binary '','adwad','SMA N 1 MEDAN11','123123','wadawd','2026-04-30 09:55:18.137921'),(4,'SMA','2026-04-30 10:04:24.725946',_binary '','wdadwa','SMA N11 MEDAN','121233121','Sumatera Utara','2026-04-30 10:04:24.725946');
/*!40000 ALTER TABLE `sma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_form_data`
--

DROP TABLE IF EXISTS `student_form_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_form_data` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `education_data_json` text COLLATE utf8mb4_unicode_ci,
  `exam_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_version` int DEFAULT NULL,
  `modified_at` datetime(6) DEFAULT NULL,
  `parent_data_json` text COLLATE utf8mb4_unicode_ci,
  `personal_data_json` text COLLATE utf8mb4_unicode_ci,
  `submitted_at` datetime(6) DEFAULT NULL,
  `formula_id` bigint DEFAULT NULL,
  `gelombang_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK19dax91g13cifd5xydbtgkda` (`formula_id`),
  KEY `FKlil8ghx2k80tkeijiq7sm5nty` (`gelombang_id`),
  KEY `FKnllt14wfro7jlqwrvajeqxmo4` (`user_id`),
  CONSTRAINT `FK19dax91g13cifd5xydbtgkda` FOREIGN KEY (`formula_id`) REFERENCES `selection_types` (`id`),
  CONSTRAINT `FKlil8ghx2k80tkeijiq7sm5nty` FOREIGN KEY (`gelombang_id`) REFERENCES `registration_periods` (`id`),
  CONSTRAINT `FKnllt14wfro7jlqwrvajeqxmo4` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_form_data`
--

LOCK TABLES `student_form_data` WRITE;
/*!40000 ALTER TABLE `student_form_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_form_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_npm`
--

DROP TABLE IF EXISTS `student_npm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_npm` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `issued_date` datetime(6) DEFAULT NULL,
  `npm` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `programming_start_date` datetime(6) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `program_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK3woithjxxf4rpbriok4sfaanv` (`npm`),
  UNIQUE KEY `UKgl1a7dkuapxwcbakvh02honti` (`user_id`),
  KEY `FK2n8fsxxrkkmf5r6vav7qfd463` (`program_id`),
  CONSTRAINT `FK2n8fsxxrkkmf5r6vav7qfd463` FOREIGN KEY (`program_id`) REFERENCES `selection_types` (`id`),
  CONSTRAINT `FK3ot6b1pcc0eatl10lufpy1p10` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_npm`
--

LOCK TABLES `student_npm` WRITE;
/*!40000 ALTER TABLE `student_npm` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_npm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` text COLLATE utf8mb4_unicode_ci,
  `birth_date` date DEFAULT NULL,
  `birth_place` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` enum('FEMALE','MALE') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nik` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_origin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK4sak51y93jyg6v63judt3cn54` (`nik`),
  UNIQUE KEY `UKg4fwvutq09fjdlb4bb0byp7t` (`user_id`),
  CONSTRAINT `FKdt1cjx5ve5bdabmuuf3ibrwaq` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,NULL,NULL,NULL,'2026-04-19 13:56:33.139625','Mychael Daniel N',NULL,'ae2c2974-b7f',NULL,NULL,NULL,NULL,NULL,'2026-04-19 13:56:33.139625',4),(2,NULL,NULL,NULL,'2026-04-19 14:11:37.836696','Mychael Daniel N',NULL,'b6fe8418-a33',NULL,NULL,NULL,NULL,NULL,'2026-04-19 14:11:37.836696',5),(3,NULL,NULL,NULL,'2026-04-20 02:02:39.802474','mychael doneil n',NULL,'3cce099f-a9a',NULL,NULL,NULL,NULL,NULL,'2026-04-20 02:02:39.802474',6),(4,NULL,NULL,NULL,'2026-04-27 08:06:18.752102','test student',NULL,'c8463612-dcf',NULL,NULL,NULL,NULL,NULL,'2026-04-27 08:06:18.752102',7),(5,NULL,NULL,NULL,'2026-04-27 14:44:57.047498','mikel',NULL,'ac1c3ec4-596',NULL,NULL,NULL,NULL,NULL,'2026-04-27 14:44:57.047498',8),(6,'AWDAWD','2026-04-24','Jakarta','2026-04-30 09:12:40.613497','test student','MALE','474b7429-d61','mychaeldaniel31','083872746279','083872746279','SMA Negeri 1 Medan','2019','2026-04-30 09:13:50.736422',9),(7,NULL,NULL,NULL,'2026-04-30 09:50:36.111816','test 3',NULL,'29df8086-f1b',NULL,NULL,NULL,NULL,NULL,'2026-04-30 09:50:36.111816',10),(8,NULL,NULL,NULL,'2026-04-30 10:32:06.022053','lukas',NULL,'e39bda04-36d',NULL,NULL,NULL,NULL,NULL,'2026-04-30 10:32:06.022053',11),(11,NULL,NULL,NULL,'2026-04-30 10:45:42.843843','Budi Santoso',NULL,'3d867eaf-05f',NULL,NULL,NULL,NULL,NULL,'2026-04-30 10:45:42.843843',14);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_configurations`
--

DROP TABLE IF EXISTS `system_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_configurations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `config_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `config_type` enum('BOOLEAN','JSON','NUMBER','STRING','TEXT') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` bit(1) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK867jsfttn43kaegq3c6c24b7r` (`config_key`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_configurations`
--

LOCK TABLES `system_configurations` WRITE;
/*!40000 ALTER TABLE `system_configurations` DISABLE KEYS */;
INSERT INTO `system_configurations` VALUES (17,'email_support','STRING','pmb@hkbpnommensen.ac.id','2026-04-19 16:57:17.000000','Email untuk kontak PMB',_binary '','2026-04-19 16:57:17.000000'),(18,'whatsapp_admin','STRING','628123456789','2026-04-19 16:57:17.000000','Nomor WhatsApp admin PMB (format: 62xxxxx)',_binary '','2026-04-19 16:57:17.000000'),(19,'bank_nama','STRING','BRI (Bank Rakyat Indonesia)','2026-04-19 16:57:17.000000','Nama Bank untuk rekening PMB',_binary '','2026-04-19 16:57:17.000000'),(20,'bank_rekening','STRING','1234567890','2026-04-19 16:57:17.000000','Nomor Rekening untuk pembayaran PMB',_binary '','2026-04-19 16:57:17.000000'),(21,'penerima_rekening','STRING','HKBP Nommensen University','2026-04-19 16:57:17.000000','Nama Penerima Rekening',_binary '','2026-04-19 16:57:17.000000'),(22,'facebook_url','STRING','https://www.facebook.com/hkbpnommensen','2026-04-19 16:57:17.000000','URL Facebook HKBP Nommensen',_binary '','2026-04-19 16:57:17.000000'),(23,'instagram_handle','STRING','hkbp_nommensen','2026-04-19 16:57:17.000000','Instagram Handle (tanpa @)',_binary '','2026-04-19 16:57:17.000000'),(24,'website_url','STRING','https://www.hkbpnommensen.ac.id','2026-04-19 16:57:17.000000','Website resmi HKBP Nommensen',_binary '','2026-04-19 16:57:17.000000');
/*!40000 ALTER TABLE `system_configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_links`
--

DROP TABLE IF EXISTS `system_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_links` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` bit(1) NOT NULL,
  `link_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link_url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKn285ux9xecrnakj2iecb1gp9q` (`link_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_links`
--

LOCK TABLES `system_links` WRITE;
/*!40000 ALTER TABLE `system_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `university_bank_account`
--

DROP TABLE IF EXISTS `university_bank_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `university_bank_account` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_holder` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `purpose` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `university_bank_account`
--

LOCK TABLES `university_bank_account` WRITE;
/*!40000 ALTER TABLE `university_bank_account` DISABLE KEYS */;
INSERT INTO `university_bank_account` VALUES (1,'HKBP Nommensen University','0014-01-020929-30-9','BRI','2026-04-19 16:57:58.000000',_binary '','Pendaftaran PMB','2026-04-19 16:57:58.000000'),(2,'HKBP Nommensen University','1234567890','BCA','2026-04-19 16:57:58.000000',_binary '','Cicilan PMB','2026-04-19 16:57:58.000000');
/*!40000 ALTER TABLE `university_bank_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verification_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified` bit(1) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('ADMIN_PUSAT','ADMIN_VALIDASI','CAMABA','PENGAWAS_UJIAN') COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2026-04-19 16:54:28.460890','admin@pmb.com',NULL,NULL,_binary '','$2a$10$95mibkf4XlkC4Mgz04j6buUnsUIfbz/bZvogCwWRGiN2zIZUsPnxC','ADMIN_PUSAT','2026-04-19 16:54:28.461900'),(2,'2026-04-19 16:54:28.490553','validasi@pmb.com',NULL,NULL,_binary '','$2a$10$rVO8zvkUNV3.UonvV6HjvOHnhG2QuEr7SvZZkEs29msIK442DP6KC','ADMIN_VALIDASI','2026-04-19 16:54:28.490553'),(3,'2026-04-19 16:54:28.492547','camaba@pmb.com',NULL,_binary '',_binary '','$2a$10$zlSxOH02V3wYBP/xB/0wOe7F./RdO3vufrDIHuPqItM99tIeAM4Ae','ADMIN_VALIDASI','2026-04-30 12:20:37.491204'),(4,'2026-04-19 13:56:33.079226','mychaeldaniel31@gmail.com',NULL,_binary '',_binary '\0','$2a$10$ZJwigYzA1zNcl763Ny4iWO18Fj62yJwLPly.kbKUCZU/T29ooLCye','CAMABA','2026-04-30 12:22:56.766164'),(5,'2026-04-19 14:11:37.832315','Mychael.122140104@student.itera.ac.id',NULL,_binary '',_binary '','$2a$10$L/pUrrvGzcjD84bn9ok8fu4ByZH.c0IuIoRmWF0dKTpA.bQgUXYbi','CAMABA','2026-04-19 14:11:47.932931'),(6,'2026-04-20 02:02:39.777475','kambingkambingna70@gmail.com',NULL,_binary '',_binary '\0','$2a$10$H5z0ww1KUWZzHQr3kEXB4e59ozpSuq4TSUvYT1t7dOojM6PAnJAfi','CAMABA','2026-04-30 12:20:53.157739'),(7,'2026-04-27 08:06:18.701400','testtestna70@gmail.com',NULL,_binary '',_binary '','$2a$10$fNxK6zdTryiUQafsfVT2H.csB3ncURUi95u/Mj2btCCXTILQFLR4G','CAMABA','2026-04-27 08:06:33.320254'),(8,'2026-04-27 14:44:57.025218','top0up0diamond@gmail.com',NULL,_binary '',_binary '','$2a$10$pr3Pp8yT1u4nNjKma6yY9Obff7o1YIRn8VTDPq6pdOnb36xljsMtq','CAMABA','2026-04-27 14:45:08.850116'),(9,'2026-04-30 09:12:40.604221','test2test2na70@gmail.com',NULL,_binary '',_binary '','$2a$10$MDYcfzeq6JBBuF9/9IVQV.9fI3jjS6W2Pn/31q1G.sMjglVR1rtG2','CAMABA','2026-04-30 09:14:14.679969'),(10,'2026-04-30 09:50:36.107658','test3test3na70@gmail.com',NULL,_binary '',_binary '','$2a$10$pgwbLTGjP8e1FRSWs7OHJ.66PHr7UEvkQkQ50W5oPEjwk1oNYJWr.','CAMABA','2026-04-30 09:50:54.740094'),(11,'2026-04-30 10:32:06.015005','lukasricardo02@gmail.com',NULL,_binary '',_binary '','$2a$10$/J0zDseDjRjudq2NoqvoUucv5Lcc7Ntp/ELL0N01lrF7bzBAueuIi','CAMABA','2026-04-30 10:33:20.916162'),(14,'2026-04-30 10:45:42.842831','margarethavera50@gmail.com',NULL,_binary '',_binary '','$2a$10$2owpPy.EjwL1ku.wChRqh.sExncZT82i.GsoHZDC4HNOGhduu38vq','CAMABA','2026-04-30 10:46:37.256174');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `validation_status_tracker`
--

DROP TABLE IF EXISTS `validation_status_tracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `validation_status_tracker` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `last_action` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_reason` text COLLATE utf8mb4_unicode_ci,
  `status` enum('DITOLAK','DIVALIDASI','MENUNGGU','NOT_STARTED','REVISI') COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `admission_form_id` bigint NOT NULL,
  `last_updated_by` bigint DEFAULT NULL,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK486rj1lrycxrmn30rupsppxh7` (`admission_form_id`),
  UNIQUE KEY `UKjypgolcx9cx51n7uwq3j2kftp` (`student_id`),
  KEY `FKt53km4xtwuk9hmstqnrx9ly0k` (`last_updated_by`),
  CONSTRAINT `FKa6157984h00ck6g3qjtethhii` FOREIGN KEY (`admission_form_id`) REFERENCES `admission_forms` (`id`),
  CONSTRAINT `FKlw4xw9x4yc8f4tfl2n762u6bb` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `FKt53km4xtwuk9hmstqnrx9ly0k` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validation_status_tracker`
--

LOCK TABLES `validation_status_tracker` WRITE;
/*!40000 ALTER TABLE `validation_status_tracker` DISABLE KEYS */;
INSERT INTO `validation_status_tracker` VALUES (1,'2026-04-19 15:15:48.379310','APPROVED','Formulir disetujui oleh validasi','DIVALIDASI','2026-04-19 15:16:32.071129',2,2,2),(2,'2026-04-27 08:16:09.175939','APPROVED','Formulir disetujui oleh validasi','DIVALIDASI','2026-04-27 08:16:09.181395',4,2,4),(3,'2026-04-30 10:18:40.095251','REVISION_REQUESTED','4. Bukti Bayar Formulir: jelek bukti formulir anda','REVISI','2026-04-30 10:18:40.096658',5,2,5),(4,'2026-04-30 11:15:00.596371','APPROVED','Formulir disetujui oleh validasi','DIVALIDASI','2026-04-30 11:44:18.871341',8,2,11);
/*!40000 ALTER TABLE `validation_status_tracker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `virtual_accounts`
--

DROP TABLE IF EXISTS `virtual_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `virtual_accounts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(38,2) NOT NULL,
  `briva_reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `expired_at` datetime(6) NOT NULL,
  `paid_at` datetime(6) DEFAULT NULL,
  `payment_info` text COLLATE utf8mb4_unicode_ci,
  `payment_type` enum('INSTALLMENT_1','INSTALLMENT_2','INSTALLMENT_3','REGISTRATION_FORM') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('ACTIVE','CANCELLED','EXPIRED','PAID') COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `va_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `form_id` bigint DEFAULT NULL,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKhtwnws666dvturqv8uwl259rq` (`va_number`),
  KEY `FKtkmpellay9f161riqsc6gvf8f` (`form_id`),
  KEY `FKei7nx7lvjwl5hvw42rdwb5cwm` (`student_id`),
  CONSTRAINT `FKei7nx7lvjwl5hvw42rdwb5cwm` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `FKtkmpellay9f161riqsc6gvf8f` FOREIGN KEY (`form_id`) REFERENCES `admission_forms` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `virtual_accounts`
--

LOCK TABLES `virtual_accounts` WRITE;
/*!40000 ALTER TABLE `virtual_accounts` DISABLE KEYS */;
INSERT INTO `virtual_accounts` VALUES (1,750000.00,'c2e55c7a-746c-47a5-9708-928505adc2cc','2026-04-19 14:42:22.406160','2026-04-26 14:42:22.406160','2026-04-19 14:42:30.674631',NULL,'REGISTRATION_FORM','PAID','2026-04-19 14:42:30.679248','8860742403200297',NULL,1),(2,750000.00,'099a83a7-9432-4373-9cb3-ad2475a6386a','2026-04-19 15:00:24.834118','2026-04-26 15:00:24.834118','2026-04-19 15:00:28.207535',NULL,'REGISTRATION_FORM','PAID','2026-04-19 15:00:28.209453','8860824827963713',NULL,2),(3,750000.00,'33936355-9f73-4b40-ba66-3686524d7679','2026-04-20 02:50:05.173802','2026-04-27 02:50:05.173802',NULL,NULL,'REGISTRATION_FORM','ACTIVE','2026-04-20 02:50:05.188793','8860405162663507',NULL,3),(4,750000.00,'4404f398-c8b9-4b77-84a9-f083ebf9d474','2026-04-26 16:38:33.664822','2026-05-03 16:38:33.661690',NULL,NULL,'REGISTRATION_FORM','ACTIVE','2026-04-26 16:38:33.706758','8860513658998736',NULL,3),(5,750000.00,'e55f05ed-031b-4a33-8451-d68fcd43c23f','2026-04-26 16:38:39.743390','2026-05-03 16:38:39.743390','2026-04-26 16:38:48.398750',NULL,'REGISTRATION_FORM','PAID','2026-04-26 16:38:48.400747','8860519741062382',NULL,3),(6,750000.00,'8f655bad-7164-4577-bfca-300b733952b1','2026-04-27 08:12:32.848721','2026-05-04 08:12:32.846716','2026-04-27 08:12:39.796521',NULL,'REGISTRATION_FORM','PAID','2026-04-27 08:12:39.799436','8860552841052180',NULL,4),(7,750000.00,'6a4ae1a3-a8ac-4e5f-a108-02257dda77fe','2026-04-27 14:46:01.012354','2026-05-04 14:46:01.012354','2026-04-27 14:46:05.117855',NULL,'REGISTRATION_FORM','PAID','2026-04-27 14:46:05.119855','8860161009017308',NULL,5),(8,1500000.00,'90461500-940d-49e6-8bbd-0dc9c64b783e','2026-04-30 09:15:05.058934','2026-05-07 09:15:05.058934','2026-04-30 09:15:08.820200',NULL,'REGISTRATION_FORM','PAID','2026-04-30 09:15:08.825563','8860505054379451',NULL,6),(9,750000.00,'a3b608eb-da70-4d42-a72c-0d095c78d1c9','2026-04-30 10:34:04.351272','2026-05-07 10:34:04.351272','2026-04-30 10:34:08.616111',NULL,'REGISTRATION_FORM','PAID','2026-04-30 10:34:08.619210','8860244347674821',NULL,8),(10,1500000.00,'905914d2-1671-46fa-8bc2-353248814a69','2026-04-30 10:49:18.342474','2026-05-07 10:49:18.342474','2026-04-30 10:49:24.326034',NULL,'REGISTRATION_FORM','PAID','2026-04-30 10:49:24.330934','8860158338267417',NULL,11);
/*!40000 ALTER TABLE `virtual_accounts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-01  8:41:48
