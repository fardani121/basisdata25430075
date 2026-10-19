-- ============================================================
-- Modul 6: Data Manipulation Language (DML) & Kueri Dasar
-- Tema Proyek : Akademik (akad_075)
-- NIM         : 25430075
-- Nama        : M. Fuad Fardani
-- ============================================================

USE akad_075;

-- 1. INSERT DATA MASTER: mahasiswa
INSERT INTO mahasiswa (nim_mahasiswa, nama_mahasiswa, prodi_mahasiswa, no_hp_mahasiswa, status_mahasiswa) VALUES
('25430075', 'M. Fuad Fardani', 'Teknik Informatika', '081234567890', 'Aktif'),
('25430001', 'Siti Aminah', 'Sistem Informasi', '081298765432', 'Aktif'),
('25430002', 'Budi Santoso', 'Teknik Informatika', '081321436587', 'Cuti');

-- 2. INSERT DATA MASTER: mata_kuliah
INSERT INTO mata_kuliah (kode_mk, nama_mk, sks_mk, semester_mk) VALUES
('IF101', 'Basis Data I', 3, 3),
('IF102', 'Pemrograman Berorientasi Objek', 4, 3),
('SI201', 'Analisis Perancangan Sistem', 3, 3);

-- 3. INSERT DATA TRANSAKSI: krs
INSERT INTO krs (no_krs, id_mahasiswa, tgl_krs) VALUES
('KRS202603075', 1, '2026-08-25'),
('KRS202603001', 2, '2026-08-26');

-- 4. INSERT DATA DETAIL KRS: detail_krs
INSERT INTO detail_krs (id_krs, id_mk, nilai_huruf) VALUES
(1, 1, 'A'),
(1, 2, 'B+'),
(2, 1, 'A'),
(2, 3, 'B');

-- ============================================================
-- 5. PENGUJIAN KUERI (SELECT & JOIN)
-- ============================================================

-- A. Menampilkan seluruh data mahasiswa
SELECT * FROM mahasiswa;

-- B. Menampilkan daftar KRS mahasiswa menggunakan INNER JOIN
SELECT 
    k.no_krs,
    m.nim_mahasiswa,
    m.nama_mahasiswa,
    mk.kode_mk,
    mk.nama_mk,
    mk.sks_mk,
    dk.nilai_huruf
FROM krs k
JOIN mahasiswa m ON k.id_mahasiswa = m.id_mahasiswa
JOIN detail_krs dk ON k.id_krs = dk.id_krs
JOIN mata_kuliah mk ON dk.id_mk = mk.id_mk;

-- C. Menggunakan Agregat: Menghitung total SKS mahasiswa
SELECT 
    m.nim_mahasiswa,
    m.nama_mahasiswa,
    SUM(mk.sks_mk) AS total_sks_diambil
FROM mahasiswa m
JOIN krs k ON m.id_mahasiswa = k.id_mahasiswa
JOIN detail_krs dk ON k.id_krs = dk.id_krs
JOIN mata_kuliah mk ON dk.id_mk = mk.id_mk
WHERE m.nim_mahasiswa = '25430075'
GROUP BY m.id_mahasiswa;