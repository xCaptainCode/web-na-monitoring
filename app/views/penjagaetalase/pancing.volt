<style>
   .table tbody td, .table thead th {
      font-family: Oxanium;
   }

   .row-click {
      cursor: pointer;
   }
</style>

<div class="content-header">
   <div class="container">
      <div class="row mb-2">
         <div class="col-sm-6">
            <h1 class="m-0"> Area {{ area_label }}</h1>
         </div><!-- /.col -->
         <div class="col-sm-6 small">
            <ol class="breadcrumb float-sm-right">
               <li class="breadcrumb-item"><a href="#">Home</a></li>
               <li class="breadcrumb-item"><a href="#">Penjaga Etalase</a></li>
               <li class="breadcrumb-item active">Area {{ area_label }}</li>
            </ol>
         </div><!-- /.col -->
      </div><!-- /.row -->
   </div><!-- /.container-fluid -->
</div>

<div class="content">
   <div class="container">
      <div class="row">
         <div id="refreshData" class="col-lg-12">
            {% include 'penjagaetalase/pancingLoad.volt' %}
         </div>
      </div>
   </div>
</div>

<div id="modalDetail" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modalDetailTitle"
   aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
         <div class="modal-header bg-primary text-white">
            <h5 class="modal-title" id="modalDetailTitle">Scan Nota</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <div class="modal-body">
            <h3 class="text-bold text-center"><span id="data-kode"></span></h3>
            <div class="row">
               <div class="col-6"><i class="fa fa-id-card" aria-hidden="true"></i> <span id="data-customer"></span></div>
               <div class="col-6"><i class="fa fa-table" aria-hidden="true"></i> <span id="data-meja"></span></div>
               <div class="col-6"><i class="fas fa-user"></i> <span id="data-jmlorg"></span></div>
               <div class="col-6"><i class="fa fa-clock" aria-hidden="true"></i> <span id="data-jam"></span></div>
            </div>
            <br>
            <table class="table table-sm text-center mb-0">
               <tr>
                  <th>PIRING</th>
                  <th>GELAS</th>
               </tr>
               <tr>
                  <th><h3 class="text-bold"><span id="data-piring"></span></h3></th>
                  <th><h3 class="text-bold"><span id="data-gelas"></span></h3></th>
               </tr>
            </table>
            <!-- Form -->
            <form method="post" action="{{ url('penjagaetalase/scan_nota') }}" id="formScanNota" class="mt-3">
               <input type="hidden" name="id_area" id="form-id-area">
               <input type="hidden" name="o_kode" id="form-o-kode">
               <input type="hidden" name="qty_piring" id="form-qty-piring">
               <input type="hidden" name="qty_gelas" id="form-qty-gelas">

               <div class="form-group mb-2" hidden>
                  <label for="form-nomor-nota" class="mb-1">Nota</label>
                  <input type="text" id="form-nomor-nota" class="form-control form-control-sm" readonly>
               </div>
               <div class="form-group mb-2" hidden>
                  <label for="form-customer" class="mb-1">Customer</label>
                  <input type="text" id="form-customer" class="form-control form-control-sm" readonly>
               </div>
               <div class="form-row" hidden>
                  <div class="form-group col-6 mb-2">
                     <label for="form-piring" class="mb-1">Qty Piring</label>
                     <input type="text" id="form-piring" class="form-control form-control-sm text-center" readonly>
                  </div>
                  <div class="form-group col-6 mb-2">
                     <label for="form-gelas" class="mb-1">Qty Gelas</label>
                     <input type="text" id="form-gelas" class="form-control form-control-sm text-center" readonly>
                  </div>
               </div>
               <div class="form-group mb-0">
                  <label class="mb-1 d-block">Pengantar</label>
                  {% if penjaga_area|length > 1 %}
                     {% for pj in penjaga_area %}
                     <div class="custom-control custom-radio">
                        <input class="custom-control-input" type="radio" id="pengantar-{{ pj.penjaga_id }}" name="pengantar" value="{{ pj.penjaga_id }}" required>
                        <label for="pengantar-{{ pj.penjaga_id }}" class="custom-control-label">{{ pj.nama_alias }}</label>
                     </div>
                     {% endfor %}
                  {% elseif penjaga_area|length == 1 %}
                     <input type="hidden" name="pengantar" value="{{ penjaga_area[0].penjaga_id }}">
                     <input type="text" class="form-control form-control-sm" value="{{ penjaga_area[0].nama_alias }}" readonly>
                  {% else %}
                     <div class="alert alert-warning mb-0 py-2 px-2 small">
                        Belum ada penjaga etalase untuk area ini hari ini.
                     </div>
                  {% endif %}
               </div>
            </form>
         </div>
         <div class="modal-footer justify-content-around">
            <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Batal</button>
            <button type="submit" form="formScanNota" class="btn btn-sm btn-primary" {% if penjaga_area|length == 0 %}disabled{% endif %}><i class="fas fa-save"></i> Simpan</button>
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
            lengthChange: false,
            // pageLength: 10
         });
      }

      initDataTable();

      $('#refreshData').on('click', '.row-click', function () {
         $('#formScanNota')[0].reset();

         let id        = $(this).attr('data-id');

         let kode      = $(this).attr('data-kode');
         let customer  = $(this).attr('data-customer');
         let jmlorg    = $(this).attr('data-jmlorg');
         let meja      = $(this).attr('data-meja');
         let area      = $(this).attr('data-area');
         let piring    = $(this).attr('data-piring');
         let gls       = $(this).attr('data-gls');
         let jam       = $(this).attr('data-jam');


         $('#form-id-area').val(area);
         $('#form-o-kode').val(id);
         $('#form-qty-piring').val(piring);
         $('#form-qty-gelas').val(gls);
         $('#form-nomor-nota').val(kode);
         $('#form-customer').val(customer);
         $('#form-piring').val(piring);
         $('#form-gelas').val(gls);

         $('#data-kode').text(kode);
         $('#data-customer').text(customer);
         $('#data-jmlorg').text(jmlorg);
         $('#data-meja').text(meja);
         $('#data-pengantar').text('Pilih di form');
         $('#data-piring').text(piring);
         $('#data-gelas').text(gls);
         $('#data-jam').text(jam);

         let $pengantarOptions = $('input[name="pengantar"]');
         if ($pengantarOptions.length > 1) {
            $pengantarOptions.prop('checked', false);
            $pengantarOptions.first().prop('checked', true);
         }

         $('#modalDetail').modal('show');
      });

      function refreshTable() {
         $.ajax({
            url: "{{ url('penjagaetalase/load_' ~ area_slug) }}",
            type: "GET",
            success: function (response) {
               $('#refreshData').html(response);
               initDataTable();
            },
            error: function (xhr, status, error) {
               console.error("Terjadi kesalahan: " + error);
            }
         });
      }

      // Memanggil fungsi refreshTable setiap 5 detik
      setInterval(refreshTable, 5000);

   });
</script>
