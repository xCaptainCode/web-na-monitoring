<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>NA Monitoring</title>
	<!-- Tell the browser to be responsive to screen width -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Font Awesome -->
	<!-- {{ stylesheet_link("plugins/fontawesome-free/css/all.min.css") }} -->
	{{ stylesheet_link("plugins/fontawesome-free-6/css/all.min.css") }}
	<!-- CodeSeven toastr -->
	<!-- Toastr -->
	{#
	<link rel="stylesheet" href="../../../public/plugins/toastr/toastr.min.css"> #}
	{# {{ stylesheet_link("plugins/toastr/toastr.min.css") }} #}

	<!-- dari sini link sementara dimatikan agar akses lebih cepat Rabu, 04 Februari 2026 -->
	<!-- icon apps -->
	<link rel="shortcut icon" href="{{ url('dist/img/monitoring_12744110.png') }}" type="image/x-icon">
	<!-- Ionicons -->
		{# <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"> #}
	<!-- remix icon -->
		{# <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.css"> #}
	{{ stylesheet_link("plugins\RemixIcon_Fonts_v4.3.0\fonts\remixicon.css") }}

	<!-- DataTables -->
	{{ stylesheet_link("plugins/datatables-bs4/css/dataTables.bootstrap4.min.css") }}
	{{ stylesheet_link("plugins/datatables-responsive/css/responsive.bootstrap4.min.css") }}

	<!-- Tempusdominus Bbootstrap 4 -->
	{{ stylesheet_link("plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css") }}
	<!-- iCheck -->
	{{ stylesheet_link("plugins/icheck-bootstrap/icheck-bootstrap.min.css") }}

	<!-- Theme style -->
	{{ stylesheet_link("dist/css/adminlte.min.css") }}
	<!-- overlayScrollbars -->
	{{ stylesheet_link("plugins/overlayScrollbars/css/OverlayScrollbars.min.css") }}
	<!-- Daterange picker -->
	{{ stylesheet_link("plugins/daterangepicker/daterangepicker.css") }}
	<!-- summernote -->
	{{ stylesheet_link("plugins/summernote/summernote-bs4.css") }}

	<!-- Google Font: Source Sans Pro -->
	{# <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet"> #}
	<!-- Google Font: Poopins -->
	{# <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link
		href="https://fonts.googleapis.com/css2?family=Fira+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Josefin+Sans:ital,wght@0,100..700;1,100..700&family=Jost:ital,wght@0,100..900;1,100..900&family=Oxanium:wght@200..800&family=Playwrite+BE+VLG:wght@100..400&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
		rel="stylesheet"> #}
	<!-- CSS Custom -->
	{{ stylesheet_link("css/main-custom.css") }}

	<!-- jQuery -->
	{{ javascript_include("plugins/jquery/jquery.min.js") }}
	<!-- jQuery UI 1.11.4 -->
	{{ javascript_include("plugins/jquery-ui/jquery-ui.min.js") }}
	<!-- jQuery UI 1.12.4 -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
	<script>
		$.widget.bridge('uibutton', $.ui.button)
	</script>
	<!-- Bootstrap 4 -->
	{{ javascript_include("plugins/bootstrap/js/bootstrap.bundle.min.js") }}

	<!-- Sparkline -->
	<!-- {{ javascript_include("plugins/sparklines/sparkline.js") }} -->

	<!-- jQuery Knob Chart -->
	{{ javascript_include("plugins/jquery-knob/jquery.knob.min.js") }}
	<!-- daterangepicker -->
	{{ javascript_include("plugins/moment/moment.min.js") }}
	{{ javascript_include("plugins/daterangepicker/daterangepicker.js") }}

	<!-- Tempusdominus Bootstrap 4 -->
	{{ javascript_include("plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js") }}
	<!-- Summernote -->
	{{ javascript_include("plugins/summernote/summernote-bs4.min.js") }}
	<!-- overlayScrollbars -->
	{{ javascript_include("plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js") }}
	<!-- Sweetalert2 -->
	{{ javascript_include("plugins/sweetalert2/dist/sweetalert2.min.js") }}
	{{ stylesheet_link("plugins/sweetalert2/dist/sweetalert2.min.css") }}
	<!-- <link rel="stylesheet" href="../../../public/plugins/sweetalert2/style.css"> -->
		<!-- select 2 -->
		{# {{ stylesheet_link("plugins/select2-4.1.0-rc.0/dist/css/select2.min.css") }} #}
		{# {{ javascript_include("plugins/select2-4.1.0-rc.0/dist/js/select2.min.js") }} #}
		
	{{ stylesheet_link("plugins/select2/css/select2.min.css") }}
	{{ javascript_include("plugins/select2/js/select2.full.min.js") }}
	
	{{ javascript_include("plugins/select2-bootstrap4-theme/select2-bootstrap4.css") }}
	{{ javascript_include("plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css") }}
	<!-- DataTables -->
	{{ javascript_include("plugins/datatables/jquery.dataTables.min.js") }}
	{{ javascript_include("plugins/datatables-bs4/js/dataTables.bootstrap4.min.js") }}
	{{ javascript_include("plugins/datatables-responsive/js/dataTables.responsive.min.js") }}
	{{ javascript_include("plugins/datatables-responsive/js/responsive.bootstrap4.min.js") }}
	{{ javascript_include("plugins/datatables-buttons/js/dataTables.buttons.min.js") }}
	{{ javascript_include("plugins/datatables-buttons/js/buttons.bootstrap4.min.js") }}
	{{ javascript_include("plugins/datatables-buttons/js/buttons.html5.min.js") }}
	{{ javascript_include("plugins/datatables-buttons/js/buttons.print.min.js") }}
	{{ javascript_include("plugins/jszip/jszip.min.js") }}
	{{ javascript_include("plugins/pdfmake/pdfmake.min.js") }}
	{{ javascript_include("plugins/pdfmake/vfs_fonts.js") }}
	{# {{ javascript_include("plugins/datatables-buttons/js/button.colVis.min.js") }} #}

	<!-- chart -->
	{{ javascript_include("plugins/chart.js/Chart.min.js") }}

	<!-- custom file input -->
	{{ javascript_include("plugins/bs-custom-file-input/bs-custom-file-input.min.js")}}
	<!-- jQuery Knob Chart -->
	{{ javascript_include("plugins/jquery-knob/jquery.knob.min.js") }}
	<!-- AdminLTE App -->
	{{ javascript_include("dist/js/adminlte.js") }}
	<!-- phospor icon -->
	{# <script src="https://unpkg.com/@phosphor-icons/web"></script> #}
	<!-- html2pdf -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>
	<!-- html2canvas -->
	<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>


	<script type="text/javascript" language="javascript">
		function closeSpinnerModal() {
			$('#mdlsprinnerloading').on('shown.bs.modal', function (e) {
				$("#mdlsprinnerloading").modal("hide");
			});
		}
	</script>
	{{ stylesheet_link("fonts/font.css") }}
	
</head>

<style>
	* {
		font-family: Poppins, sans-serif;
	}

	#backToTop {
		display: none;
		/* Hide the button by default */
		position: fixed;
		/* tetap di posisi saat di scroll  */
		bottom: 20px;
		right: 10px;
		z-index: 99;
		/* Make sure the button is on top */
		border: none;
		/* Remove borders */
		outline: none;
		/* Remove outline */
		background-color: #555;
		/* Set a background color */
		color: white;
		/* Text color */
		padding: 5px;
		border-radius: 50px;
		height: 40px;
		width: 40px;
		opacity: 0.5;
	}

	.btn-link:hover {
		text-decoration:underline;
	}

	.my-side {
		/* display: none; */
		/* Hide the button by default */
		position: fixed;
		/* tetap di posisi saat di scroll  */
		bottom: 20px;
		left: 10px;
		z-index: 99;
		/* Make sure the button is on top */
		border: none;
		/* Remove borders */
		outline: none;
		/* Remove outline */
		background-color: #555;
		/* Set a background color */
		color: white;
		/* Text color */
		cursor: pointer;
		/* Add a mouse pointer on hover */
		padding: 5px;
		border-radius: 50px;
		height: 40px;
		width: 40px;
		opacity: 0.5;
	}

	.poppins-thin {
		font-family: "Poppins", serif;
		font-weight: 100;
		font-style: normal;
	}

	.poppins-extralight {
		font-family: "Poppins", serif;
		font-weight: 200;
		font-style: normal;
	}

	.poppins-light {
		font-family: "Poppins", serif;
		font-weight: 300;
		font-style: normal;
	}

	.poppins-regular {
		font-family: "Poppins", serif;
		font-weight: 400;
		font-style: normal;
	}

	.poppins-medium {
		font-family: "Poppins", serif;
		font-weight: 500;
		font-style: normal;
	}

	.poppins-semibold {
		font-family: "Poppins", serif;
		font-weight: 600;
		font-style: normal;
	}

	.poppins-bold {
		font-family: "Poppins", serif;
		font-weight: 700;
		font-style: normal;
	}

	.poppins-extrabold {
		font-family: "Poppins", serif;
		font-weight: 800;
		font-style: normal;
	}

	.poppins-black {
		font-family: "Poppins", serif;
		font-weight: 900;
		font-style: normal;
	}

	.poppins-thin-italic {
		font-family: "Poppins", serif;
		font-weight: 100;
		font-style: italic;
	}

	.poppins-extralight-italic {
		font-family: "Poppins", serif;
		font-weight: 200;
		font-style: italic;
	}

	.poppins-light-italic {
		font-family: "Poppins", serif;
		font-weight: 300;
		font-style: italic;
	}

	.poppins-regular-italic {
		font-family: "Poppins", serif;
		font-weight: 400;
		font-style: italic;
	}

	.poppins-medium-italic {
		font-family: "Poppins", serif;
		font-weight: 500;
		font-style: italic;
	}

	.poppins-semibold-italic {
		font-family: "Poppins", serif;
		font-weight: 600;
		font-style: italic;
	}

	.poppins-bold-italic {
		font-family: "Poppins", serif;
		font-weight: 700;
		font-style: italic;
	}

	.poppins-extrabold-italic {
		font-family: "Poppins", serif;
		font-weight: 800;
		font-style: italic;
	}

	.poppins-black-italic {
		font-family: "Poppins", serif;
		font-weight: 900;
		font-style: italic;
	}
	.form-borderless {
    border-inline: 0;
    border-top: 0;
    border-radius: 0;
  }
	.underline:hover {
    text-decoration: underline;
  }
</style>

<!-- notification -->
<script>
	document.addEventListener("DOMContentLoaded", (event) => {
		const urlParams = new URLSearchParams(window.location.search);
		const message = urlParams.get('message');
		const text = urlParams.get('text');

		if (message == 'success') {
			Swal.fire({
				icon: 'success',
				title: text,
				showConfirmButton: false,
				timer: 1500
			});
		} else if (message == 'error') {
			Swal.fire({
				icon: 'error',
				title: text,
				showConfirmButton: false,
				timer: 1500
			});
		} else if (message == 'info') {
			Swal.fire({
				icon: 'info',
				title: text,
				showConfirmButton: false,
				timer: 1500
			});
		}

	});
</script>
<script>
	const Toast = Swal.mixin({
		toast: true,
		position: "top-end",
		showConfirmButton: false,
		timer: 1500,
		timerProgressBar: true,
		customClass: {
			popup: 'colored-toast',
		},
		didOpen: (toast) => {
			toast.onmouseenter = Swal.stopTimer;
			toast.onmouseleave = Swal.resumeTimer;
		}
	});
	document.addEventListener("DOMContentLoaded", (event) => {
		const urlParams = new URLSearchParams(window.location.search);
		const messageToast = urlParams.get('messageToast');
		const text = urlParams.get('text');

		if (messageToast && text) {

			if (messageToast === 'success') {
				Toast.fire({
					icon: 'success',
					title: text,
					// iconColor: '#fff',
					// background: '#a5dc86',
					// background: '#8ac926',
					// color: '#fff'
				});
			} else if (messageToast === 'error') {
				Toast.fire({
					icon: 'error',
					title: text
				});
			} else if (messageToast === 'warning') {
				Toast.fire({
					icon: 'warning',
					title: text
				});
			} else if (messageToast === 'info') {
				Toast.fire({
					icon: 'info',
					title: text,
					// iconColor: '#fff',
					// background: '#3fc3ee',
					// color: '#fff'
				});
			}
		}
	});

	
</script>

<script type="text/javascript" language="javascript">
	$(document).ready(function () {
		$('.tool-tip').tooltip();
	});
</script>