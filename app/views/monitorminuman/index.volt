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
   <div class="container">
      <div class="row mb-2">
         <div class="col-sm-6">
            <h1 class="m-0"> Monitor Minuman</h1>
         </div>
         <div class="col-sm-6 small">
            <ol class="breadcrumb float-sm-right">
               <li class="breadcrumb-item"><a href="#">Home</a></li>
               <li class="breadcrumb-item active">Monitor Minuman</li>
            </ol>
         </div>
      </div>
   </div>
</div>

<div class="content">
   <div class="container">
      <div id="refreshData">
         {% include 'monitorminuman/load.volt' %}
      </div>
   </div>
</div>

<div id="modalDetail" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modalDetailTitle" aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
      <div class="modal-content">
         <div class="modal-header bg-primary text-white">
            <h5 class="modal-title" id="modalDetailTitle">Detail Minuman Belum Tersaji</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <div class="modal-body">
            <h3 class="text-bold text-center"><span id="data-kode"></span></h3>
            <div class="row">
               <div class="col-6"><i class="fa fa-user" aria-hidden="true"></i> <span id="data-customer"></span></div>
               <div class="col-6"><i class="fa fa-table" aria-hidden="true"></i> <span id="data-meja"></span></div>
               <div class="col-6"><i class="fa fa-map-marker-alt" aria-hidden="true"></i> <span id="data-area"></span></div>
               <div class="col-6"><i class="fa fa-hourglass-2" aria-hidden="true"></i> <span id="data-jam"></span></div>
            </div>
            <div id="scan-warning" class="alert alert-warning py-2 px-3 mt-3 mb-0" hidden>
               Nota ini belum mendapat meja, jadi belum bisa di-scan.
            </div>
            <hr>
            <div class="table-responsive">
               <table class="table table-sm table-bordered mb-0">
                  <thead class="text-center">
                     <tr>
                        <th width="8%">No</th>
                        <th>Nama Minuman</th>
                        <th width="15%">Qty</th>
                        <th width="15%">Satuan</th>
                     </tr>
                  </thead>
                  <tbody id="detail-minuman-body"></tbody>
               </table>
            </div>
            <!-- note -->
            <div class="form-group">
               <label for="form-note">Note</label>
               <input type="text" name="" id="form-note" class="form-control form-control-sm" readonly>
            </div>
            
            <form method="post" action="{{ url('monitorminuman/scan_nota') }}" id="formScanMinuman" class="mt-3">
               <input type="hidden" name="o_kode" id="form-o-kode">
               <input type="hidden" name="nik_penyaji" id="form-nik-penyaji">

               <div class="form-group mb-2">
                  <label for="form-penyaji-nama" class="mb-1">Penyaji Minuman</label>
                  <input type="text" id="form-penyaji-nama" class="form-control form-control-sm text-center font-weight-bold" readonly placeholder="Pilih penyaji minuman">
               </div>

               <div class="mb-2">
                  <div class="small text-muted mb-1">Karyawan</div>
                  <div class="d-flex flex-wrap" style="gap:6px;">
                     {% for item in daftar_penyaji_karyawan %}
                     <button type="button" class="btn btn-outline-primary btn-sm btn-penyaji" data-nik="{{ item.nik }}" data-nama="{{ item.nama_alias }}">
                        {{ item.nama_alias }}
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
            <button type="submit" form="formScanMinuman" class="btn btn-sm btn-primary" id="btn-simpan-saji">
               <i class="fas fa-save"></i> Simpan
            </button>
         </div>
      </div>
   </div>
</div>

<script>
   $(document).ready(function () {

      function initDataTable() {
         if (!$.fn.DataTable) {
            return;
         }

         if ($.fn.DataTable.isDataTable('#dataTable')) {
            $('#dataTable').DataTable().destroy();
         }

         $('#dataTable').DataTable({
            responsive: false,
            autoWidth: false,
            paging: false,
            searching: true,
            ordering: true,
            info: true,
            lengthChange: false
         });
      }

      // initDataTable();

      $('#refreshData').on('click', '.row-click', function () {
         $('#form-o-kode').val($(this).attr('data-id'));
         $('#form-nik-penyaji').val('');
         $('#form-penyaji-nama').val('');
         $('.btn-penyaji').removeClass('active');

         let kode = $(this).attr('data-kode');
         let customer = $(this).attr('data-customer');
         let meja = $(this).attr('data-meja');
         let area = $(this).attr('data-area');
         let jam = $(this).attr('data-jam');
         let note = $(this).attr('data-note');
         let hasMeja = $(this).attr('data-has-meja') === '1';
         let detail = $(this).attr('data-detail');
         let detailMinuman = [];

         try {
            let detailJson = detail ? atob(detail) : '[]';
            detailMinuman = JSON.parse(detailJson);
         } catch (error) {
            detailMinuman = [];
         }

         $('#data-kode').text(kode);
         $('#data-customer').text(customer);
         $('#data-meja').text(meja);
         $('#data-area').text(area);
         $('#data-jam').text(jam);
         $('#form-note').val(note);
         $('#scan-warning').prop('hidden', hasMeja);
         $('.btn-penyaji').prop('disabled', !hasMeja);
         $('#btn-simpan-saji').prop('disabled', !hasMeja);
         if (!hasMeja) {
            $('#form-penyaji-nama').val('Menunggu meja');
         }

         let rows = '';

         if (detailMinuman.length === 0) {
            rows = '<tr><td colspan="4" class="text-center text-muted">Belum ada detail minuman.</td></tr>';
         } else {
            $.each(detailMinuman, function (index, item) {
               rows += '<tr>' +
                  '<td class="text-center">' + (index + 1) + '</td>' +
                  '<td>' + item.nama_olahan + '</td>' +
                  '<td class="text-center">' + item.od_qty + '</td>' +
                  '<td class="text-center">' + item.satuan + '</td>' +
               '</tr>';
            });
         }

         $('#detail-minuman-body').html(rows);
         $('#modalDetail').modal('show');
      });

      $(document).on('click', '.btn-penyaji', function () {
         if ($(this).prop('disabled')) {
            return;
         }

         let nik = $(this).attr('data-nik');
         let nama = $(this).attr('data-nama');

         $('.btn-penyaji').removeClass('active');
         $(this).addClass('active');

         $('#form-nik-penyaji').val(nik);
         $('#form-penyaji-nama').val(nama + ' (' + nik + ')');
      });

      $('#formScanMinuman').on('submit', function () {
         if ($('#btn-simpan-saji').prop('disabled')) {
            return false;
         }

         if ($('#form-nik-penyaji').val() === '') {
            alert('Pilih penyaji minuman terlebih dahulu.');
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
            url: "{{ url('monitorminuman/load') }}",
            type: "GET",
            success: function (response) {
               $('#refreshData').html(response);
               // initDataTable();
            },
            error: function (xhr, status, error) {
               console.error("Terjadi kesalahan: " + error);
            }
         });
      }

      setInterval(refreshTable, 3000);
   });
</script>
