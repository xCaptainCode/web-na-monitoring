Tambahkan data daftar minuman yang sudah di order, group by sel_mmenu_id dan tampilkan di sebelah Daftar Nota Mimunan Belum Saji buat auto refresh dengan waktu yang sama seperti menampilkan Daftar Nota Minuman Belum Saji.

- daftar karywan
administrasi=# SELECT username as nik, nama_alias FROM users_employee WHERE org_department_id = '06' AND jab_id in (5151, 5103, 5152);
   nik   | nama_alias
---------+------------
 2310458 | Ari
 2411469 | Sofiyan
 2510484 | Ambar
(3 rows)

- daftar parttimer
administrasi=#  SELECT nomor_id_card as nik, nama_alias from pt_vpresence where tanggal = CURRENT_DATE and keterangan = 1 and namapos in ('PRAMUSAJI', 'DAPUR SAJI') order by nama_alias;

 nik  | nama_alias
------+------------
 8718 | AINUN
 2295 | ANDIN
 5098 | AYA
 4682 | AZAM
 3187 | BINTANG
 5202 | CHILLO
 6271 | EDWAR
 1126 | EVA
 7908 | FITRI
 4143 | ILHAM
 3951 | LISA
 2595 | MEFIA
(24 rows)

Tambahkan metode scan untuk Daftar Nota Minuman Belum Saji yang mana saat scan akan meng-update table sel_jual_hariini berdasarkan field kolom yang di ubah sebagai berikut:
- j_jamsajiminum = current_time
- j_penyajiminum = nik (berdasarkan input dari daftar karywan atau daftar parttimer)

untuk memilih penyaji minum gunakan metode button dan value (seperti calculator, jangan gunakan select option), jadi tampilkan seluruh daftar penyaji minum (karyawan dan parttimer) saat user mengklik nama penyaji tersebut maka penyaji tersebut yang menjadi value baru kemudian simpan