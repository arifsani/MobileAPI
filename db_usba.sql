-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 14, 2019 at 02:34 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_usba`
--

-- --------------------------------------------------------

--
-- Table structure for table `keys`
--

CREATE TABLE `keys` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `key` int(40) NOT NULL,
  `level` int(2) NOT NULL,
  `ignore_limits` tinyint(1) NOT NULL DEFAULT '0',
  `is_private_key` tinyint(1) NOT NULL DEFAULT '0',
  `ip_addresses` text NOT NULL,
  `date_created` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `m_admin`
--

CREATE TABLE `m_admin` (
  `id` int(6) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `level` enum('admin','guru','siswa') NOT NULL,
  `kon_id` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `m_admin`
--

INSERT INTO `m_admin` (`id`, `username`, `password`, `level`, `kon_id`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin', 0),
(28, '1004', 'fed33392d3a48aa149a87a38b875ba4a', 'guru', 7),
(29, '12090677', 'baaf63831059795a0cedec6d705ad519', 'siswa', 7),
(30, '1001', 'b8c37e33defde51cf91e1e03e51657da', 'guru', 2),
(31, '1003', 'aa68c75c4a77c87f97fb686b2f068676', 'guru', 6),
(32, '1002', 'fba9d88164f3e2d9109ee770223212a0', 'guru', 5),
(33, '1000', 'a9b7ba70783b617e9998dc4dd82eb3c5', 'guru', 4),
(34, '1005', '2387337ba1e0b0249ba90f55b2ba2521', 'guru', 8),
(36, '11090673', '42af3ba484d700ceac7708eaf8c51e01', 'siswa', 3),
(37, '16650086', '68fe949e99b470d46fa74e666230fdd0', 'siswa', 9);

-- --------------------------------------------------------

--
-- Table structure for table `m_guru`
--

CREATE TABLE `m_guru` (
  `id` int(6) NOT NULL,
  `nip` varchar(30) NOT NULL,
  `nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `m_guru`
--

INSERT INTO `m_guru` (`id`, `nip`, `nama`) VALUES
(2, '1001', 'Ir. Joko Widodo'),
(4, '1000', 'Dr. Abdulrahman Wahid'),
(5, '1002', 'Ir. Baharudin Jusuf Habibie'),
(6, '1003', 'Erik Maulana'),
(7, '1004', 'Tes'),
(8, '1005', 'Sumarsono');

--
-- Triggers `m_guru`
--
DELIMITER $$
CREATE TRIGGER `hapus_guru` AFTER DELETE ON `m_guru` FOR EACH ROW BEGIN
DELETE FROM m_soal WHERE m_soal.id_guru = OLD.id;
DELETE FROM m_admin WHERE m_admin.level = 'guru' AND m_admin.kon_id = OLD.id;
DELETE FROM tr_guru_mapel WHERE tr_guru_mapel.id_guru = OLD.id;
DELETE FROM tr_guru_tes WHERE tr_guru_tes.id_guru = OLD.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `m_mapel`
--

CREATE TABLE `m_mapel` (
  `id` int(6) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `Thumbnail` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `m_mapel`
--

INSERT INTO `m_mapel` (`id`, `nama`, `Thumbnail`) VALUES
(1, 'Bahasa Indonesia', 0),
(2, 'Bahasa Inggris', 0),
(3, 'IPA', 0),
(5, 'Matematika', 0),
(6, 'Seni Budaya', 0);

--
-- Triggers `m_mapel`
--
DELIMITER $$
CREATE TRIGGER `hapus_mapel` AFTER DELETE ON `m_mapel` FOR EACH ROW BEGIN
DELETE FROM m_soal WHERE m_soal.id_mapel = OLD.id;
DELETE FROM tr_guru_mapel WHERE tr_guru_mapel.id_mapel = OLD.id;
DELETE FROM tr_guru_tes WHERE tr_guru_tes.id_mapel = OLD.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `m_siswa`
--

CREATE TABLE `m_siswa` (
  `id` int(6) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `nim` varchar(50) NOT NULL,
  `jurusan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `m_siswa`
--

INSERT INTO `m_siswa` (`id`, `nama`, `nim`, `jurusan`) VALUES
(1, 'Agus Yudhoyono', '12090671', 'Teknik Informatika'),
(2, 'Edi Baskoro Yudhoyono', '12090672', 'Teknik Informatika'),
(3, 'Puan Maharani', '11090673', 'Sistem Informasi'),
(4, 'Kaesang Pangarep', '11090674', 'Sistem Informasi'),
(5, 'Anisa Pohan', '12090675', 'Teknik Informatika'),
(6, 'Gibran Rakabuming Raka', '11090676', 'Sistem Informasi'),
(7, 'Kahiyang Ayu', '12090677', 'Teknik Informatika'),
(9, 'Fauzan Arif Sani', '16650086', 'IPA');

--
-- Triggers `m_siswa`
--
DELIMITER $$
CREATE TRIGGER `hapus_siswa` AFTER DELETE ON `m_siswa` FOR EACH ROW BEGIN
DELETE FROM tr_ikut_ujian WHERE tr_ikut_ujian.id_user = OLD.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `m_soal`
--

CREATE TABLE `m_soal` (
  `id` int(6) NOT NULL,
  `id_guru` int(6) NOT NULL,
  `id_mapel` int(6) NOT NULL,
  `bobot` int(2) NOT NULL,
  `file` varchar(150) NOT NULL,
  `tipe_file` varchar(50) NOT NULL,
  `soal` longtext NOT NULL,
  `opsi_a` longtext NOT NULL,
  `opsi_b` longtext NOT NULL,
  `opsi_c` longtext NOT NULL,
  `opsi_d` longtext NOT NULL,
  `opsi_e` longtext NOT NULL,
  `jawaban` varchar(5) NOT NULL,
  `tgl_input` datetime NOT NULL,
  `jml_benar` int(6) NOT NULL,
  `jml_salah` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `m_soal`
--

INSERT INTO `m_soal` (`id`, `id_guru`, `id_mapel`, `bobot`, `file`, `tipe_file`, `soal`, `opsi_a`, `opsi_b`, `opsi_c`, `opsi_d`, `opsi_e`, `jawaban`, `tgl_input`, `jml_benar`, `jml_salah`) VALUES
(34, 6, 1, 1, '', '', '<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\" style=\"width:500px\">\r\n	<thead>\r\n		<tr>\r\n			<th scope=\"col\">Teks Fabel I</th>\r\n			<th scope=\"col\">Teks Fabel II</th>\r\n		</tr>\r\n	</thead>\r\n	<tbody>\r\n		<tr>\r\n			<td>Dengan bangganya lucky berlari-lari kecil sambil menyeret-nyeret balok kayu yang dikalungkan majikannya, untuk&nbsp;menarik perhatian orang lain. Tetapi tak ada satu pun orang yang senang melihat anjing itu. Balok itu sebenarnya dikalungkan majikannya agar orang mengetahui kehadiran lucky, dan bisa menghindarinya. Seekor anjing lain yang melihatnya kemudian berkata &quot;Kamu seharusnya lebih bijaksana dan berdiam diri di rumah agar orang tidak melihat balok yang dikalungkan di lehermu. Apakah kamu senang bahwa semua orang tahu betapa nakal dan jahatnya kamu?&quot;</td>\r\n			<td>Di sebuah hutan, musim kemarau, burung-burung dan hewan-hewan lain sangat sulit untuk mendapatkan air.&nbsp;Namun ada seekor burung perkutut yang menemukan kendi tua yang berisi sedikit air. Kendi tersebut memiliki bentuk yang tinggi dan juga sempit, sehingga burung tersebut tidak bisa menjangkau air di dalam kendi tersebut. Burung perkutut tersebut tetap mencoba untuk meminum air yang ada di dalam kendi, tetapi tetap saja tidak bisa. Burung itu hampir putus asa hingga munculah sebuah ide.. Burung tersebut kemudian mengambil kerikilkerikil yang ada di samping kendi dan menjatuhkannya ke dalam kendi satu persatu. Ide yang cemerlang itu membuat air lama kelamaan naik sehingga burung perkutut bisa meminum air tersebut</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<p>Perbedaan pola pengembangan kedua kutipan fabel tersebut diawali dengan ....</p>\r\n', '#####<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\" style=\"width:500px\">\r\n	<thead>\r\n		<tr>\r\n			<th scope=\"col\">Fabel I</th>\r\n			<th scope=\"col\">Fabel II</th>\r\n		</tr>\r\n	</thead>\r\n	<tbody>\r\n		<tr>\r\n			<td>menampilkan lokasi cerita</td>\r\n			<td>memberikan garis besar cerita</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n', '#####<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\" style=\"width:500px\">\r\n	<thead>\r\n		<tr>\r\n			<th scope=\"col\">Fabel I</th>\r\n			<th scope=\"col\">Fabel II</th>\r\n		</tr>\r\n	</thead>\r\n	<tbody>\r\n		<tr>\r\n			<td>memberikan garis besar cerita</td>\r\n			<td>memulai dengan aksi</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', '#####<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\" style=\"width:500px\">\r\n	<thead>\r\n		<tr>\r\n			<th scope=\"col\">Fabel I</th>\r\n			<th scope=\"col\">Fabel II</th>\r\n		</tr>\r\n	</thead>\r\n	<tbody>\r\n		<tr>\r\n			<td>memunculkan masalah</td>\r\n			<td>mengisyaratkan bahaya</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', '#####<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\" style=\"width:500px\">\r\n	<thead>\r\n		<tr>\r\n			<th scope=\"col\">Fabel I</th>\r\n			<th scope=\"col\">Fabel II</th>\r\n		</tr>\r\n	</thead>\r\n	<tbody>\r\n		<tr>\r\n			<td>memulai dengan aksi</td>\r\n			<td>menampilkan lokasi cerita</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', '#####', 'D', '2017-01-25 10:13:02', 0, 2),
(38, 6, 1, 1, '', '', '<p>&ldquo;Nada, minggu depan kita harus pindah ke Jogjakarta. Ayah dipindahtugaskan di sana.&rdquo; Bagaikan petir di siang bolong menyambar Nada yang seketika itu langsung diam mematung. &ldquo;Kenapa mendadak, Bunda? Nada senang tinggal di sini. Apa Nada tidak bisa tetap tinggal di sini? Sekolah Nada gimana?&rdquo; &ldquo;Tidak bisa, sayang. Kamu mau tinggal sama siapa di sini? Masalah sekolah, semua sudah diurus Ayah. Kamu hanya tinggal mengemasi barang-barangmu.&rdquo; Nada terdiam. Tak mungkin mampu ia membantah. Minggu depan ia harus meninggalkan tempat ini. Tepat di hari ulang tahun Dio yang ke-18. Terasa berat untuknya meninggalkan tempat ini. Terlalu banyak kenangan yang terukir. Semakin terasa berat ketika harus meninggalkan Dio.</p>\r\n\r\n<p>Makna simbol <strong><em>petir di siang bolong</em></strong> pada kutipan cerpen tersebut adalah....</p>\r\n', '#####<p>merasa sedih</p>\r\n', '#####<p>merasa bingung</p>\r\n', '#####<p>sangat terkejut</p>\r\n', '#####<p>merasa heran</p>\r\n', '#####', 'C', '2017-01-25 10:13:02', 0, 3),
(42, 6, 1, 1, '', '', '<p>Langit menjadi kelabu. Awan hitam mulai tak mampu lagi membendung butiran air. Matahari pergi. Sinarnya pun tak berbekas. Di samping rumah Nada, nampak Dio masih asyik bermain dengan merpatinya. Nada tersenyum menatapnya dari balik jendela kamarnya. Ya, tetangganya itu memang sangat menyukai merpati. Bahkan di samping rumahnya ada sebuah kandang merpati yang cukup luas miliknya sendiri. Ia biasa menyebutnya istana Merpati Dara Dori. Begitu banyak jenis merpati yang ia piara. Semuanya sepasang. Ada merpati lokal, merpati kipas, merpati gondok, merpati Lahore, dan masih banyak lagi. Namun, di antara semua merpatinya, merpati lokal berwarna seputih saljulah yang paling ia sukai. Dara dan Dori.</p>\r\n\r\n<p>Makna kata &ldquo;membendung&rdquo; pada kutipan cerpen tersebut ialah &hellip;.</p>\r\n', '#####<p>menahan</p>\r\n', '#####<p>menampung</p>\r\n', '#####<p>membentengi</p>\r\n', '#####<p>mengumpulkan</p>\r\n', '#####', 'A', '2017-01-25 10:13:02', 0, 2),
(43, 6, 1, 1, '', '', '<p>1) Penerbit Wayang menerbitkan buku terbaru yang berjudul Sudah Saatnya Menjadi Penulis Hebat. 2) Buku ini ditulis oleh Bendi Derajat. 3) Judulnya menarik, isinya lengkap, bahasanya ringan dan mudah dipahami serta bermanfaat bagi pembaca. 4) Hanya saja buku tersebut menggunakan banyak istilah akademik yang sulit dipahami pembaca awam.</p>\r\n\r\n<p>Kelemahan karya sastra yang terdapat pada ulasan buku tersebut ditandai nomor...</p>\r\n\r\n<p>&nbsp;</p>\r\n', '#####<p>1</p>\r\n', '#####<p>2</p>\r\n', '#####<p>3</p>\r\n', '#####<p>4</p>\r\n', '#####', 'D', '2017-01-25 10:13:02', 0, 3),
(45, 6, 1, 1, '', '', '<p>Sejak zaman dahulu, nenek moyang kita sudah mengenal tanaman lidah buaya serta manfaatnya. Manfaat tumbuhan yang bernama latin Aloe Vera ini tidak hanya sebagai penyubur rambut, tetapi juga bermanfaat bagi kesehatan. Tumbuhan tanpa buah ini mempunyai ciri-ciri, seperti daun berbentuk panjang, tebal, dan berwarna hijau. Daunnya mengandung serat bening sebagai daging. Meskipun sejak dahulu dikenal memiliki banyak khasiat, belum banyak yang mengetahui bahwa tanaman ini bisa menjadi komoditas yang menguntungkan. Komoditas yang berbahan lidah buaya, di antaranya obat untuk mempercepat proses penyembuhan penyakit, jus lidah buaya atau gel sebagai obat pencahar yang baik dan sangat membantu jika mengalami sembelit, ramuan penyubur rambut, juga sebagai minuman yang menyehatkan.</p>\r\n\r\n<p>Ringkasan paragraf tersebut adalah....</p>\r\n', '#####<p>Lidah buaya bermanfaat sebagai penyubur rambut juga untuk kesehatan.</p>\r\n', '#####<p>Lidah buaya sangat bermanfaat untuk mengobati berbagai macam penyakit.</p>\r\n', '#####<p>Lidah buaya selain bermanfaat juga menjadi komoditas yang menguntungkan</p>\r\n', '#####<p>Lidah buaya memiliki ciri-ciri tertentu dan nilai komoditas yang menguntungkan</p>\r\n', '#####', 'C', '2017-01-25 10:13:02', 1, 2),
(46, 6, 1, 1, '', '', '<p>Perlunya Resapan Air untuk Mencegah Banjir</p>\r\n\r\n<p>Banjir sudah menjadi agenda tahunan bagi masyarakat Indonesia. Tidak heran bila pemerintah berjuang keras dan mengeluarkan biaya yang sangat besar untuk menyelesaikan masalah ini. Membangun saluran air yang bagus merupakan salah satu cara pemerintah menanggulangi banjir. Namun, itu semua tidak akan berhasil apabila tidak diimbangi dengan pembangunan daerah resapan air. Jadi, resapan air ini merupakan syarat mutlak untuk menanggulangi banjir.</p>\r\n\r\n<p>Pendapat yang mendukung kutipan isi teks tersebut adalah ...</p>\r\n', '#####<p>Solusi tersebut hanya akan menghamburkan uang negara.</p>\r\n', '#####<p>Solusi seperti itu sudah tepat sehingga harus segera direalisasikan.</p>\r\n', '#####<p>Solusi yang dipilih pemerintah tidak akan mampu menanggulangi banjir</p>\r\n', '#####<p>Solusi tersebut masuk akal, tetapi sulit membangun resapan air di perkotaan.</p>\r\n', '#####<p>opsi E.13</p>\r\n', 'B', '2017-01-25 10:13:02', 0, 2),
(47, 7, 3, 1, '', '', 'Soal ke 1', '#####opsi A.1', '#####opsi B.1', '#####opsi C.1', '#####opsi D.1', '#####opsi E.1', 'A', '2019-03-23 12:20:35', 0, 1),
(48, 7, 3, 1, '', '', 'Soal ke 2', '#####opsi A.2', '#####opsi B.2', '#####opsi C.2', '#####opsi D.2', '#####opsi E.2', 'B', '2019-03-23 12:20:35', 0, 0),
(49, 7, 3, 1, '', '', 'Soal ke 3', '#####opsi A.3', '#####opsi B.3', '#####opsi C.3', '#####opsi D.3', '#####opsi E.3', 'E', '2019-03-23 12:20:35', 0, 1),
(50, 7, 3, 1, '', '', 'Soal ke 4', '#####opsi A.4', '#####opsi B.4', '#####opsi C.4', '#####opsi D.4', '#####opsi E.4', 'D', '2019-03-23 12:20:35', 0, 0),
(51, 7, 3, 1, '', '', 'Soal ke 5', '#####opsi A.5', '#####opsi B.5', '#####opsi C.5', '#####opsi D.5', '#####opsi E.5', 'E', '2019-03-23 12:20:35', 0, 0),
(52, 7, 3, 1, '', '', 'Soal ke 6', '#####opsi A.6', '#####opsi B.6', '#####opsi C.6', '#####opsi D.6', '#####opsi E.6', 'C', '2019-03-23 12:20:35', 0, 0),
(53, 7, 3, 1, '', '', 'Soal ke 7', '#####opsi A.7', '#####opsi B.7', '#####opsi C.7', '#####opsi D.7', '#####opsi E.7', 'A', '2019-03-23 12:20:35', 0, 1),
(54, 7, 3, 1, '', '', 'Soal ke 8', '#####opsi A.8', '#####opsi B.8', '#####opsi C.8', '#####opsi D.8', '#####opsi E.8', 'B', '2019-03-23 12:20:35', 1, 0),
(55, 7, 3, 1, '', '', 'Soal ke 9', '#####opsi A.9', '#####opsi B.9', '#####opsi C.9', '#####opsi D.9', '#####opsi E.9', 'B', '2019-03-23 12:20:35', 0, 0),
(56, 7, 3, 1, '', '', 'Soal ke 10', '#####opsi A.10', '#####opsi B.10', '#####opsi C.10', '#####opsi D.10', '#####opsi E.10', 'C', '2019-03-23 12:20:35', 0, 1),
(57, 7, 3, 1, '', '', 'Soal ke 11', '#####opsi A.11', '#####opsi B.11', '#####opsi C.11', '#####opsi D.11', '#####opsi E.11', 'D', '2019-03-23 12:20:35', 1, 0),
(58, 7, 3, 1, '', '', 'Soal ke 12', '#####opsi A.12', '#####opsi B.12', '#####opsi C.12', '#####opsi D.12', '#####opsi E.12', 'E', '2019-03-23 12:20:35', 0, 0),
(59, 7, 3, 1, '', '', 'Soal ke 13', '#####opsi A.13', '#####opsi B.13', '#####opsi C.13', '#####opsi D.13', '#####opsi E.13', 'A', '2019-03-23 12:20:35', 0, 0),
(60, 7, 3, 1, '', '', 'Soal ke 14', '#####opsi A.14', '#####opsi B.14', '#####opsi C.14', '#####opsi D.14', '#####opsi E.14', 'A', '2019-03-23 12:20:35', 1, 0),
(61, 7, 3, 1, '', '', 'Soal ke 15', '#####opsi A.15', '#####opsi B.15', '#####opsi C.15', '#####opsi D.15', '#####opsi E.15', 'D', '2019-03-23 12:20:35', 0, 1),
(62, 7, 3, 1, '', '', 'Soal ke 16', '#####opsi A.16', '#####opsi B.16', '#####opsi C.16', '#####opsi D.16', '#####opsi E.16', 'C', '2019-03-23 12:20:35', 0, 1),
(63, 7, 3, 1, '', '', 'Soal ke 17', '#####opsi A.17', '#####opsi B.17', '#####opsi C.17', '#####opsi D.17', '#####opsi E.17', 'D', '2019-03-23 12:20:35', 0, 0),
(64, 7, 3, 1, '', '', 'Soal ke 18', '#####opsi A.18', '#####opsi B.18', '#####opsi C.18', '#####opsi D.18', '#####opsi E.18', 'E', '2019-03-23 12:20:35', 0, 1),
(65, 4, 3, 1, '', '', 'Soal ke 1', '#####opsi A.1', '#####opsi B.1', '#####opsi C.1', '#####opsi D.1', '#####opsi E.1', 'A', '2019-05-13 10:01:42', 0, 2),
(66, 4, 3, 1, '', '', 'Soal ke 2', '#####opsi A.2', '#####opsi B.2', '#####opsi C.2', '#####opsi D.2', '#####opsi E.2', 'B', '2019-05-13 10:01:42', 0, 2),
(67, 4, 3, 1, '', '', 'Soal ke 3', '#####opsi A.3', '#####opsi B.3', '#####opsi C.3', '#####opsi D.3', '#####opsi E.3', 'E', '2019-05-13 10:01:42', 0, 2),
(68, 4, 3, 1, '', '', 'Soal ke 4', '#####opsi A.4', '#####opsi B.4', '#####opsi C.4', '#####opsi D.4', '#####opsi E.4', 'D', '2019-05-13 10:01:42', 0, 2),
(69, 4, 3, 1, '', '', 'Soal ke 5', '#####opsi A.5', '#####opsi B.5', '#####opsi C.5', '#####opsi D.5', '#####opsi E.5', 'E', '2019-05-13 10:01:42', 0, 2),
(70, 4, 3, 1, '', '', 'Soal ke 6', '#####opsi A.6', '#####opsi B.6', '#####opsi C.6', '#####opsi D.6', '#####opsi E.6', 'C', '2019-05-13 10:01:42', 0, 2),
(71, 4, 3, 1, '', '', 'Soal ke 7', '#####opsi A.7', '#####opsi B.7', '#####opsi C.7', '#####opsi D.7', '#####opsi E.7', 'A', '2019-05-13 10:01:42', 0, 2),
(72, 4, 3, 1, '', '', 'Soal ke 8', '#####opsi A.8', '#####opsi B.8', '#####opsi C.8', '#####opsi D.8', '#####opsi E.8', 'B', '2019-05-13 10:01:42', 0, 2),
(73, 4, 3, 1, '', '', 'Soal ke 9', '#####opsi A.9', '#####opsi B.9', '#####opsi C.9', '#####opsi D.9', '#####opsi E.9', 'B', '2019-05-13 10:01:42', 0, 2),
(74, 4, 3, 1, '', '', 'Soal ke 10', '#####opsi A.10', '#####opsi B.10', '#####opsi C.10', '#####opsi D.10', '#####opsi E.10', 'C', '2019-05-13 10:01:42', 0, 2),
(75, 4, 3, 1, '', '', 'Soal ke 11', '#####opsi A.11', '#####opsi B.11', '#####opsi C.11', '#####opsi D.11', '#####opsi E.11', 'D', '2019-05-13 10:01:42', 0, 2),
(76, 4, 3, 1, '', '', 'Soal ke 12', '#####opsi A.12', '#####opsi B.12', '#####opsi C.12', '#####opsi D.12', '#####opsi E.12', 'E', '2019-05-13 10:01:42', 0, 2),
(77, 4, 3, 1, '', '', 'Soal ke 13', '#####opsi A.13', '#####opsi B.13', '#####opsi C.13', '#####opsi D.13', '#####opsi E.13', 'A', '2019-05-13 10:01:42', 0, 2),
(78, 4, 3, 1, '', '', 'Soal ke 14', '#####opsi A.14', '#####opsi B.14', '#####opsi C.14', '#####opsi D.14', '#####opsi E.14', 'A', '2019-05-13 10:01:42', 0, 2),
(79, 4, 3, 1, '', '', 'Soal ke 15', '#####opsi A.15', '#####opsi B.15', '#####opsi C.15', '#####opsi D.15', '#####opsi E.15', 'D', '2019-05-13 10:01:42', 0, 2),
(80, 4, 3, 1, '', '', 'Soal ke 16', '#####opsi A.16', '#####opsi B.16', '#####opsi C.16', '#####opsi D.16', '#####opsi E.16', 'C', '2019-05-13 10:01:42', 0, 2),
(81, 4, 3, 1, '', '', 'Soal ke 17', '#####opsi A.17', '#####opsi B.17', '#####opsi C.17', '#####opsi D.17', '#####opsi E.17', 'D', '2019-05-13 10:01:42', 0, 2),
(82, 4, 3, 1, '', '', 'Soal ke 18', '#####opsi A.18', '#####opsi B.18', '#####opsi C.18', '#####opsi D.18', '#####opsi E.18', 'E', '2019-05-13 10:01:42', 0, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tr_guru_mapel`
--

CREATE TABLE `tr_guru_mapel` (
  `id` int(6) NOT NULL,
  `id_guru` int(6) NOT NULL,
  `id_mapel` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tr_guru_mapel`
--

INSERT INTO `tr_guru_mapel` (`id`, `id_guru`, `id_mapel`) VALUES
(3, 6, 1),
(4, 6, 2),
(5, 6, 3),
(9, 2, 1),
(10, 2, 2),
(12, 4, 1),
(13, 4, 2),
(14, 4, 3),
(16, 5, 1),
(17, 5, 2),
(18, 5, 3),
(20, 7, 1),
(21, 7, 2),
(22, 7, 3),
(23, 8, 5),
(24, 8, 6);

-- --------------------------------------------------------

--
-- Table structure for table `tr_guru_tes`
--

CREATE TABLE `tr_guru_tes` (
  `id` int(6) NOT NULL,
  `id_guru` int(6) NOT NULL,
  `id_mapel` int(6) NOT NULL,
  `nama_ujian` varchar(200) NOT NULL,
  `jumlah_soal` int(6) NOT NULL,
  `waktu` int(6) NOT NULL,
  `jenis` enum('acak','set') NOT NULL,
  `detil_jenis` varchar(500) NOT NULL,
  `tgl_mulai` datetime NOT NULL,
  `terlambat` datetime NOT NULL,
  `token` varchar(5) NOT NULL,
  `Thumbnail` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tr_guru_tes`
--

INSERT INTO `tr_guru_tes` (`id`, `id_guru`, `id_mapel`, `nama_ujian`, `jumlah_soal`, `waktu`, `jenis`, `detil_jenis`, `tgl_mulai`, `terlambat`, `token`, `Thumbnail`) VALUES
(1, 6, 1, 'Ujian Akhir Semester', 10, 60, 'acak', '', '2019-03-22 14:12:00', '2019-03-22 14:40:00', 'YKXSI', 0),
(2, 7, 3, 'Ujian Akhir Semester', 10, 60, 'acak', '', '2019-03-23 12:24:00', '2019-03-23 15:00:00', 'FJXJY', 0),
(3, 4, 3, 'Ujian Akhir Semester', 18, 60, 'set', '', '2019-05-13 21:33:00', '2019-05-13 22:08:00', 'STDFN', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tr_ikut_ujian`
--

CREATE TABLE `tr_ikut_ujian` (
  `id` int(6) NOT NULL,
  `id_tes` int(6) NOT NULL,
  `id_user` int(6) NOT NULL,
  `list_soal` longtext NOT NULL,
  `list_jawaban` longtext NOT NULL,
  `jml_benar` int(6) NOT NULL,
  `nilai` decimal(10,2) NOT NULL,
  `nilai_bobot` decimal(10,2) NOT NULL,
  `tgl_mulai` datetime NOT NULL,
  `tgl_selesai` datetime NOT NULL,
  `status` enum('Y','N') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tr_ikut_ujian`
--

INSERT INTO `tr_ikut_ujian` (`id`, `id_tes`, `id_user`, `list_soal`, `list_jawaban`, `jml_benar`, `nilai`, `nilai_bobot`, `tgl_mulai`, `tgl_selesai`, `status`) VALUES
(1, 1, 7, '48,51,38,50,45,36,43,35,37,40', '48:B:N,51:A:N,38:B:N,50:B:N,45:D:N,36:C:N,43:C:N,35:C:N,37:C:N,40:A:N', 3, '30.00', '30.00', '2019-03-22 14:12:20', '2019-03-22 15:12:20', 'N'),
(2, 2, 7, '57,49,56,47,64,62,60,54,53,61', '57:D:N,49:C:N,56:A:N,47:D:N,64:C:N,62:B:N,60:A:N,54:B:N,53:C:N,61:A:N', 3, '30.00', '30.00', '2019-03-23 12:24:02', '2019-03-23 13:24:02', 'N'),
(5, 3, 7, '74,67,65,76,75,80,71,69,82,77,78,79,73,81,70,68,72,66', '74::N,67::N,65::N,76::N,75::N,80::N,71::N,69::N,82::N,77::N,78::N,79::N,73::N,81::N,70::N,68::N,72::N,66::N', 0, '0.00', '0.00', '2019-05-13 10:09:45', '2019-05-13 11:09:45', 'N'),
(6, 3, 3, '65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82', '65::N,66::N,67::N,68::N,69::N,70::N,71::N,72::N,73::N,74::N,75::N,76::N,77::N,78::N,79::N,80::N,81::N,82::N', 0, '0.00', '0.00', '2019-05-13 21:33:38', '2019-05-13 22:33:38', 'Y');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `m_admin`
--
ALTER TABLE `m_admin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kon_id` (`kon_id`);

--
-- Indexes for table `m_guru`
--
ALTER TABLE `m_guru`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `m_mapel`
--
ALTER TABLE `m_mapel`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `m_siswa`
--
ALTER TABLE `m_siswa`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `m_soal`
--
ALTER TABLE `m_soal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_guru` (`id_guru`),
  ADD KEY `id_mapel` (`id_mapel`);

--
-- Indexes for table `tr_guru_mapel`
--
ALTER TABLE `tr_guru_mapel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_guru` (`id_guru`),
  ADD KEY `id_mapel` (`id_mapel`);

--
-- Indexes for table `tr_guru_tes`
--
ALTER TABLE `tr_guru_tes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_guru` (`id_guru`),
  ADD KEY `id_mapel` (`id_mapel`);

--
-- Indexes for table `tr_ikut_ujian`
--
ALTER TABLE `tr_ikut_ujian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tes` (`id_tes`),
  ADD KEY `id_user` (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `m_admin`
--
ALTER TABLE `m_admin`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `m_guru`
--
ALTER TABLE `m_guru`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `m_mapel`
--
ALTER TABLE `m_mapel`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `m_siswa`
--
ALTER TABLE `m_siswa`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `m_soal`
--
ALTER TABLE `m_soal`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `tr_guru_mapel`
--
ALTER TABLE `tr_guru_mapel`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `tr_guru_tes`
--
ALTER TABLE `tr_guru_tes`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tr_ikut_ujian`
--
ALTER TABLE `tr_ikut_ujian`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
