<style type="text/css">
.image404 {
	width: 400px;
	height: 200;
}
</style>

<div class="ex-page-content text-center">
	
	{{ image("images/test.png", "class": "image404", "alt": "Error 404: Halaman Belum Tersedia!") }}
	

	<p class="text-muted"><strong>Halaman ini memang belum tersedia.</strong></p>
	<p class="text-muted"><strong>Click back pada browser Anda atau click tombol home berikut.</strong></p>
	<br>
	<a class="btn btn-default waves-effect waves-light" href="{{ url('index') }}"><i class="fa fa-home"></i> Home</a>
	
</div>