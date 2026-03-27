<?php
/**
* References Helpers Class
*/
use Phalcon\DI;
use Phalcon\Mvc\Model\Manager as ModelsManager;

class References {
	/**
	 * Database connection
	 */
	static function sql_connect () {
		try {
			$db = DI::getDefault()->get('db');
		}

		catch (PDOException $e) {
			self::fatal(
				"An error occurred while connecting to the database. ".
				"The error reported by the server was: ".$e->getMessage()
			);
		}
		return $db;
	}

	static function sql_connect2 () {
		try {
			$db = DI::getDefault()->get('dbFrontOffice');
		}

		catch (PDOException $e) {
			self::fatal(
				"An error occurred while connecting to the database. ".
				"The error reported by the server was: ".$e->getMessage()
			);
		}
		return $db;
	}

	static function sql_exec ( $db, $bindings, $sql=null ) {
		// Argument shifting
		if ( $sql === null ) {
			$sql = $bindings;
		}
		$stmt = $db->prepare( $sql );
		// Bind parameters
		if ( is_array( $bindings ) ) {
			for ( $i=0, $ien=count($bindings) ; $i<$ien ; $i++ ) {
				$binding = $bindings[$i];
				$stmt->bindValue( $binding['key'], $binding['val'], $binding['type'] );
			}
		}
		// Execute
		try {
			$stmt->execute();
		}
		catch (PDOException $e) {
			self::fatal( "An SQL error occurred: ".$e->getMessage() );
		}
		// Return all
		return $stmt->fetchAll( PDO::FETCH_BOTH );
	}

	static function fatal ( $msg ) {
		echo json_encode( array(
			"error" => $msg
		) );

		exit(0);
	}
	/*---------------------end of database connection--------------------*/

	public static function getTA_aktif() {
		/*
		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings,
			"SELECT nama_tahunajar FROM yayasan_lembaga_tahunajar ORDER BY nama_tahunajar DESC LIMIT 1"
		);
		$taaktif = $result[0]['nama_tahunajar'];
		*/
		$today = new DateTime();
		$tahun = $today->format("Y");
		$bulan = $today->format("n");
		if ( $bulan >= 7 ) {
			$taaktif = strval($tahun) . "-" . strval($tahun+1);
		} else {
			$taaktif = strval($tahun-1) . "-" . strval($tahun);
		}
		return $taaktif;
	}

	/*-------------------------------------------------------------------*/

	public static function cmbTahun($namaTabel, $fieldTgl) {
		$bindings = array();
		$db = self::sql_connect();

		$result = self::sql_exec( $db, $bindings,
			"SELECT DISTINCT date_part('year', $fieldTgl) AS tahun FROM $namaTabel WHERE $fieldTgl IS NOT NULL ORDER BY tahun"
		);

		$tag 	   = "";
		foreach ($result as $val) {
			if ( $val['tahun'] == date('Y') ) {
				$pilih = " selected";
			} else {
				$pilih = "";
			}
			$tag  .= "<option value='$val[tahun]'$pilih> $val[tahun] </option>"."\n";

		}
		return $tag;
	}

	public static function cmbBulan() {
		$bulan = array("", "Januari", "Februari", "Maret", "April", "Mei", "Juni",
		"Juli", "Agustus", "September", "Oktober", "November", "Desember");
		$tag 	   = "";

		for($y=1;$y<=12;$y++) {
			if ($y==date("n")) {
				$pilih = " selected";
			} else {
				$pilih = "";
			}
			$tag  .= "<option value=\"$y\"$pilih>$bulan[$y]</option>"."\n";
		}
		return $tag;
	}

	public static function rombel($selected = null) {
		$rombel    = YayasanLembagaRombel::find();
		$tag 	   = "";
		foreach ($rombel as $value) {
			$tag  .= "<option value='$value->rombel_id'> $value->nama_rombel </option>";
		}
        return $tag;
	}

	public static function getnmRombel($selected = null) {
		//Creating PHQL QueriesEdit on Crowdin
		//PHQL queries can be created just by instantiating the class Phalcon\Mvc\Model\Query:
		$sql = "SELECT DISTINCT kelas_id, nama_rombel FROM YayasanLembagaRombel ORDER BY kelas_id, nama_rombel";
		$query = new Phalcon\Mvc\Model\Query($sql, \Phalcon\Di::getDefault());
		$rombel = $query->execute();

		$tag 	   = "";
		foreach ($rombel as $value) {
			$tag  .= "<option value='$value->rombel_id'> $value->nama_rombel </option>";
		}
      return $tag;
	}

	public static function cmbRombels($selected = null) {
		$taaktif = self::getTA_aktif();

		$bindings = array();
		$db = self::sql_connect();

		$result = self::sql_exec( $db, $bindings,
			"SELECT DISTINCT kelas_id, rombel_id, nama_rombel FROM yayasan_lembaga_rombel
			WHERE nama_tahunajar='$taaktif' ORDER BY kelas_id, nama_rombel"
		);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[1]'> $val[2] </option>";
		}
      return $tag;
	}

	public static function kelastingkat($selected = null) {
		$tingkat   = YayasanLembagaKelas::find([
			"yayasan_lembaga_id = '01'",
			'order' => 'kelas_id'
		]);
		$tag 	   = "";
		//https://docs.phalconphp.com/3.3/en/db-models.html

		foreach ($tingkat as $key => $value) {
			$tag  .= "<option value='$value->kelas_id'> $value->nama_kelas </option>";
		}
        return $tag;
	}

	public static function tahunajar($selected = null) {
		$taaktif = self::getTA_aktif();
		$thnajar   = YayasanLembagaTahunajar::find(array(
         "order" => "nama_tahunajar DESC"
      ));
		$tag 	   = "";

		foreach ($thnajar as $key => $value) {
			if ($value->nama_tahunajar == $taaktif) {
				$tag  .= "<option value='$value->nama_tahunajar' selected> $value->nama_tahunajar </option>";
			}else{
				$tag  .= "<option value='$value->nama_tahunajar'> $value->nama_tahunajar </option>";
			}
		}
      return $tag;
	}

	public static function agama($selected = null) {
		$agama = RefAgama::find([
        "agama_id < '7'",
        'order' => 'agama_id',
		]);
		$tag	   = "";
		foreach ($agama as $key => $value) {
			$tag  .= "<option value='$value->agama_id'> $value->nama </option>";
		}
        return $tag;
	}

	public static function pendidikan($selected = null) {
		$sql = "SELECT jenjang_pendidikan_id, nama FROM ref.jenjang_pendidikan
		WHERE jenjang_pendidikan_id BETWEEN 4 AND 98 ORDER BY jenjang_pendidikan_id";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
      return $tag;
	}

	public static function pekerjaan($selected = null) {
		$pekerjaan = RefPekerjaan::find(["nama != ''"]);
		$tag	   = "";
		foreach ($pekerjaan as $key => $value) {
			$tag  .= "<option value='$value->pekerjaan_id'> $value->nama </option>";
		}
        return $tag;
	}

	public static function perkawinan($selected = null) {
		$perkawinan = RefPerkawinan::find();
		$tag	   = "";
		foreach ($perkawinan as $key => $value) {
			$tag  .= "<option value='$value->perkawinan_id'> $value->nama </option>";
		}
        return $tag;
	}

	public static function Tunafisik($selected = null) {
		$sql = "SELECT kebutuhan_khusus_id, kebutuhan_khusus FROM ref.kebutuhan_khusus
		WHERE lower(kebutuhan_khusus) like '%tuna%'";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "<option value='0'> Tidak Ada </option>";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

	public static function Jenistinggal($selected = null) {
		$sql = "SELECT jenis_tinggal_id, nama FROM ref.jenis_tinggal
		WHERE lower(nama) not like '%unknown%' ORDER BY jenis_tinggal_id";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

	public static function AlatTransport($selected = null) {
		$sql = "SELECT alat_transportasi_id, nama FROM ref.alat_transportasi
		WHERE lower(nama) not like '%unknown%' ORDER BY alat_transportasi_id";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
      return $tag;
	}

	public static function DeptLembaga($selected = null) {
		$sql = "SELECT dept_id, nama FROM yayasan_lembaga_department ORDER BY dept_id";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

	public static function NamaPegawai($selected = null) {
		$sql = "SELECT emp_memployee_id, nama_pegawai, jabatan FROM vposkerja_pejabat where jabatan in ('KABAG', 'KADIV', 'STAFF') order by jabatan, nama_pegawai";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

	public static function NamaPoskerja($selected = null) {
		$sql = "SELECT nama_poskerja, jabatan FROM vposkerja_pejabat where jabatan in ('KABAG', 'KADIV', 'STAFF') order by jabatan, nama_poskerja";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[0] </option>";
		}
        return $tag;
	}

	public static function cmbTahun2($selected = null) {
		$sql = "SELECT distinct tahun FROM resume_labarugi order by tahun";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[0] </option>";
		}
        return $tag;
	}

	public static function jeniswahana($selected = null) {
		$sql = "SELECT sel_mtickets_id, nama from sel_mtickets where is_aktif='t' order by nama;";

		$bindings = array();
		$db = self::sql_connect2();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

	public static function cmbTahun3($selected = null) {
		$sql = "select distinct tahun from prediksi_omset order by tahun";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			if ( $val['tahun'] == date('Y') ) {
				$pilih = " selected";
			} else {
				$pilih = "";
			}
			$tag  .= "<option value='$val[tahun]'$pilih> $val[tahun] </option>"."\n";

		}
				return $tag;
	}

	public static function areaetalase($selected = null) {
		$sql = "SELECT id_area, area_etalase from stock_etalase order by id_area";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
				return $tag;
	}

	public static function tempat($selected = null) {
		$sql = "SELECT distinct tempat from daftar_tempat order by tempat";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[0] </option>";
		}
				return $tag;
	}

	public static function tempat_aktif($selected = null) {
		$sql = "SELECT distinct tempat from daftar_tempat where is_aktif = 'AKTIF' order by tempat";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[0] </option>";
		}
				return $tag;
	}

	public static function status_tempat($selected = null) {
		$sql = "SELECT distinct status from daftar_tempat order by status";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[0] </option>";
		}
				return $tag;
	}

	public static function area($selected = null) {
		$sql = "SELECT id_area, area_etalase from stock_etalase order by id_area";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
				return $tag;
	}

	public static function is_aktif($selected = null) {
		$sql = "SELECT distinct is_aktif from daftar_tempat order by is_aktif";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[0] </option>";
		}
				return $tag;
	}

	public static function pramusaji($selected = null) {
		$sql = "SELECT pt_mparttimer_id, b.nama_alias
		from pt_vpresence as a
		inner join pt_mparttimer as b using (pt_mparttimer_id)
		where tanggal = current_date and keterangan = 1 and namapos = 'PRAMUSAJI'
		order by b.nama_alias;";

		$bindings = array();
		$db = self::sql_connect2();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[1]'> $val[1] </option>";
		}
				return $tag;
	}

	public static function harilibur($selected = null) {
		$sql = "SELECT distinct harilibur, case harilibur
		when 2 THEN 'Senin'
		when 3 THEN 'Selasa'
		when 4 THEN 'Rabu'
		when 5 THEN 'Kamis'
		when 6 THEN 'Jumat'
		end as hari
		from emp_harilibur where harilibur != 0 order by harilibur;";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
				return $tag;
	}

	public static function Dept_id($selected = null) {
		$sql = "SELECT org_department_id, nama from org_department where is_aktif='t' order by nama";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}


	public static function notifAccPeng() {

    $dept_id = $_SESSION['bo_user_dept_id'];
    $id = $_SESSION['bo_user_id'];
    $user_level = $_SESSION['bo_user_level'];

    $bindings = array();

    if ($dept_id === '00') {

			$sql = "SELECT count(*) as data
			FROM pengajuan_ijincuti p
			JOIN users_employee u USING (emp_memployee_id)
			JOIN org_department d USING (org_department_id)
			WHERE status_atasan is null
			AND emp_memployee_id != :id
			AND user_level = 'KABAG'
			OR (jabatan = 'Kadiv Security' and status_atasan is null)";
			$bindings[] = ['key' => ':id', 'val' => $id, 'type' => PDO::PARAM_INT];

    } elseif ($user_level === 'KABAG') {

			$sql = "SELECT count(*) as data
			FROM pengajuan_ijincuti p
			JOIN users_employee u USING (emp_memployee_id)
			JOIN org_department d USING (org_department_id)
			WHERE d.parent = :dept_id
			AND status_atasan is null
			AND emp_memployee_id != :id
			AND (user_level = 'KADIV' or user_level = 'STAFF' or (user_level = 'UNIT' and org_department_id = :dept_id) or (user_level = 'KOORDINATOR' and org_department_id = :dept_id))";
			$bindings[] = ['key' => ':dept_id', 'val' => $dept_id, 'type' => PDO::PARAM_STR];
			$bindings[] = ['key' => ':id', 'val' => $id, 'type' => PDO::PARAM_STR];

    } elseif ($user_level === 'KADIV') {

			$sql = "SELECT count(*) as data
			FROM pengajuan_ijincuti p
			JOIN users_employee u USING (emp_memployee_id)
			JOIN org_department d USING (org_department_id)
			WHERE status_atasan is null
			AND emp_memployee_id != :id
			AND org_department_id = :dept_id
			AND (user_level = 'UNIT' or user_level = 'KOORDINATOR' or user_level = 'SECURITY')";
			// Menambahkan binding parameter ':dept_id' dengan nilai $dept_id dan tipe PDO::PARAM_STR
			// Kode ini digunakan untuk menggantikan nilai parameter ':dept_id' di dalam query dengan nilai yang sesuai
			$bindings[] = ['key' => ':dept_id', 'val' => $dept_id, 'type' => PDO::PARAM_STR];
			$bindings[] = ['key' => ':id', 'val' => $id, 'type' => PDO::PARAM_STR];

    }

    $db = self::sql_connect();
    $result = self::sql_exec($db, $bindings, $sql);
    $data = $result[0]['data']; // Mengambil nilai 'data' dari hasil query

    // Menghasilkan HTML output
		if ($data > 0) {
			$tag = "{$data}";
		} else {
			$tag = "";
		}

    return $tag;
	}

	// notif pengajuan cuti a & k
	public static function notifAccAdm() {

		$bindings = array();

		$sql = "SELECT count(*) as data
    FROM pengajuan_ijincuti JOIN emp_memployee USING (emp_memployee_id) WHERE status_atasan = 'ACC' AND status_adm is null;";
		$db = self::sql_connect();
		$result = self::sql_exec($db, $bindings, $sql);
		$data = $result[0]['data'];

		if ($data > 0) {
			$tag = "{$data}";
		} else {
			$tag = "";
		}

		return $tag;

	}

	// notif daftar atasan
	public static function notifAccPengPinjaman() {

    $dept_id = $_SESSION['bo_user_dept_id'];
    $emp_id = $_SESSION['bo_user_id'];
    $user_level = $_SESSION['bo_user_level'];

		$bindings = array();

    if ($dept_id === '00') {

      $sql = "SELECT count(*) as data
      FROM pinjaman_pengajuan p
      JOIN users_employee u USING (emp_memployee_id)
      JOIN org_department d ON (d.org_department_id = u.org_department_id)
      WHERE status_atasan is null
      AND emp_memployee_id != :emp_id
      AND u.user_level = 'KABAG'
      OR (u.jabatan = 'Kadiv Security' and status_atasan is null)";
			$bindings[] = ['key' => ':emp_id', 'val' => $emp_id, 'type' => PDO::PARAM_INT];

    } elseif ($user_level === 'KABAG') {

      $sql = "SELECT count(*) as data
      FROM pinjaman_pengajuan p
      JOIN users_employee u USING (emp_memployee_id)
      JOIN org_department d ON (d.org_department_id = u.org_department_id)
      WHERE parent = :dept_id
      AND status_atasan is null
      AND emp_memployee_id != :emp_id
      AND (u.user_level = 'KADIV' or u.user_level = 'STAFF' or u.user_level = 'UNIT' and d.org_department_id = :dept_id or u.user_level = 'KOORDINATOR' and d.org_department_id = :dept_id)";
      $bindings[] = ['key' => ':dept_id', 'val' => $dept_id, 'type' => PDO::PARAM_STR];
			$bindings[] = ['key' => ':emp_id', 'val' => $emp_id, 'type' => PDO::PARAM_STR];

    } elseif ($user_level === 'KADIV') {

      $sql = "SELECT count(*) as data
      FROM pinjaman_pengajuan p
      JOIN users_employee u USING (emp_memployee_id)
      JOIN org_department d ON (d.org_department_id = u.org_department_id)
      WHERE status_atasan is null
      AND emp_memployee_id != :emp_id
      AND d.org_department_id = :dept_id
      AND (u.user_level = 'UNIT' or u.user_level = 'KOORDINATOR' or u.user_level = 'SECURITY')";
      $bindings[] = ['key' => ':dept_id', 'val' => $dept_id, 'type' => PDO::PARAM_STR];
			$bindings[] = ['key' => ':emp_id', 'val' => $emp_id, 'type' => PDO::PARAM_STR];

    }

    $db = self::sql_connect();
    $result = self::sql_exec($db, $bindings, $sql);
    $data = $result[0]['data']; // Mengambil nilai 'data' dari hasil query

    // Menghasilkan HTML output
		if ($data > 0) {
			$tag = "{$data}";
		} else {
			$tag = "";
		}

    return $tag;
	}

	// notif daftar manager
	public static function notifDaftarManager() {

		$dept_id = $_SESSION['bo_user_dept_id'];
    $emp_id = $_SESSION['bo_user_id'];
    $user_level = $_SESSION['bo_user_level'];

		$bindings = array();

		$sql = "SELECT count(*) as data
    FROM pinjaman_pengajuan p
    JOIN users_employee u USING (emp_memployee_id)
    JOIN org_department d ON (d.org_department_id = u.org_department_id)
    WHERE status_atasan is null
    AND emp_memployee_id != :emp_id
    AND u.user_level = 'KABAG'
    OR (u.jabatan = 'Kadiv Security' and status_atasan is null)
    OR (jaminan is true AND status_atasan = 'ACC' AND status_manager is null)";
		$bindings[] = ['key' => ':emp_id', 'val' => $emp_id, 'type' => PDO::PARAM_INT];

		$db = self::sql_connect();
		$result = self::sql_exec($db, $bindings, $sql);
		$data = $result[0]['data'];

		if ($data > 0) {
			$tag = "{$data}";
		} else {
			$tag = "";
		}

		return $tag;

	}

	// notif daftar a & k
	public static function notifDaftarPinjamAdm() {

		$sql = "SELECT count(*) as data
		FROM pinjaman_pengajuan p
		JOIN users_employee u USING (emp_memployee_id)
		JOIN org_department d ON (d.org_department_id = u.org_department_id)
		WHERE status_atasan = 'ACC'
		AND status_adm is null
		AND jaminan is false
		OR (jaminan is true AND status_atasan = 'ACC' AND status_manager = 'ACC' AND status_adm is null )";

		$db = self::sql_connect();
		$result = self::sql_exec($db, $sql);
		$data = $result[0]['data'];

		if ($data > 0) {
			$tag = "{$data}";
		} else {
			$tag = "";
		}

		return $tag;

	}
	// notif daftar keuangan
	public static function notifDaftarPinjamKeu() {

		$sql = "SELECT count(*) as data
		FROM pinjaman_pengajuan p
		JOIN users_employee u USING (emp_memployee_id)
		JOIN org_department d ON (d.org_department_id = u.org_department_id)
		WHERE status_adm = 'ACC'
		AND (status_keuangan is null OR status_keuangan = 'PENDING')
		AND jaminan is false
		OR (jaminan is true AND status_atasan = 'ACC' AND status_manager = 'ACC' AND status_adm = 'ACC' AND status_keuangan is null OR status_keuangan = 'PENDING')";

		$db = self::sql_connect();
		$result = self::sql_exec($db, $sql);
		$data = $result[0]['data'];

		if ($data > 0) {
			$tag = "{$data}";
		} else {
			$tag = "";
		}

		return $tag;

	}
	public static function notifMemo() {

		$dept_id = $_SESSION['bo_user_dept_id'];

		$bindings = array();

		$sql = "SELECT count(*) as data
		FROM memo_pejabat
		WHERE org_department_id = :dept_id
		AND tgl_diterima is null AND status is null";
		$bindings[] = ['key' => ':dept_id', 'val' => $dept_id, 'type' => PDO::PARAM_INT];

		$db = self::sql_connect();
		$result = self::sql_exec($db, $bindings, $sql);
		$data = $result[0]['data'];

		if ($data > 0) {
			$tag = "{$data}";
		} else {
			$tag = "";
		}

		return $tag;

	}

	public static function menu($selected = null) {
		$sql = "SELECT sel_mmenu_id, COALESCE(nama || ' ' || olahan, nama) || ' - ' || satuan AS nama, satuan, wh_mikan_id
		FROM sel_mmenu
    WHERE is_aktif ='t' 
		ORDER BY sel_mmenu_id;";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
				return $tag;
	}

public static function Atasan($selected = null) {
		$sql = "SELECT a.jab_id as atasan, nama from atasan as a inner join org_strukjabatan as b using (jab_id) where is_aktif = 't' and org_department_id <> '24' order by org_department_id, nama";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

public static function Parent($selected = null) {
		$sql = "select a.org_department_id, a.nama from org_department inner join parent as a using (org_department_id)";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

public static function Poskerja($selected = null) {
		$sql = "select pt_mpk_no, nama from pt_mpos_kerja where is_aktif='t' order by pt_mpk_no";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}
public static function Karyawan_id($selected = null) {

		$sql = "select emp_memployee_id, nama from emp_memployee where is_aktif='t' and org_department_id <> '24' order by nama;";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

public static function NamaParttimer($selected = null) {

		$sql = "select pt_mparttimer_id, nama from pt_mparttimer where status='1' order by nama";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

public static function jenisolahan($selected = null) {
		$sql = "select distinct olahan from sel_mmenu where kategori='IKAN' order by olahan";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[0] </option>";
		}
        return $tag;
	}

public static function jenisbumbu($selected = null) {
		$sql = "SELECT distinct jenis_bumbu from hpp_mbumbu order by jenis_bumbu";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[0] </option>";
		}
				return $tag;
	}

public static function bahan($selected = null) {
		$sql = "SELECT  wh_mbarang_id, case when nama_detil is null then nama else nama || ' ' || nama_detil end as nama from wh_mbarang where wh_mwh_id = 1 order by nama";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
				return $tag;
	}

public static function nama_olahan($selected = null) {
		$sql = "select distinct olahan from sel_mmenu where sel_mmenu_id < '210' order by olahan";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[0] </option>";
		}
				return $tag;
	}


public static function ketetapanbiaya($selected = null) {
		$sql = "select biaya from hpp_ketetapanbiaya order by biaya";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[0] </option>";
		}
				return $tag;
	}

public static function notifberikansolusi() {
		$org_department_id = $_SESSION['empjhb_user_department'];
		$id = $_SESSION['empjhb_user_id'];
		$user_level = $_SESSION['empjhb_user_level'];

		// SQL dasar untuk mendapatkan jumlah permasalahan
		$sql = "SELECT COUNT(*) AS total
				FROM permasalahan AS p
				JOIN users_employee AS u ON p.emp_memployee_id = u.emp_memployee_id
				JOIN org_department AS d ON p.org_department_id = d.org_department_id
				WHERE p.emp_memployee_id != :id
				AND p.solusi IS NULL ";

		// Menyesuaikan query berdasarkan level user
		if ($org_department_id === '00') {
			$sql .= "AND (u.user_level = 'KABAG'
						  OR u.jabatan = 'Kadiv Security')";
		} elseif ($user_level === 'KABAG') {
			$sql .= "AND u.parent = :org_department_id
					 AND (u.user_level IN ('KADIV', 'STAFF', 'UNIT', 'KOORDINATOR')
						  OR p.org_department_id = :org_department_id)";
		} elseif ($user_level === 'KADIV') {
			$sql .= "AND p.org_department_id = :org_department_id
					 AND u.user_level IN ('UNIT', 'KOORDINATOR', 'SECURITY')";
		}

		try {
			// Koneksi database
			$db = self::sql_connect();
			$stmt = $db->prepare($sql);

			// Bind parameter
			$stmt->bindParam(':id', $id, PDO::PARAM_INT);
			if ($org_department_id !== '00') {
				$stmt->bindParam(':org_department_id', $org_department_id, PDO::PARAM_INT);
			}

			// Eksekusi query
			$stmt->execute();
			$result = $stmt->fetch(PDO::FETCH_ASSOC);

			// Ambil total notifikasi
			$data = $result['total'] ?? 0;

			// Return notifikasi dalam bentuk tag
			return ($data > 0) ? "{$data}" : "";
		} catch (PDOException $e) {
			// Log jika terjadi error
			error_log("Database error: " . $e->getMessage());
			return "";
		}
	}

	public static function pospengeluaran($selected = null) {

		$org_department_id = $_SESSION['bo_user_dept_id'];

		$sql = "SELECT org_subdepartment_id, nama FROM org_subdepartment WHERE is_aktif='t' ORDER BY nama";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

	public static function namafolder($selected = null) {
		$sql = "select distinct nama_folder from master_folder order by nama_folder";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[0] </option>";
		}
        return $tag;
	}

public static function BarangGbr($selected = null) {

		$sql = "SELECT wh_mbarang_id, case when nama_detil is null then nama else nama || ' ' || nama_detil end as nama_barang, satuan from wh_mbarang where wh_mwh_id='1' order by nama";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec($db, $bindings, $sql);

		$tag = "";
		foreach ($result as $val) {
			$tag .= "<option value='$val[0]' data-satuan='$val[2]'> $val[1] </option>";
		}
		return $tag;
	}

public static function BarangGu($selected = null) {
		$sql = "select wh_mbarang_id, case when nama_detil is null then nama else nama || ' ' || nama_detil end as nama_barang, satuan from wh_mbarang where wh_mwh_id='2' order by nama";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec($db, $bindings, $sql);

		$tag = "";
		foreach ($result as $val) {
			$tag .= "<option value='$val[0]' data-satuan='$val[2]'> $val[1] </option>";
		}
		return $tag;
	}

public static function Jab_id($selected = null) {

		$id = $_SESSION['bo_user_dept_id'];

		$sql = "SELECT jab_id, nama from org_strukjabatan where org_department_id='$id' and is_aktif='t' order by nama";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

public static function Unit($selected = null) {

    // Ambil default id dari session
    $id = $_SESSION['bo_user_dept_id'];
    $parent = $_SESSION['bo_user_parent'];

    // Kalau jabatan ID-nya 9000, override jadi 19
    if (isset($_SESSION['bo_user_jab_id']) && $_SESSION['bo_user_level'] == 'KABAG') {
        $sql = "SELECT emp_memployee_id, nama_pegawai
					FROM status_jabatan j
					INNER JOIN users_employee b using (emp_memployee_id)
					WHERE parent = '$parent'
					AND j.jabatan = 'UNIT';";
		} else {
			$sql = "SELECT emp_memployee_id, nama_pegawai
				FROM status_jabatan
				INNER JOIN emp_memployee USING (emp_memployee_id)
				WHERE org_department_id = '$id'
					AND jabatan = 'UNIT'
					AND is_aktif = 't'";
		}


    $bindings = array();
    $db = self::sql_connect();
    $result = self::sql_exec($db, $bindings, $sql);

    $tag = "";
    foreach ($result as $val) {
        $tag .= "<option value='$val[0]'> $val[1] </option>";
    }

    return $tag;
	}
	public static function cmbNilai($selected = null) {
		$sql = "SELECT nilai, keterangan FROM nilai_pkk WHERE nilai != 0 ORDER BY nilai";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

	public static function Koordinator($selected = null) {

		// Ambil default id dari session
		$id = $_SESSION['bo_user_dept_id'];
		$parent = $_SESSION['bo_user_parent'];

		// Kalau jabatan level kabag, override jadi 19
		if (isset($_SESSION['bo_user_jab_id']) && $_SESSION['bo_user_level'] == 'KABAG') {
			$sql = "SELECT emp_memployee_id, nama_pegawai
				FROM status_jabatan j
				INNER JOIN users_employee b using (emp_memployee_id)
				WHERE parent = '$parent' AND j.jabatan = 'KOORDINATOR';";
		} else {
			$sql = "SELECT emp_memployee_id, nama_pegawai
				FROM status_jabatan
				INNER JOIN emp_memployee USING (emp_memployee_id)
				WHERE org_department_id = '$id'
				AND jabatan = 'KOORDINATOR'
				AND is_aktif = 't'";
		}


		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec($db, $bindings, $sql);

		$tag = "";
		foreach ($result as $val) {
			$tag .= "<option value='$val[0]'> $val[1] </option>";
		}

		return $tag;
	}

	public static function Kadiv($selected = null) {

		$id = $_SESSION['bo_user_dept_id'];
		$parent = $_SESSION['bo_user_parent'];

		$sql = "select emp_memployee_id, nama_pegawai FROM status_jabatan
		INNER JOIN emp_memployee USING (emp_memployee_id)
		INNER JOIN org_department USING (org_department_id)
		WHERE jabatan = 'KADIV' AND (org_department_id = '$id' OR parent = '$parent');";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

	public static function cmbDepartment($selected = null) {

		$id = $_SESSION['bo_user_dept_id'];
		$parent = $_SESSION['bo_user_parent'];

		$sql = "SELECT org_department_id, nama from org_department
		where is_aktif = 't' and (org_department_id = '$id' OR parent = '$parent') order by nama";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[1]'> $val[1] </option>";
		}
        return $tag;
	}

	public static function Staff($selected = null) {

		$id = $_SESSION['bo_user_dept_id'];
		$parent = $_SESSION['bo_user_parent'];

		$sql = "select emp_memployee_id, nama_pegawai FROM status_jabatan
		INNER JOIN emp_memployee USING (emp_memployee_id)
		INNER JOIN org_department USING (org_department_id)
		WHERE jabatan = 'STAFF' AND (org_department_id = '$id');";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

	public static function Staff2($selected = null) {

		$id = $_SESSION['bo_user_dept_id'];
		$parent = $_SESSION['bo_user_parent'];

		$sql = "SELECT emp_memployee_id, nama_pegawai FROM status_jabatan
		INNER JOIN emp_memployee USING (emp_memployee_id)
		INNER JOIN org_department USING (org_department_id)
		WHERE jabatan = 'STAFF' AND (parent = '$parent');";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

public static function cmbEmployee($selected = null) {
		$sql = "SELECT distinct nama FROM vemp_pkk_nilaipejabat ORDER BY nama";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[0] </option>";
		}
        return $tag;
	}

public static function Deptkabag($selected = null) {


		$sql = "SELECT org_department_id, nama
			FROM org_department
			WHERE is_aktif = 't'
			AND (type = 'Bagian' OR type = 'HO')
			ORDER BY nama;
			";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

public static function Kabag($selected = null) {
		$sql = "SELECT emp_memployee_id, nama
			FROM users_employee
			WHERE
					(user_level = 'KABAG')
					or (jab_id in (3900, 7000))
			ORDER BY nama;";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

public static function Penerimatunjangan($selected = null) {
		$sql = " select emp_memployee_id, nama_pegawai, org_department_id, nama_pegawai, b.nama as department, nama_poskerja as jabatan
		from vposkerja_pejabat inner join emp_memployee using (emp_memployee_id)
		inner join org_department as b using (org_department_id)
		where jabatan in ('KADIV', 'STAFF') order by nama_pegawai";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

	public static function Jabatanpenerima($selected = null) {
		$sql = " SELECT nama_poskerja as jabatan
		from vposkerja_pejabat inner join emp_memployee using (emp_memployee_id)
		inner join org_department as b using (org_department_id)
		where jabatan in ('KADIV', 'STAFF') order by nama_pegawai";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[0] </option>";
		}
        return $tag;
	}

	public static function Deptpenerima($selected = null) {
		$sql = " select org_department_id, b.nama
		from vposkerja_pejabat inner join emp_memployee using (emp_memployee_id)
		inner join org_department as b using (org_department_id)
		where jabatan in ('KADIV', 'STAFF') order by nama_pegawai";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

public static function Krycuti($selected = null) {

		$sql = "SELECT nama FROM emp_memployee WHERE tgl_masuk < CURRENT_DATE - INTERVAL '1 year' and is_aktif='t' order by nama";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[0] </option>";
		}
        return $tag;
	}

public static function perawatanpp($selected = null) {
		$sql = "SELECT id_inventaris, case when merek is null then nama_inventaris else nama_inventaris || ' ' || merek end as nama_inventaris from inventaris_pp where is_aktif = 't' and kelompok='Koord Perawatan Peralatan' order by nama_inventaris";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

public static function perawatanhardware($selected = null) {
		$sql = "SELECT id_inventaris, case when merek is null then nama_inventaris else nama_inventaris || ' ' || merek end as nama_inventaris from inventaris_pp where is_aktif = 't' and kelompok='Koord TKJ' order by nama_inventaris";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

public static function Jabatan($selected = null) {
		$sql = "select Jab_id, nama from org_strukjabatan where is_aktif='t' and org_department_id <> '24' order by nama;";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

public static function paketangbr($selected = null) {
		$sql = "select jenis_paketan from jenispaketan_gbr where is_aktif='t' and jenis_paketan <>'Daftar Bahan'";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[0] </option>";
		}
        return $tag;
	}

public static function baranggbpr($selected = null) {
    $sql = "SELECT wh_mbarang_id,
                   CASE WHEN nama_detil IS NULL THEN nama ELSE nama || ' ' || nama_detil END AS nama_barang,
                   satuan
            FROM wh_mbarang
            WHERE wh_mwh_id = '1' AND is_aktif = 't'
            ORDER BY nama_barang";

    $bindings = array();
    $db = self::sql_connect();
    $result = self::sql_exec($db, $bindings, $sql);

    $tag = "";
    foreach ($result as $val) {
        $selectedAttr = $selected === $val['wh_mbarang_id'] ? "selected" : "";
        $tag .= "<option value='{$val['wh_mbarang_id']}' data-satuan='{$val['satuan']}' $selectedAttr>
                    {$val['nama_barang']}
                 </option>";
    }
    return $tag;
}

public static function bagian($selected = null) {


		$sql = "select nama from org_department where is_aktif='t' order by nama";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[0] </option>";
		}
        return $tag;
	}

public static function Security($selected = null) {

		$id = $_SESSION['bo_user_dept_id'];

		$sql = "select emp_memployee_id, nama_pegawai from status_jabatan inner join emp_memployee using (emp_memployee_id) where org_department_id='$id' and jabatan='SECURITY'";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}

public static function Posisi($selected = null) {
		$sql = "SELECT pt_mjp_no, nama FROM pt_mjob_position WHERE is_aktif = 't' order by nama";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[1] </option>";
		}
        return $tag;
	}


	public static function kelipatan() {
		$bindings = array();
		$sql="SELECT reafter as kelipatan from sel_formatnota order by tanggal desc";
		$db = self::sql_connect2();
		$result = self::sql_exec( $db, $bindings, $sql);
		$data = $result[0]['kelipatan']; // Mengambil nilai 'data' dari hasil query

		return $data;

	}

	public static function notifLayananLitbang() {

		$sql ="SELECT COUNT(*) as data
      FROM layanan_pp
        LEFT JOIN layanan_status USING (id_layanan)
      WHERE isi_realisasi IS NULL
        AND tgl_finish IS NULL
        AND tujuan = 'Litbang'";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);
		$data = $result[0]['data'];

		if ($data > 0) {
			$tag = "{$data}";
		} else {
			$tag = "";
		}

		return $tag;
	}
	public static function cmbSecurity($selected = null) {


		$sql = "SELECT DISTINCT nama
FROM emp_memployee
WHERE is_aktif = 't'
  AND (org_department_id = '11' OR jab_id = '6206')
ORDER BY nama;";

		$bindings = array();
		$db = self::sql_connect();
		$result = self::sql_exec( $db, $bindings, $sql);

		$tag 	   = "";
		foreach ($result as $val) {
			$tag  .= "<option value='$val[0]'> $val[0] </option>";
		}
        return $tag;
	}

}

