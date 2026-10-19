-- ============================================================
-- Modul 5: Data Definition Language (DDL) & Constraint
-- Tema Studi Kasus : Koperasi Mahasiswa (Kopma)
-- NIM         : 25430075
-- Nama        : M. Fuad Fardani
-- ============================================================

-- 1. Pembuatan Basis Data
DROP DATABASE IF EXISTS kopma_075;
CREATE DATABASE kopma_075;
USE kopma_075;

-- 2. Tabel Master: supplier
CREATE TABLE supplier (
    id_supplier INT AUTO_INCREMENT PRIMARY KEY,
    kode_supplier VARCHAR(10) NOT NULL UNIQUE,
    nama_supplier VARCHAR(100) NOT NULL,
    alamat_supplier TEXT NULL,
    telepon_supplier VARCHAR(20) NULL
) ENGINE=InnoDB;

-- 3. Tabel Master: kategori_barang
CREATE TABLE kategori_barang (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- 4. Tabel Master: barang
CREATE TABLE barang (
    id_barang INT AUTO_INCREMENT PRIMARY KEY,
    kode_barang VARCHAR(10) NOT NULL UNIQUE,
    nama_barang VARCHAR(100) NOT NULL,
    id_kategori INT NOT NULL,
    harga_jual DECIMAL(10,2) NOT NULL CHECK (harga_jual >= 0),
    stok_barang INT NOT NULL CHECK (stok_barang >= 0),
    CONSTRAINT fk_barang_kategori 
        FOREIGN KEY (id_kategori) REFERENCES kategori_barang(id_kategori)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 5. Tabel Master: anggota
CREATE TABLE anggota (
    id_anggota INT AUTO_INCREMENT PRIMARY KEY,
    no_anggota VARCHAR(15) NOT NULL UNIQUE,
    nama_anggota VARCHAR(100) NOT NULL,
    telepon_anggota VARCHAR(20) NULL
) ENGINE=InnoDB;

-- 6. Tabel Transaksi Utama: transaksi_penjualan
CREATE TABLE transaksi_penjualan (
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    no_nota VARCHAR(20) NOT NULL UNIQUE,
    tgl_transaksi DATETIME NOT NULL,
    id_anggota INT NULL,
    CONSTRAINT fk_transaksi_anggota 
        FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota)
        ON DELETE SET NULL 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 7. Tabel Detail Transaksi: detail_penjualan
CREATE TABLE detail_penjualan (
    id_transaksi INT NOT NULL,
    id_barang INT NOT NULL,
    jumlah_beli INT NOT NULL CHECK (jumlah_beli > 0),
    harga_satuan DECIMAL(10,2) NOT NULL CHECK (harga_satuan >= 0),
    PRIMARY KEY (id_transaksi, id_barang),
    CONSTRAINT fk_detail_transaksi 
        FOREIGN KEY (id_transaksi) REFERENCES transaksi_penjualan(id_transaksi)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    CONSTRAINT fk_detail_barang 
        FOREIGN KEY (id_barang) REFERENCES barang(id_barang)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
) ENGINE=InnoDB;