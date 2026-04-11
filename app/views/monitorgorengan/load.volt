<div class="row">
   <div class="col-lg-8">
      <div class="card card-indigo card-outline presence-card-body">
         <div class="card-header">
            <h3 class="card-title m-0">Daftar Nota Belum Saji</h3>
         </div>
         <div class="card-body p-2">
            <div class="table-responsive">
               <table id="dataTable" class="table table-sm table-bordered table-striped table-hover">
                  <thead class="text-center bg-indigo">
                     <tr>
                        <th>Nota</th>
                        <th>Customer</th>
                        <th>Meja</th>
                        <th>Tunggu</th>
                        <th>Item</th>
                     </tr>
                  </thead>
                  <tbody>
                     {% set hasRow = false %}
                     {% for dn in daftar_nota %}
                     {% set hasRow = true %}
                     <tr class="row-click {% if dn.has_meja == false %}table-warning{% endif %}"
                        style="cursor:pointer"
                        data-id="{{ dn.o_kode }}"
                        data-kode="{{ dn.nota_format }}"
                        data-customer="{{ dn.o_cnama }}"
                        data-area="{{ dn.area }}"
                        data-meja="{{ dn.o_meja }}"
                        data-jmlorg="{{ dn.o_jmlorg }}"
                        data-jam="{{ dn.tunggu }}"
                        data-detail="{{ dn.detail_nota_base64 }}"
                        data-note="{{ dn.o_note }}"
                        data-has-meja="{% if dn.has_meja %}1{% else %}0{% endif %}">
                        <td class="text-center text-bold">{{ dn.nota_format }}</td>
                        <td>{{ dn.o_cnama }}</td>
                        <td class="text-center">
                           {{ dn.o_meja }}
                           {% if dn.has_meja == false %}
                           <span class="badge badge-warning ml-1">Belum Dapat Meja</span>
                           {% endif %}
                        </td>
                        <td class="text-center">{{ dn.tunggu }}</td>
                        <td class="text-center">{{ dn.jumlah_nota }}</td>
                     </tr>
                     {% endfor %}
                     {% if hasRow == false %}
                     <tr>
                        <td colspan="5" class="text-center text-muted">Belum ada nota yang menunggu disajikan.</td>
                     </tr>
                     {% endif %}
                  </tbody>
               </table>
            </div>
         </div>
      </div>
   </div>

   <div class="col-lg-4">
      <div class="card card-pink card-outline presence-card-body">
         <div class="card-header">
            <h3 class="card-title m-0">Daftar Menu Sudah Di Order</h3>
         </div>
         <div class="card-body p-2">
            <div class="table-responsive">
               <table class="table table-sm table-bordered table-striped table-hover mb-0">
                  <thead class="text-center bg-pink">
                     <tr>
                        <th>Menu</th>
                        <th>Qty</th>
                        <th>Satuan</th>
                     </tr>
                  </thead>
                  <tbody>
                     {% set hasOrder = false %}
                     {% for item in daftar_nota_order %}
                     {% set hasOrder = true %}
                     <tr>
                        <td>{{ item.nama_olahan }}</td>
                        <td class="text-center">{{ item.total_qty }}</td>
                        <td class="text-center">{{ item.satuan }}</td>
                        {# <td class="text-center">
                           {{ item.jml_nota }}
                           {% if item.jml_nota_belum_meja > 0 %}
                           <div><span class="badge badge-warning">{{ item.jml_nota_belum_meja }} blm meja</span></div>
                           {% endif %}
                        </td> #}
                     </tr>
                     {% endfor %}
                     {% if hasOrder == false %}
                     <tr>
                        <td colspan="3" class="text-center text-muted">Belum ada nota yang di-order.</td>
                     </tr>
                     {% endif %}
                  </tbody>
               </table>
            </div>
         </div>
      </div>
   </div>
</div>
