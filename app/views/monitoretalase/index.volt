<div class="content-header">
   <div class="container">
      <div class="row mb-2">
         <div class="col-sm-6">
            <h1 class="m-0"> Monitor Etalase</h1>
         </div><!-- /.col -->
         <div class="col-sm-6 small">
            <ol class="breadcrumb float-sm-right">
               <li class="breadcrumb-item"><a href="#">Home</a></li>
               <li class="breadcrumb-item active">Monitor Etalase</li>
            </ol>
         </div><!-- /.col -->
      </div><!-- /.row -->
   </div><!-- /.container-fluid -->
</div>

<div class="content">
   <div class="container">
      <div class="row">
         <div class="col-lg-12">
            <div class="card card-primary card-outline">
               <div class="card-header">
                  <h3 class="card-title m-0">Stock Peralatan</h3>
                  <div class="card-tools">
                     <button type="button" class="btn btn-tool bg-primary" data-toggle="modal" data-target="#modal-tambah-alat"><i class="fas fa-plus"></i>
                        <span class="text-white">Tambah Alat</span>
                     </button>
                  </div>
               </div>
               <div class="card-body p-2">
                  <div class="table-responsive">
                     <table class="table table-sm table-bordered table-hover">
                        <thead class="text-center">
                           <tr>
                              <th rowspan="2" class="align-middle">No</th>
                              <th rowspan="2" class="align-middle">Area Etalase</th>
                              <th colspan="2" class="align-middle bg-info">Stock Awal</th>
                              <th colspan="2" class="align-middle bg-danger">Terpakai</th>
                              <th colspan="2" class="align-middle bg-success">Stock Sisa</th>
                           </tr>
                           <tr>
                              <th class="bg-info">P</th>
                              <th class="bg-info">G</th>
                              <th class="bg-danger">P</th>
                              <th class="bg-danger">G</th>
                              <th class="bg-success">P</th>
                              <th class="bg-success">G</th>
                           </tr>
                        </thead>
                        <tbody id="stocks-tbody">
                           {% for st in stocks %}
                           <tr>
                              <td class="text-center">{{ loop.index }}</td>
                              <td class="text-left">{{ st.area_etalase }}</td>
                              <td class="text-center table-info">{{ st.stock_awal_piring }}</td>
                              <td class="text-center table-info">{{ st.stock_awal_gelas }}</td>
                              <td class="text-center table-danger">{{ st.terpakai_piring }}</td>
                              <td class="text-center table-danger">{{ st.terpakai_gelas }}</td>
                              <td class="text-center table-success">{{ st.stock_sisa_piring }}</td>
                              <td class="text-center table-success">{{ st.stock_sisa_gelas }}</td>
                           </tr>
                           {% endfor %}
                           <tr class="font-weight-bold bg-light">
                              <td colspan="2" class="text-center">Total</td>
                              <td class="text-center table-info">{{ totals['stock_awal_piring'] }}</td>
                              <td class="text-center table-info">{{ totals['stock_awal_gelas'] }}</td>
                              <td class="text-center table-danger">{{ totals['terpakai_piring'] }}</td>
                              <td class="text-center table-danger">{{ totals['terpakai_gelas'] }}</td>
                              <td class="text-center table-success">{{ totals['stock_sisa_piring'] }}</td>
                              <td class="text-center table-success">{{ totals['stock_sisa_gelas'] }}</td>
                           </tr>
                        </tbody>
                     </table>
                     <div class="small text-muted">*Qty <b>Stock Awal</b> dan <b>Terpakai</b> berdasarkan hari ini ( {{ Helpers.tgl_indo(date('Y-m-d')) }} )</div>
                  </div>
               </div>
               <div class="card-footer">
                  <div class="float-right">
                     <button class="btn btn-danger btn-sm" type="button" data-toggle="modal" data-target="#modal-reset-stock"><i class="fa fa-undo" aria-hidden="true"></i> Reset</button>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>

<div id="modal-tambah-alat" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="my-modal-title" aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
         <div class="modal-header bg-primary">
            <h5 class="modal-title" id="my-modal-title">Tambah Stock Peralatan</h5>
            <button class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <form action="{{ url('monitoretalase/simpan_tambah_stock') }}" method="post" id="form-tambah-stock">
            <div class="modal-body">
               {% for st in stocks %}
               <div class="row mb-2">
                  <div class="col-md-6">
                     <label for="">{{ st.area_etalase }}</label>
                     <input type="hidden" name="id_area[]" class="form-control form-control-sm" value="{{ st.id_area }}">
                  </div>
                  <div class="col-md-3">
                     <input type="text" inputmode="numeric" name="qty_piring[]" class="form-control form-control-sm text-center" value="0" min="0" placeholder="Qty Piring">
                  </div>
                  <div class="col-md-3">
                     <input type="text" inputmode="numeric" name="qty_gelas[]" class="form-control form-control-sm text-center" value="0" min="0" placeholder="Qty Gelas">
                  </div>
               </div>
               {% endfor %}
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal"><i class="fas fa-times" aria-hidden="true"></i> Tutup</button>
               <button type="submit" class="btn btn-primary btn-sm" id="btn-simpan-stock"><i class="fa fa-save" aria-hidden="true"></i> <span class="btn-label">Simpan</span></button>
            </div>
         </form>
      </div>
   </div>
</div>

<div id="modal-reset-stock" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modal-reset-stock-title" aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
         <div class="modal-header bg-danger">
            <h5 class="modal-title" id="modal-reset-stock-title">Konfirmasi Reset Stock</h5>
            <button class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <form action="{{ url('monitoretalase/reset_stock') }}" method="post" id="form-reset-stock">
            <div class="modal-body">
               <div class="text-center">
                  <h5 class="mb-0">Apakah Anda yakin ingin mereset stock peralatan?</h5>
               </div>
               <div class="alert alert-warning mt-2">
                  <div class="small text-center">
                     <i class="fa fa-exclamation-triangle" aria-hidden="true"></i> 
                     Seluruh <strong>Sisa Stock</strong> di seluruh area etalase akan direset.
                  </div>
               </div>
            </div>
            <div class="modal-footer justify-content-around">
               <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal"><i class="fas fa-times" aria-hidden="true"></i> Batal</button>
               <button type="submit" class="btn btn-danger btn-sm" id="btn-reset-stock"><i class="fa fa-undo" aria-hidden="true"></i> <span class="btn-label">Ya, Reset!</span></button>
            </div>
         </form>
      </div>
   </div>
</div>

<script>
   $(function () {
      $('#form-tambah-stock').on('submit', function () {
         var $button = $('#btn-simpan-stock');

         if ($button.prop('disabled')) {
            return false;
         }

         $button.prop('disabled', true);
         $button.html('<i class="fa fa-spinner fa-spin" aria-hidden="true"></i> Menyimpan...');
      });

      $('#form-reset-stock').on('submit', function () {
         var $button = $('#btn-reset-stock');

         if ($button.prop('disabled')) {
            return false;
         }

         $button.prop('disabled', true);
         $button.html('<i class="fa fa-spinner fa-spin" aria-hidden="true"></i> Memproses...');
      });

      function updateStocks() {
         $.ajax({
            url: '{{ url("monitoretalase/getData") }}',
            type: 'GET',
            dataType: 'json',
            success: function(data) {
               var tbody = '';
               $.each(data.stocks, function(index, st) {
                  tbody += '<tr>' +
                     '<td class="text-center">' + (index + 1) + '</td>' +
                     '<td class="text-left">' + st.area_etalase + '</td>' +
                     '<td class="text-center table-info">' + st.stock_awal_piring + '</td>' +
                     '<td class="text-center table-info">' + st.stock_awal_gelas + '</td>' +
                     '<td class="text-center table-danger">' + st.terpakai_piring + '</td>' +
                     '<td class="text-center table-danger">' + st.terpakai_gelas + '</td>' +
                     '<td class="text-center table-success">' + st.stock_sisa_piring + '</td>' +
                     '<td class="text-center table-success">' + st.stock_sisa_gelas + '</td>' +
                     '</tr>';
               });
               tbody += '<tr class="font-weight-bold bg-light">' +
                  '<td colspan="2" class="text-center">Total</td>' +
                  '<td class="text-center table-info">' + data.totals.stock_awal_piring + '</td>' +
                  '<td class="text-center table-info">' + data.totals.stock_awal_gelas + '</td>' +
                  '<td class="text-center table-danger">' + data.totals.terpakai_piring + '</td>' +
                  '<td class="text-center table-danger">' + data.totals.terpakai_gelas + '</td>' +
                  '<td class="text-center table-success">' + data.totals.stock_sisa_piring + '</td>' +
                  '<td class="text-center table-success">' + data.totals.stock_sisa_gelas + '</td>' +
                  '</tr>';
               $('#stocks-tbody').html(tbody);
            }
         });
      }

      // Auto refresh setiap 3 detik menggunakan AJAX
      setInterval(updateStocks, 3000);
   });
</script>
