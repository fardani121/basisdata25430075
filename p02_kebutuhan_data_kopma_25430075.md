# Dokumen Kebutuhan Data Proyek

## 1. Latar Belakang dan Aktivitas Organisasi
Organisasi fiktif ini dikembangkan untuk mengelola sistem pencatatan operasional secara terkomputerisasi guna menghindari kesalahan pencatatan manual, stok minus, dan hilangnya data historis transaksi. Aktivitas utama meliputi pendaftaran anggota, pencatatan transaksi penjualan, pemesanan barang ke pemasok, dan penerimaan laporan berkala.

## 2. Aktor dan Proses Bisnis
| Kode | Proses Bisnis | Aktor | Pemicu |
|---|---|---|---|
| PB-01 | Mendaftarkan anggota | Kasir | Mahasiswa ingin menjadi anggota |
| PB-02 | Mencatat penjualan | Kasir | Pembeli melakukan transaksi di kasir |
| PB-03 | Memesan barang ke pemasok | Petugas Gudang | Stok barang di bawah batas minimum |
| PB-04 | Menerima barang dari pemasok | Petugas Gudang | Barang datang bersama faktur |
| PB-05 | Menyusun laporan bulanan | Ketua | Memasuki awal bulan |

## 3. Dokumen Sumber yang Dianalisis
- Nota Penjualan (memuat identitas transaksi, kasir, anggota, rincian barang, qty, dan harga saat transaksi).
- Formulir Pendaftaran Anggota.
- Faktur Pembelian Pemasok.

## 4. Entitas Kandidat dan Elemen Data
- **Anggota**: id_anggota, no_anggota, nim_anggota, nama_anggota, prodi_anggota, no_hp_anggota, status_anggota, tgl_daftar_anggota.
- **Barang**: id_barang, kode_barang, nama_barang, kategori_barang, harga_jual_barang, stok_barang, stok_min_barang.
- **Penjualan**: id_penjualan, no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan.
- **Detail Penjualan**: id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan.
- **Petugas**: id_petugas, kode_petugas, nama_petugas, peran_petugas.
- **Pemasok**: id_pemasok, nama_pemasok, telepon_pemasok, alamat_pemasok.

## 5. Aturan Bisnis
- **AB-01**: Setiap nota memiliki nomor unik dan minimal satu baris barang.
- **AB-02**: Penjualan boleh tanpa anggota (umum); jika ada anggota, status harus aktif untuk mendapat diskon 5%.
- **AB-03**: Stok barang tidak boleh bernilai negatif; penjualan ditolak bila `qty` melebihi stok tersedia.
- **AB-04**: Harga jual pada nota disimpan per baris dan tidak berubah meski harga barang naik di kemudian hari.
- **AB-05**: NIM dan nomor anggota bersifat unik.
- **AB-06**: Pesanan pembelian dibuat jika stok barang kurang dari batas minimum.

## 6. Kebutuhan Informasi
- **KI-01**: Omzet dan jumlah nota per hari dan per bulan.
- **KI-02**: Lima barang terlaris per bulan berdasarkan `qty`.
- **KI-03**: Barang dengan stok di bawah batas minimum.
- **KI-04**: Sepuluh anggota dengan belanja terbesar per bulan.

## 7. Matriks CRUD
| Proses Bisnis | Anggota | Barang | Penjualan | Detail Penjualan | Pemasok | Pembelian |
|---|---|---|---|---|---|---|
| PB-01 Daftar Anggota | C | | | | | |
| PB-02 Catat Penjualan | R | R, U | C | C | | |
| PB-03 Pesan ke Pemasok | | R | | | R | C |
| PB-04 Terima Barang | | U | | | U | U |
| PB-05 Laporan Bulanan | R | R | R | R | | R |

## 8. Kamus Data Awal
| Elemen Data | Arti | Contoh Nilai | Aturan | Penanggung Jawab |
|---|---|---|---|---|
| no_anggota | Nomor kartu anggota | A-0457 | Unik, format A-4 digit | Ketua |
| nim_anggota | NIM mahasiswa | 2301010123 | Unik, 10 digit | Ketua |
| no_nota_penjualan | Nomor nota transaksi | PJ-2609-0142 | Unik per nota | Kasir |
| stok_barang | Jumlah stok tersedia | 35 | Bilangan bulat $\ge 0$ | Petugas Gudang |

## 9. Kebutuhan Non-Fungsional dan Parameter P
- **Volume & Retensi**: Perkiraan $\pm 150$ nota per hari; data transaksi disimpan minimal 5 tahun.
- **Privasi**: Nomor HP anggota bersifat pribadi dan hanya boleh diakses oleh Ketua.
- **Parameter P**: Dihitung berdasarkan ketentuan NIM Anda untuk menentukan batas maksimal item dan volume transaksi harian[cite: 59].

## 10. Isu Kualitas Data yang Diantisipasi
- Potensi duplikasi data anggota saat pendaftaran.
- Kesalahan penulisan format nomor HP dan perbedaan ejaan nama program studi.