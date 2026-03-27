<footer class="main-footer">
	<i class="text-center small">Created on 2026-03-07 by <a href="#">Staff USH - Litbang</a>.</i>
	<!-- All rights reserved. -->
	<div class="float-right d-none d-sm-inline-block small">
		<b>Version</b> 1.0.0
	</div>
</footer>

<!-- Control Sidebar -->
<aside class="control-sidebar control-sidebar-dark">
	<!-- Control sidebar content goes here -->
</aside>
<!-- /.control-sidebar -->

<script type="text/javascript" language="javascript">
	$(document).ready(function () {
		/** add active class and stay opened when selected */
		var url = window.location;

		// for sidebar menu entirely but not cover treeview
		$('ul.nav-sidebar a').filter(function () {
			return this.href == url;
		}).addClass('active');

		// for treeview
		$('ul.nav-treeview a').filter(function () {
			return this.href == url;
		}).parentsUntil(".nav-sidebar > .nav-treeview").addClass('menu-open').prev('a').addClass('active');
	})

	//	document.getElementById('main-btn').addEventListener('click', function () {
	//			const popupMenu = document.getElementById('popup-menu');
	//			popupMenu.style.display = (popupMenu.style.display === 'none' || popupMenu.style.display === '') ? 'block' : 'none';
	//	});

</script>

<!-- back to top -->
<script>
	// ketika pengguna menggulir ke bawah 20 piksel dari atas dokumen, tampilkan tombol
	window.onscroll = function () {
		scrollFunction()
	}

	function scrollFunction() {
		if (document.body.scrollBottom > 20 || document.documentElement.scrollTop > 20) {
			document.getElementById("backToTop").style.display = "block";
		} else {
			document.getElementById("backToTop").style.display = "none";
		}
	}

	// ketika tombol di klik, gulir ke atas dengan lancar
	document.getElementById("backToTop").onclick = function () {
		document.body.scrollTop = 0; //untuk safari
		window.scrollTo({ top: 0, behavior: "smooth" });  //untuk firefox, chrome, opera, IE6+
	}
</script>

<script>
	$(function () {
		$(document).on('click', '[data-toggle="lightbox"]', function (event) {
			event.preventDefault();
			$(this).ekkoLightbox({
				alwaysShowClose: true
			});
		});

		$('.filter-container').filterizr({ gutterPixels: 3 });
		$('.btn[data-filter]').on('click', function () {
			$('.btn[data-filter]').removeClass('active');
			$(this).addClass('active');
		});
	})
</script>

<!-- notification -->
{% set successMessages = flashSession.getMessages('success') %}
{% set errorMessages = flashSession.getMessages('error') %}
{% set noticeMessages = flashSession.getMessages('notice') %}
{% set warningMessages = flashSession.getMessages('warning') %}

{% if successMessages is not empty %}
<script>
	Swal.fire({
		icon: 'success',
		title: '{{ successMessages[0] }}',
		showConfirmButton: false,
		timer: 1500
	});
</script>
{% endif %}

{% if errorMessages is not empty %}
<script>
	Swal.fire({
		icon: 'error',
		title: '{{ errorMessages[0] }}',
		showConfirmButton: true,
	});
</script>
{% endif %}

{% if noticeMessages is not empty %}
<script>
	Toast.fire({
		icon: 'success',
		title: '{{ noticeMessages[0] }}',
		timer: 3000
	})
</script>
{% endif %}

{% if warningMessages is not empty %}
<script>
	Toast.fire({
		icon: 'info',
		title: '{{ warningMessages[0] }}'
	})
</script>
{% endif %}

<script>
	// Function to convert input to uppercase on keyup for elements with class 'upper-case'
	$(document).on('keyup', '.upper-case', function () {
		$(this).val($(this).val().toUpperCase());
	});
</script>