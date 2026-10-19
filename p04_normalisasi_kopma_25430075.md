# Dokumen Normalisasi dan Skema Relasional - Koperasi Mahasiswa (Kopma)

**Nama:** M. Fuad Fardani  
**NIM:** 25430075  
**Studi Kasus:** Koperasi Mahasiswa Sejahtera (Kopma)  

---

## 1. Dokumen Sumber Awal (UNF)
Dokumen sumber yang dianalisis adalah **Nota Penjualan Kopma** yang mencatat identitas transaksi, kasir, anggota, serta grup berulang daftar barang yang dibeli dalam satu transaksi.

* **Bentuk Unnormalized Form (UNF):**
  `NOTA_UNF` (`no_nota_penjualan`, `tgl_penjualan`, `kode_petugas`, `nama_petugas`, `no_anggota`, `nama_anggota`, `{ kode_barang, nama_barang, qty_detail_penjualan, harga_satuan_detail_penjualan, subtotal_detail_penjualan }`, `jumlah_penjualan`, `diskon_penjualan`, `total_penjualan`)

---

## 2. Bentuk Normal Pertama (1NF)
Pada tahap 1NF, grup berulang (*repeating group*) dihilangkan sehingga setiap sel bernilai atomik (tunggal). Kunci utama dibentuk secara komposit dari `no_nota_penjualan` dan `kode_barang`.

* **Bentuk 1NF:**
  `NOTA_1NF` (`no_nota_penjualan`, `kode_barang`, `tgl_penjualan`, `kode_petugas`, `nama_petugas`, `no_anggota`, `nama_anggota`, `nama_barang`, `qty_detail_penjualan`, `harga_satuan_detail_penjualan`, `subtotal_detail_penjualan`, `jumlah_penjualan`, `diskon_penjualan`, `total_penjualan`)

---

## 3. Daftar Dependensi Fungsional (Functional Dependency / FD)
Dependensi fungsional diturunkan berdasarkan aturan bisnis (Business Rules / AB) Kopma dari Pertemuan 2:

* **FD1:** `no_nota_penjualan` -> `tgl_penjualan`, `kode_petugas`, `no_anggota` *(Aturan AB-01: Satu nota memiliki nomor unik, tanggal, petugas, dan anggota)*
* **FD2:** `kode_petugas` -> `nama_petugas` *(Satu kode petugas menentukan nama petugas)*
* **FD3:** `no_anggota` -> `nama_anggota` *(Aturan AB-05: Satu nomor anggota menentukan nama anggota)*
* **FD4:** `kode_barang` -> `nama_barang` *(Satu kode barang menentukan nama barang)*
* **FD5:** (`no_nota_penjualan`, `kode_barang`) -> `qty_detail_penjualan`, `harga_satuan_detail_penjualan` *(Aturan AB-04: Harga jual saat transaksi disimpan per baris nota)*
* **FD6:** (`qty_detail_penjualan`, `harga_satuan_detail_penjualan`) -> `subtotal_detail_penjualan` *(Nilai turunan yang dapat dihitung)*

---

## 4. Bentuk Normal Kedua (2NF)
Pada tahap 2NF, atribut non-kunci yang hanya bergantung pada sebagian kunci komposit (ketergantungan parsial) dipisahkan ke relasi tersendiri.

* **Pemisahan Tabel 2NF:**
  * `PENJUALAN_2NF` (`no_nota_penjualan`, `tgl_penjualan`, `kode_petugas`, `nama_petugas`, `no_anggota`, `nama_anggota`, `bayar_penjualan`)
  * `BARANG_2NF` (`kode_barang`, `nama_barang`, `kategori_barang`, `harga_jual_barang`, `stok_barang`, `stok_min_barang`)
  * `DETAIL_PENJUALAN_2NF` (`no_nota_penjualan`*, `kode_barang`*, `qty_detail_penjualan`, `harga_satuan_detail_penjualan`)

---

## 5. Bentuk Normal Ketiga (3NF) dan Skema Kanonik Kopma
Pada tahap 3NF, ketergantungan transitif (`no_nota_penjualan` -> `kode_petugas` -> `nama_petugas` dan `no_nota_penjualan` -> `no_anggota` -> `nama_anggota`) dipisahkan menjadi tabel `petugas` dan `anggota`. 

Selain itu, sesuai standar skema kanonik Kopma, digunakan kunci pengganti (*surrogate key*) `id_*` sebagai kunci primer:

1. **`petugas`**
   * Primary Key: `id_petugas`
   * Unique Key: `kode_petugas`
   * Atribut: `nama_petugas`, `peran_petugas`

2. **`anggota`**
   * Primary Key: `id_anggota`
   * Unique Key: `no_anggota`, `nim_anggota`
   * Atribut: `nama_anggota`, `prodi_anggota`, `no_hp_anggota`, `status_anggota`, `tgl_daftar_anggota`

3. **`barang`**
   * Primary Key: `id_barang`
   * Unique Key: `kode_barang`
   * Atribut: `nama_barang`, `kategori_barang`, `harga_jual_barang`, `stok_barang`, `stok_min_barang`

4. **`pemasok`**
   * Primary Key: `id_pemasok`
   * Atribut: `nama_pemasok`, `telepon_pemasok`, `alamat_pemasok`

5. **`penjualan`**
   * Primary Key: `id_penjualan`
   * Unique Key: `no_nota_penjualan`
   * Foreign Key: `id_petugas` -> `petugas(id_petugas)`, `id_anggota` -> `anggota(id_anggota)` (opsional / boleh NULL)
   * Atribut: `tgl_penjualan`, `bayar_penjualan`

6. **`detail_penjualan`**
   * Primary Key: (`id_penjualan`, `id_barang`)
   * Foreign Key: `id_penjualan` -> `penjualan(id_penjualan)`, `id_barang` -> `barang(id_barang)`
   * Atribut: `qty_detail_penjualan`, `harga_satuan_detail_penjualan`

7. **`pembelian`**
   * Primary Key: `id_pembelian`
   * Foreign Key: `id_pemasok` -> `pemasok(id_pemasok)`
   * Atribut: `no_faktur_pembelian`, `tgl_pembelian`, `status_pembelian`

8. **`detail_pembelian`**
   * Primary Key: (`id_pembelian`, `id_barang`)
   * Foreign Key: `id_pembelian` -> `pembelian(id_pembelian)`, `id_barang` -> `barang(id_barang)`
   * Atribut: `qty_detail_pembelian`, `harga_beli_detail_pembelian`

---

## 6. Keputusan Nilai Turunan
Nilai turunan seperti `subtotal_detail_penjualan`, `jumlah_penjualan`, dan `total_penjualan` **TIDAK DISIMPAN** di dalam tabel operasional. Nilai-nilai tersebut dihitung secara dinamis saat kueri dijalankan untuk mencegah terjadinya inkonsistensi data.

---

## 7. Pemeriksaan BCNF (Boyce-Codd Normal Form)
Seluruh penentu (*determinan*) pada setiap relasi skema kanonik Kopma sudah merupakan kunci kandidat (*candidate key*) yang sah, sehingga skema ini telah memenuhi kriteria BCNF.