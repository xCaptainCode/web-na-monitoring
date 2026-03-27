<style type="text/css">
	.badge-pills {
		border-radius: 17px;
		width: 15px;
		color: aqua;
	}

	aside p {
		font-size: 14px;
	}

	aside .brand-link {
		font-size: 18px;
	}

	body {
		overflow: auto;
		/* overflow: hidden; */

	}

	.brand-text {
		font-weight: bold;
	}

	.dropdown-divider {
		padding-inline: 0;
		padding-block: 0;
	}

	.nav-treeview .nav-link,
	.nav-treeview .nav-link .text-dark {
		padding-left: 20px;
	}
</style>

<!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-light-primary elevation-5" style="background-color: #f7f7f7;" hidden>
	<!-- <aside class="main-sidebar sidebar-light-primary elevation-5"> -->
	<!-- Brand Logo -->
	<a href="{{ url() }}" class="brand-link navbar-light"> {{ image("dist/img/back-office.jpg", "class": "brand-image
		img-circle elevation-2", "alt": "AdminLTE Logo") }}
		<span class="brand-text font-weight-bold text-bold">NA Back Office</span>
	</a>
	<!-- Sidebar -->
	<div class="sidebar">
		<!-- Sidebar Menu -->
		<nav class="mt-2">
			<ul id="custom-scroll" class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu"
				data-accordion="false">
				<!-- Add icons to the links using the .nav-icon class with font-awesome or any other icon font library -->
				<li class="nav-item">
					<a href="{{ url('index') }}" class="nav-link text-bold">
						<i class="nav-icon far ri-dashboard-fill"></i>
						<!-- <i class="nav-icon fas fa-tachometer-alt"></i> -->
						<p>
							DASHBOARD
							<span class="badge badge-danger right">
								<i class="fas fa-star"></i>
							</span>
						</p>
					</a>
				</li>
				<!-- search -->
				<div class="form-inline">
					<div class="input-group" data-widget="sidebar-search">
						<input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
						<div class="input-group-append">
							<button class="btn btn-sidebar">
								<i class="fas fa-search fa-fw"></i>
							</button>
						</div>
					</div>
					<div class="sidebar-search-results">
						<div class="list-group"></div>
					</div>
				</div>
				<div class="dropdown-dividers"></div>
				<!-- umum -->
				<li class="nav-item">
					<a href="#" class="nav-link text-bold">
						<!-- <i class="nav-icon far ri-layout-grid-fill"></i> -->
						<i class="nav-icon far ri-list-check-2"></i>
						<!-- <i class="fa-envelope"></i> -->
						<p>
							UMUM
							<i class="right fas fa-angle-left"></i>
							{% if session.bo_user_dept_id == '25' %}
							{% if References.notifLayananLitbang() != 0 %}
							<span class="right badge badge-danger badge-pill">{{ References.notifLayananLitbang() +
								References.notifMemo() }}</span>
							{% endif %}
							{% else %}
							<span class="badge badge-danger badge-pill right">{{ References.notifMemo() }}</span>
							{% endif %}
						</p>
					</a>
					<ul class="nav nav-treeview">
						<!-- memo -->
						{% if session.bo_user_jab_id in ['9000', '3000'] %}
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									User Administration
									<i class="right fas fa-angle-left"></i>
									<span class="badge badge-danger badge-pill right"></span>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('useradministration/index') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Hak Akses</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('useradministration/backoffice') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Backoffice</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('useradministration/selling') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Selling</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('useradministration/intranet') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Intranet New-web</p>
									</a>
								</li>
							</ul>
						</li>
						{% endif %}
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Memo
									<i class="right fas fa-angle-left"></i>
									<span class="badge badge-danger badge-pill right">{{ References.notifMemo() }}</span>
								</p>
							</a>
							<ul class="nav nav-treeview">
								{% if (session.bo_user_level in ['KABAG', 'KADIV', 'STAFF']) %}
								<li class="nav-item">
									<a href="{{ url('memo/buatMemo') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Buat Memo</p>
									</a>
								</li>
								{% endif %}
								<li class="nav-item">
									<a href="{{ url('memo/kotakMasuk') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Kotak Masuk
											<span class="badge badge-danger badge-pill right">{{ References.notifMemo() }}</span>
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('memo/memoTerkirim') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Memo Terkirim
										</p>
									</a>
								</li>
								<!-- riwayat -->
								<li class="nav-item" hidden>
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Riwayat
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('memo/riwayatMasuk') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Kotak Masuk</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('memo/riwayatTerkirim') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Memo Terkirim</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
						</li>
						<!-- lost and found -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Lost and Found
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								{% if session.bo_user_dept_id == '03' %}
								<li class="nav-item">
									<a href="{{ url('lostfound/inputBarang') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Input Barang</p>
									</a>
								</li>
								{% endif %}
								<!-- daftar barang -->
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Daftar Barang
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('lostfound/barangFo') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Front Office</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('lostfound/barangKebersihan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Kebersihan</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<!-- riwayat -->
								<li class="nav-item">
									<a href="{{ url('lostfound/riwayat') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Riwayat
										</p>
									</a>
								</li>
							</ul>
						</li>
						<!-- kritik saran -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<!-- <i class="nav-icon fas fa-headset"></i> -->
								<p>
									Kritik & Saran
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							{% if session.bo_user_level in ['KABAG', 'KADIV', 'STAFF'] %}
							<ul class="nav nav-treeview">
								<!-- input -->
								<li class="nav-item">
									<a href="{{ url('krisa/inputKrisa') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Input Kritik & Saran
										</p>
									</a>
								</li>
							</ul>
							{% endif %}
							<ul class="nav nav-treeview">
								<!-- belum -->
								<li class="nav-item">
									<a href="{{ url('krisa/belumDitindaklanjut') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Belum Ditindaklanjuti
										</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<!-- sudah -->
								<li class="nav-item">
									<a href="{{ url('krisa/sudahDitindaklanjut') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Sudah Ditindaklanjuti
										</p>
									</a>
								</li>
							</ul>
						</li>
						<!-- layanan PP -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Layanan PP
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<!-- pengajuan -->
								<li class="nav-item">
									<a href="{{ url('layananpp/pengajuan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Pengajuan
										</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<!-- riwayat -->
								<li class="nav-item">
									<a href="{{ url('layananpp/realisasi') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Realisasi
										</p>
									</a>
								</li>
							</ul>
						</li>
						<!-- layanan DM -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Layanan DM
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<!-- pengajuan -->
								<li class="nav-item">
									<a href="{{ url('layananpp/pengajuan_dm') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Pengajuan
										</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<!-- riwayat -->
								<li class="nav-item">
									<a href="{{ url('layananpp/realisasi_dm') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Realisasi
										</p>
									</a>
								</li>
							</ul>
						</li>
						<!-- layanan Litbang -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Layanan Litbang
									<i class="right fas fa-angle-left"></i>
									{% if session.bo_user_dept_id == '25' %}
									<span class="right badge badge-danger badge-pill">{{ References.notifLayananLitbang() }}</span>
									{% endif %}
								</p>
							</a>
							<ul class="nav nav-treeview">
								<!-- pengajuan -->
								<li class="nav-item">
									<a href="{{ url('layananpp/pengajuan_lt') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Pengajuan
											{% if session.bo_user_dept_id == '25' %}
											<span class="right badge badge-danger badge-pill">{{ References.notifLayananLitbang() }}</span>
											{% endif %}
										</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<!-- riwayat -->
								<li class="nav-item">
									<a href="{{ url('layananpp/realisasi_lt') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Realisasi
										</p>
									</a>
								</li>
							</ul>
						</li>
						<!-- peralatan GU -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Peralatan GU
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('pinjamperalatan/daftarbarang') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Alat</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('pinjamperalatan/barangReadyNew') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Alat Ready</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('pinjamperalatan/barangkeluar') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Alat Keluar</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('pinjamperalatan/barangperawatan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Alat Perawatan</p>
									</a>
								</li>
							</ul>
						</li>
						<!-- Management HT -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Management HT
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('managementht/daftar_ht') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar HT</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('managementht/daftar_baterai') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Baterai HT
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('managementht/daftar_baterai') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Daftar Baterai</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('managementht/manage_baterai') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Manage Baterai</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('managementht/daftar_pemilik') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Pemilik</p>
									</a>
								</li>
							</ul>
						</li>
						{% if session.bo_user_parent == '25' %}
						<!-- Agenda Rutin -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Agenda Rutin
								</p>
								<i class="right fas fa-angle-left"></i>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('tasks/index') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Tugas</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('tasks/rekapBulanan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Rekap Tugas</p>
									</a>
								</li>
							</ul>
						</li>
						{% endif %}
					</ul>
				</li>
				{% if session.bo_user_level not in ['SECURITY'] %}
				<div class="dropdown-dividers"></div>
				<!-- pelayanan -->
				<li class="nav-item">
					<a href="#" class="nav-link">
						<i class="nav-icon fas fa-concierge-bell"></i>
						<p class="text-bold">
							PELAYANAN
							<i class="right fas fa-angle-left"></i>
						</p>
					</a>
					<ul class="nav nav-treeview">
						<!-- resume pelayanan -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Resume
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								{% if session.bo_user_level not in ['UNIT', 'SECURITY'] %}
								<li class="nav-item">
									<a href="{{ url('pelayanan/harian') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Harian</p>
									</a>
								</li>
								{% endif %}
								{% if session.bo_user_level in ['KABAG', 'KADIV', 'MANAGER'] %}
								<li class="nav-item">
									<a href="{{ url('pelayanan/periode') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Periode</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pelayanan/bulanan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Bulanan</p>
									</a>
								</li>
								{% endif %}
								{% if session.bo_user_level in ['KABAG', 'MANAGER'] %}
								<li class="nav-item">
									<a href="{{ url('pelayanan/tahunan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Tahunan</p>
									</a>
								</li>
								{# <li class="nav-item">
									<a href="{{ url('perbandinganpelayanan/index') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Perbandingan</p>
									</a>
								</li> #}
								{% endif %}
							</ul>
						</li>
						<!-- kecepatan penyajian -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Kecepatan
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								{% if session.bo_user_level not in ['UNIT', 'SECURITY'] %}
								<li class="nav-item">
									<a href="{{ url('penyajian/pelayananNota') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Pelayanan Nota</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('penyajian/penyajianIkan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Penyajian Ikan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('penyajian/penyediaanMeja') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Penyediaan Meja</p>
									</a>
								</li>
								{% endif %}
								{% if session.bo_user_level in ['KABAG', 'KADIV', 'MANAGER'] %}
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Resume Perjam
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('penyajian/perjamIkan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Ikan</p>
											</a>
										</li>
									</ul>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('penyajian/perjamMenu') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Menu</p>
											</a>
										</li>
									</ul>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('penyajian/perjamMeja') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Meja</p>
											</a>
										</li>
									</ul>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('penyajian/perjam_tiket_masuk') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Tiket Masuk</p>
											</a>
										</li>
									</ul>
								</li>
								{% endif %}
							</ul>
						</li>
						{% if session.bo_user_level in ['KABAG', 'KADIV', 'MANAGER', 'STAFF'] %}
						<!-- monitor nota -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Monitor Nota
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('monitor/daftarNota') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Nota</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Daftar Pesanan
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('monitor/pesananPerhari') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Perhari</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('monitor/pesananPerbulan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Perbulan</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('monitor/pesananPertahun') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Pertahun</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
						</li>

						<!-- monitor customer -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>Monitor Customer
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('monitor/customer') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Pemakaian Area</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Datang Langsung
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('kelompok/harian') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Daftar Kedatangan</p>
											</a>
										</li>
									</ul>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('kelompok/rekaptahun') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Rekap Kedatangan</p>
											</a>
										</li>
									</ul>

								</li>
							</ul>
						</li>
						{% endif %}
						{% if session.bo_user_level in ['KABAG', 'KADIV', 'MANAGER', 'STAFF','KOORDINATOR'] %}
						<!-- status hari-->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Status Hari
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<!-- prediksi & realisasi -->
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('statushari/tgl_merah') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Tgl Merah
										</p>
									</a>
								</li>
							</ul>
							{% endif %}
							{% if session.bo_user_level in ['KABAG', 'KADIV', 'MANAGER', 'STAFF', 'KOORDINATOR'] %}
							<!-- Status Hari -->
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('statushari/status_hari') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Status Hari
										</p>
									</a>
								</li>
							</ul>
							{% endif %}
							{% if session.bo_user_level in ['KABAG', 'KADIV', 'MANAGER'] %}
							<!-- resume prediksi -->
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Resume
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('statushari/resumeBulanan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Bulanan</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('statushari/resumeTahunan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Tahunan</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
							{% endif %}
						</li>
						{% if (Helpers.getSessionValue('bo_user_dept_id') in ['19', '25']) OR
						(Helpers.getSessionValue('bo_user_jab_id')
						in ['9000']) %}
						<!-- stok tandon  -->
						<li class="nav-item">
							<a href="{{ url('stoktandon/index') }}" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Stok Tandon
								</p>
							</a>
						</li>
						<li class="nav-item">
							<a href="{{ url('coffeecorner/status') }}" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>Coffee Corner</p>
							</a>
						</li>

						{% endif %}
						{% if (session.bo_user_level in ['MANAGER', 'KABAG']) or (session.bo_user_dept_id in ['02', '03']) %}
						<!-- stok tandon  -->
						<li class="nav-item">
							{% if References.kelipatan() == 150 %}
							<a href="{{ url('servermeja150') }}" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Server Meja
								</p>
							</a>
							{% elseif References.kelipatan() == 250 %}
							<a href="{{ url('servermeja250') }}" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Server Meja
								</p>
							</a>
							{% else %}
							<a href="{{ url('servermeja350') }}" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Server Meja
								</p>
							</a>
							{% endif %}
						</li>
						{% endif %}
						{% if session.bo_user_jab_id == '9000' %}
						<li class="nav-item has-treeview">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Rating Customer
									<i class="fas fa-angle-left right"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('rating/index') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Pertanyaan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('rating/bulan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Resume Per Bulan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('rating/tahun') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Resume Per Tahun</p>
									</a>
								</li>
								<li class="nav-item" hidden>
									<a href="{{ url('rating/rincian') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Rincian Rating</p>
									</a>
								</li>
							</ul>
						</li>
						{% endif %}
					</ul>
				</li>
				{% endif %}
				{% if session.bo_user_level in ['KABAG', 'MANAGER', 'KADIV', 'STAFF', 'KOORDINATOR' ] %}
				<div class="dropdown-dividers"></div>
				<!-- sales -->
				<li class="nav-item">
					<a href="#" class="text-bold nav-link">
						<i class="nav-icon fa-solid fa-cash-register"></i>
						<p>
							SALES
							<i class="right fas fa-angle-left"></i>
						</p>
					</a>
					<ul class="nav nav-treeview">
						<!-- reservation -->
						<li class="nav-item has-treeview">
							{% if session.bo_user_level not in ['UNIT', 'SECURITY'] %}
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Reservations
									<i class="fas fa-angle-left right"></i>
								</p>
							</a>
							{% endif %}
							<!-- cart -->
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Chart
											<i class="fas fa-angle-left right"></i>
										</p>
									</a>
									<ul class="nav-treeview">
										{% if (session.bo_user_dept_id == '03') or (session.bo_user_jab_id == '9000') %}
										<li class="nav-item">
											<a href="{{ url('reservation/addNew') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>New Reservation</p>
											</a>
										</li>
										{% endif %}
										<li class="nav-item">
											<a href="{{ url('reservation/cart') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Chart Reservations</p>
											</a>
										</li>
										<li class="nav-item" hidden>
											<a href="{{ url('reservation/namePlate') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Name Plates</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
							<!-- proses -->
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('reservation/proses') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Proses</p>
									</a>
								</li>
							</ul>
							<!-- menu -->
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Menu
											<i class="fas fa-angle-left right"></i>
										</p>
									</a>
									<ul class="nav-treeview">
										<li class="nav-item" hidden>
											<a href="{{ url('reservation/daftarPesanan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Daftar Pesanan</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('reservation/pesananHarian') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Pesanan Harian</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('reservation/pesananGlobal') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Pesanan Global</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
							<!-- riiwayat -->
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('reservation/riwayat') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Riwayat</p>
									</a>
								</li>
							</ul>
							<!-- daftar customer -->
							{% if session.bo_user_level != 'KOORDINATOR' %}
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('reservation/customerList') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Customer</p>
									</a>
								</li>
							</ul>
							<!-- resume -->
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('reservation/resume') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Resume</p>
									</a>
								</li>
							</ul>
							{% endif %}
							<!-- rank reservator -->
							{% if session.bo_user_level in ['KABAG', 'MANAGER' ] %}
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Reservator
											<i class="fas fa-angle-left right"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item" hidden>
											<a href="#" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Peringkat
													<i class="fas fa-angle-left right"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('reservation/rankBulan') }}" class="nav-link">
														<i class="fas street-view nav-icon"></i>
														<p>Per Bulan</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('reservation/rankTahun') }}" class="nav-link">
														<i class="fas street-view far nav-icon"></i>
														<p>Per Tahun</p>
													</a>
												</li>
											</ul>
										</li>
										{% if session.bo_user_level in ['MANAGER','KABAG'] %}
										<li class="nav-item">
											<a href="javascript:void(0);" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Bonus v.2024
													<i class="fas fa-angle-left right"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('reservation/rincianBonus') }}" class="nav-link">
														<i class="fas street-view nav-icon"></i>
														<p>Rincian Perolehan</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('reservation/resumeBonus') }}" class="nav-link">
														<i class="fas street-view far nav-icon"></i>
														<p>Resume Tahunan</p>
													</a>
												</li>
											</ul>
										</li>

										<li class="nav-item">
											<a href="javascript:void(0);" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Bonus v.2025
													<i class="fas fa-angle-left right"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												{% if session.bo_user_jab_id == 9000 %}
												<li class="nav-item">
													<a href="{{ url('bonusresv/ketetapan') }}" class="nav-link">
														<i class="fas street-view nav-icon"></i>
														<p>Ketetapan</p>
													</a>
												</li>
												{% endif %}
												<li class="nav-item">
													<a href="{{ url('bonusresv/rekap') }}" class="nav-link">
														<i class="fas street-view far nav-icon"></i>
														<p>Rekap</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('bonusresv/bonus') }}" class="nav-link">
														<i class="fas street-view far nav-icon"></i>
														<p>Peringkat & Bonus</p>
													</a>
												</li>
											</ul>
										</li>

										{% endif %}
									</ul>
								</li>
							</ul>
							{% endif %}
						</li>
						{% if session.bo_user_level in ['KABAG', 'MANAGER', 'KADIV', 'KOORDINATOR' ] %}
						<!-- restoran -->
						<li class="nav-item has-treeview">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Restoran
									<i class="fas fa-angle-left right"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Qty Menu
											<i class="fas fa-angle-left right"></i>
										</p>
									</a>
									<ul class="nav-treeview">
										<li class="nav-item">
											<a href="{{ url('restoran/riwayat_harian') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Riwayat Harian</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('restoran/periode2') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Periode Bulan Ini</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('restoran/periode') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Periode Bulan Lalu</p>
											</a>
										</li>
										<li class="nav-item" hidden>
											<a href="{{ url('restoran/penjualan_bulanan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Bulanan</p>
											</a>
										</li>
										<li class="nav-item" hidden>
											<a href="{{ url('restoran/penjualan_tahunan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Tahunan</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('restoran/tahunan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Qty Tahunan</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Jenis Masakan
											<i class="fas fa-angle-left right"></i>
										</p>
									</a>
									<ul class="nav-treeview">
										<li class="nav-item">
											<a href="{{ url('restoran/periodejenismasakan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Periode Tertentu</p>
											</a>
										</li>
										<li class="nav-item" hidden>
											<a href="{{ url('restoran/jenis_bulanan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Bulanan</p>
											</a>
										</li>
										<li class="nav-item" hidden>
											<a href="{{ url('restoran/jenis_tahunan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Tahunan</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('restoran/tahunan2') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Jenis Tahunan</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Komplain Restoran
											<i class="fas fa-angle-left right"></i>
										</p>
									</a>
									<ul class="nav-treeview">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>
													Daftar Komplain
													<i class="fas fa-angle-left right"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('restoran/komplain_daftar') }}" class="nav-link">
														<i class="ri-git-commits-line far nav-icon"></i>
														<p>Komplain Menu</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('restoran/komplain_lainnya') }}" class="nav-link">
														<i class="ri-git-commits-line far nav-icon"></i>
														<p>Komplain Lainnya</p>
													</a>
												</li>
											</ul>
										</li>
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>
													Resume Komplain
													<i class="fas fa-angle-left right"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('restoran/komplain_resume') }}" class="nav-link">
														<i class="ri-git-commits-line far nav-icon"></i>
														<p>Komplain Menu</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('restoran/resume_lainnya') }}" class="nav-link">
														<i class="ri-git-commits-line far nav-icon"></i>
														<p>Komplain Lainnya</p>
													</a>
												</li>
											</ul>
										</li>
										<li class="nav-item">
											<a href="{{ url('restoran/komplain_grafik') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Grafik Komplain</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
						</li>
						{% if session.bo_user_level !='KOORDINATOR' %}
						<!-- permainan -->
						<li class="nav-item has-treeview">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Permainan
									<i class="fas fa-angle-left right"></i>
								</p>
							</a>
							<ul class="nav-treeview">
								<li class="nav-item">
									<a href="{{ url('permainan/permainan_bulanan') }}" class="nav-link">
										<i class="ri-git-commit-line far nav-icon"></i>
										<p>Bulanan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('permainan/permainan_tahunan') }}" class="nav-link">
										<i class="ri-git-commit-line far nav-icon"></i>
										<p>Tahunan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('permainan/perwahana') }}" class="nav-link">
										<i class="ri-git-commit-line far nav-icon"></i>
										<p>Per Wahana</p>
									</a>
								</li>
							</ul>
						</li>
						<!-- paintball -->
						<li class="nav-item has-treeview">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Paintball
									<i class="fas fa-angle-left right"></i>
								</p>
							</a>
							<ul class="nav-treeview">
								<li class="nav-item">
									<a href="{{ url('permainan/paintball_bulanan') }}" class="nav-link">
										<i class="ri-git-commit-line far nav-icon"></i>
										<p>Bulanan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('permainan/paintball_tahunan') }}" class="nav-link">
										<i class="ri-git-commit-line far nav-icon"></i>
										<p>Tahunan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('permainan/allpb') }}" class="nav-link">
										<i class="ri-git-commit-line far nav-icon"></i>
										<p>All</p>
									</a>
								</li>
							</ul>
						</li>
						<!-- fieldtrip -->
						<li class="nav-item has-treeview">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Fieldtrip
									<i class="fas fa-angle-left right"></i>
								</p>
							</a>
							<ul class="nav-treeview">
								<li class="nav-item">
									<a href="{{ url('permainan/fieldtrip_bulanan') }}" class="nav-link">
										<i class="ri-git-commit-line far nav-icon"></i>
										<p>Bulanan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('permainan/fieldtrip_tahunan') }}" class="nav-link">
										<i class="ri-git-commit-line far nav-icon"></i>
										<p>Tahunan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('permainan/allft') }}" class="nav-link">
										<i class="ri-git-commit-line far nav-icon"></i>
										<p>All</p>
									</a>
								</li>
							</ul>
						</li>
						<li class="nav-item has-treeview">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Qty Pengunjung
									<i class="fas fa-angle-left right"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('jmlpengunjung/bulanan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Bulanan</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('jmlpengunjung/tahunan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Tahunan</p>
									</a>
								</li>
							</ul>

						</li>
						{% endif %}
						{% endif %}
						<!-- rata-rata penjualan -->
						{% if session.bo_user_level in ['KABAG', 'MANAGER', 'KADIV' ] %}
						<li class="nav-item has-treeview">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Rata Rata Sales
									<i class="fas fa-angle-left right"></i>
								</p>
							</a>
							<!-- user level Kabag Litbang -->
							{% if session.bo_user_jab_id == '9000' %}
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('average/menu') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Menu Restoran</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('average/wahana') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Wahana Permainan</p>
									</a>
								</li>
							</ul>
							{% endif %}
							<!-- end user level Kabag Litbang -->
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('average/index') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Rekap Rata Rata</p>
									</a>
								</li>
							</ul>
						</li>
						{% endif %}
						<!-- member -->
						{% if session.bo_user_level in ['KABAG', 'KADIV', 'STAFF' ] %}
						<li class="nav-item has-treeview">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Member
									<i class="fas fa-angle-left right"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('member/regular') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Regular</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('member/paintball') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Paintball</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('member/fieldtrip') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Field Trip</p>
									</a>
								</li>
							</ul>
						</li>

						{% if session.bo_user_jab_id in [9000, 4000, 2000, 2100, 2200, 2300] %}
						<!-- member restoran -->
						<li class="nav-item has-treeview">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Member Restoran
									<i class="fas fa-angle-left right"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('memberrestoran/ketetapan_poin') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Ketetapan Poin </p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('memberrestoran/daftar_member') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Member </p>
									</a>
								</li>
							</ul>
						</li>
						{% endif %}
						<!-- hpp menu -->
						<li class="nav-item has-treeview">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									HPP Menu
									<i class="fas fa-angle-left right"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Resume Laba</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('hppbumbu/prosentaselaba') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Prosenstase</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('hppbumbu/pointlaba') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Poin</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
							{% if session.bo_user_jab_id in ['6000','9000', '5100'] %}
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('hppbumbu/tambahbahan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Buat Paketan</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('hppbumbu/hppolahan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Buat HPP Olahan</p>
									</a>
								</li>
							</ul>
							{% endif %}
							{% if session.bo_user_level in ['KABAG', 'MANAGER', 'KADIV' ] %}
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('hppbumbu/hppbumbu') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>HPP Bumbu</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('hppbumbu/hasilhpp') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>HPP Olahan Ikan</p>
									</a>
								</li>
							</ul>

							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('hppbumbu/ketetapan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Ketetapan Paketan</p>
									</a>
								</li>
							</ul>
							{% endif %}
						</li>
						{% endif %}
						<!-- grafik -->
						{% if session.bo_user_level in ['KABAG', 'MANAGER', 'KADIV'] %}
						<li class="nav-item has-treeview">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Grafik
									<i class="fas fa-angle-left right"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Penjualan Ikan
											<i class="fas fa-angle-left right"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('grafik/penjualanIkanHarian') }}" class="nav-link">
												<i class="far ri-git-commit-line nav-icon"></i>
												<p>Harian</p>
											</a>
										</li>
									</ul>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('grafik/penjualanIkanPerbulan') }}" class="nav-link">
												<i class="far ri-git-commit-line nav-icon"></i>
												<p>Per Bulan</p>
											</a>
										</li>
									</ul>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('grafik/penjualanIkanPertahun') }}" class="nav-link">
												<i class="far ri-git-commit-line nav-icon"></i>
												<p>Per Tahun</p>
											</a>
										</li>
									</ul>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('grafik/perbandinganPenjualanIkan') }}" class="nav-link">
												<i class="far ri-git-commit-line nav-icon"></i>
												<p>Perbandingan</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Jenis Masakan Ikan
											<i class="fas fa-angle-left right"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('grafik/masakanIkanPerbulan') }}" class="nav-link">
												<i class="far ri-git-commit-line nav-icon"></i>
												<p>Per Bulan</p>
											</a>
										</li>
									</ul>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('grafik/masakanIkanPertahun') }}" class="nav-link">
												<i class="far ri-git-commit-line nav-icon"></i>
												<p>Per Tahun</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('grafik/penjualanTiket') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Penjualan Tiket</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('grafik/penjualanFieldtrip') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Penjualan Fieldtrip</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('grafik/penjualanPaintball') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Penjualan Paintball</p>
									</a>
								</li>
							</ul>
						</li>
						{% endif %}
						{% if session.bo_user_jab_id in ['9000', '4000' ] %}
						<!-- fo control -->
						<li class="nav-item has-treeview">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									FO Control
									<i class="fas fa-angle-left right"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('focontrol/menu') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Menu</p>
									</a>
								</li>
							</ul>

							{% if session.bo_user_jab_id == 9000 %}
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Menu Tambahan
											<i class="fas fa-angle-left right"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('menutambahan/daftar_menu') }}" class="nav-link">
												<i class="far ri-git-commit-line nav-icon"></i>
												<p>Daftar Menu</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('menutambahan/penggunaan_menu') }}" class="nav-link">
												<i class="far ri-git-commit-line nav-icon"></i>
												<p>Penggunaan Menu</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
							{% endif %}

							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('focontrol/wahana') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Wahana</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('focontrol/fieldtrip') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Fieldtrip
											<i class="fas fa-angle-left right"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('focontrol/ft_fungames') }}" class="nav-link">
												<i class="far ri-git-commit-line nav-icon"></i>
												<p>Fun Games</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('focontrol/ft_makan') }}" class="nav-link">
												<i class="far ri-git-commit-line nav-icon"></i>
												<p>Makan</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('focontrol/ft_package') }}" class="nav-link">
												<i class="far ri-git-commit-line nav-icon"></i>
												<p>Paket</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('focontrol/ft_wahana') }}" class="nav-link">
												<i class="far ri-git-commit-line nav-icon"></i>
												<p>Wahana</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('focontrol/ft_souvenir') }}" class="nav-link">
												<i class="far ri-git-commit-line nav-icon"></i>
												<p>Souvenir</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('focontrol/paintball') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Paintball</p>
									</a>
								</li>
							</ul>
							{% if session.bo_user_jab_id in [9000, 1000, 4000] %}
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Tiket Masuk
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('promosi/ketetapan_disc_tiket_masuk') }}" class="nav-link">
												<i class="far ri-git-commit-line nav-icon"></i>
												<p>
													Ketetapan Diskon
												</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far ri-git-commit-line nav-icon"></i>
												<p>
													Resume Diskon
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('promosi/resume_disc_tiket_masuk_hari') }}" class="nav-link">
														<i class="far ri-git-commitss-line nav-icon"></i>
														<p>
															Per Hari
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('promosi/resume_disc_tiket_masuk_bulan') }}" class="nav-link">
														<i class="far ri-git-commit-liness nav-icon"></i>
														<p>
															Per Bulan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('promosi/resume_disc_tiket_masuk_tahun') }}" class="nav-link">
														<i class="far ri-git-commit-liness nav-icon"></i>
														<p>
															Per Tahun
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('promosi/resume_disc_tiket_masuk_all') }}" class="nav-link">
														<i class="far ri-git-commit-liness nav-icon"></i>
														<p>
															Global
														</p>
													</a>
												</li>
											</ul>
										</li>
									</ul>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('focontrol/menu_ideal') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Menu Ideal</p>
									</a>
								</li>
							</ul>

							{% if session.bo_user_jab_id == 9000 %}
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Kecepatan Penyajian
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('kecepatanpenyajian/setting_durasi') }}" class="nav-link">
												<i class="ri-git-commit-line nav-icon"></i>
												<p>Setting Durasi</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('kecepatanpenyajian/setting_video') }}" class="nav-link">
												<i class="ri-git-commit-line nav-icon"></i>
												<p>Setting Video</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
							{% endif %}

							{% endif %}
							{% endif %}
						</li>
						<!-- order batal-->
						{% if session.bo_user_jab_id in ['9000'] %}
						<li class="nav-item has-treeview">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Hapus Transaksi
									<i class="fas fa-angle-left right"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('orderbatal/today') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Order Hari Ini</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('orderbatal/index') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Transaksi Order</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('orderbatal/notahariini') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Transaksi Kasir</p>
									</a>
								</li>
							</ul>
						</li>
						{% endif %}
					</ul>
				</li>
				{% endif %}
				<div class="dropdown-dividers"></div>
				<!-- sdm -->
				{% if (session.bo_user_level in ['KABAG', 'MANAGER', 'KADIV' ]) OR (Helpers.getSessionValue('bo_user_dept_id')
				in ['02', '00']) %}
				<li class="nav-item">
					<a href="#" class="text-bold nav-link">
						<i class="nav-icon fa-solid fa-users"></i>
						<p>
							SDM
							<i class="right fas fa-angle-left"></i>
						</p>
					</a>
					<ul class="nav nav-treeview">
						<!-- karyawan -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Karyawan
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('sdm/daftarkaryawan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Karyawan
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('sdm/tabelkaryawan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Tabel Karyawan
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('sdm/leveljabatan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Level Jabatan
										</p>
									</a>
								</li>

								<li class="nav-item">
									<a href="{{ url('sdm/poskerja') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Pos Kerja
										</p>
									</a>
								</li>
								{% if session.bo_user_jab_id in [9000, 3000, 3400] %}
								<li class="nav-item">
									<a href="{{ url('sdm/department') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Department
										</p>
									</a>
								</li>
								{% endif %}
								{% if session.bo_user_level in ['MANAGER','KABAG', 'KADIV'] %}
								<!-- mutasi -->
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="nav-icon far fa-circle"></i>
										<p>
											Mutasi
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('sdm/daftarmutasi') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Mutasi Karyawan</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('kontrakkerja/riwayatmutasi') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Riwayat Mutasi</p>
											</a>
										</li>
									</ul>
								</li>
								{% endif %}
								<!-- kehadiran -->
								{% if session.bo_user_jab_id != '1100' %}
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="nav-icon far fa-circle"></i>
										<p>
											Kehadiran
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('kehadiran/harian') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Kehadiran Harian
												</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('kehadiran/riwayatkehadiran') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Riwayat Kehadiran
												</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('kehadiran/rekapkehadiran') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Rekap Kehadiran
												</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('managepresence/jadwallibur') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Jadwal Libur
												</p>
											</a>
										</li>
									</ul>
								</li>
								{% endif %}
								<!-- ishoma -->
								{% if Helpers.getSessionValue('bo_user_jab_id') in ['3000', '3400', '9000'] %}
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Ishoma
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('ishoma/ishomaharian') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Ishoma Harian</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('ishoma/ishomaperbulan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Rekap Ishoma</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('ishoma/riwayatishoma') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Riwayat Ishoma</p>
											</a>
										</li>
									</ul>
								</li>
								{% endif %}
								{% if session.bo_user_jab_id != '1000' %}
								<!-- kontrak kerja -->
								{% if (session.bo_user_jab_id in ['9000', '3000', '3400']) OR (session.bo_user_level in ['MANAGER',
								'KABAG', 'KADIV']) %}
								<li class="nav-item has-treeview">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Kontrak Kerja
											<i class="fas fa-angle-left right"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										{% if session.bo_user_jab_id in ['9000', '3000', '3400'] %}
										<li class="nav-item">
											<a href="{{ url('kontrakkerja/kontrak_baru') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Kontrak Baru</p>
											</a>
										</li>
										{% endif %}
										<li class="nav-item">
											<a href="{{ url('kontrakkerja/masakontrak') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Masa Kontrak</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('kontrakkerja/riwayatkontrak') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Riwayat Kontrak</p>
											</a>
										</li>
									</ul>
								</li>
								{% endif %}
								{% endif %}
								{% if session.bo_user_jab_id == 9000 %}
								<li class="nav-item has-treeview">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Perpanjang Kontrak
											<i class="fas fa-angle-left right"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item" hidden>
											<a href="{{ url('empcontrack/pengajuan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Buat Pengajuan</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('empcontrack/statuspengajuan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Status Pengajuan</p>
											</a>
										</li>
										{% if session.bo_user_level == 'KADIV' or session.bo_user_level == 'KABAG' or
										session.bo_user_level == 'MANAGER' %}
										<li class="nav-item">
											<a href="{{ url('empcontrack/daftarpengajuan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Daftar Pengajuan</p>
											</a>
										</li>
										{% endif %}
										{% if session.bo_user_level == 'KADIV' %}
										<li class="nav-item">
											<a href="{{ url('empcontrack/daftarAcckadiv') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>ACC Kadiv</p>
											</a>
										</li>
										{% endif %}

										{% if session.bo_user_level == 'KABAG' %}
										<li class="nav-item">
											<a href="{{ url('empcontrack/daftarAcckabag') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>ACC Kabag</p>
											</a>
										</li>
										{% endif %}

										{% if session.bo_user_jab_id == '3000' %}
										<li class="nav-item">
											<a href="{{ url('empcontrack/daftarAccadmin') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>ACC A & K</p>
											</a>
										</li>
										{% endif %}

										{% if session.bo_user_jab_id == '2000' %}
										<li class="nav-item">
											<a href="{{ url('empcontrack/daftarAcckeuangan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>ACC Keuangan</p>
											</a>
										</li>
										{% endif %}

										{% if session.bo_user_jab_id == '1000' %}
										<li class="nav-item">
											<a href="{{ url('empcontrack/daftarAccmanager') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>ACC Manager</p>
											</a>
										</li>
										{% endif %}

										<li class="nav-item">
											<a href="{{ url('empcontrack/riwayat') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Riwayat Pengajuan</p>
											</a>
										</li>
									</ul>
								</li>
								{% endif %}
								<!-- pkk -->
								{% if (session.bo_user_level in ['MANAGER','KABAG', 'KADIV']) OR (session.bo_user_jab_id in ['3400',
								'1100']) %}
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="nav-icon far fa-circle"></i>
										<p>
											Penilaian
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
											<li class="nav-item">
												<a href="{{ url('itempkk/index') }}" class="nav-link">
													<i class="ri-git-commit-line far nav-icon"></i>
													<p>Daftar Item Penilaian</p>
												</a>
											</li>
										{% if session.bo_user_jab_id in ['7000', 9000] %}
										<li class="nav-item">
											<a href="{{ url('pkk/addnilaisecurity') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Security</p>
											</a>
										</li>
										{% endif %}
										{% if session.bo_user_jab_id not in ['3400', '1000', '1100'] %}
										<li class="nav-item">
											<a href="{{ url('pkk/addnilaiunit') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Unit</p>
											</a>
										</li>
										{% endif %}
										{% if session.bo_user_jab_id not in ['3400', '1000', '1100'] %}
										<li class="nav-item">
											<a href="{{ url('pkk/addnilaikoordinator') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Koordinator</p>
											</a>
										</li>
										{% endif %}
										{% if session.bo_user_level in ['KABAG', 'KADIV'] %}
										<li class="nav-item">
											<a href="{{ url('pkk/addnilaistaff') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Staff</p>
											</a>
										</li>
										{% endif %}
										{% if session.bo_user_level in ['KABAG'] %}
										<li class="nav-item">
											<a href="{{ url('pkk/addnilaikadiv') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Kadiv</p>
											</a>
										</li>
										{% endif %}
										{% if session.bo_user_jab_id in ['1000'] %}
										<li class="nav-item">
											<a href="{{ url('pkk/addnilaikabag') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Kabag</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('pkk/addnilaistaff') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Staff</p>
											</a>
										</li>
										{% endif %}
										{% if session.bo_user_jab_id != '1100' %}
										<li class="nav-item">
											<a href="{{ url('pkk/penilaianadmin') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>
													Presensi & Ketertiban
												</p>
											</a>
										</li>
										{% endif %}
										<li class="nav-item">
											<a href="{{ url('pkk/hasilpenilaian') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>
													Peringkat
												</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('pkk/resumekaryawan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>
													riwayat
												</p>
											</a>
										</li>
									</ul>
								</li>
								{% endif %}
								{% if (session.bo_user_jab_id in ['3000','3400']) OR
								(session.bo_user_level in ['KABAG', 'MANAGER']) %}
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="nav-icon far fa-circle"></i>
										<p>
											Gaji Karyawan
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										{% if session.bo_user_jab_id in ['3000','3400', '9000'] %}
										<li class="nav-item">
											<a href="{{ url('gaji/ketetapangaji') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Ketetapan
												</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('gaji/inputgaji') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Input Gaji
												</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('gaji/accgaji') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>ACC Gaji
												</p>
											</a>
										</li>
										{% endif %}
										<li class="nav-item">
											<a href="{{ url('gaji/daftarAcc') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Rekap Gaji
												</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('gaji/printgaji') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Struk
												</p>
											</a>
										</li>
										{% if session.bo_user_jab_id in ['3400', '9000', '3000'] %}

										<li class="nav-item">
											<a href="{{ url('gaji/daftar_gaji') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Riwayat Gaji
												</p>
											</a>
										</li>
										{% endif %}

										<li class="nav-item">
											<a href="{{ url('gaji/daftarAcc2') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Laporan Gaji</p>
											</a>
										</li>
									</ul>
								</li>
								{% endif %}
								<!-- lembur -->
								{% if session.bo_user_level in ['MANAGER','KABAG', 'KADIV'] %}
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="nav-icon far fa-circle"></i>
										<p>
											Lembur Karyawan
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										{% if session.bo_user_jab_id != '1000' %}
										<li class="nav-item">
											<a href="{{ url('lembur/jenislembur') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Jenis Lembur</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('lembur/daftarlembur') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Daftar Lembur</p>
											</a>
										</li>
										<li class="nav-item" hidden>
											<a href="{{ url('lembur/perkaryawan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Per Karyawan</p>
											</a>
										</li>
										{% endif %}
										<li class="nav-item">
											<a href="{{ url('lembur/lemburbagian') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Lembur Bagian</p>
											</a>
										</li>
									</ul>
								</li>
								{% endif %}
								<!-- tunjangan pejabat -->
								{% if (session.bo_user_jab_id in ['3400']) OR (session.bo_user_level in ['KABAG', 'MANAGER']) %}
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="nav-icon far fa-circle"></i>
										<p>
											Tunjangan Pejabat
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										{% if session.bo_user_jab_id in ['3400', '9000', '2000'] %}
										<li class="nav-item">
											<a href="{{ url('tunjanganpejabat/inputtunjangan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Input Tunjangan</p>
											</a>
										</li>
										{% endif %}
										{% if session.bo_user_jab_id in ['3000','3400','9000', '2000'] %}
										<li class="nav-item">
											<a href="{{ url('tunjanganpejabat/daftar') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Daftar Tunjangan</p>
											</a>
										</li>
										{% endif %}
										{% if (session.bo_user_level in ['KABAG', 'MANAGER']) OR (session.bo_user_jab_id in ['3400']) %}
										<li class="nav-item">
											<a href="{{ url('tunjanganpejabat/rekaptunjangan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>
													Rekap
												</p>
											</a>
										</li>
										{% endif %}
									</ul>
								</li>
								{% endif %}
							</ul>
						</li>
						<!-- parttimer kontrak -->
						{% if session.bo_user_jab_id != '1100' %}
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Trainee & Percobaan
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('ptkontrak/daftar_ptkontrak') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Karyawan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('presenceptkontrak/resumeKehadiran') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Kehadiran</p>
									</a>
								</li>
								<!-- penilaian -->

								<!-- gaji -->
								{% if Helpers.getSessionValue ('bo_user_jab_id') in [ '1000', '3000', '3400', '9000', '2000' ] %}
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Gaji Trainee
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										{% if session.bo_user_jab_id not in ['1000', '2000'] %}
										<li class="nav-item">
											<a href="{{ url('ptkontrak/daftargaji') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Daftar</p>
											</a>
										</li>
										{% endif %}
										<li class="nav-item">
											<a href="{{ url('ptkontrak/rekapgaji') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Rekap</p>
											</a>
										</li>
									</ul>
								</li>
								{% endif %}
							</ul>
						</li>
						{% endif %}
						<!-- parttimer -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Parttimer
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('parttimer/daftarParttimer') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Parttimer
										</p>
									</a>
								</li>
								{% if Helpers.getSessionValue ('bo_user_jab_id') in [ '3300', '3000', '8610', '9000' ] %}
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Ploting Parttimer
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('manageparttimer/kehadiranharian') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Hari Ini
												</p>
											</a>
										</li>
									</ul>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('manageparttimer/addploting') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Add Ploting</p>
											</a>
										</li>
									</ul>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('manageparttimer/perposkerja') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Rekap Data</p>
											</a>
										</li>
									</ul>
								</li>
								{% endif %}

								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Pos Kerja
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('parttimer/pos_kerja') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Daftar Pos Kerja
												</p>
											</a>
										</li>
									</ul>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('parttimer/ploatingPoskerja') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Ploting
												</p>
											</a>
										</li>
									</ul>
									<ul class="nav nav-treeview" hidden>
										<li class="nav-item">
											<a href="{{ url('parttimer/resumept') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Resume Ploting
												</p>
											</a>
										</li>
									</ul>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('parttimer/kebutuhanPoskerja') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Resume Ploting
												</p>
											</a>
										</li>
									</ul>
								</li>
								<!-- kehadiran -->
								{% if session.bo_user_jab_id != '1100' %}
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Kehadiran
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('parttimer/lapkehadiran') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Kehadiran Harian
												</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('parttimer/rinciantahunan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Kehadiran Bulanan
												</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('parttimer/laptahunan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Kehadiran Tahunan
												</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('parttimer/department') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Pengeluaran Dept
												</p>
											</a>
										</li>
									</ul>
								</li>
								<!-- ishoma -->
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Ishoma
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('ishomaemp/daftarfpid') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Ishoma Masuk</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('ishomaemp/monitorishoma') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Monitor Ishoma
												</p>
											</a>
										</li>
									</ul>
								</li>
								<!-- lembur -->
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Lembur
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										{% if Helpers.getSessionValue('bo_user_jab_id') == '3400' OR
										Helpers.getSessionValue('bo_user_jab_id') == '3000' OR Helpers.getSessionValue('bo_user_jab_id') ==
										'9000' %}
										<li class="nav-item">
											<a href="{{ url('parttimer/inputLembur') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Input Lembur
												</p>
											</a>
										</li>
										{% endif %}
										{%if session.bo_user_jab_id != '1000' %}
										<li class="nav-item">
											<a href="{{ url('parttimer/acclembur') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Daftar Lembur
												</p>
											</a>
										</li>
										{% endif %}
										<li class="nav-item">
											<a href="{{ url('parttimer/rekaplembur') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Rekap Lembur
												</p>
											</a>
										</li>
									</ul>
								</li>
								<!-- gaji -->
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Gaji Parttimer
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('parttimer/gaji_na') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Gaji Parttimer NA</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('parttimer/gaji_ul') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Gaji Parttimer UL</p>
											</a>
										</li>
									</ul>
								</li>
								{% if session.bo_user_level in ['STAFF','KABAG'] %}
								<!-- pengeluaran -->
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Pengeluaran
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										{%if session.bo_user_jab_id != '1000' %}
										<li class="nav-item">
											<a href="{{ url('parttimer/daftarpengeluaran') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Daftar Pengeluaran
												</p>
											</a>
										</li>
										{% endif %}
										<li class="nav-item">
											<a href="{{ url('parttimer/rekappengeluaran') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Rekap Pengeluaran
												</p>
											</a>
										</li>
									</ul>
								</li>
								{% endif %}
								{% endif %}
							</ul>
						</li>
						{% if session.bo_user_jab_id in ['2000', '9000'] %}
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									OS
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>

							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('gajios/rekap') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Rekap</p>
									</a>
								</li>
							</ul>
						</li>
						{% endif %}
						{% if session.bo_user_level in ['MANAGER', 'KABAG'] %}
						<!-- karyawan -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Peduli Yuk
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								
								<li class="nav-item">
									<a href="{{ url('kepedulian/resume_bulan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Resume Per Bulan
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('kepedulian/resume_tahun') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Resume Per Tahun
										</p>
									</a>
								</li>
							</ul>
						</li>
						{% endif %}
						
					</ul>
				</li>
				{% endif %}
				<div class="dropdown-dividers"></div>
				<!-- pengajuan -->
				<li class="nav-item">
					<a href="#" class="text-bold nav-link">
						<i class="nav-icon fa-solid fa-stamp"></i>
						<p>
							PENGAJUAN
							<i class="right fas fa-angle-left"></i>
							{% if session.bo_user_level in ['KABAG', 'KADIV', 'MANAGER'] %}
							<span class="badge badge-danger badge-pill right">{{ References.notifAccPeng() }}</span>
							{% endif %}
						</p>
					</a>
					<ul class="nav nav-treeview">
						{% if Helpers.getSessionValue('bo_user_level') == 'KABAG' or Helpers.getSessionValue('bo_user_level') ==
						'KADIV' %}
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Sub Department
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('subdepartment/daftar') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar</p>
									</a>
								</li>
							</ul>
						</li>
						{% endif %}
						<!-- tugas keluar -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Tugas Keluar
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								{%if session.bo_user_jab_id != '1000' %}
								<li class="nav-item">
									<a href="{{ url('tugaskeluar/pengajuan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Pengajuan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('tugaskeluar/acckepegawaian') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Acc A & K
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('tugaskeluar/proses') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Proses</p>
									</a>
								</li>
								{% endif %}
								<li class="nav-item">
									<a href="{{ url('tugaskeluar/riwayat') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Riwayat</p>
									</a>
								</li>
							</ul>
						</li>
						{% if Helpers.getSessionValue('bo_user_level') in ['KABAG', 'KADIV', 'MANAGER', 'STAFF'] %}
						<!-- cuti -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Izin & Cuti
									<i class="right fas fa-angle-left"></i>
									{% if session.bo_user_level in ['KABAG', 'KADIV', 'MANAGER'] %}
									<span class="badge badge-danger badge-pill right">{{ References.notifAccPeng()
										}}</span>
									{% endif %}
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('cuti/daftarPengajuan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Pengajuan</p>
									</a>
								</li>

								<li class="nav-item">
									<a href="{{ url('cuti/daftarAccPengajuan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Acc Pengajuan
											{% if session.bo_user_level in ['KABAG', 'KADIV', 'MANAGER'] %}
											<span class="badge badge-danger badge-pill right">{{ References.notifAccPeng()
												}}</span>
											{% endif %}
										</p>
									</a>
								</li>
								{% if session.bo_user_dept_id in ['02', '25'] %}
								<li class="nav-item">
									<a href="{{ url('cuti/daftarAccAtasan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Acc A & K
										</p>
									</a>
								</li>
								{% endif %}
								<li class="nav-item">
									<a href="{{ url('cuti/daftarkaryawan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Riwayat Per Orang</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('cuti/riwayatpertanggal') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Riwayat Per Tanggal</p>
									</a>
								</li>
							</ul>
						</li>
						<!-- lembur -->
						{% if (session.bo_user_level in ['KABAG', 'KADIV', 'MANAGER']) or session.bo_user_jab_id == '3400' %}
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Lembur
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>

							<ul class="nav nav-treeview">
								{%if session.bo_user_jab_id != '1000' %}
								<li class="nav-item">
									<a href="{{ url('spl/create_spl') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Buat SPL</p>
									</a>
								</li>
								{% endif %}
								<li class="nav-item">
									<a href="{{ url('spl/list_spl') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Daftar SPL
										</p>
									</a>
								</li>
							</ul>

						</li>
						{% endif %}
						{% endif %}
						<!-- pinjaman -->
						{% if Helpers.getSessionValue('bo_user_jab_id') == '9000' %}
						<li class="nav-item" hidden>
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<!-- <i class="nav-icon fas fa-calendar-times"></i> -->
								<p>
									Pinjaman *
									<i class="right fas fa-angle-left"></i>
									<!-- notification -->
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('pinjaman/pengajuan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Pengajuan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pinjaman/daftarPengajuan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Acc Pengajuan
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pinjaman/daftarManager') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Acc Manager
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pinjaman/daftarAccAtasan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Acc A & K
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pinjaman/daftarAngsuran') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Angsuran</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pinjaman/laporanAngsuran') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Laporan Angsuran</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pinjaman/daftarAccAdm') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Acc Keuangan
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pinjaman/bukuAngsuran') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Buku Angsuran</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pinjaman/riwayat') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Riwayat</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pinjaman/batasPinjaman') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Batasan Pinjaman</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pinjaman/saldoDanaPinjaman') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Saldo Dana Pinjaman</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pinjaman/pengajuanOs') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Pengajuan OS</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Input Riwayat
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('pinjaman/inputRiwayatPinjaman') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Karyawan</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('pinjaman/inputRiwayatPinjamanOs') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Outsourching</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
						</li>
						{% endif %}
						{% if Helpers.getSessionValue('bo_user_level') in ['KABAG', 'KADIV', 'MANAGER', 'SECURITY'] %}
						<!-- proyek -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Proyek
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								{% if session.bo_user_level != 'SECURITY' %}
								{% if session.bo_user_level == 'KABAG' %}
								<li class="nav-item">
									<a href="{{ url('proyek/inputbarukb') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Proyek Baru
										</p>
									</a>
								</li>
								{% endif %}
								{% if session.bo_user_level == 'KADIV' %}
								<li class="nav-item">
									<a href="{{ url('proyek/inputbaru') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Proyek Baru
										</p>
									</a>
								</li>
								{% endif %}
								<li class="nav-item">
									<a href="{{ url('proyek/pengajuankadiv') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Pengajuan Kadiv
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('proyek/pengajuankabag') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Pengajuan Kabag
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('proyek/penilaianproyek') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Penilaian
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('proyek/proyekPrioritas') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Prioritas
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('proyek/pengajuanrab') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											RAB Kadiv
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('proyek/pengajuanrabkb') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											RAB Kabag
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('proyek/proyekacc') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											ACC Manager
										</p>
									</a>
								</li>
								{% endif %}
								<li class="nav-item">
									<a href="{{ url('proyek/proyekjalan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Jalan
										</p>
									</a>
								</li>
								{% if session.bo_user_level != 'SECURITY' %}
								<li class="nav-item">
									<a href="{{ url('proyek/laporanproyek') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Laporan
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('proyek/proyekselesai') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Selesai
										</p>
									</a>
								</li>
								{% if session.bo_user_jab_id != '1000' %}
								<li class="nav-item">
									<a href="{{ url('barangproyek/seluruhbarangproyek') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Daftar Barang
										</p>
									</a>
								</li>
								<!-- kedatangan barang -->
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Kedatangan Barang
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('barangproyek/rencanakedatangan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Rencana kedatangan</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('barangproyek/realkedatangan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Real Kedatangan</p>
											</a>
										</li>
									</ul>
								</li>
								{% endif %}
								{% endif %}
							</ul>
						</li>
						{% endif %}
						{% if (Helpers.getSessionValue('bo_user_level') in ['KABAG', 'KADIV', 'MANAGER']) OR
						(Helpers.getSessionValue('bo_user_dept_id') in ['27']) %}
						<!-- ikan -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<!-- <i class="nav-icon fas fa-calendar-times"></i> -->
								<p>
									Ikan
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								{% if session.bo_user_jab_id != '1000' %}
								<li class="nav-item">
									<a href="{{ url('pengajuanikan/penjualanikan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Penjualan Ikan</p>
									</a>
								</li>

								<li class="nav-item">
									<a href="{{ url('pengajuanikan/daftarpengajuan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Pengajuan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanikan/daftaracckabag') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Acc Kabag
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanikan/sudahdidatangkan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Sudah Datang
										</p>
									</a>
								</li>
								{% endif %}
								<!-- rekap -->
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Rekap
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('pengajuanikan/rekapbulanan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Per Bulan</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('pengajuanikan/rekapperjenis') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Per Jenis Ikan</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
						</li>
						<!-- online -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Online
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								{% if Helpers.getSessionValue('bo_user_jab_id') != '7000' %}
								<li class="nav-item">
									<a href="{{ url('pengajuanonline/pengajuankadiv') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Pengajuan Kadiv</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanonline/tidakacckabag') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Ditolak Kabag</p>
									</a>
								</li>
								{% endif %}
								<li class="nav-item">
									<a href="{{ url('pengajuanonline/pengajuankabag') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Pengajuan Kabag</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanonline/tidakaccmanager') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Ditolak Manager
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanonline/proses') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											ACC Manager
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanonline/sudahdibelanjakan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Sudah Dibelanjakan
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanonline/rekapbulanan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Rekap Bulanan
										</p>
									</a>
								</li>
								<!-- rekap -->
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Rekap
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('pengajuanonline/seluruhpembelanjaan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Seluruh Pembelanjaan</p>
											</a>
										</li>

										<li class="nav-item">
											<a href="{{ url('pengajuanonline/rekapperbagian') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Per Department</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('pengajuanonline/pospengeluaran') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Pos Pengeluaran</p>
											</a>
										</li>
										{% if session.bo_user_jab_id == 9000 %}
										<li class="nav-item">
											<a href="{{ url('pengajuanonline/rekap_proyek') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Rekap Proyek</p>
											</a>
										</li>
										{% endif %}
									</ul>
								</li>
							</ul>
						</li>
						<!-- pertamanan -->
						{% if session.bo_user_jab_id != '1000' %}
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Pertamanan
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('pengajuanprt/pengajuan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Pengajuan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanprt/acckabag') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Acc Kabag
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanprt/accadmin') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Sudah Dibelanjakan
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanprt/daftarbelanja') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Laporan Belanja
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanprt/rincian') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Rincian Pengeluaran
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanprt/rekap') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Rekap Pengeluaran
										</p>
									</a>
								</li>
							</ul>
						</li>
						<!-- PLS -->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									PLS
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('pengajuanpls/pengajuan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Pengajuan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanpls/acckabag') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Acc Kabag
										</p>
									</a>
								</li>


								<li class="nav-item">
									<a href="{{ url('pengajuanpls/accadmin') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Sudah Dibelanjakan
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanpls/daftarbelanja') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Laporan Belanja
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanpls/rincian') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Rincian Pengeluaran
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanpls/rekap') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Rekap Pengeluaran
										</p>
									</a>
								</li>

							</ul>
						</li>
						{% endif %}
						{% endif %}
						{% if (Helpers.getSessionValue('bo_user_level') in ['KABAG', 'KADIV', 'MANAGER', 'STAFF']) OR
						(Helpers.getSessionValue('bo_user_dept_id') in ['18', '19','27','25']) %}
						{% if (Helpers.getSessionValue('bo_user_level') in ['KABAG', 'KADIV', 'MANAGER']) OR
						(Helpers.getSessionValue('bo_user_dept_id') in ['18', '19','27', '25']) %}
						<!-- gudang sudah tidak digunakan-->
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Gudang
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								{% if session.bo_user_jab_id != '1000' %}
								<li class="nav-item">
									<a href="{{ url('pengajuangudangv2/daftarbarang') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Barang
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuangudangv2/pengajuankoordinator') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Pengajuan Koordinator</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuangudangv2/pembelanjaan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Pembelanjaan
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuangudangv2/sudahdibelanjakan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Sudah Datang
										</p>
									</a>
								</li>
								{% endif %}
								<!-- rekap -->
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Rekap Belanja
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('pengajuangudangv2/rekapharian') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Per Hari</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('pengajuangudangv2/rekapbulanan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Per Bulan</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('pengajuangudangv2/rekaptahunan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Per Tahun</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('gudang/index') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Rekap Qty</p>
											</a>
										</li>
									</ul>
								</li>
								<!-- riwayat -->
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Riwayat
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('pengajuangudangv2/riwayatgudangumum') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Belanja GU</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('pengajuangudangv2/riwayatgbr') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Belanja GBR</p>
											</a>
										</li>
									</ul>
								</li>
								{% if (Helpers.getSessionValue('bo_user_dept_id') in ['27', '19']) OR
								(Helpers.getSessionValue('bo_user_jab_id') in ['9000', '1000']) %}
								<!-- grafik harga -->
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Grafik Harga
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('perbandingangudang/grafikgi') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Harga Ikan</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('perbandingangudang/grafikgbr') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Harga GBR</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('perbandingangudang/grafikgu') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Harga GU</p>
											</a>
										</li>
									</ul>
								</li>
								<!-- grafik qty-->
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Grafik Qty
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('perbandingangudang/pembeliangi') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Qty Ikan</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('perbandingangudang/pembeliangbr') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Qty GBR</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('perbandingangudang/pembeliangu') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Qty GU</p>
											</a>
										</li>
									</ul>
								</li>
								<!-- grafik Pembelanjaan-->
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Grafik Belanja
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('perbandingangudang/beligi') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Belanja Ikan</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('perbandingangudang/beligbr') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Belanja GBR</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('perbandingangudang/beligu') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Belanja GU</p>
											</a>
										</li>
									</ul>
								</li>
								{% endif %}
							</ul>
						</li>
						{% endif %}
						<!-- keluar masuk gudang umum sudah tidak digunakan-->
						<!-- ikan -->
						{% if (session.bo_user_level in ['KOORDINATOR']) and (session.bo_user_dept_id in ['19']) %}
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<!-- <i class="nav-icon fas fa-calendar-times"></i> -->
								<p>
									Ikan
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								{% if session.bo_user_jab_id != '1000' %}
								<li class="nav-item">
									<a href="{{ url('pengajuanikan/penjualanikan2') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Penjualan Ikan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanikan/daftarpengajuan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Pengajuan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanikan/daftaracckabag') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Acc Kabag
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('pengajuanikan/sudahdidatangkan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Sudah Datang
										</p>
									</a>
								</li>
								{% endif %}
								<!-- rekap -->
								<li class="nav-item">
									<a href="#" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Rekap
											<i class="right fas fa-angle-left"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('pengajuanikan/rekapbulanan') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Per Bulan</p>
											</a>
										</li>
										<li class="nav-item">
											<a href="{{ url('pengajuanikan/rekapperjenis') }}" class="nav-link">
												<i class="ri-git-commit-line far nav-icon"></i>
												<p>Per Jenis Ikan</p>
											</a>
										</li>
									</ul>
								</li>
							</ul>
						</li>
						{% endif %}
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Keluar Masuk GU
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('baranggudangv2/daftarbarang') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Barang</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('baranggudangv2/daftarpermintaanlp') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Permintaan Lapangan</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('baranggudangv2/daftarpermintaan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Permintaan</p>
									</a>
								</li>
								{% if (Helpers.getSessionValue('bo_user_level') in ['KABAG', 'KADIV', 'MANAGER']) OR
								(Helpers.getSessionValue('bo_user_dept_id') in ['18', '19','27', '25']) %}
								<li class="nav-item">
									<a href="{{ url('baranggudangv2/rekapbulanan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Rekap Bulanan
										</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('gudang/pemakaiangu') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Rekap Tahunan
										</p>
									</a>
								</li>
								{% if Helpers.getSessionValue('bo_user_level') in ['KABAG', 'KADIV', 'MANAGER', 'STAFF'] %}
								<li class="nav-item">
									<a href="{{ url('gudang/allgu') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											All Out GU
										</p>
									</a>
								</li>
								{% endif %}
								{% endif %}
								<li class="nav-item">
									<a href="{{ url('baranggudangv2/riwayat') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Riwayat
										</p>
									</a>
								</li>
								{% if Helpers.getSessionValue('bo_user_level') in ['KABAG', 'KADIV', 'MANAGER'] %}
								<li class="nav-item">
									<a href="{{ url('baranggudangv2/pospengeluaran') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>
											Pos Pengeluaran *
										</p>
									</a>
								</li>
								{% endif %}

							</ul>
						</li>
						{% endif %}
					</ul>
				</li>
				{% if (session.bo_user_dept_id != '03') or (session.bo_user_level != 'STAFF')%}
				{% if (session.bo_user_jab_id != 1100)%}
				<div class="dropdown-dividers"></div>
				<!-- laporan -->
				<li class="nav-item">
					<a href="#" class="text-bold nav-link">
						<i class="nav-icon fa-solid fa-layer-group"></i>
						<p>
							LAPORAN
							<i class="right fas fa-angle-left"></i>
						</p>
					</a>
					<ul class="nav nav-treeview">
						{% if (Helpers.getSessionValue('bo_user_dept_id') in ['02']) OR
						(Helpers.getSessionValue('bo_user_jab_id') in ['9000', '1000']) %}
						<div class="dropdown-divider"></div>
						<!-- menu a & k -->
						<div class="">
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-building-columns nav-icon" aria-hidden="true"></i>
									<p>
										A & K
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									<!-- inventaris aset -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Inventaris Aset
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												{% if Helpers.getSessionValue('bo_user_dept_id') in ['02'] %}
												<li class="nav-item">
													<a href="{{ url('inventarisaset/input_aset') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Input Aset
														</p>
													</a>
												</li>
												{% endif %}
												<li class="nav-item">
													<a href="{{ url('inventarisaset/daftar_aset') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Daftar Aset
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Pembelian
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('inventarisaset/pembelian_bulanan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Bulanan</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('inventarisaset/pembelian_tahunan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Tahunan</p>
															</a>
														</li>
													</ul>
												</li>
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Penggantian
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('inventarisaset/ganti_bulanan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Bulanan</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('inventarisaset/ganti_tahunan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Tahunan</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('inventarisaset/ganti_biaya') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Biaya</p>
															</a>
														</li>
													</ul>
												</li>
											</ul>
										</li>
									</div>
									<!-- pengeluaran rutin -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Pengeluaran Rutin
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												{% if session.bo_user_jab_id != '1000' %}
												<li class="nav-item">
													<a href="{{ url('pengeluaranrutin/daftar_pengeluaran') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Daftar Pengeluaran</p>
													</a>
												</li>
												{% endif %}
												<li class="nav-item">
													<a href="{{ url('pengeluaranrutin/riwayat') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Riwayat
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('pengeluaranrutin/rekap') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekap
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<!-- resume pengeluaran -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Resume Laporan
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('resume/resumelaporan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Seluruh Pengeluaran</p>
													</a>
												</li>
												{% if session.bo_user_jab_id not in ['1000', '3000'] %}
												<li class="nav-item">
													<a href="{{ url('resume/resumestaffumum') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Staff U Umum
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('resume/resumestaffparttimer') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Staff U Parttimer
														</p>
													</a>
												</li>
												{% endif %}
											</ul>
										</li>
									</div>
								</ul>
							</li>
						</div>
						{% endif %}
						{% if (Helpers.getSessionValue('bo_user_dept_id') in ['27']) OR
						(Helpers.getSessionValue('bo_user_jab_id') in ['9000', '1000']) %}
						<div class="dropdown-divider"></div>
						<!-- menu purchasing -->
						<div class="">
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-building-columns nav-icon" aria-hidden="true"></i>
									<p>
										PURCHASING
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Rencana Belanja
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('perencanaanbelanja/daftarbarang') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Daftar Belanja</p>
													</a>
												</li>

											</ul>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('perencanaanbelanja/tempatbelanja') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Tempat Belanja</p>
													</a>
												</li>

											</ul>

										</li>
									</div>

									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Suplier
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('suplier/daftarsuplier') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Daftar Suplier</p>
													</a>
												</li>

											</ul>
										</li>
									</div>
									<!-- pengeluaran rutin -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Pengeluaran Rutin
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('pengeluaranrutin/daftar_pengeluaran2') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Daftar Pengeluaran</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('pengeluaranrutin/riwayat2') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Riwayat
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('pengeluaranrutin/rekap2') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekap
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<!-- resume pengeluaran -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Resume Laporan
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('resume/resumelaporan2') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Seluruh Pengeluaran</p>
													</a>
												</li>
												{% if session.bo_user_jab_id not in ['1000'] %}
												<li class="nav-item">
													<a href="{{ url('resume/resumestaffpurchasing') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Staff U Purchasing
														</p>
													</a>
												</li>
												{% endif %}
											</ul>
										</li>
									</div>
									<!-- resume pengeluaran -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Label Barang
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('labelbarang/daftar_label') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Daftar Label</p>
													</a>
												</li>
												{% if session.bo_user_jab_id not in ['1000'] %}
												<li class="nav-item">
													<a href="{{ url('labelbarang/tagging') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Tagging
														</p>
													</a>
												</li>
												{% endif %}
											</ul>
										</li>
									</div>
								</ul>
							</li>
						</div>
						{% endif %}
						{% if (Helpers.getSessionValue('bo_user_dept_id') in ['11']) OR (Helpers.getSessionValue('bo_user_jab_id')
						in
						['9000', '1000', '3000','3400', '2000']) %}
						<div class="dropdown-divider"></div>
						<!-- menu security -->
						<div class="">
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-building-columns nav-icon" aria-hidden="true"></i>
									<p>
										HAPPY KEEPER
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									<!-- jadwal security -->
									<div class="menu-security">
										<!-- presensi -->
										{% if session.bo_user_level != 'UNIT' %}
										{% if (session.bo_user_dept_id == '11') or (session.bo_user_jab_id == '9000') %}
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Presensi
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('presensiscr/downloadPresensi') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Masuk</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('presensiscr/pulang') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Keluar</p>
													</a>
												</li>
											</ul>
										</li>
										{% endif %}
										{% endif %}
										{% if Helpers.getSessionValue('bo_user_jab_id') not in ['3400', '3000', '2000'] %}
										<!-- jadwal security -->
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Jadwal
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<!-- jadwal masuk -->
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Jadwal Masuk
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														{% if session.bo_user_jab_id in ['9000', '7000'] %}
														<li class="nav-item">
															<a href="{{ url('jadwalsecurity/input_jadwal') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Input Jadwal
																</p>
															</a>
														</li>
														{% endif %}
														<li class="nav-item">
															<a href="{{ url('jadwalsecurity/jadwal_masuk') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Jadwal Masuk
																</p>
															</a>
														</li>
														{% if session.bo_user_jab_id in ['9000', '7000'] %}
														<li class="nav-item">
															<a href="{{ url('jadwalsecurity/daftar_security') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Daftar
																</p>
															</a>
														</li>
														{% endif %}
													</ul>
												</li>
											</ul>
											<!-- jadwal patroli -->
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Jadwal Patroli
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('patrolisecurity/patroliPagi') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Patroli Pagi
																</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('patrolisecurity/patroliMalam') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Patroli Malam
																</p>
															</a>
														</li>

													</ul>
												</li>
											</ul>
										</li>
										{% if session.bo_user_level != 'UNIT' %}
										<!-- patroli security-->
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Patroli
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('patrolisecurity/laporanPatroli') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Daftar Laporan</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('patrolisecurity/resumePatroli') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Resume Check Point
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('patrolisecurity/rekapPatroli') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekap Patroli
														</p>
													</a>
												</li>
											</ul>
										</li>
										<!-- jurnal security -->
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Jurnal
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												{% if session.bo_user_jab_id != '1000' %}
												<li class="nav-item">
													<a href="{{ url('jurnalsecurity/input_jurnal') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Input Jurnal</p>
													</a>
												</li>
												{% endif %}
												<li class="nav-item">
													<a href="{{ url('jurnalsecurity/daftar_jurnal') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Daftar Jurnal
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('jurnalsecurity/rekap_jurnal') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekap Jurnal
														</p>
													</a>
												</li>
											</ul>
										</li>
										{% endif %}
										<!-- tiket parkir -->
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Tiket Parkir
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('tiketparkir/rekap') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Rekap</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Resume
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('tiketparkir/resumeHarian') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Harian
																</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('tiketparkir/resumeBulanan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Bulanan
																</p>
															</a>
														</li>
													</ul>
												</li>
												<li class="nav-item">
													<a href="{{ url('tiketparkir/rincian') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rincian
														</p>
													</a>
												</li>
											</ul>
										</li>
										<div class="">
											<li class="nav-item">
												<a href="#" class="nav-link">
													<i class="far fa-dot-circle nav-icon"></i>
													<p>
														Valet Parkir
														<i class="right fas fa-angle-left"></i>
													</p>
												</a>
												<ul class="nav nav-treeview">

													<li class="nav-item">
														<a href="{{ url('valet/riwayat') }}" class="nav-link">
															<i class="far fa-circle nav-icon"></i>
															<p>
																Riwayat
															</p>
														</a>
													</li>


												</ul>
											</li>
										</div>

										{% if session.bo_user_level != 'UNIT' %}
										<!-- setoran parkir -->
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Setoran Parkir
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('setoranparkir/daftar_setoran') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Daftar Setoran</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('setoranparkir/diterima_kasir') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Diterima Kasir
														</p>
													</a>
												</li>
											</ul>
										</li>
										{% if session.bo_user_jab_id != '1000' %}
										<!-- kedatangan barang -->
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Kedatangan Barang
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<!-- gi -->
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															GI
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('kedatanganbarang/rencana_gi') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Rencana Kedatangan
																</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('kedatanganbarang/realisasi_gi') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Realisasi Kedatangan
																</p>
															</a>
														</li>
													</ul>
												</li>
												<!-- gu -->
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															GU
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('kedatanganbarang/rencana_gu') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Rencana Kedatangan
																</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('kedatanganbarang/realisasi_gu') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Realisasi Kedatangan
																</p>
															</a>
														</li>
													</ul>
												</li>
												<!-- gbr -->
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															GBR
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('kedatanganbarang/rencana_gbr') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Rencana Kedatangan
																</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('kedatanganbarang/realisasi_gbr') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Realisasi Kedatangan
																</p>
															</a>
														</li>
													</ul>
												</li>
												<!-- pls -->
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															PLS
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('kedatanganbarang/rencana_pls') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Rencana Kedatangan
																</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('kedatanganbarang/realisasi_pls') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Realisasi Kedatangan
																</p>
															</a>
														</li>
													</ul>
												</li>
												<!-- pertamanan -->
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Pertamanan
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('kedatanganbarang/rencana_pertamanan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Rencana Kedatangan
																</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('kedatanganbarang/realisasi_pertamanan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Realisasi Kedatangan
																</p>
															</a>
														</li>
													</ul>
												</li>
												<!-- TODO proyek -->
												<li class="nav-item" hidden>
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Proyek
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('kedatanganbarang/rencana_proyek') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Rencana Kedatangan
																</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('kedatanganbarang/realisasi_proyek') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Realisasi Kedatangan
																</p>
															</a>
														</li>
													</ul>
												</li>
												<!-- non gudang -->
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Non Gudang
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('kedatanganbarang/rencana_non_gudang') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Rencana Kedatangan
																</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('kedatanganbarang/realisasi_non_gudang') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Realisasi Kedatangan
																</p>
															</a>
														</li>
													</ul>
												</li>
												<!-- lain-lain -->
												<li class="nav-item">
													<a href="{{ url('kedatanganbarang/lain_lain') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Lain-lain
														</p>
													</a>
												</li>
											</ul>
										</li>
										{% endif %}
										{% endif %}
										{% endif %}
										<div class="dropdown-divider"></div>
									</div>
									<!-- pelanggaran -->
									{% if session.bo_user_level != 'UNIT' %}
									{% if session.bo_user_jab_id != '1000' %}
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Pelanggaran
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												{% if session.bo_user_dept_id == '11' or session.bo_user_jab_id == '9000' %}
												<li class="nav-item">
													<a href="{{ url('pelanggaran/input_pelanggaran') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Input Pelanggaran</p>
													</a>
												</li>
												{% endif %}
												<li class="nav-item">
													<a href="{{ url('pelanggaran/belumdiberisanksi') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Daftar Pelanggaran</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('pelanggaran/seluruhpelanggaran') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Riwayat Pelanggaran</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('pelanggaran/rekap') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Rekap Per Karyawan</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									{% endif %}
									{% if Helpers.getSessionValue('bo_user_jab_id') not in ['3400'] %}
									<!-- empati security-->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Empati
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('empatisecurity/daftar_kegiatan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Daftar Kegiatan</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('empatisecurity/daftar_empati') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Daftar Empati
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('empatisecurity/resume_empati') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Resume Empati
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									{% endif %}
									<!-- bonus security -->
									{% if (session.bo_user_level in ['MANAGER','KABAG']) or (session.bo_user_jab_id == '7000') %}
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Bonus
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('bonussecurity/ketetapan_bonus') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Ketetapan Bonus
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('bonussecurity/bonus') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Peringkat & Bonus
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									{% endif %}
									{% endif %}
								</ul>
							</li>
						</div>
						{% endif %}
						{% if (Helpers.getSessionValue('bo_user_dept_id') in ['19', '25']) OR
						(Helpers.getSessionValue('bo_user_jab_id') in
						['9000', '1000']) %}
						<div class="dropdown-divider"></div>
						<!-- menu giu -->
						<div class="">
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-building-columns nav-icon" aria-hidden="true"></i>
									<p>
										GIU
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									{% if Helpers.getSessionValue('bo_user_jab_id') in
									['9000'] %}
									<!-- stock opname GU -->
									<div class="">
										<li class="nav-item">
											<a href="{{ url('gudangumum/stockOpname') }}" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Stock Opname GU
												</p>
											</a>
										</li>
									</div>
									{% endif %}
									<!-- ikan tidak layak  -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Ikan Tidak Layak
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('ikantidaklayak/index') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Daftar Tidak Layak</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('ikantidaklayak/rekapTidakLayak') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekap Tidak Layak
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Persentase
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('ikantidaklayak/persentasePerbulan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Perbulan
																</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('ikantidaklayak/persentasePertahun') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Pertahun
																</p>
															</a>
														</li>
													</ul>
												</li>
											</ul>
										</li>
									</div>
									<!-- ikan prioritas  -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Ikan Prioritas
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('ikanprioritas/index') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Daftar Prioritas
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekap Prioritas
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('ikanprioritas/rekapPerbulan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Perbulan
																</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('ikanprioritas/rekapPertahun') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>
																	Pertahun
																</p>
															</a>
														</li>
													</ul>
												</li>
											</ul>
										</li>
									</div>
								</ul>
							</li>
						</div>
						{% endif %}
						{% if (Helpers.getSessionValue('bo_user_dept_id') in
						['18', '19', '25']) or (Helpers.getSessionValue('bo_user_jab_id') in
						['9000', '6400', '1000']) %}
						<div class="dropdown-divider"></div>
						<!-- menu gbpr -->
						<div class="">
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-building-columns nav-icon" aria-hidden="true"></i>
									<p>
										GBR
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									{% if (Helpers.getSessionValue('bo_user_dept_id') in
									['18', '19', '25']) %}
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Estimasi 45 Item
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('estgbr/statushari') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Status Hari</p>
													</a>
												</li>
											</ul>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('estgbr/ketetapan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Ketetapan</p>
													</a>
												</li>
											</ul>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('estgbr/bumburesto') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Bumbu Resto</p>
													</a>
												</li>
											</ul>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('estgbr/opname') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Stock Opname</p>
													</a>
												</li>
											</ul>

											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('estgbr/rekap') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Kebutuhan Bahan</p>
													</a>
												</li>
											</ul>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('estgbr/rekaptahunan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Kebutuhan Tahunan</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									{% endif %}
									<!-- keluar masuk gbr  -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Bahan Keluar
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												{% if Helpers.getSessionValue('bo_user_dept_id') in
												['25', '18', '19'] %}
												<li class="nav-item">
													<a href="{{ url('gbpr/inputbahankeluar') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Input Keluar
														</p>
													</a>
												</li>
												{% endif %}
												{% if session.bo_user_jab_id != '1000' %}
												<li class="nav-item">
													<a href="{{ url('gbpr/bahankeluar') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>P. Bahan</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('gbpr/paketankeluar') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															P. Paketan
														</p>
													</a>
												</li>
												{% endif %}
												<li class="nav-item">
													<a href="{{ url('gbpr/rincianpermintaan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rincian Permintaan
														</p>
													</a>
												</li>
												<li class="nav-item" hidden>
													<a href="{{ url('gbpr/rekappermintaan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekap Bulanan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('gbpr/rekaptahunan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekap Tahunan
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<!-- Bahan Busuk  -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Bahan Busuk
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('gbpr/bahanbusuk') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekap Busuk
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('gbpr/prosentasebusuk') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Prosentase Busuk
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<!-- menu control -->
									{% if session.bo_user_jab_id != '1000' %}
									<div class="">
										<li class="nav-item">
											<a href="{{ url('gbpr/menukontrol') }}" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Menu Control
												</p>
											</a>
										</li>
									</div>
									{% endif %}
									<!-- ketetapan paketan -->
									<div class="">
										<li class="nav-item">
											<a href="{{ url('gbpr/ketetapanpaketan') }}" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Daftar Paketan
												</p>
											</a>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Ikan Terbul
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('ikanterangbulan/pengajuan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekap Inputan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('ikanterangbulan/resume') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Resume
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
								</ul>
							</li>
						</div>
						{% endif %}
						{% if (Helpers.getSessionValue('bo_user_dept_id') in
						['10']) or (Helpers.getSessionValue('bo_user_jab_id') in
						['9000', '6000', '1000']) %}
						<div class="dropdown-divider"></div>
						<!-- kebersihan -->
						<div class="">
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-building-columns nav-icon" aria-hidden="true"></i>
									<p>
										KEBERSIHAN
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									<!-- general cleaning  -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													General Cleaning
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												{% if Helpers.getSessionValue('bo_user_dept_id') in
												['10'] %}
												<li class="nav-item">
													<a href="{{ url('generalcleaning/inputpengecekan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Input Pengecekan</p>
													</a>
												</li>
												{% endif %}
												<li class="nav-item">
													<a href="{{ url('generalcleaning/daftarpengecekan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Daftar Pengecekan</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('generalcleaning/laporanperawatan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Laporan Perawatan
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
								</ul>
							</li>
						</div>
						{% endif %}
						{% if (Helpers.getSessionValue('bo_user_dept_id') in
						['14', '16']) or (Helpers.getSessionValue('bo_user_jab_id') in
						['9000', '6000']) %}
						<div class="dropdown-divider"></div>
						<!-- perawatan dan perbaikan -->
						<div class="">
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-building-columns nav-icon" aria-hidden="true"></i>
									<p>
										PP
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									<!-- inventaris pp -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Inventaris PP
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('pp/daftarinventaris') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Daftar Inventaris</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('pp/jadwalpenggantian') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Jadwal Penggantian</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('pp/daftarpenyusutan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Daftar Penyusutan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('pp/inventarisrusak') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Daftar Rusak
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<!-- perbaikan pp -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Perbaikan PP
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('pp/agendaperbaikan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Agenda Perbaikan</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('pp/realisasiperbaikan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Realisasi Perbaikan</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<!-- perawatan pp -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Perawatan PP
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('pp/agendaperawatan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Agenda Perawatan</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('pp/realisasiperawatan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Realisasi Perawatan</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<!--  -->
								</ul>
							</li>
						</div>
						{% endif %}
						{% if (Helpers.getSessionValue('bo_user_dept_id') in
						['25']) or (Helpers.getSessionValue('bo_user_jab_id') ==
						'9000') %}
						<div class="dropdown-divider"></div>
						<!-- Urusan Hardware -->
						<div class="">
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-building-columns nav-icon" aria-hidden="true"></i>
									<p>
										LITBANG
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									<!-- inventaris hardware -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Inventaris Hardware
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('urusanhardware/daftarinventaris') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Daftar Inventaris</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('urusanhardware/jadwalpenggantian') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Jadwal Penggantian</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('urusanhardware/daftarpenyusutan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Daftar Penyusutan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('urusanhardware/inventarisrusak') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Daftar Rusak
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<!-- perawatan hardware -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Perawatan Hardware
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('urusanhardware/agendaperawatan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Agenda Perawatan</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('urusanhardware/realisasiperawatan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Realisasi Perawatan</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<!-- Management Printer -->
									<div class="">
										<li class="nav-item">
											<a href="{{ url('urusanhardware/management_printer') }}" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Management Printer
													{# <i class="right fas fa-angle-left"></i> #}
												</p>
											</a>
										</li>
									</div>
									<!-- Management IP -->
									<div class="">
										<li class="nav-item">
											<a href="{{ url('urusanhardware/management_ip_address') }}" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													IP Address
												</p>
											</a>
										</li>
									</div>
									<!-- Management Access Point -->
									<div class="">
										<li class="nav-item">
											<a href="{{ url('urusanhardware/management_access_point') }}" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Access Point
												</p>
											</a>
										</li>
									</div>
								</ul>
							</li>
						</div>
						{% endif %}

						{% if (Helpers.getSessionValue('bo_user_dept_id') in
						['07']) or (Helpers.getSessionValue('bo_user_jab_id') in
						['9000', '5000']) %}
						<div class="dropdown-divider"></div>
						<!-- taman dino -->
						<div class="">
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-building-columns nav-icon" aria-hidden="true"></i>
									<p>
										PERMAINAN
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Taman Dino
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<!-- kolam djeguria -->
												<div class="">
													<li class="nav-item">
														<a href="{{ url('djeguria/ceklapangan') }}" class="nav-link">
															<i class="far fa-circle nav-icon"></i>
															<p>
																Kolam Djeguria
																<i class="right fas fa-angle-left"></i>
															</p>
														</a>
														<ul class="nav nav-treeview">
															<li class="nav-item">
																<a href="{{ url('djeguria/ceklapangan') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Petugas</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('djeguria/cekkadiv') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kadiv</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('djeguria/cekkabag') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kabag</p>
																</a>
															</li>
														</ul>
													</li>
												</div>
												<!-- target shooting -->
												<div class="">
													<li class="nav-item">
														<a href="#" class="nav-link">
															<i class="far fa-circle nav-icon"></i>
															<p>
																Target Shooting
																<i class="right fas fa-angle-left"></i>
															</p>
														</a>
														<ul class="nav nav-treeview">
															<li class="nav-item">
																<a href="{{ url('targetshooting/ceklapangan') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Petugas</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('targetshooting/cekkadiv') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kadiv</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('targetshooting/cekkabag') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kabag</p>
																</a>
															</li>
														</ul>
													</li>
												</div>
												<!-- ember tumpah -->
												<div class="">
													<li class="nav-item">
														<a href="#" class="nav-link">
															<i class="far fa-circle nav-icon"></i>
															<p>
																Ember Tumpah
																<i class="right fas fa-angle-left"></i>
															</p>
														</a>
														<ul class="nav nav-treeview">
															<li class="nav-item">
																<a href="{{ url('ember/ceklapangan') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Petugas</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('ember/cekkadiv') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kadiv</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('ember/cekkabag') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kabag</p>
																</a>
															</li>
														</ul>
													</li>
												</div>
												<!-- ff td -->
												<div class="">
													<li class="nav-item">
														<a href="#" class="nav-link">
															<i class="far fa-circle nav-icon"></i>
															<p>
																Flying Fox TD
																<i class="right fas fa-angle-left"></i>
															</p>
														</a>
														<ul class="nav nav-treeview">
															<li class="nav-item">
																<a href="{{ url('dino/ceklapangan') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Petugas</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('dino/cekkadiv') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kadiv</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('dino/cekkabag') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kabag</p>
																</a>
															</li>
														</ul>
													</li>
												</div>
												<!-- kolam renang -->
												<div class="">
													<li class="nav-item">
														<a href="#" class="nav-link">
															<i class="far fa-circle nav-icon"></i>
															<p>
																Kolam Renang
																<i class="right fas fa-angle-left"></i>
															</p>
														</a>
														<ul class="nav nav-treeview">
															<li class="nav-item">
																<a href="{{ url('renang/ceklapangan') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Petugas</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('renang/cekkadiv') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kadiv</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('renang/cekkabag') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kabag</p>
																</a>
															</li>
														</ul>
													</li>
												</div>
												<!-- show center -->
												<div class="">
													<li class="nav-item">
														<a href="#" class="nav-link">
															<i class="far fa-circle nav-icon"></i>
															<p>
																Show Center
																<i class="right fas fa-angle-left"></i>
															</p>
														</a>
														<ul class="nav nav-treeview">
															<li class="nav-item">
																<a href="{{ url('center/ceklapangan') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Petugas</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('center/cekkadiv') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kadiv</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('center/cekkabag') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kabag</p>
																</a>
															</li>
														</ul>
													</li>
												</div>
												<!-- terapi ikan -->
												<div class="">
													<li class="nav-item">
														<a href="#" class="nav-link">
															<i class="far fa-circle nav-icon"></i>
															<p>
																Terapi Ikan
																<i class="right fas fa-angle-left"></i>
															</p>
														</a>
														<ul class="nav nav-treeview">
															<li class="nav-item">
																<a href="{{ url('terapi/ceklapangan') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Petugas</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('terapi/cekkadiv') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kadiv</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('terapi/cekkabag') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kabag</p>
																</a>
															</li>
														</ul>
													</li>
												</div>
												<!-- kereta mini -->
												<div class="">
													<li class="nav-item">
														<a href="#" class="nav-link">
															<i class="far fa-circle nav-icon"></i>
															<p>
																Kereta Mini
																<i class="right fas fa-angle-left"></i>
															</p>
														</a>
														<ul class="nav nav-treeview">
															<li class="nav-item">
																<a href="{{ url('kereta/ceklapangan') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Petugas</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('kereta/cekkadiv') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kadiv</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('kereta/cekkabag') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kabag</p>
																</a>
															</li>
														</ul>
													</li>
												</div>
												<!-- mobil kecil -->
												<div class="">
													<li class="nav-item">
														<a href="#" class="nav-link">
															<i class="far fa-circle nav-icon"></i>
															<p>
																Mobil Kecil
																<i class="right fas fa-angle-left"></i>
															</p>
														</a>
														<ul class="nav nav-treeview">
															<li class="nav-item">
																<a href="{{ url('mocil/ceklapangan') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Petugas</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('mocil/cekkadiv') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kadiv</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('mocil/cekkabag') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kabag</p>
																</a>
															</li>
														</ul>
													</li>
												</div>
												<!-- otoped -->
												<div class="">
													<li class="nav-item">
														<a href="#" class="nav-link">
															<i class="far fa-circle nav-icon"></i>
															<p>
																Otoped
																<i class="right fas fa-angle-left"></i>
															</p>
														</a>
														<ul class="nav nav-treeview">
															<li class="nav-item">
																<a href="{{ url('otoped/ceklapangan') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Petugas</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('otoped/cekkadiv') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kadiv</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('otoped/cekkabag') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kabag</p>
																</a>
															</li>
														</ul>
													</li>
												</div>
												<!-- omah kayu -->
												<div class="">
													<li class="nav-item">
														<a href="#" class="nav-link">
															<i class="far fa-circle nav-icon"></i>
															<p>
																Omah Kayu
																<i class="right fas fa-angle-left"></i>
															</p>
														</a>
														<ul class="nav nav-treeview">
															<li class="nav-item">
																<a href="{{ url('kayu/ceklapangan') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Petugas</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('kayu/cekkadiv') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kadiv</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('kayu/cekkabag') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kabag</p>
																</a>
															</li>
														</ul>
													</li>
												</div>
												<!-- Omah Playon -->
												<div class="">
													<li class="nav-item">
														<a href="#" class="nav-link">
															<i class="far fa-circle nav-icon"></i>
															<p>
																Omah Playon
																<i class="right fas fa-angle-left"></i>
															</p>
														</a>
														<ul class="nav nav-treeview">
															<li class="nav-item">
																<a href="{{ url('omah/ceklapangan') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Petugas</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('omah/cekkadiv') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kadiv</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('omah/cekkabag') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kabag</p>
																</a>
															</li>
														</ul>
													</li>
												</div>
												<!-- audio publik -->
												<div class="">
													<li class="nav-item">
														<a href="#" class="nav-link">
															<i class="far fa-circle nav-icon"></i>
															<p>
																Audio Publik
																<i class="right fas fa-angle-left"></i>
															</p>
														</a>
														<ul class="nav nav-treeview">
															<li class="nav-item">
																<a href="{{ url('audio/ceklapangan') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Petugas</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('audio/cekkadiv') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kadiv</p>
																</a>
															</li>
															<li class="nav-item">
																<a href="{{ url('audio/cekkabag') }}" class="nav-link">
																	<i class="ri-git-commit-line far nav-icon"></i>
																	<p>Pengecekan Kabag</p>
																</a>
															</li>
														</ul>
													</li>
												</div>
											</ul>
										</li>
									</div>
									<!-- wahana outbound -->
									{% if session.bo_user_jab_id != '1000' %}
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Outbound
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<!-- ff jungle -->
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Flying Fox Jungle
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('wahana/ceklapangan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Petugas</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('wahana/cekkadiv') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kadiv</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('wahana/cekkabag') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kabag</p>
															</a>
														</li>
													</ul>
												</li>
												<!-- floating ball -->
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Floating Ball
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('floating/ceklapangan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Petugas</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('floating/cekkadiv') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kadiv</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('floating/cekkabag') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kabag</p>
															</a>
														</li>
													</ul>
												</li>
												<!-- Mini Boat -->
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Mini Boat
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('miniboat/ceklapangan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Petugas</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('miniboat/cekkadiv') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kadiv</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('miniboat/cekkabag') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kabag</p>
															</a>
														</li>
													</ul>
												</li>
												<!-- ATV -->
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															ATV
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('atv/ceklapangan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Petugas</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('atv/cekkadiv') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kadiv</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('atv/cekkabag') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kabag</p>
															</a>
														</li>
													</ul>
												</li>
												<!-- Kuda Tunggang -->
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Kuda Tunggang
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('berkuda/ceklapangan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Petugas</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('berkuda/cekkadiv') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kadiv</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('berkuda/cekkabag') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kabag</p>
															</a>
														</li>
													</ul>
												</li>
												<!-- Bungee Trampoline -->
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Bungee Trampoline
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('trampoline/ceklapangan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Petugas</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('trampoline/cekkadiv') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kadiv</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('trampoline/cekkabag') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kabag</p>
															</a>
														</li>
													</ul>
												</li>
												<!-- Fun Game -->
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Fun Game
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('fungame/ceklapangan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Petugas</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('fungame/cekkadiv') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kadiv</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('fungame/cekkabag') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kabag</p>
															</a>
														</li>
													</ul>
												</li>
												<!-- Paintball -->
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Paintball
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('paintball/ceklapangan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Petugas</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('paintball/cekkadiv') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kadiv</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('paintball/cekkabag') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kabag</p>
															</a>
														</li>
													</ul>
												</li>
												<!-- Becak -->
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Becak
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('becak/ceklapangan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Petugas</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('becak/cekkadiv') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kadiv</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('becak/cekkabag') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kabag</p>
															</a>
														</li>
													</ul>
												</li>
												<!-- Omah Playon -->
												<li class="nav-item" hidden>
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Omah Playon
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('omah/ceklapangan') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Petugas</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('omah/cekkadiv') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kadiv</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('omah/cekkabag') }}" class="nav-link">
																<i class="ri-git-commit-line far nav-icon"></i>
																<p>Pengecekan Kabag</p>
															</a>
														</li>
													</ul>
												</li>
											</ul>
										</li>
									</div>
									{% endif %}
									<!-- ikan pancing -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Ikan Pancing
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												{% if session.bo_user_jab_id != '1000' %}
												<!-- daftar pengajuan -->
												<li class="nav-item">
													<a href="{{ url('ikanpancing/daftarpengajuan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Daftar Pengajuan
														</p>
													</a>
												</li>
												<!-- acc kabag -->
												<li class="nav-item">
													<a href="{{ url('ikanpancing/daftaracc') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															ACC Kabag
														</p>
													</a>
												</li>
												<!-- kedatangan ikan -->
												<li class="nav-item">
													<a href="{{ url('ikanpancing/kedatanganikan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Qty Ikan Datang
														</p>
													</a>
												</li>
												<!-- kematian ikan -->
												<li class="nav-item">
													<a href="{{ url('ikanpancing/rekapkematianikan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Qty Ikan Mati
														</p>
													</a>
												</li>
												{% endif %}
												<!-- Penjualan Ikan -->
												<li class="nav-item">
													<a href="{{ url('ikanpancing/penjualanikan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Qty Ikan Terjual
														</p>
													</a>
												</li>
												<!-- Pemasukan Ikan -->
												<li class="nav-item">
													<a href="{{ url('ikanpancing/pemasukanikan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Lap Pemasukan
														</p>
													</a>
												</li>
												<!-- Pengeluaran Ikan -->
												<li class="nav-item">
													<a href="{{ url('ikanpancing/pengeluaranikan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Lap Pengeluaran
														</p>
													</a>
												</li>
												<!-- Laporan Ikan Pancing -->
												<li class="nav-item">
													<a href="{{ url('ikanpancing/laporanbulanan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Laporan Bulanan
														</p>
													</a>
												</li>
												<!-- Qty Keluar Masuk -->
												<li class="nav-item">
													<a href="{{ url('ikanpancing/stok_ikan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Qty Keluar Masuk
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
								</ul>
							</li>
						</div>
						{% endif %}

						{% if (Helpers.getSessionValue('bo_user_dept_id') in
						['15']) or (Helpers.getSessionValue('bo_user_jab_id') in
						['9000', '1000', '5000']) %}
						<div class="dropdown-divider"></div>
						<!-- pertamanan -->
						<div class="">
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-building-columns nav-icon" aria-hidden="true"></i>
									<p>
										PERTAMANAN
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									{% if session.bo_user_jab_id != '1000' %}
									<!-- pendapatan pertamanan -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Pendapatan
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('laporanprt/rincianpendapatan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Rincian Pendapatan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('laporanprt/rekappendapatan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Rekap Pendapatan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('laporanprt/disetorkankasir') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Disetorkan Kasir
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									{% endif %}
									<!-- laporan dana -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Laporan Dana
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('laporanprt/laporandanabulanan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Bulanan</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('laporanprt/laporandanatahunan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Tahunan</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<!-- Usaha -->
									<div class="">
										<li class="nav-item">
											<a href="{{ url('laporanprt/daftar_usaha') }}" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Daftar Usaha
												</p>
											</a>
										</li>
									</div>
								</ul>
							</li>
						</div>
						{% endif %}
						{% if (Helpers.getSessionValue('bo_user_dept_id') in ['21']) or (Helpers.getSessionValue('bo_user_jab_id')
						in ['9000', '1000', '5000']) %}
						<div class="dropdown-divider"></div>
						<!-- pls -->
						<div class="">
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-building-columns nav-icon" aria-hidden="true"></i>
									<p>
										PLS
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									{% if session.bo_user_jab_id != '1000' %}
									<!-- pendapatan pls -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Pendapatan
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('laporanpls/rincianpendapatan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Rincian Pendapatan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('laporanpls/rekappendapatan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Rekap Pendapatan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('laporanpls/disetorkankasir') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Disetorkan Kasir
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									{% endif %}
									<!-- laporan dana -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Laporan Dana
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('laporanpls/laporandanabulanan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Bulanan</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('laporanpls/laporandanatahunan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Tahunan</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<!-- Usaha -->
									<div class="">
										<li class="nav-item">
											<a href="{{ url('laporanpls/daftar_usaha') }}" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Daftar Usaha
												</p>
											</a>
										</li>
									</div>
								</ul>
							</li>
						</div>
						{% endif %}
						{% if (Helpers.getSessionValue('bo_user_dept_id') in ['01']) or (Helpers.getSessionValue('bo_user_jab_id')
						in ['9000']) %}
						<div class="dropdown-divider"></div>
						<!-- kasir -->
						<div class="">
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-building-columns nav-icon" aria-hidden="true"></i>
									<p>
										KASIR
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									{% if session.bo_user_jab_id != '1000' %}
									<!-- reservation -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Reservations
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('kasir/reservasidp') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Reservasi DP</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('kasir/laporandp') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Laporan DP</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									{% endif %}
									<!-- transaksi kasir -->
									{% if Helpers.getSessionValue('bo_user_jab_id') in ['9000', '1000', '2000'] %}
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Transaksi Kasir
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('kasir/daftartransaksi') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Daftar Transaksi</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('kasir/rekaprestoran') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>Rekap Restoran</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									{% endif %}
									<!-- pendapatan -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Pendapatan
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															PLS
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('kasir/rincianpendapatanpls') }}" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>Rincian Pendapatan</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('kasir/rinciansetoranpls') }}" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>Rincian Setoran</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('kasir/riwayatsetoranpls') }}" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>Riwayat Setoran</p>
															</a>
														</li>
													</ul>
												</li>
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Pertamanan
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('kasir/rincianpendapatanprt') }}" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>Rincian Pendapatan</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('kasir/rinciansetoranprt') }}" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>Rincian Setoran</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('kasir/riwayatsetoranprt') }}" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>Riwayat Setoran</p>
															</a>
														</li>
													</ul>
												</li>
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Other Income
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('othinc/rincianothinc') }}" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>Rincian Othinc</p>
															</a>
														</li>
													</ul>
												</li>
											</ul>
										</li>
									</div>
									<!-- Setoran Tiket -->
									<div class="">
										<li class="nav-item">
											<a href="{{ url('setorantiket/hari') }}" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Setoran Tiket
													{# <i class="right fas fa-angle-left"></i> #}
												</p>
											</a>
											{# <ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('setorantiket/hari') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Per Hari
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('setorantiket/bulan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Per Bulan
														</p>
													</a>
												</li>
											</ul> #}
										</li>
									</div>
									<!-- pajak -->
									{% if Helpers.getSessionValue('bo_user_jab_id') in ['9000', '1000', '2000'] %}
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Pajak Restoran
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															All Transaksi
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('kasir/alltransaksiharian') }}" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>Harian</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('kasir/alltransaksibulanan') }}" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>Bulanan</p>
															</a>
														</li>
													</ul>
												</li>
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Transaksi RB
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item" hidden>
															<a href="{{ url('kasir/transaksirbharian') }}" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>Harian</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('kasir/transaksirbbulanan') }}" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>Bulanan</p>
															</a>
														</li>
													</ul>
												</li>
											</ul>
										</li>
									</div>
									<!-- Pendapatan Parkir -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Pendapatan Parkir
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('kasir/danaparkirbelumdisetorkan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Belum Disetorkan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('kasir/rekappendapatanparkir') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekap Pendapatan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('kasir/daftarpengeluaranparkir') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Daftar Pengeluaran
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('kasir/rekaptahunan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Saldo
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									{% endif %}
								</ul>
							</li>
						</div>
						{% if session.bo_user_jab_id != '1000' %}
						<div class="dropdown-divider"></div>
						<!-- toko & souvenir -->
						<div class="">
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-building-columns nav-icon" aria-hidden="true"></i>
									<p>
										TOKO
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									<div class="">
										<li class="nav-item">
											<a href="{{ url('toko/daftarbarang') }}" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Daftar Barang
												</p>
											</a>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="{{ url('toko/barangretur') }}" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Barang Retur
												</p>
											</a>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="{{ url('toko/laporanpemasukan') }}" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Pemasukan Lain
												</p>
											</a>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Pengeluaran Lain
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('toko/pengeluaranbahanbaku') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Bahan Baku
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('toko/pengeluaranbarangfree') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Barang Free
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Transaksi Pembelian
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('toko/pembelianpertanggal') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Pertanggal
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('toko/pembelianperbarang') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Perbarang
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Transaksi Penjualan
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('toko/penjualanpertanggal') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Pertanggal
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('toko/penjualanperbarang') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Perbarang
														</p>
													</a>
												</li>
												{% if session.bo_user_jab_id in [9000, 2000] %}
												<li class="nav-item">
													<a href="{{ url('toko/penjualanperkelompok') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Perkelompok
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('toko/penjualanpertahun') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Pertahun
														</p>
													</a>
												</li>
												{% endif %}
											</ul>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Setoran
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('toko/setoranharian') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Harian
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('toko/setoranbulanan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Bulanan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('toko/setorantahunan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Tahunan
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Laporan Toko
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('toko/laporanbulanan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Bulanan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('toko/rekaptabungan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekap Tabungan
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
								</ul>
							</li>
						</div>
						{% endif %}
						{% endif %}

						{% if session.bo_user_level in ['MANAGER','KABAG'] %}
						<div class="dropdown-divider"></div>
						<!-- kenangan baru -->
						<div class="">
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-building-columns nav-icon" aria-hidden="true"></i>
									<p>
										KEUANGAN
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									<!-- laporan keuangan -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Laba Rugi
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('labarugi/bulanan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Bulanan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('labarugi/tahunan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Tahunan
														</p>
													</a>
												</li>
												{% if Helpers.getSessionValue('bo_user_jab_id') in ['9000', '2000'] %}
												<li class="nav-item">
													<a href="{{ url('labarugi/rekap') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekap Bulanan
														</p>
													</a>
												</li>
												{% endif %}
												<li class="nav-item">
													<a href="{{ url('labarugi/resumebulanan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Resume Bulanan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('labarugi/resumetahunan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Resume Tahunan
														</p>
													</a>
												</li>
												{% if Helpers.getSessionValue('bo_user_jab_id') in ['9000', '1000'] %}
												<li class="nav-item">
													<a href="{{ url('labarugi/grafikpemasukan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Grafik Perbandingan
														</p>
													</a>
												</li>
												{% endif %}
											</ul>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Dana Tabungan
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												{% if Helpers.getSessionValue('bo_user_jab_id') in ['9000', '2000'] %}
												<li class="nav-item">
													<a href="{{ url('tabungan/addtabungan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Input Tabungan
														</p>
													</a>
												</li>
												{% endif %}
												<li class="nav-item">
													<a href="{{ url('tabungan/rekening') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekening Tabungan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('tabungan/rekaptabungan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rincian Tabungan
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Penyusutan
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('penyusutan/penyusutan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekening Penyusutan
														</p>
													</a>
												</li>
											</ul>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('penyusutan/rincian') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rincian Penyusutan
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Rekening Pajak
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('pajak/rekening') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekening Tagihan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('pajak/tagihan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rincian Tagihan
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Dana Taktis
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('danataktis/rekening') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekening Dana
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('danataktis/rekapDanaTaktis') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rincian Dana
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Pemasukan
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('pendapatan/pemasukanlain') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Pemasukan Lain
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('pendapatan/pemasukan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Resume Pemasukan
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Pengeluaran Lain
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('pengeluaranlain/rincian') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rincian Pengeluaran
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('pengeluaranlain/rekap') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekap Pengeluaran
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Tunjangan Khusus
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('tunjangankhusus/rekap') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekap Tunjangan
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Bonus Efisiensi
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('rekeningbonusv2/resumepenilaian') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Resume Penilaian
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('rekeningbonusv2/rekapbonusmasuk') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Resume Dana Masuk
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('rekeningbonusv2/rekapbonuskeluar') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Resume Dana Keluar
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('rekeningbonusv2/resumebonusv2') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekening Bonus
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<!-- penyisihan gaji -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Penyisihan Gaji
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<!-- daftar penyisihan -->
												<li class="nav-item">
													<a href="{{ url('penyisihangaji/penyisihan_daftar') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Ketetapan Penyisihan
														</p>
													</a>
												</li>
												<!-- input penyisihan -->
												<li class="nav-item">
													<a href="{{ url('penyisihangaji/penyisihan_input') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Input Penyisihan
														</p>
													</a>
												</li>
												<!-- rincian penyisihan -->
												<li class="nav-item">
													<a href="{{ url('penyisihangaji/penyisihan_resume') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rincian Penyisihan
														</p>
													</a>
												</li>
												<!-- rekening penyisihan -->
												<li class="nav-item">
													<a href="{{ url('penyisihangaji/penyisihan_rekening') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekening Penyisihan
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									{% if session.bo_user_jab_id in [9000] %}
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Donasi Kasir
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Pendapatan
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('donasi/harian') }}" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>
																	Harian
																</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('donasi/bulanan') }}" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>
																	Bulanan
																</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('donasi/tahunan') }}" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>
																	Tahunan
																</p>
															</a>
														</li>
													</ul>
												</li>
											</ul>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekening
															<i class="right fas fa-angle-left"></i>
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="{{ url('donasi/rekening') }}" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>
																	Rekening Donasi
																</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="{{ url('donasi/pengeluaran') }}" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>
																	Rincian
																</p>
															</a>
														</li>
													</ul>
												</li>
											</ul>

										</li>
									</div>
									{% endif %}
								</ul>
							</li>
						</div>
						<div class="dropdown-divider"></div>
						{% endif %}
						{% if (session.bo_user_dept_id in ['23', '02']) or (session.bo_user_level in ['KABAG', 'MANAGER']) %}
						<!-- digital marketing -->
						<div class="">
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-building-columns nav-icon" aria-hidden="true"></i>
									<p>
										KREASI & PROMOSI
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<!-- Ensiklopedia -->
								<ul class="nav nav-treeview">
									<li class="nav-item has-treeview">
										<a href="#" class="nav-link">
											<i class="far fa-dot-circle nav-icon"></i>
											<p>
												Ensiklopedia
												<i class="fas fa-angle-left right"></i>
											</p>
										</a>
										<ul class="nav nav-treeview">
											<li class="nav-item">
												<a href="{{ url('ensiklopedia/satwa') }}" class="nav-link">
													<i class="far fa-circle nav-icon"></i>
													<p>Satwa</p>
												</a>
											</li>
											<li class="nav-item">
												<a href="{{ url('ensiklopedia/tanaman') }}" class="nav-link">
													<i class="far fa-circle nav-icon"></i>
													<p>Tanaman</p>
												</a>
											</li>
											<li class="nav-item">
												<a href="{{ url('ensiklopedia/wahana') }}" class="nav-link">
													<i class="far fa-circle nav-icon"></i>
													<p>Wahana</p>
												</a>
											</li>
											<li class="nav-item">
												<a href="{{ url('ensiklopedia/fun_game') }}" class="nav-link">
													<i class="far fa-circle nav-icon"></i>
													<p>Fun Game</p>
												</a>
											</li>
											<li class="nav-item">
												<a href="{{ url('ensiklopedia/jenis_masakan') }}" class="nav-link">
													<i class="far fa-circle nav-icon"></i>
													<p>Jenis Masakan</p>
												</a>
											</li>
											<li class="nav-item">
												<a href="{{ url('ensiklopedia/menu_ikan') }}" class="nav-link">
													<i class="far fa-circle nav-icon"></i>
													<p>Menu Ikan</p>
												</a>
											</li>
											<li class="nav-item">
												<a href="{{ url('ensiklopedia/menu_non_ikan') }}" class="nav-link">
													<i class="far fa-circle nav-icon"></i>
													<p>Menu Non Ikan</p>
												</a>
											</li>
											<li class="nav-item">
												<a href="{{ url('ensiklopedia/fasilitas') }}" class="nav-link">
													<i class="far fa-circle nav-icon"></i>
													<p>Fasilitas</p>
												</a>
											</li>
										</ul>
									</li>
									{% if session.bo_user_jab_id in [9000] %}
									<li class="nav-item" hidden>
										<a href="{{ url('trxjual') }}" class="nav-link">
											<i class="far fa-circle-dot nav-icon"></i>
											<p>Sync Data Trx Jual</p>
										</a>
									</li>
									{% endif %}
								</ul>
								<!-- rekening promosi -->
								<ul class="nav nav-treeview">
									<li class="nav-item">
										<a href="#" class="nav-link">
											<i class="far fa-dot-circle nav-icon"></i>
											<p>
												Rekening Promosi
												<i class="right fas fa-angle-left"></i>
											</p>
										</a>
										<ul class="nav nav-treeview">
											<li class="nav-item">
												<a href="#" class="nav-link">
													<i class="far fa-circle nav-icon"></i>
													<p>
														Event Promosi
														<i class="right fas fa-angle-left"></i>
													</p>
												</a>
												<ul class="nav nav-treeview">
													<li class="nav-item">
														<a href="{{ url('rekeningpromosi/rekap') }}" class="nav-link">
															<i class="far ri-git-commit-line nav-icon"></i>
															<p>
																Daftar Event
															</p>
														</a>
													</li>
													<li class="nav-item">
														<a href="{{ url('rekeningpromosi/resume') }}" class="nav-link">
															<i class="far ri-git-commit-line nav-icon"></i>
															<p>
																Resume Event
															</p>
														</a>
													</li>
												</ul>
											</li>
										</ul>
										<ul class="nav nav-treeview">
											<li class="nav-item">
												<a href="#" class="nav-link">
													<i class="far fa-circle nav-icon"></i>
													<p>
														Anggaran Promosi
														<i class="right fas fa-angle-left"></i>
													</p>
												</a>
												<ul class="nav nav-treeview">
													<li class="nav-item">
														<a href="{{ url('rekeningpromosi/cash_flow_dana') }}" class="nav-link">
															<i class="far ri-git-commit-line nav-icon"></i>
															<p>
																Cash Flow
															</p>
														</a>
													</li>
													<li class="nav-item">
														<a href="{{ url('rekeningpromosi/cash_flow_anggaran') }}" class="nav-link">
															<i class="far ri-git-commit-line nav-icon"></i>
															<p>
																Rincian
															</p>
														</a>
													</li>
													<li class="nav-item">
														<a href="{{ url('rekeningpromosi/cash_flow_rekap') }}" class="nav-link">
															<i class="far ri-git-commit-line nav-icon"></i>
															<p>
																Resume
															</p>
														</a>
													</li>
												</ul>
											</li>
										</ul>
									</li>
								</ul>
							</li>
						</div>
						{% endif %}
						{% if session.bo_user_level in ['MANAGER', 'KABAG', 'KADIV'] %}
						<div class="dropdown-divider"></div>
						<!-- Tapping Box -->
						<div class="">
							<li class="nav-item">
								<a href="#" class="nav-link">
									<i class="fas fa-building-columns nav-icon" aria-hidden="true"></i>
									<p>
										OTHER
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									{% if session.bo_user_level in ['MANAGER', 'KABAG'] %}
									<!-- target pendapatan -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Target Pendapatan
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('targetpendapatan/realisasi') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Realisasi
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<!-- target tahunan -->
									<div class="">
										<li class="nav-item" hidden>
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Target Tahunan
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="#" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Target Department
														</p>
													</a>
													<ul class="nav nav-treeview">
														<li class="nav-item">
															<a href="#" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>
																	Daftar Target
																</p>
															</a>
														</li>
														<li class="nav-item">
															<a href="#" class="nav-link">
																<i class="far ri-git-commit-line nav-icon"></i>
																<p>
																	Target Umum
																</p>
															</a>
														</li>
													</ul>
												</li>
											</ul>
										</li>
									</div>
									{% endif %}
									{% if session.bo_user_level in ['MANAGER','KABAG', 'KADIV'] %}
									<!-- pengeluaran department -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Pengeluaran Dept
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>

											<ul class="nav nav-treeview">
												{% if session.bo_user_level in ['KADIV'] %}
												<li class="nav-item">
													<a href="{{ url('pengeluarandept/rinciankadiv') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rincian Pengeluaran
														</p>
													</a>
												</li>
												<li class="nav-item" hidden>
													<a href="{{ url('pengeluarandept/resumekadiv') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Resume Pengeluaran *
														</p>
													</a>
												</li>
												{% endif %}
												{% if session.bo_user_level in ['MANAGER','KABAG'] %}
												<li class="nav-item">
													<a href="{{ url('anggarandept/anggarandept') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Anggaran Dept
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('anggarandept/resumeanggaran') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Resume Anggaran
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('pengeluarandept/rinciankabag') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Pengeluaran Dept
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('pengeluarandept/resumekabag') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Resume Pengeluaran
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('anggarandept/sisaanggaran') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Sisa Anggaran Dept
														</p>
													</a>
												</li>
												{% endif %}

											</ul>
										</li>
									</div>
									{% endif %}
									{% if session.bo_user_level in ['MANAGER','KABAG'] %}
									<!-- pengeluaran na -->
									{% if session.bo_user_jab_id in [9000, 1000, 2000] %}

									{% endif %}
									<!-- usulan gaji -->
									<div class="">
										<li class="nav-item">
											<a href="{{ url('usulangaji/daftarusulan') }}" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Usulan Gaji
												</p>
											</a>
										</li>
									</div>
									<!-- monitor box -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Monitor Box
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<!-- pengaturan device aktif -->
												<li class="nav-item">
													<a href="{{ url('settingdevice/index') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Setting Device
														</p>
													</a>
												</li>
												<!-- data taping mulai okt 2024 -->
												<li class="nav-item" hidden>
													<a href="{{ url('monitorbox/box') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Box Mulai Okt 2024
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('monitorbox/resume') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Resume
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('monitorbox/harianbox') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekap Harian Box
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('monitorbox/rincianbox') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rincian Box
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									{% endif %}
									{% if session.bo_user_level in ['MANAGER', 'KABAG', 'KADIV'] %}
									<!-- rekening bagaian -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-dot-circle nav-icon"></i>
												<p>
													Rekening Bagian
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<!-- rekap anggaran -->
												{% if session.bo_user_jab_id in [9000, 1000, 2000] %}
												<!-- hak akses developer, manager & kabag keuangan -->
												<li class="nav-item">
													<a href="{{ url('rekeningbagian/anggaran') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Rekap Anggaran
														</p>
													</a>
												</li>
												{% endif %}
												<!-- pemasukan -->
												<li class="nav-item">
													<a href="{{ url('rekeningbagian/cash_flow') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Transfer Dana
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('rekeningbagian/saldo_bagian_v2') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Saldo Bagian
														</p>
													</a>
												</li>
												<!-- Saldo manager -->
												{% if session.bo_user_level in ['MANAGER'] %}
												<li class="nav-item">
													<a href="{{ url('rekeningbagian/saldo_manager') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Saldo Penyusutan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('rekeningbagian/dana_cadangan') }}" class="nav-link">
														<i class="far fa-circle nav-icon"></i>
														<p>
															Dana Cadangan
														</p>
													</a>
												</li>
												{% endif %}
											</ul>
										</li>
									</div>
									<!-- rekening promosi -->
									{% endif %}
								</ul>
							</li>
						</div>
						{% endif %}
					</ul>
				</li>
				{% endif %}
				{% endif %}
				<div class="dropdown-dividers"></div>
				{% if session.bo_user_level in ['MANAGER', 'KABAG'] %}
				<!-- prediksi omZet -->
				<li class="nav-item">
					<a href="#" class="text-bold nav-link">
						<i class="nav-icon fa-solid fa-chart-line"></i>
						<p>
							PREDIKSI OMZET
							<i class="right fas fa-angle-left"></i>
						</p>
					</a>
					<ul class="nav nav-treeview">
						<div class="">
							<li class="nav-item">
								<a href="{{ url('average/prediksi_realisasi') }}" class="nav-link">
									<i class="far fa-dot-circle nav-icon"></i>
									<p>
										Per Thn Lalu
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									<!-- prediksi status -->
									<div class="">
										<li class="nav-item">
											<a href="{{ url('average/prediksiOmset2') }}" class="nav-link">
												<i class="far fa-circle nav-icon"></i>
												<p>P. Omzet Bulanan</p>
											</a>
										</li>
									</div>
									<!-- prediksi omzet -->
									<div class="">
										<li class="nav-item">
											<a href="{{ url('average/prediksiOmset') }}" class="nav-link">
												<i class="far fa-circle nav-icon"></i>
												<p>P. Omzet Tahunan</p>
											</a>
										</li>
									</div>
									<!-- prediksi laba rugi -->
									<div class="" hidden>
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-circle nav-icon"></i>
												<p>
													Prediksi Laba Rugi
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<li class="nav-item">
													<a href="{{ url('prediksi/labarugi') }}" class="nav-link">
														<i class="far ri-git-commit-line nav-icon"></i>
														<p>
															Resume Prediksi LR
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('prediksi/rincian') }}" class="nav-link">
														<i class="far ri-git-commit-line nav-icon"></i>
														<p>
															Rincian Prediksi LR
														</p>
													</a>
												</li>
												{% if session.bo_user_jab_id != 1000 %}
												<li class="nav-item">
													<a href="{{ url('prediksi/inputpemasukan') }}" class="nav-link">
														<i class="far ri-git-commit-line nav-icon"></i>
														<p>
															Pemasukan
														</p>
													</a>
												</li>
												<li class="nav-item">
													<a href="{{ url('prediksi/inputpengeluaran') }}" class="nav-link">
														<i class="far ri-git-commit-line nav-icon"></i>
														<p>
															Pengeluaran
														</p>
													</a>
												</li>
												{% endif %}
											</ul>
										</li>
									</div>
								</ul>
							</li>
						</div>
						<!-- 2025 -->
						<div class="" hidden>
							<li class="nav-item">
								<a href="{{ url('average/prediksi_realisasi') }}" class="nav-link">
									<i class="far fa-dot-circle nav-icon"></i>
									<p>
										Per Thn 2025
										<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									<div class="">
										<li class="nav-item">
											<a href="{{ url('prediksiv2/prediksi_realisasi') }}" class="nav-link">
												<i class="far fa-circle nav-icon"></i>
												<p>P. Status Baru</p>
											</a>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="{{ url('prediksiv2/prediksiOmset2') }}" class="nav-link">
												<i class="far fa-circle nav-icon"></i>
												<p>P. Omzet Bulanan</p>
											</a>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="{{ url('prediksiv2/prediksiOmset') }}" class="nav-link">
												<i class="far fa-circle nav-icon"></i>
												<p>P. Omzet Tahunan
												</p>
											</a>
										</li>
									</div>
									<div class="">
										<li class="nav-item">
											<a href="{{ url('prediksiv2/resumeprediksi') }}" class="nav-link">
												<i class="far fa-circle nav-icon"></i>
												<p>Awal VS Baru</p>
											</a>
										</li>
									</div>
								</ul>
							</li>
						</div>
					</ul>
				</li>
				{% endif %}
				{% if (session.bo_user_level in ['MANAGER','KABAG', 'KADIV']) or (session.bo_user_jab_id in ['8610', '1100']) %}
				<div class="dropdown-dividers"></div>
				<!-- arsip -->
				<li class="nav-item">
					<a href="#" class="text-bold nav-link">
						<i class="nav-icon fa-solid fa-box-archive"></i>
						<p>
							ARSIP
							<i class="right fas fa-angle-left"></i>
						</p>
					</a>
					<ul class="nav nav-treeview">
								{% if session.bo_user_level in ['MANAGER', 'KABAG'] %}
								<li class="nav-item has-treeview">
								<li class="nav-item has-treeview">
									<a href="#" class="nav-link">
										<i class="far fa-dot-circle nav-icon"></i>
										<p>
											AD ART
											<i class="fas fa-angle-left right"></i>
										</p>
									</a>
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('adart/index') }}" class="nav-link">
												<i class="far fa-circle nav-icon"></i>
												<p>Preview</p>
											</a>
										</li>
									</ul>
									{% if session.bo_user_jab_id == 9000 %}
									<ul class="nav nav-treeview">
										<li class="nav-item">
											<a href="{{ url('adart/penyesuaian') }}" class="nav-link">
												<i class="far fa-circle nav-icon"></i>
												<p>Penyesuaian</p>
											</a>
										</li>
									</ul>
									{% endif %}


								</li>


								</li>
								{% endif %}
						<!-- Managemen File -->
						<li class="nav-item has-treeview">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Permasalahan
									<i class="fas fa-angle-left right"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('permasalahan/daftarpermasalahan') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Permasalahan</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('permasalahan/berikansolusi') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Berikan Solusi</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('permasalahan/daftartertangani') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Sudah Ditangani</p>
									</a>
								</li>
							</ul>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('permasalahan/resume') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Resume Catatan</p>
									</a>
								</li>
							</ul>
						</li>
						<!-- Managemen File -->
						<li class="nav-item has-treeview">
							<a href="{{ url('unggah/daftarfile2') }}" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Managemen File
								</p>
							</a>
						</li>
						<!-- SK -->
						<li class="nav-item has-treeview">
							<a href="{{ url('arsip/daftarkeputusan') }}" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Surat Keputusan
								</p>
							</a>
						</li>
						<!-- catatan -->
						<li class="nav-item has-treeview">
							<a href="{{ url('arsip/daftarCatatan') }}" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Catatan
								</p>
							</a>
						</li>
						<!-- strategi -->
						<li class="nav-item has-treeview">
							<a href="{{ url('arsip/daftarStrategi') }}" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Strategi
								</p>
							</a>
						</li>
						<!-- kejadian -->
						<li class="nav-item has-treeview">
							<a href="{{ url('arsip/daftarKejadian') }}" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Kejadian
								</p>
							</a>
						</li>
						<!-- instruksi -->
						<li class="nav-item has-treeview">
							<a href="{{ url('arsip/daftarInstruksi') }}" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Instruksi
								</p>
							</a>
						</li>
						<!-- SOP -->
						<li class="nav-item has-treeview" hidden>
							<a href="{{ url('arsip/daftarSop') }}" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									SOP
								</p>
							</a>
						</li>
						<!-- job desk -->
						<li class="nav-item has-treeview" hidden>
							<a href="{{ url('arsip/daftarjobdesk') }}" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Job Desk
								</p>
							</a>
						</li>
						<!-- target departemen -->
						<li class="nav-item has-treeview">
							<a href="{{ url('target/depttarget') }}" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Target Departement
								</p>
							</a>
						</li>
					</ul>
					{% if (session.bo_user_level in ['MANAGER','KABAG', 'KADIV']) or (session.bo_user_jab_id in ['8610', '1100']) %}
					<ul class="nav nav-treeview">
						<li class="nav-item has-treeview">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Job Descriptions
									<i class="fas fa-angle-left right"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="{{ url('newjobdesk/struktur') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Gambar Struktur</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('jobdesk/kualifikasi') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Kualifikasi</p>
									</a>
								</li>
								{# <li class="nav-item">
									<a href="{{ url('newjobdesk/kualifikasi') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Kualifikasi</p>
									</a>
								</li> #}
								<li class="nav-item" hidden>
									<a href="{{ url('newjobdesk/jobdesk') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Pengajuan Jobdesc</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="{{ url('newjobdesk/daftarjobdesk') }}" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Daftar Jobdesc</p>
									</a>
								</li>
							</ul>
						</li>
					</ul>
					{% endif %}
				</li>
				<div class="dropdown-dividers"></div>
				{% if session.bo_user_level in ['MANAGER','KABAG'] %}
				<!-- developer -->
				<li class="nav-item">
					<a href="#" class="text-bold nav-link">
						<i class="nav-icon fa-solid fa-code"></i>
						<p>
							DEVELOPER
							<i class="right fas fa-angle-left"></i>
						</p>
					</a>
					{% if session.bo_user_jab_id == 9000 %}
					<ul class="nav nav-treeview">
						<li class="nav-item">
							<a href="{{ url('agendakerjalitbang') }}" class="nav-link">
								<i class="far fa-circle-dot nav-icon"></i>
								<p>Agenda Kerja Litbang</p>
							</a>
						</li>
					</ul>
					<ul class="nav nav-treeview">
						<li class="nav-item">
							<a href="{{ url('monitorbox/transaksi_resto') }}" class="nav-link">
								<i class="far fa-circle-dot nav-icon"></i>
								<p>Transaksi Resto</p>
							</a>
						</li>
					</ul>
					<ul class="nav nav-treeview">
						<li class="nav-item">
							<a href="{{ url('backup') }}" class="nav-link">
								<i class="far fa-circle-dot nav-icon"></i>
								<p>Backup Data</p>
							</a>
						</li>
					</ul>
					{% endif %}
					{% if session.bo_user_level in ['MANAGER', 'KABAG'] %}
					<ul class="nav nav-treeview">
						<li class="nav-item">
							<a href="#" class="nav-link">
								<i class="far fa-dot-circle nav-icon"></i>
								<p>
									Laporan Tahunan
									<i class="right fas fa-angle-left"></i>
								</p>
							</a>
							<ul class="nav nav-treeview">
								<div class="">
									<!-- laba rugi -->
									<li class="nav-item">
										<a href="{{ url('laporantahunan/laba_rugi') }}" class="nav-link">
											<i class="far fa-circle nav-icon"></i>
											<p>Perbandingan LR</p>
										</a>
									</li>
									<!-- tiket masuk -->
									<li class="nav-item">
										<a href="{{ url('laporantahunan/tiket_masuk') }}" class="nav-link">
											<i class="far fa-circle nav-icon"></i>
											<p>Perbandingan TM</p>
										</a>
									</li>
									<!-- langkah efisiensi -->
									<li class="nav-item">
										<a href="{{ url('laporantahunan/langkah_efisiensi') }}" class="nav-link">
											<i class="far fa-circle nav-icon"></i>
											<p>Langkah Efisiensi</p>
										</a>
									</li>
									<!-- kendala & solusi -->
									<li class="nav-item">
										<a href="{{ url('laporantahunan/kendala_dan_solusi') }}" class="nav-link">
											<i class="far fa-circle nav-icon"></i>
											<p>Kendala & Solusi</p>
										</a>
									</li>
									<!-- grafik keuangan -->
									<li class="nav-item">
										<a href="{{ url('lapporantahunan/prediksi_realisasi') }}" class="nav-link">
											<i class="far fa-circle nav-icon"></i>
											<p>
												Grafik Keuangan
												<i class="right fas fa-angle-left"></i>
											</p>
										</a>
										<ul class="nav nav-treeview">
											<div class="">
												<!-- resume tahunan -->
												<li class="nav-item">
													<a href="{{ url('laporantahunan/resume_tahunan') }}" class="nav-link">
														<i class="ri-git-commit-line far nav-icon"></i>
														<p>Resume</p>
													</a>
												</li>
												<!-- grafik tahunan -->
												<li class="nav-item">
													<a href="{{ url('laporantahunan/grafik_tahunan') }}" class="nav-link">
														<i class="ri-git-commit-line far nav-icon"></i>
														<p>Perbandingan</p>
													</a>
												</li>
											</div>
										</ul>
									</li>
									<!-- pengeluaran na -->
									<div class="">
										<li class="nav-item">
											<a href="#" class="nav-link">
												<i class="far fa-circle nav-icon"></i>
												<p>
													Pengeluaran NA
													<i class="right fas fa-angle-left"></i>
												</p>
											</a>
											<ul class="nav nav-treeview">
												<!-- pengeluaran tahunan -->
												<li class="nav-item">
													<a href="{{ url('perbandinganpengeluaran/index') }}" class="nav-link">
														<i class="ri-git-commit-line far nav-icon"></i>
														<p>
															Out Tahunan
														</p>
													</a>
												</li>
												<!-- pengeluaran bulanan -->
												<li class="nav-item">
													<a href="{{ url('perbandinganpengeluaran/bulan') }}" class="nav-link">
														<i class="ri-git-commit-line far nav-icon"></i>
														<p>
															Out Bulanan
														</p>
													</a>
												</li>
												<!-- prosentase bulanan -->
												<li class="nav-item">
													<a href="{{ url('perbandinganpengeluaran/prosen') }}" class="nav-link">
														<i class="ri-git-commit-line far nav-icon"></i>
														<p>
															Prosentase
														</p>
													</a>
												</li>
											</ul>
										</li>
									</div>
									<!-- resume pelayanan -->
									<li class="nav-item">
										<a href="{{ url('perbandinganpelayanan/index') }}" class="nav-link">
											<i class="far fa-circle nav-icon"></i>
											<p>Resume Pelayanan</p>
										</a>
									</li>
								</div>
							</ul>
						</li>
					</ul>
					{% endif %}
				</li>
				{% endif %}
				<div class="dropdown-dividers"></div>
				<!-- NOTEs akses program -->
				<li class="nav-item">
					<a href="#" class="text-bold nav-link">
						<i class="nav-icon fa-solid fa-link"></i>
						<p>
							AKSES PROGRAM
							<i class="right fas fa-angle-left"></i>
						</p>
					</a>
					<ul class="nav nav-treeview">
						<!-- na service -->
						<li class="nav-item">
							<a href="http://192.168.1.3/na_service" target="_blank" class="nav-link">
								<i class="fas fa-earth-asia nav-icon"></i>
								<p>
									NA Service
								</p>
							</a>
						</li>
						<!-- proses ikan -->
						<li class="nav-item">
							<a href="http://192.168.1.3/prosesikan" target="_blank" class="nav-link">
								<i class="fas fa-earth-asia nav-icon"></i>
								<p>
									Proses Ikan
								</p>
							</a>
						</li>
						<!-- na rating -->
						<li class="nav-item">
							<a href="http://192.168.1.3/na_rating" target="_blank" class="nav-link">
								<i class="fas fa-earth-asia nav-icon"></i>
								<p>
									NA Rating
								</p>
							</a>
						</li>
						<!-- scan note -->
						<li class="nav-item">
							<a href="{{ url('scannota') }}" target="_blank" class="nav-link">
								<i class="fas fa-earth-asia nav-icon"></i>
								<p>
									Scan Nota
								</p>
							</a>
						</li>
					</ul>
				</li>
				{% endif %}
				<div class="dropdown-divider"></div>
			</ul>
			<br><br><br><br><br>
		</nav>
		<!-- /.sidebar-menu -->
	</div>
	<!-- /.sidebar -->
</aside>

<!-- script search -->
<script>
	document.addEventListener('DOMContentLoaded', function () {
		const searchInput = document.querySelector('.form-control-sidebar');
		const searchResults = document.querySelector('.sidebar-search-results .list-group');
		const navLinks = document.querySelectorAll('.nav-link');

		searchInput.addEventListener('input', function () {
			const query = searchInput.value.toLowerCase().trim();
			searchResults.innerHTML = ''; // Clear previous results

			if (query) {
				navLinks.forEach(link => {
					const text = link.textContent.toLowerCase();
					if (text.includes(query)) {
						const resultItem = document.createElement('a');
						resultItem.href = link.href;
						resultItem.className = 'list-group-item list-group-item-action';
						resultItem.textContent = link.textContent.trim();
						searchResults.appendChild(resultItem);
					}
				});

				if (searchResults.innerHTML === '') {
					const noResults = document.createElement('div');
					noResults.className = 'list-group-item text-muted';
					noResults.textContent = 'No results found';
					searchResults.appendChild(noResults);
				}
			}
		})
	})
</script>
