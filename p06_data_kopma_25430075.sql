-- ============================================================
-- Modul 6: Data Manipulation Language (DML) & Kueri Dasar
-- Tema Studi Kasus : Koperasi Mahasiswa (Kopma_075)
-- NIM         : 25430075
-- Nama        : M. Fuad Fardani
-- ============================================================

USE kopma_075;

-- 1. INSERT DATA MASTER: supplier
INSERT INTO supplier (kode_supplier, nama_supplier, alamat_supplier, telepon_supplier) VALUES
('SUP001', 'PT Sumber Pangan', 'Jl. Sudirman No. 10, Jakarta', '0215551234'),
('SUP002', 'CV Berkah Jaya', 'Jl. Ahmad Yani No. 45, Bandung', '0227778889');

-- 2. INSERT DATA MASTER: kategori_barang
INSERT INTO kategori_barang (nama_kategori) VALUES
('Makanan Ringan'),
('Minuman'),
('Alat Tulis Kantor');

-- 3. INSERT DATA MASTER: barang
INSERT INTO barang (kode_barang, nama_barang, id_kategori, harga_jual, stok_barang) VALUES
('BRG001', 'Keripik Singkong', 1, 5000.00, 50),
('BRG002', 'Teh Botol Kotak', 2, 4000.00, 100),
('BRG003', 'Pulpen Gel Hitam', 3, 3500.00, 75);

-- 4. INSERT DATA MASTER: anggota
INSERT INTO anggota (no_anggota, nama_anggota, telepon_anggota) VALUES
('ANG001', 'Dewi Lestari', '085611223344'),
('ANG002', 'Rian Hidayat', '081999887766');

-- 5. INSERT DATA TRANSAKSI: transaksi_penjualan
INSERT INTO transaksi_penjualan (no_nota, tgl_transaksi, id_anggota) VALUES
('NOT20261019-01', '2026-10-19 09:30:00', 1),
('NOT20261019-02', '2026-10-19 10:15:00', 2);

-- 6. INSERT DATA DETAIL TRANSAKSI: detail_penjualan
INSERT INTO detail_penjualan (id_transaksi, id_barang, jumlah_beli, harga_satuan) VALUES
(1, 1, 2, 5000.00),
(1, 2, 3, 4000.00),
(2, 3, 4, 3500.00);

-- ============================================================
-- 7. PENGUJIAN KUERI (SELECT, JOIN, & AGREGAT KOPMA)
-- ============================================================

-- A. Menampilkan seluruh data barang beserta kategorinya
SELECT 
    b.kode_barang,
    b.nama_barang,
    k.nama_kategori,
    b.harga_jual,
    b.stok_barang
FROM barang b
JOIN kategori_barang k ON b.id_kategori = k.id_kategori;

-- B. Menampilkan rincian transaksi penjualan lengkap dengan nama anggota
SELECT 
    tp.no_nota,
    tp.tgl_transaksi,
    a.nama_anggota,
    b.nama_barang,
    dp.jumlah_beli,
    dp.harga_satuan,
    (dp.jumlah_beli * dp.harga_satuan) AS subtotal
FROM transaksi_penjualan tp
LEFT JOIN anggota a ON tp.id_anggota = a.id_anggota
JOIN detail_penjualan dp ON tp.id_transaksi = dp.id_transaksi
JOIN barang b ON dp.id_barang = b.id_barang;