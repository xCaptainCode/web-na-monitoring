<?php
/**
* helpers Class
*/
class Helpers
{

	public static function showTgl($tgl, $format) {
		$date = new DateTime($tgl);
		$tanggal = $date->format($format);
		return $tanggal;
	}
	
	public static function showJam($jam, $format) {
		$time = new DateTime($jam);
		$fjam = $time->format($format);
		return $fjam;
	}

	public static function formatJam($jam, $format) {
		$time = date_create($jam);
		$fjam = $time->format($format);
		return $fjam;
	}
	
	public static function number($number) {
		if (!empty($number)) {
			return number_format($number, 0, ',', '.');
		} else {
			return 0;
		}
	}

	public static function numberCurr($number) {
		if (!empty($number)) {
			if ($number < 0) {
				$total = $number - $number - $number;
				return '('.number_format($total, 2, ',', '.').')';
			} else {
				return number_format($number, 2, ',', '.');
			}
		} else {
			return '0';
		}
	}

    public static function numberCurr2($number) {
		if (!empty($number)) {
			if ($number < 0) {
				$total = $number - $number - $number;
				return '('.number_format($total, ($total == (int) $total ? 0 : 1), ',', '.').')';
			} else {
				return number_format($number, ($number == (int) $number ? 0 : 1), ',', '.');
			}
		} else {
			return '0';
		}
	}

	public static function ucwords($text) {
		$newtext = ucwords(strtolower($text));
		return $newtext;
	}
	
	public static function notify($type, $text) {
		if ($type === 'error') {
            $notify = [
                'title' => 'Errors',
                'text'  => $text,
                'type'  => 'error'
            ];
		} elseif ($type === 'warning'){
			$notify = [
	            'title' => 'Warning',
	            'text'  => $text,
	            'type'  => 'warning',
	        ];
		} elseif ($type === 'success'){
			$notify = [
	            'title' => 'Success',
	            'text'  => $text,
	            'type'  => 'success',
	        ];
		}

		return $notify;
	}
	
	public static function isEmptyString($str) {
		return !(isset($str) && (strlen(trim($str)) > 0));
	}

	public static function getSessionValue($value) {
		return isset($_SESSION[$value]) ? $_SESSION[$value] : null;
	}

	public static function tgl_indo($date, $date_format=''){
        $dayList = array(
            'Sunday'    => 'Minggu',
            'Monday'    => 'Senin',
            'Tuesday'   => 'Selasa',
            'Wednesday' => 'Rabu',
            'Thursday'  => 'Kamis',
            'Friday'    => 'Jumat',
            'Saturday'  => 'Sabtu'
        );

        $monthList = array(
            '01' => 'Januari',
            '02' => 'Februari',
            '03' => 'Maret',
            '04' => 'April',
            '05' => 'Mei',
            '06' => 'Juni',
            '07' => 'Juli',
            '08' => 'Agustus',
            '09' => 'September',
            '10' => 'Oktober',
            '11' => 'November',
            '12' => 'Desember'
        );

        $format_hari = date('l', strtotime($date));
        $format_tgl  = date('d', strtotime($date));
        $format_bln  = date('m', strtotime($date));
        $format_thn  = date('Y', strtotime($date));

        switch ($date_format) {
            case 'l':
                # Hari ex: Kamis
                $output = $dayList[$format_hari];
                break;
            case 'd':
                # Tanggal ex: 21
                $output = $format_tgl;
                break;  
            case 'm':
                # Bulan ex: Januari
                $output = $monthList[$format_bln];
                break;  
            case 'y':
                # Tahun ex: 2016
                $output = $format_thn;
                break;                                            
            default:
                # Hari, Tanggal-Bulan-Tahun ex: Rabu, 26-Juli-2016 
                $output = $dayList[$format_hari] . ', ' . $format_tgl . ' ' . $monthList[$format_bln] . ' ' . $format_thn;
                break;
        }

        return $output;
    }

    public static function tgl_upper($date, $date_format=''){
        $dayList = array(
            'Sunday'    => 'MINGGU',
            'Monday'    => 'SENIN',
            'Tuesday'   => 'SELASA',
            'Wednesday' => 'RABU',
            'Thursday'  => 'KAMIS',
            'Friday'    => 'JUM\'AT',
            'Saturday'  => 'SABTU'
        );

        $monthList = array(
            '01' => 'JANUARI',
            '02' => 'FEBRUARI',
            '03' => 'MARET',
            '04' => 'APRIL',
            '05' => 'MEI',
            '06' => 'JUNI',
            '07' => 'JULI',
            '08' => 'AGUSTUS',
            '09' => 'SEPTEMBER',
            '10' => 'OKTOBER',
            '11' => 'NOVEMBER',
            '12' => 'DESEMBER'
        );

        $format_hari = date('l', strtotime($date));
        $format_tgl  = date('d', strtotime($date));
        $format_bln  = date('m', strtotime($date));
        $format_thn  = date('Y', strtotime($date));

        switch ($date_format) {
            case 'l':
                # Hari ex: Kamis
                $output = $dayList[$format_hari];
                break;
            case 'd':
                # Tanggal ex: 21
                $output = $format_tgl;
                break;  
            case 'm':
                # Bulan ex: Januari
                $output = $monthList[$format_bln];
                break;  
            case 'y':
                # Tahun ex: 2016
                $output = $format_thn;
                break;                                            
            default:
                # Hari, Tanggal-Bulan-Tahun ex: Rabu, 26-Juli-2016 
                $output = $dayList[$format_hari] . ', ' . $format_tgl . ' ' . $monthList[$format_bln] . ' ' . $format_thn;
                break;
        }

        return $output;
    }

    public static function bln($date, $date_format='') {
        $dayList = array(
            'Sunday'    => 'Minggu',
            'Monday'    => 'Senin',
            'Tuesday'   => 'Selasa',
            'Wednesday' => 'Rabu',
            'Thursday'  => 'Kamis',
            'Friday'    => 'Jumat',
            'Saturday'  => 'Sabtu'
        );

        $monthList = array(
            '01' => 'Jan',
            '02' => 'Feb',
            '03' => 'Mar',
            '04' => 'Apr',
            '05' => 'Mei',
            '06' => 'Jun',
            '07' => 'Jul',
            '08' => 'Agt',
            '09' => 'Sep',
            '10' => 'Okt',
            '11' => 'Nov',
            '12' => 'Des'
        );

        // $format_hari = date('l', strtotime($date));
        $format_tgl  = date('d', strtotime($date));
        $format_bln  = date('m', strtotime($date));
        $format_thn  = date('Y', strtotime($date));

        switch ($date_format) {
            case 'l':
                # Hari ex: Kamis
                $output = $dayList[$format_hari];
                break;
            case 'd':
                # Tanggal ex: 21
                $output = $format_tgl;
                break;  
            case 'm':
                # Bulan ex: Januari
                $output = $monthList[$format_bln];
                break;  
            case 'y':
                # Tahun ex: 2016
                $output = $format_thn;
                break;                                            
            default:
                # Hari, Tanggal-Bulan-Tahun ex: Rabu, 26-Juli-2016 
                $output = $format_tgl . ' - ' . $monthList[$format_bln] . ' - ' . $format_thn;
                break;
        }

        return $output;
    }

    public static function bln_thn($date, $date_format='') {
        $dayList = array(
            'Sunday'    => 'Minggu',
            'Monday'    => 'Senin',
            'Tuesday'   => 'Selasa',
            'Wednesday' => 'Rabu',
            'Thursday'  => 'Kamis',
            'Friday'    => 'Jumat',
            'Saturday'  => 'Sabtu'
        );

        $monthList = array(
            '01' => 'Januari',
            '02' => 'Februari',
            '03' => 'Maret',
            '04' => 'April',
            '05' => 'Mei',
            '06' => 'Juni',
            '07' => 'Juli',
            '08' => 'Agustus',
            '09' => 'September',
            '10' => 'Oktober',
            '11' => 'November',
            '12' => 'Desember'
        );

        // $format_hari = date('l', strtotime($date));
        $format_tgl  = date('d', strtotime($date));
        $format_bln  = date('m', strtotime($date));
        $format_thn  = date('Y', strtotime($date));

        switch ($date_format) {
            case 'l':
                # Hari ex: Kamis
                $output = $dayList[$format_hari];
                break;
            case 'd':
                # Tanggal ex: 21
                $output = $format_tgl;
                break;  
            case 'm':
                # Bulan ex: Januari
                $output = $monthList[$format_bln];
                break;  
            case 'y':
                # Tahun ex: 2016
                $output = $format_thn;
                break;                                            
            default:
                # Hari, Tanggal-Bulan-Tahun ex: Rabu, 26-Juli-2016 
                $output = $monthList[$format_bln] . ' ' . $format_thn;
                break;
        }

        return $output;
    }

    public static function Jam_indo($date, $date_format='') {
        
        $format_hari = date('l', strtotime($date));
        $format_tgl  = date('d', strtotime($date));
        $format_bln  = date('m', strtotime($date));
        $format_thn  = date('Y', strtotime($date));
        $format_jam  = date('H', strtotime($date));
        $format_mnt  = date('i', strtotime($date));
        $format_dtk  = date('s', strtotime($date));

        switch ($date_format) {
            case 'H':
                # Jam ex: 13
                $output = $format_jam;
                break;
            case 'i':
                # Menit ex: 21
                $output = $format_mnt;
                break;  
            case 's':
                # Detik 45
                $output = $format_dtk;
                break;                                            
            default:
                # Jam:Menit:Detik ex: 13:21:45 
                $output = $format_jam . ':' . $format_mnt . ':' .  $format_dtk;
                break;
        }

        return $output;
	}

    
	public static function tgl_short($date, $date_format='')
    {
        $dayList = array(
            'Sunday'    => 'Minggu',
            'Monday'    => 'Senin',
            'Tuesday'   => 'Selasa',
            'Wednesday' => 'Rabu',
            'Thursday'  => 'Kamis',
            'Friday'    => 'Jumat',
            'Saturday'  => 'Sabtu'
        );

        $monthList = array(
            '01' => 'Jan',
            '02' => 'Feb',
            '03' => 'Mar',
            '04' => 'Apr',
            '05' => 'Mei',
            '06' => 'Jun',
            '07' => 'Jul',
            '08' => 'Agt',
            '09' => 'Sep',
            '10' => 'Okt',
            '11' => 'Nov',
            '12' => 'Des'
        );

        $format_hari = date('l', strtotime($date));
        $format_tgl  = date('d', strtotime($date));
        $format_bln  = date('m', strtotime($date));
        $format_thn  = date('Y', strtotime($date));

        switch ($date_format) {
            case 'l':
                # Hari ex: Kamis
                $output = $dayList[$format_hari];
                break;
            case 'd':
                # Tanggal ex: 21
                $output = $format_tgl;
                break;  
            case 'm':
                # Bulan ex: Januari
                $output = $monthList[$format_bln];
                break;  
            case 'y':
                # Tahun ex: 2016
                $output = $format_thn;
                break;                                            
            default:
                # Hari, Tanggal-Bulan-Tahun ex: Rb, 26-Jul-2016 
                $output = $dayList[$format_hari] . ', ' . $format_tgl . ' ' . $monthList[$format_bln] . ' ' . $format_thn;
                break;
        }

        return $output;
    }
	public static function tgl($date, $date_format='')
    {
        $dayList = array(
            'Sunday'    => 'Minggu',
            'Monday'    => 'Senin',
            'Tuesday'   => 'Selasa',
            'Wednesday' => 'Rabu',
            'Thursday'  => 'Kamis',
            'Friday'    => 'Jumat',
            'Saturday'  => 'Sabtu'
        );

        $monthList = array(
            '01' => 'Jan',
            '02' => 'Feb',
            '03' => 'Mar',
            '04' => 'Apr',
            '05' => 'Mei',
            '06' => 'Jun',
            '07' => 'Jul',
            '08' => 'Agt',
            '09' => 'Sep',
            '10' => 'Okt',
            '11' => 'Nov',
            '12' => 'Des'
        );

        $format_hari = date('l', strtotime($date));
        $format_tgl  = date('d', strtotime($date));
        $format_bln  = date('m', strtotime($date));
        $format_thn  = date('Y', strtotime($date));

        switch ($date_format) {
            case 'l':
                # Hari ex: Kamis
                $output = $dayList[$format_hari];
                break;
            case 'd':
                # Tanggal ex: 21
                $output = $format_tgl;
                break;  
            case 'm':
                # Bulan ex: Januari
                $output = $monthList[$format_bln];
                break;  
            case 'y':
                # Tahun ex: 2016
                $output = $format_thn;
                break;                                            
            default:
                # Hari, Tanggal-Bulan-Tahun ex: Rb, 26-Jul-2016 
                $output = $dayList[$format_hari] . ', ' .  $format_tgl . ' ' . $monthList[$format_bln] . ' ' . $format_thn;
                break;
        }

        return $output;
    }

public static function showHari($tanggal)
	{
		$dow = date('w', strtotime($tanggal));
		switch ($dow) {
			case 0:
				 $hari = "Minggu";
				 break;
			case 1:
				 $hari = "Senin";
				 break;
			case 2:
				 $hari = "Selasa";
				 break;
			case 3:
				 $hari = "Rabu";
				 break;
			case 4:
				 $hari = "Kamis";
				 break;
			case 5:
				 $hari = "Jum'at";
				 break;
			case 6:
				 $hari = "Sabtu";
				 break;
		}
		return $hari;		
	}

    public static function tgl_indo2($date, $date_format=''){
        $dayList = array(
            'Sunday'    => 'MINGGU',
            'Monday'    => 'SENIN',
            'Tuesday'   => 'SELASA',
            'Wednesday' => 'RABU',
            'Thursday'  => 'KAMIS',
            'Friday'    => 'JUMAT',
            'Saturday'  => 'SABTU'
        );

        $monthList = array(
            '01' => 'JANUARI',
            '02' => 'FEBRUARI',
            '03' => 'MARET',
            '04' => 'APRIL',
            '05' => 'MEI',
            '06' => 'JUNI',
            '07' => 'JULI',
            '08' => 'AGUSTUS',
            '09' => 'SEPTEMBER',
            '10' => 'OKTOBER',
            '11' => 'NOVEMBER',
            '12' => 'DESEMBER'
        );

        $format_hari = date('l', strtotime($date));
        $format_tgl  = date('d', strtotime($date));
        $format_bln  = date('m', strtotime($date));
        $format_thn  = date('Y', strtotime($date));

        switch ($date_format) {
            case 'l':
                # Hari ex: Kamis
                $output = $dayList[$format_hari];
                break;
            case 'd':
                # Tanggal ex: 21
                $output = $format_tgl;
                break;  
            case 'm':
                # Bulan ex: Januari
                $output = $monthList[$format_bln];
                break;  
            case 'y':
                # Tahun ex: 2016
                $output = $format_thn;
                break;                                            
            default:
                # Hari, Tanggal-Bulan-Tahun ex: Rabu, 26-Juli-2016 
                $output = $dayList[$format_hari] . ', ' . $format_tgl . ' ' . $monthList[$format_bln] . ' ' . $format_thn;
                break;
        }

        return $output;
    }

    public static function tgl_jam($timeStamp, $format) {
        
         $dayList = array(
            'Sunday'    => 'Minggu',
            'Monday'    => 'Senin',
            'Tuesday'   => 'Selasa',
            'Wednesday' => 'Rabu',
            'Thursday'  => 'Kamis',
            'Friday'    => 'Jumat',
            'Saturday'  => 'Sabtu'
        );

        $monthList = array(
            '01' => 'Jan',
            '02' => 'Feb',
            '03' => 'Mar',
            '04' => 'Apr',
            '05' => 'Mei',
            '06' => 'Jun',
            '07' => 'Jul',
            '08' => 'Agt',
            '09' => 'Sep',
            '10' => 'Okt',
            '11' => 'Nov',
            '12' => 'Des'
        );

        $format_hari = date('l', strtotime($date));
        $format_tgl  = date('d', strtotime($date));
        $format_bln  = date('m', strtotime($date));
        $format_thn  = date('Y', strtotime($date));

        switch ($date_format) {
            case 'l':
                # Hari ex: Kamis
                $output = $dayList[$format_hari];
                break;
            case 'd':
                # Tanggal ex: 21
                $output = $format_tgl;
                break;  
            case 'm':
                # Bulan ex: Januari
                $output = $monthList[$format_bln];
                break;  
            case 'y':
                # Tahun ex: 2016
                $output = $format_thn;
                break;                                            
            default:
                # Hari, Tanggal-Bulan-Tahun ex: Rb, 26-Jul-2016 
                $output = $dayList[$format_hari] . ', ' .  $format_tgl . ' ' . $monthList[$format_bln] . ' ' . $format_thn;
                break;
        }

        return $output;
    }

public static function getFotoVersion($empId)
{
    $path = BASE_PATH . '/public/images/emp/' . $empId . '.jpg';
    return file_exists($path) ? filemtime($path) : time();
}

    
}