<style>
   .table tbody td, .table thead th {
      font-family: Oxanium;
   }
   
   .data-card-body {
      height: calc(100vh - 260px);
      overflow-y: auto;
   }
</style>

<div class="content-header">
   <div class="container">
      <div class="row mb-2">
         <div class="col-sm-6">
            <h1 class="m-0"> Riwayat Nota</h1>
         </div>
         <div class="col-sm-6 small">
            <ol class="breadcrumb float-sm-right">
               <li class="breadcrumb-item"><a href="#">Home</a></li>
               <li class="breadcrumb-item"><a href="#">Monitor Etalase</a></li>
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
                  <h3 class="card-title m-0">Riwayat Penggunaan Peralatan</h3>
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
                              <th>Piring</th>
                              <th>Gelas</th>
                              <th>Pengantar</th>
                           </tr>
                        </thead>
                        <tbody>
                           {% set ttl_prg = 0 %}
                           {% set ttl_gls = 0 %}
                           {% if riwayat_nota|length > 0 %}
                           {% for item in riwayat_nota %}
                           <tr>
                              <td class="text-center">{{ loop.index }}</td>
                              <td class="text-center text-bold">{{ item.nota_format }}</td>
                              <td>{{ item.o_cnama }}</td>
                              <td class="text-center">{{ item.o_meja }}</td>
                              <td class="text-center">{{ item.qty_piring }}</td>
                              <td class="text-center">{{ item.qty_gelas }}</td>
                              <td class="text-center">{{ item.pengantar }}</td>
                           </tr>
                           {% set ttl_prg += item.qty_piring %}
                           {% set ttl_gls += item.qty_gelas %}
                           {% endfor %}
                           {% else %}
                           <tr>
                              <td colspan="7" class="text-center text-muted">Belum ada riwayat peralatan.</td>
                           </tr>
                           {% endif %}
                        </tbody>
                        <tfoot>
                           <tr>
                              <td colspan="4">Total</td>
                              <td class="text-center">{{ ttl_prg }}</td>
                              <td class="text-center">{{ ttl_gls }}</td>
                              <td></td>
                           </tr>
                        </tfoot>
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
</script>
