perbaiki fungsi scan nota monitor minuman.

jika ada data penjaga etalase hari ini maka:
- tambahkan perintah untuk mengurangi stock peralatan etalase di area pancing saja, kareana untuk stock peralatan etalase selain pancing akan di scan oleh penjaga etalase.

tapi jika tidak ada data penjaga etalase hari ini maka:
- tambahkan perintah untuk mengurangi stock peralatan etalase di area pancing meskipun nota tersebut berada di area selain pancing.

Hint:
- jika ada tidak ada penjaga etalase maka seluruh peralatan etalase ambil di area pancing yang otomatis berkurang saat fungsi scan nota minuman di jalankan
- jika ada pengaja etalase maka scan nota minuman hanya mengambil peralatan di area etalase pancing, selain itu akan di scan nota peralatan etalase akan di scan oleh para penjaga etalase

refactor(monitor minuman): perubahan metode scan nota minuman
- otomatis mengurangi peralatan di etalase dengan logika:
1. Cek apakah ada data penjaga_etalase hari ini.
2. Ambil area nota (monitor_area_hariini.area) dan jumlah orang (o_jmlorg).
3. Hitung kebutuhan qty_piring dan qty_gelas dengan rumus yang sama seperti penjaga etalase.
4. Insert ke kurang_stocketalase dengan id_area = 1 (AREA PANCING) berdasarkan aturan:
- Jika ada penjaga etalase hari ini: hanya kurangi stok saat nota area AREA PANCING.
- Jika tidak ada penjaga etalase hari ini: tetap kurangi stok area pancing untuk semua nota (termasuk area selain pancing).
5. Ada proteksi agar tidak double insert untuk o_kode yang sama.