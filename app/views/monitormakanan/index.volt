<style>
   .table tbody td, .table thead th {
      font-family: Oxanium;
   }
   .presence-card-body {
      height: calc(105vh - 260px);
      overflow-y: auto;
   }

   .presence-row-clickable,
   .presence-insert-clickable,
   .presence-edit-clickable {
      cursor: pointer;
      transition: background-color 0.2s ease;
   }

   .presence-row-clickable:hover,
   .presence-insert-clickable:hover,
   .presence-edit-clickable:hover {
      background-color: rgba(23, 162, 184, 0.12);
   }

   .btn-penyaji {
      width: 100px;
   }
</style>

<div class="content-header">
   <div class="row mb-2">
      <div class="col-sm-6">
         <h1 class="m-0">Monitor Makanan</h1>
      </div>
      <div class="col-sm-6 small">
         <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="#">Home</a></li>
            <li class="breadcrumb-item"><a href="#">Monitor</a></li>
            <li class="breadcrumb-item active">Monitor Makanan</li>
         </ol>
      </div>
   </div>
</div>

<div class="content">
   <div id="refreshData">
      {% include 'monitormakanan/load.volt' %}
   </div>
</div>

<div id="modalScanMakanan" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modalScanMakananTitle" aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
      <div class="modal-content">
         <div class="modal-header bg-success text-white">
            <h5 class="modal-title" id="modalScanMakananTitle">Scan Nota Makanan</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <div class="modal-body">
            <h1 class="text-bold text-center"><span id="data-kode"></span></h1>
            <div class="row">
               <div class="col-6"><i class="fa fa-id-card" aria-hidden="true"></i> <span id="data-customer"></span></div>
               <div class="col-6"><i class="fa fa-couch" aria-hidden="true"></i> <span id="data-meja"></span></div>
               <div class="col-6"><i class="fa fa-hourglass-2" aria-hidden="true"></i> <span id="data-sesek"></span></div>
               <div class="col-6"><i class="fa fa-fire" aria-hidden="true"></i> <span id="data-goreng"></span></div>
               <div class="col-6"><i class="fa fa-burn" aria-hidden="true"></i> <span id="data-bakar"></span></div>
               <div class="col-6"><i class="fa fa-clock" aria-hidden="true"></i> <span id="data-saji"></span></div>
            </div>
            <hr>
            <div class="table-responsive">
               <table class="table table-sm table-bordered mb-0">
                  <thead class="text-center bg-success">
                     <tr>
                        <th width="8%">No</th>
                        <th>Nama Menu</th>
                        <th width="15%">Qty</th>
                        <th width="15%">Satuan</th>
                     </tr>
                  </thead>
                  <tbody id="detail-makanan-body"></tbody>
               </table>
            </div>

            <div class="form-group mt-3 mb-2">
               <label for="form-note">Note</label>
               <input type="text" id="form-note" class="form-control form-control-sm" readonly>
            </div>

            <form method="post" action="{{ url('monitormakanan/scan_nota') }}" id="formScanMakanan" class="mt-3">
               <input type="hidden" name="o_kode" id="form-o-kode">
               <input type="hidden" name="j_penyaji" id="form-j-penyaji">

               <div class="form-group mb-2">
                  <label for="form-penyaji-nama" class="mb-1">Penyaji Makanan</label>
                  <input type="text" id="form-penyaji-nama" class="form-control form-control-sm text-center font-weight-bold" readonly placeholder="Pilih penyaji makanan">
               </div>

               <div class="mb-2">
                  <div class="small text-muted mb-1">Karyawan</div>
                  <div class="d-flex flex-wrap" style="gap:6px;">
                     {% for item in daftar_penyaji_karyawan %}
                     <button type="button" class="btn btn-outline-success btn-sm btn-penyaji" data-nik="{{ item.nik }}" data-nama="{{ item.nama_alias }}">
                        {{ Helpers.ucwords(item.nama_alias) }}
                     </button>
                     {% endfor %}
                  </div>
               </div>

               <div class="mb-0">
                  <div class="small text-muted mb-1">Parttimer</div>
                  <div class="d-flex flex-wrap" style="gap:6px;">
                     {% for item in daftar_penyaji_parttimer %}
                     <button type="button" class="btn btn-outline-info btn-sm btn-penyaji" data-nik="{{ item.nik }}" data-nama="{{ item.nama_alias }}">
                        {{ item.nama_alias }}
                     </button>
                     {% endfor %}
                  </div>
               </div>
            </form>
         </div>
         <div class="modal-footer justify-content-around">
            <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Tutup</button>
            <button type="submit" form="formScanMakanan" class="btn btn-sm btn-success" id="btn-simpan-saji">
               <i class="fas fa-save"></i> Simpan
            </button>
         </div>
      </div>
   </div>
</div>

<script>
   $(document).ready(function () {
      $('#refreshData').on('click', '.row-click', function () {
         $('#form-o-kode').val($(this).attr('data-id'));
         $('#form-j-penyaji').val('');
         $('#form-penyaji-nama').val('');
         $('.btn-penyaji').removeClass('active');

         $('#data-kode').text($(this).attr('data-kode'));
         $('#data-customer').text($(this).attr('data-customer'));
         $('#data-meja').text($(this).attr('data-meja'));
         $('#data-sesek').text('Sesek: ' + $(this).attr('data-sesek'));
         $('#data-goreng').text('Goreng: ' + $(this).attr('data-goreng'));
         $('#data-bakar').text('Bakar: ' + $(this).attr('data-bakar'));
         $('#data-saji').text('Saji: ' + $(this).attr('data-saji'));
         $('#form-note').val($(this).attr('data-note'));
         let detail = $(this).attr('data-detail');
         let detailMakanan = [];

         try {
            let detailJson = detail ? atob(detail) : '[]';
            detailMakanan = JSON.parse(detailJson);
         } catch (error) {
            detailMakanan = [];
         }

         let rows = '';
         if (detailMakanan.length === 0) {
            rows = '<tr><td colspan="4" class="text-center text-muted">Belum ada detail menu makanan.</td></tr>';
         } else {
            $.each(detailMakanan, function (index, item) {
               rows += '<tr>' +
                  '<td class="text-center">' + (index + 1) + '</td>' +
                  '<td>' + item.nama_olahan + '</td>' +
                  '<td class="text-center">' + item.od_qty + '</td>' +
                  '<td class="text-center">' + item.satuan + '</td>' +
               '</tr>';
            });
         }

         $('#detail-makanan-body').html(rows);

         $('#modalScanMakanan').modal('show');
      });

      $(document).on('click', '.btn-penyaji', function () {
         let nik = $(this).attr('data-nik');
         let nama = $(this).attr('data-nama');

         $('.btn-penyaji').removeClass('active');
         $(this).addClass('active');

         $('#form-j-penyaji').val(nik);
         $('#form-penyaji-nama').val(nama + ' (' + nik + ')');
      });

      $('#formScanMakanan').on('submit', function () {
         if ($('#form-j-penyaji').val() === '') {
            alert('Pilih penyaji makanan terlebih dahulu.');
            return false;
         }

         let $button = $('#btn-simpan-saji');
         if ($button.prop('disabled')) {
            return false;
         }

         $button.prop('disabled', true);
         $button.html('<i class="fa fa-spinner fa-spin" aria-hidden="true"></i> Menyimpan...');
      });

      function refreshTable() {
         $.ajax({
            url: "{{ url('monitormakanan/load') }}",
            type: "GET",
            success: function (response) {
               $('#refreshData').html(response);
            },
            error: function (xhr, status, error) {
               console.error('Terjadi kesalahan: ' + error);
            }
         });
      }

      setInterval(refreshTable, 3000);
   });
</script>
