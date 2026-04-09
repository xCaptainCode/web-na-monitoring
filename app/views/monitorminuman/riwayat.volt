<style>
   .table tbody td, .table thead th {
      font-family: Oxanium;
   }
   
   .data-card-body {
      height: calc(100vh - 260px);
      overflow-y: auto;
   }
   
   .row-click,
   .insert-click,
   .edit-click {
      cursor: pointer;
      transition: background-color 0.2s ease;
   }
   
   .presence-row-clickable:hover,
   .presence-insert-clickable:hover,
   .presence-edit-clickable:hover {
      background-color: rgba(23, 162, 184, 0.12);
   }
   
</style>

<div class="content-header">
   <div class="container">
      <div class="row mb-2">
         <div class="col-sm-6">
            <h1 class="m-0"> Riwayat Monitor Minuman</h1>
         </div>
         <div class="col-sm-6 small">
            <ol class="breadcrumb float-sm-right">
               <li class="breadcrumb-item"><a href="#">Home</a></li>
               <li class="breadcrumb-item"><a href="#">Monitor Minuman</a></li>
               <li class="breadcrumb-item active">Riwayat Nota</li>
            </ol>
         </div>
      </div>
   </div>
</div>

<div class="content">
   <div class="container">
      <div class="row">
         <div class="col-lg-12">
            <div class="card card-primary card-outline">
               <div class="card-header">
                  <h3 class="card-title m-0">Daftar Riwayat Nota Minuman Sudah Disajikan</h3>
               </div>
               <div class="card-body p-2 data-card-body">
                  <div class="table-responsive">
                     <table id="dataTable" class="table table-sm table-bordered table-striped table-hover">
                        <thead class="text-center">
                           <tr>
                              <th>No</th>
                              <th>Nota</th>
                              <th>Customer</th>
                              <th>Meja</th>
                              <th>Proses</th>
                              <th>Jam Saji</th>
                              <th>Pramusaji</th>
                           </tr>
                        </thead>
                        <tbody>
                           {% if riwayat_nota|length > 0 %}
                           {% for item in riwayat_nota %}
                           <tr class="row-click" data-id="{{ item.o_kode }}">
                              <td class="text-center">{{ loop.index }}</td>
                              <td class="text-center text-bold">{{ item.nota_format }}</td>
                              <td>{{ item.o_cnama }}</td>
                              <td class="text-center">{{ item.o_meja }}</td>
                              <td class="text-center">{{ item.proses }}</td>
                              <td class="text-center">{{ item.jam_saji }}</td>
                              <td>{{ item.pramusaji }}</td>
                           </tr>
                           {% endfor %}
                           {% else %}
                           <tr>
                              <td colspan="7" class="text-center text-muted">Belum ada riwayat nota minuman yang sudah disajikan.</td>
                           </tr>
                           {% endif %}
                        </tbody>
                     </table>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>

<script>
   $(document).ready(function () {
      if (!$.fn.DataTable) {
         return;
      }

      $('#dataTable').DataTable({
         responsive: false,
         autoWidth: false,
         paging: false,
         searching: true,
         ordering: true,
         info: true,
         lengthChange: false,
         pageLength: 10
      });
   });

   $(document).on('click', '.row-click', function () {
      let id = $(this).data('id');
      window.location.href = `{{ url('monitorminuman/detail_nota/') }}` + id;
   });
</script>
