-- ============================================================
-- Modul 8: Ujian Tengah Semester (UTS) Basis Data
-- NIM         : 25430075
-- Nama        : M. Fuad Fardani
-- ============================================================

-- A. PENGUJIAN DATABASE AKADEMIK (akad_075)
USE akad_075;

-- Menampilkan mahasiswa teknik informatika dengan urutan nama A-Z
SELECT * FROM mahasiswa 
WHERE prodi_mahasiswa = 'Teknik Informatika' 
ORDER BY nama_mahasiswa ASC;

-- Menampilkan total SKS yang diambil oleh masing-masing mahasiswa
SELECT 
    m.nim_mahasiswa,
    m.nama_mahasiswa,
    SUM(mk.sks_mk) AS total_sks
FROM mahasiswa m
JOIN krs k ON m.id_mahasiswa = k.id_mahasiswa
JOIN detail_krs dk ON k.id_krs = dk.id_krs
JOIN mata_kuliah mk ON dk.id_mk = mk.id_mk
GROUP BY m.id_mahasiswa;


-- B. PENGUJIAN DATABASE KOPERASI MAHASISWA (kopma_075)
USE kopma_075;

-- Menampilkan barang dengan harga antara 3000 sampai 5000
SELECT * FROM barang 
WHERE harga_jual BETWEEN 3000.00 AND 5000.00;

-- Menampilkan rincian transaksi penjualan beserta subtotalnya
SELECT 
    tp.no_nota,
    tp.tgl_transaksi,
    b.nama_barang,
    dp.jumlah_beli,
    dp.harga_satuan,
    (dp.jumlah_beli * dp.harga_satuan) AS subtotal
FROM transaksi_penjualan tp
JOIN detail_penjualan dp ON tp.id_transaksi = dp.id_transaksi
JOIN barang b ON dp.id_barang = b.id_barang;