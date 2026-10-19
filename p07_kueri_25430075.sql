-- ============================================================
-- Modul 7: Kueri Lanjutan (Advanced Query & Filtering)
-- Tema Proyek : Akademik (akad_075)
-- NIM         : 25430075
-- Nama        : M. Fuad Fardani
-- ============================================================

USE akad_075;

-- 1. Kueri dengan CLAUSE WHERE & OPERATOR PERBANDINGAN
-- Menampilkan mahasiswa yang prodinya Teknik Informatika
SELECT * FROM mahasiswa 
WHERE prodi_mahasiswa = 'Teknik Informatika';

-- 2. Kueri dengan PENCARIAN POLA (LIKE)
-- Mencari mahasiswa yang namanya berawalan huruf 'M'
SELECT * FROM mahasiswa 
WHERE nama_mahasiswa LIKE 'M%';

-- 3. Kueri dengan ORDER BY (Pengurutan Data)
-- Menampilkan daftar mata kuliah diurutkan berdasarkan SKS terbesar
SELECT * FROM mata_kuliah 
ORDER BY sks_mk DESC;

-- 4. Kueri dengan LIMIT (Pembatasan Baris Tampilan)
-- Menampilkan 2 data mahasiswa teratas
SELECT * FROM mahasiswa 
LIMIT 2;