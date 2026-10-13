# Dokumen Kebutuhan Data Siakad UM Metro

## 1. Latar Belakang dan Aktivitas Organisasi
Sistem Informasi Akademik Universitas Muhammadiyah Metro (**Siakad UM Metro**) merupakan sistem terintegrasi yang dirancang untuk mengelola seluruh proses administrasi akademik perguruan tinggi. Aktivitas utama di dalam organisasi ini meliputi pendaftaran mahasiswa baru, pengelolaan data mata kuliah dan dosen, penjadwalan perkuliahan, pengisian Kartu Rencana Studi (KRS) oleh mahasiswa setiap semester, serta pencatatan dan pengelolaan nilai hasil studi.

## 2. Aktor dan Proses Bisnis
Tabel proses bisnis utama (`PB-xx`) yang diidentifikasi dari sistem akademik meliputi:

| Kode | Proses Bisnis | Aktor | Pemicu |
| :--- | :--- | :--- | :--- |
| **PB-01** | Mengelola Data Mahasiswa | Bagian Akademik / Admin | Mahasiswa melakukan daftar ulang / registrasi |
| **PB-02** | Mengelola Data Mata Kuliah & Dosen | Bagian Kurikulum / Admin | Penentuan kurikulum baru setiap tahun akademik |
| **PB-03** | Menyusun Jadwal Kuliah | Bagian Akademik | Menjelang awal semester baru |
| **PB-04** | Pengisian dan Validasi KRS | Mahasiswa & Dosen PA (Penasihat Akademik) | Periode perwalian / kRS online dibuka |
| **PB-05** | Menginput dan Mengelola Nilai Mahasiswa | Dosen Pengampu | Berakhirnya semester / ujian akhir semester |

## 3. Dokumen Sumber yang Dianalisis
Dokumen sumber yang dijadikan acuan dalam perancangan ini meliputi:
* **Formulir Registrasi Mahasiswa Baru** (memuat data diri, NIM, program studi).
* **Kartu Rencana Studi (KRS)** (memuat daftar mata kuliah yang diambil mahasiswa pada semester berjalan).
* **Lembar Penilaian / Daftar Nilai Ujian** (memuat komponen nilai tugas, UTS, UAS, dan nilai akhir huruf).

## 4. Entitas Kandidat dan Elemen Data
Berdasarkan dokumen sumber, diidentifikasi 6 entitas kandidat utama:
1. **Mahasiswa**: `id_mahasiswa`, `nim_mahasiswa`, `nama_mahasiswa`, `prodi_mahasiswa`, `angkatan`, `no_hp_mahasiswa`.
2. **Dosen**: `id_dosen`, `nidn_dosen`, `nama_dosen`, `email_dosen`.
3. **Mata Kuliah**: `id_matakuliah`, `kode_matakuliah`, `nama_matakuliah`, `sks`, `semester_kurikulum`.
4. **Jadwal Kuliah**: `id_jadwal`, `id_matakuliah`, `id_dosen`, `hari`, `jam_mulai`, `jam_selesai`, `ruangan`, `tahun_akademik`, `semester`.
5. **KRS (Kartu Rencana Studi)**: `id_krs`, `nim_mahasiswa`, `tahun_akademik`, `semester`, `status_krs`.
6. **Detail KRS / Nilai**: `id_detail_krs`, `id_krs`, `id_jadwal`, `nilai_tugas`, `nilai_uts`, `nilai_uas`, `nilai_akhir`, `grade`.

## 5. Aturan Bisnis (`AB-xx`)
| Kode | Aturan Bisnis |
| :--- | :--- |
| **AB-01** | Setiap mahasiswa wajib memiliki NIM yang unik dan terdaftar pada satu Program Studi. |
| **AB-02** | Pengisian KRS oleh mahasiswa harus mendapatkan persetujuan (validasi) dari Dosen Penasihat Akademik (PA). |
| **AB-03** | Jumlah Satuan Kredit Semester (SKS) yang diambil mahasiswa dalam satu semester dibatasi berdasarkan Indeks Prestasi Semester (IPS) sebelumnya. |
| **AB-04** | Jadwal kuliah tidak boleh bentrok pada hari, jam, dan ruangan yang sama untuk dosen atau kelas yang bersangkutan. |
| **AB-05** | Nilai akhir mahasiswa dihitung berdasarkan komponen bobot (Tugas, UTS, UAS) yang telah ditetapkan dan bersifat tetap setelah disahkan. |
| **AB-06** | Mata kuliah prasyarat harus lulus (mendapatkan nilai minimum tertentu) sebelum mengambil mata kuliah lanjutan. |
| **AB-07** | Setiap kelas perkuliahan memiliki kapasitas maksimal mahasiswa di dalam satu ruangan. |
| **AB-08** | Data transaksional akademik harus tersimpan secara historis per tahun akademik dan semester. |

## 6. Kebutuhan Informasi (`KI-xx`)
| Kode | Kebutuhan Informasi | Data yang Diperlukan |
| :--- | :--- | :--- |
| **KI-01** | Transkrip nilai dan Indeks Prestasi Kumulatif (IPK) mahasiswa | Mahasiswa, Detail KRS, Jadwal, Mata Kuliah |
| **KI-02** | Rekapitulasi jumlah mahasiswa aktif per Program Studi per semester | Mahasiswa, KRS |
| **KI-03** | Jadwal mengajar dosen dan daftar peserta kelas perkuliahan | Dosen, Jadwal, Mata Kuliah, KRS, Mahasiswa |
| **KI-04** | Laporan distribusi nilai per mata kuliah (statistik huruf mutu) | Detail KRS, Mata Kuliah |
| **KI-05** | Daftar mahasiswa yang belum melakukan pengisian atau persetujuan KRS | Mahasiswa, KRS |

## 7. Matriks CRUD Proses Bisnis terhadap Entitas
| Proses Bisnis | Mahasiswa | Dosen | Mata Kuliah | Jadwal Kuliah | KRS | Detail KRS |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **PB-01** (Kelola Mahasiswa) | C, R, U, D | - | - | - | - | - |
| **PB-02** (Kelola MK & Dosen) | - | C, R, U, D | C, R, U, D | - | - | - |
| **PB-03** (Susun Jadwal) | - | R | R | C, R, U, D | - | - |
| **PB-04** (Isi & Validasi KRS) | R | R | R | R | C, R, U | C, R, U |
| **PB-05** (Input Nilai) | R | R | R | R | R | R, U |

## 8. Kamus Data Awal
| Elemen Data | Arti / Deskripsi | Contoh Nilai | Aturan / Validasi | Penanggung Jawab |
| :--- | :--- | :--- | :--- | :--- |
| `nim_mahasiswa` | Nomor Induk Mahasiswa | `25430075` | Unik, tepat 10 digit[cite: 26] | Bagian Akademik |
| `nama_mahasiswa` | Nama lengkap mahasiswa | `M. Fuad Fardani` | Huruf dan spasi, Wajib isi | Bagian Akademik |
| `no_hp_mahasiswa` | Nomor telepon/WhatsApp | `081234567890` | Data pribadi (PDP), opsional[cite: 26] | Bagian Akademik |
| `kode_matakuliah` | Kode unik mata kuliah | `IF301` | Unik, alfanumerik | Bagian Kurikulum |
| `sks` | Bobot Satuan Kredit Semester | `3` | Bilangan bulat >= 1 | Bagian Kurikulum |
| `grade` | Huruf mutu nilai akhir | `A` | Enum (`A`, `B`, `C`, `D`, `E`) | Dosen Pengampu |

## 9. Kebutuhan Non-Fungsional Data & Parameter Personal (`P`)
* **Volume Transaksi:** Estimasi ± 3.000 mahasiswa aktif dengan rata-rata 20 KRS per semester.
* **Retensi Data:** Seluruh riwayat akademik disimpan sekurang-kurangnya selama masa studi ditambah masa arsip alumni (minimal 10 tahun).
* **Privasi Data:** Data pribadi mahasiswa (seperti nomor telepon, alamat, dan nilai transkrip) bersifat rahasia dan hanya dapat diakses oleh mahasiswa yang bersangkutan, Dosen PA, serta Admin Akademik (sesuai UU Pelindungan Data Pribadi)[cite: 21, 49].
* **Perhitungan Parameter Personal ($P$):** 
  Sesuai ketentuan buku panduan modul[cite: 51], dihitung berdasarkan dua digit terakhir NIM Anda (`75`):
  $$P = \left( \binom{6}{4} \times (75 \pmod 9) \right) + 1$$
  Parameter $P$ ini nantinya digunakan untuk menentukan batas maksimal item/beban SKS per semester, persentase komponen penilaian, serta skala volume data sampel pada modul-modul berikutnya[cite: 51].

## 10. Isu Kualitas Data yang Diantisipasi
* **Inkonsistensi Penulisan Nama Program Studi:** Potensi perbedaan penulisan (misal: "Ilmu Komputer", "ILKOM", "Informatika"). Diatasi dengan standarisasi menggunakan tipe terenumerasi (`ENUM`) atau tabel referensi prodi.
* **Duplikasi Data Mahasiswa:** Dicek melalui keunikan `nim_mahasiswa` pada saat proses impor atau pendaftaran[cite: 26].