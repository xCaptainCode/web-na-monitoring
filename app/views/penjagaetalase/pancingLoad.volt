<div class="card card-primary card-outline">
   <div class="card-header">
      <h3 class="card-title m-0">Daftar Nota Area {{ area_label }}</h3>
   </div>
   <div class="card-body p-2">
      <div class="table-responsive">
         <table id="dataTable" class="table table-sm table-bordered table-striped table-hover">
            <thead class="text-center">
               <tr>
                  <th>Nota</th>
                  <th>Customer</th>
                  <th>Meja</th>
                  <th>Piring</th>
                  <th>Gelas</th>
               </tr>
            </thead>
            <tbody>
               {% set hasRow = false %}
               {% for dn in daftar_nota %}
               {% if dn.qty_piring > 0 or dn.qty_gls > 0 %}
               {% set hasRow = true %}
               <tr class="row-click"
                  data-id="{{ dn.o_kode }}"
                  data-kode="{{ dn.nota_format }}"
                  data-customer="{{ dn.o_cnama }}"
                  data-jmlorg="{{ dn.o_jmlorg }}"
                  data-meja="{{ dn.o_meja }}"
                  data-area="{{ dn.id_area }}"
                  data-pengantar="{{ dn.j_pengantar }}"
                  data-piring="{{ dn.qty_piring }}"
                  data-gls="{{ dn.qty_gls }}"
                  data-jam="{{ dn.j_jam }}">
                  <td class="text-center text-bold">{{ dn.nota_format }}</td>
                  <td>{{ dn.o_cnama }}</td>
                  <td class="text-center">{{ dn.o_meja }}</td>
                  <td class="text-center">{{ dn.qty_piring }}</td>
                  <td class="text-center">{{ dn.qty_gls }}</td>
               </tr>
               {% endif %}
               {% endfor %}
               {% if hasRow == false %}
               <tr>
                  <td colspan="5" class="text-center text-muted">Belum ada nota area {{ area_label|lower }}.</td>
               </tr>
               {% endif %}
            </tbody>
         </table>
      </div>
   </div>
</div>
