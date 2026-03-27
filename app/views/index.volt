<!DOCTYPE html>
<html>
{% include 'layouts/header.volt' %}

{# <body class="hold-transition sidebar-mini layout-fixed text-sm"> #}
<body class="layout-top-nav">

	<!-- Site wrapper -->
	<div class="wrapper">

		<!-- include header -->
		{% include 'layouts/navbar.volt' %}

		<!-- include sidebar -->
		{# {% include 'layouts/leftbar.volt' %} #}


		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper px-3">
			{{ content() }}
			<!-- back to top -->
			<button id="backToTop"><i class="fas fa-arrow-up"></i></button>
		</div>
		<!-- /.content-wrapper -->

		<!-- include footer -->
		{% include 'layouts/footer.volt' %}

	</div>
	<!-- /.wrapper -->
	 
</body>

</html>