<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>NA Monitoring</title>
	<!-- Tell the browser to be responsive to screen width -->
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

	<!-- Font Awesome -->
	{{ stylesheet_link("plugins/fontawesome-free/css/all.min.css") }}
	<!-- logo app -->
	<link rel="shortcut icon" href="{{ url('dist/img/monitoring_12744110.png') }}" type="image/x-icon">
	<!-- Ionicons -->
	<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">

	<!-- iCheck -->
	{{ stylesheet_link("plugins/icheck-bootstrap/icheck-bootstrap.min.css") }}

	<!-- Theme style -->
	{{ stylesheet_link("dist/css/adminlte.min.css") }}
	<!-- overlayScrollbars -->
	{{ stylesheet_link("plugins/overlayScrollbars/css/OverlayScrollbars.min.css") }}

	<!-- Google Font: Source Sans Pro -->
	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

	<!-- Theme style -->
	{{ stylesheet_link("dist/css/adminlte.min.css") }}

	<!-- CSS Custom -->
	{{ stylesheet_link("css/main-custom.css") }}

	<!-- jQuery -->
	{{ javascript_include("plugins/jquery/jquery.min.js") }}
	<!-- jQuery UI 1.11.4 -->
	{{ javascript_include("plugins/jquery-ui/jquery-ui.min.js") }}
	<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
	<script>
		$.widget.bridge('uibutton', $.ui.button)
	</script>

	<!-- Bootstrap 4 -->
	{{ javascript_include("plugins/bootstrap/js/bootstrap.bundle.min.js") }}

	<!-- Sparkline -->
	{{ javascript_include("plugins/sparklines/sparkline.js") }}

	<!-- OverlayScrollbars -->
	{{ javascript_include("plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js") }}

	<!-- App Function JS -->
	{{ javascript_include("js/app-functions.js") }}

	<!-- AdminLTE App -->
	{{ javascript_include("dist/js/adminlte.js") }}
</head>

<style>
	.card {
		border-radius: 17px;
		background: linear-gradient(145deg, #f0f0f0, #f3f0f0);
		box-shadow: 22px 22px 44px #9d9d9d,
			-22px -22px 44px #ffffff;
	}
</style>

<body class="hold-transition login-page">
	<br>
	<br>
	<br>


	<div class="row justify-content-center mb-5 col-md-3">
		<div class="col-md-12">
			<div class="card">
				<div class="card-header bg-transparent mb-0 pt-4">
					<h5 class="text-center">Silakan <span class="font-weight-bold text-primary">Login</span></h5>
				</div>
				<div class="card-body">
					<form action="{{ url('login/proses') }}" method="POST" autocomplete="off" class="mb-3">
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text bg-light"><i class="fas fa-user text-info"></i></span>
							</div>
							<input type="text" id="txtusername" name="txtusername" class="form-control"
								placeholder="Username">
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text bg-light"><i class="fas fa-key text-warning"></i></span>
							</div>
							<input type="password" id="txtpassword" name="txtpassword" class="form-control" placeholder="Password">
						</div>
						<div class="row">
							<button type="submit" class="btn btn-primary btn-block btn-flat"
								style="margin-left:8px;margin-right:8px;">Sign In</button>
						</div>
					</form>
					<a href="{{ url('login/forgot') }}">I forgot my password.</a><br>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		history.pushState(null, null, "{{ url('') }}");
		jQuery(document).ready(function ($) {
			$("#txtusername").focus();
		});
	</script>
</body>

</html>