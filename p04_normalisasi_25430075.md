# Dokumen Normalisasi dan Skema Relasional - Proyek Akademik

**Nama:** M. Fuad Fardani  
**NIM:** 25430075  
**Tema Proyek:** Akademik (`akad_075`)  

---

## 1. Dokumen Sumber Awal (UNF)
Dokumen sumber yang dianalisis adalah **Kartu Rencana Studi (KRS)** mahasiswa yang mencatat identitas mahasiswa beserta daftar mata kuliah yang diambil dalam satu lembar.

* **Bentuk Unnormalized Form (UNF):**
  `KRS_UNF` (`no_krs`, `tgl_krs`, `nim_mahasiswa`, `nama_mahasiswa`, `prodi_mahasiswa`, `{ kode_mk, nama_mk, sks_mk, nilai_huruf }`)

---

## 2. Bentuk Normal Pertama (1NF)
Pada tahap 1NF, grup berulang (*repeating group*) dihilangkan sehingga setiap sel data bersifat atomik (tunggal). Kunci utama dibentuk secara komposit dari `no_krs` dan `kode_mk`.

* **Bentuk 1NF:**
  `KRS_1NF` (`no_krs`, `tgl_krs`, `nim_mahasiswa`, `nama_mahasiswa`, `prodi_mahasiswa`, `kode_mk`, `nama_mk`, `sks_mk`, `nilai_huruf`)

---

## 3. Daftar Dependensi Fungsional (Functional Dependency / FD)
Dependensi fungsional diturunkan berdasarkan aturan bisnis (Business Rules / AB) pengelolaan data akademik:

* **FD1:** `no_krs` -> `tgl_krs`, `nim_mahasiswa` *(Aturan AB-01: Satu nomor KRS menentukan tanggal pengisian dan mahasiswa pemiliknya)*
* **FD2:** `nim_mahasiswa` -> `nama_mahasiswa`, `prodi_mahasiswa` *(Aturan AB-02: Satu NIM menentukan nama dan program studi mahasiswa secara unik)*
* **FD3:** `kode_mk` -> `nama_mk`, `sks_mk` *(Aturan AB-03: Kode mata kuliah menentukan nama dan bobot SKS)*
* **FD4:** (`no_krs`, `kode_mk`) -> `nilai_huruf` *(Aturan AB-04: Nilai huruf ditentukan oleh kombinasi KRS dan mata kuliah yang diambil)*

---

## 4. Bentuk Normal Kedua (2NF)
Pada tahap 2NF, ketergantungan parsial pada kunci komposit dihilangkan. Atribut yang hanya bergantung pada sebagian kunci dipisahkan ke tabel tersendiri.

* **Pemisahan Tabel 2NF:**
  * `KRS_2NF` (`no_krs`, `tgl_krs`, `nim_mahasiswa`, `nama_mahasiswa`, `prodi_mahasiswa`)
  * `MATA_KULIAH_2NF` (`kode_mk`, `nama_mk`, `sks_mk`)
  * `DETAIL_KRS_2NF` (`no_krs`*, `kode_mk`*, `nilai_huruf`)

---

## 5. Bentuk Normal Ketiga (3NF) dan Skema Relasional Akhir
Pada tahap 3NF, ketergantungan transitif (di mana atribut non-kunci bergantung pada atribut non-kunci lainnya, seperti `no_krs` -> `nim_mahasiswa` -> `nama_mahasiswa`) dipisahkan. 

Selain itu, digunakan kunci pengganti (*surrogate key*) `id_*` sebagai kunci primer teknis untuk meningkatkan performa relasi:

1. **`mahasiswa`**
   * Primary Key: `id_mahasiswa`
   * Unique Key: `nim_mahasiswa`
   * Atribut: `nama_mahasiswa`, `prodi_mahasiswa`, `no_hp_mahasiswa`, `status_mahasiswa`

2. **`mata_kuliah`**
   * Primary Key: `id_mk`
   * Unique Key: `kode_mk`
   * Atribut: `nama_mk`, `sks_mk`, `semester_mk`

3. **`krs`**
   * Primary Key: `id_krs`
   * Unique Key: `no_krs`
   * Foreign Key: `id_mahasiswa` -> `mahasiswa(id_mahasiswa)`
   * Atribut: `tgl_krs`

4. **`detail_krs`**
   * Primary Key: (`id_krs`, `id_mk`)
   * Foreign Key: `id_krs` -> `krs(id_krs)`
   * Foreign Key: `id_mk` -> `mata_kuliah(id_mk)`
   * Atribut: `nilai_huruf`

---

## 6. Keputusan Nilai Turunan
Nilai **IPK (Indeks Prestasi Kumulatif)** dan **IPS (Indeks Prestasi Semester)** diputuskan **TIDAK DISIMPAN** secara permanen pada tabel operasional. Nilai tersebut akan dihitung secara dinamis melalui kueri agregasi (`SUM(sks * bobot) / SUM(sks)`) saat dibutuhkan. Hal ini dilakukan untuk menghindari anomali perbaikan data jika terdapat perubahan nilai mahasiswa di kemudian hari.

---

## 7. Pemeriksaan BCNF (Boyce-Codd Normal Form)
Setiap penentu (*determinan*) pada skema 3NF di atas sudah merupakan kunci kandidat yang sah (*candidate key*). Dengan demikian, skema relasional ini sudah memenuhi kriteria BCNF.