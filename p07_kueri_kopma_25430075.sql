-- ============================================================
-- Modul 7: Kueri Lanjutan (Advanced Query & Filtering)
-- Tema Studi Kasus : Koperasi Mahasiswa (kopma_075)
-- NIM         : 25430075
-- Nama        : M. Fuad Fardani
-- ============================================================

USE kopma_075;

SELECT * FROM barang WHERE harga_jual BETWEEN 3000.00 AND 5000.00;

SELECT * FROM barang WHERE id_kategori = 1 OR stok_barang > 50;

SELECT kode_supplier AS kode, nama_supplier AS nama_pt, alamat_supplier AS alamat FROM supplier ORDER BY nama_supplier ASC;