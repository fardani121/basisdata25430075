-- ============================================================
-- Modul 5: Data Definition Language (DDL) & Constraint
-- Tema Proyek : Akademik (akad_075)
-- NIM         : 25430075
-- Nama        : M. Fuad Fardani
-- ============================================================

-- 1. Pembuatan Basis Data
DROP DATABASE IF EXISTS akad_075;
CREATE DATABASE akad_075;
USE akad_075;

-- 2. Tabel Master: mahasiswa
CREATE TABLE mahasiswa (
    id_mahasiswa INT AUTO_INCREMENT PRIMARY KEY,
    nim_mahasiswa VARCHAR(15) NOT NULL UNIQUE,
    nama_mahasiswa VARCHAR(100) NOT NULL,
    prodi_mahasiswa VARCHAR(50) NOT NULL,
    no_hp_mahasiswa VARCHAR(20) NULL,
    status_mahasiswa ENUM('Aktif', 'Cuti', 'Lulus', 'DO') DEFAULT 'Aktif'
) ENGINE=InnoDB;

-- 3. Tabel Master: mata_kuliah
CREATE TABLE mata_kuliah (
    id_mk INT AUTO_INCREMENT PRIMARY KEY,
    kode_mk VARCHAR(10) NOT NULL UNIQUE,
    nama_mk VARCHAR(100) NOT NULL,
    sks_mk INT NOT NULL CHECK (sks_mk > 0 AND sks_mk <= 6),
    semester_mk INT NOT NULL CHECK (semester_mk BETWEEN 1 AND 8)
) ENGINE=InnoDB;

-- 4. Tabel Transaksi Utama: krs
CREATE TABLE krs (
    id_krs INT AUTO_INCREMENT PRIMARY KEY,
    no_krs VARCHAR(20) NOT NULL UNIQUE,
    id_mahasiswa INT NOT NULL,
    tgl_krs DATE NOT NULL,
    CONSTRAINT fk_krs_mahasiswa 
        FOREIGN KEY (id_mahasiswa) REFERENCES mahasiswa(id_mahasiswa)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 5. Tabel Detail Transaksi: detail_krs
CREATE TABLE detail_krs (
    id_krs INT NOT NULL,
    id_mk INT NOT NULL,
    nilai_huruf CHAR(2) NULL CHECK (nilai_huruf IN ('A', 'B+', 'B', 'C+', 'C', 'D', 'E')),
    PRIMARY KEY (id_krs, id_mk),
    CONSTRAINT fk_detail_krs
        FOREIGN KEY (id_krs) REFERENCES krs(id_krs)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    CONSTRAINT fk_detail_mk
        FOREIGN KEY (id_mk) REFERENCES mata_kuliah(id_mk)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
) ENGINE=InnoDB;