<div class="row">
   <div class="col-lg-9">
      <div class="card card-success card-outline presence-card-body">
         <div class="card-header">
            <h3 class="card-title m-0">Daftar Nota Belum Saji</h3>
         </div>
         <div class="card-body p-2">
            <div class="table-responsive">
               <table id="dataTable" class="table table-sm table-bordered table-striped table-hover">
                  <thead class="text-center bg-success">
                     <tr>
                        <th>Nota</th>
                        <th>Customer</th>
                        <th>Meja</th>
                        <th>Sesek</th>
                        <th>Goreng</th>
                        <th>Bakar</th>
                        <th>Saji</th>
                        <th>Note</th>
                     </tr>
                  </thead>
                  <tbody>
                     {% set hasRow = false %}
                     {% for dn in daftar_nota %}
                     {% set hasRow = true %}
                     <tr class="row-click {% if dn.waktu_saji >= '00:25' %}bg-danger{% elseif dn.waktu_saji >= '00:20' %}bg-warning{% endif %}" style="cursor:pointer"
                        data-id="{{ dn.o_kode }}"
                        data-kode="{{ dn.nota_format }}"
                        data-customer="{{ dn.o_cnama }}"
                        data-meja="{{ dn.o_meja }}"
                        data-sesek="{{ dn.sesek }}"
                        data-goreng="{{ dn.goreng }}"
                        data-bakar="{{ dn.bakar }}"
                        data-saji="{{ dn.waktu_saji }}"
                        data-note="{{ dn.catatan }}"
                        data-detail="{{ dn.detail_makanan_base64 }}">
                        <td class="text-center text-bold">{{ dn.nota_format }}</td>
                        <td>{{ dn.o_cnama }}</td>
                        <td class="text-center">{{ dn.o_meja }}</td>
                        <td align="center">
                           {% if dn.sesek > '00:00:01' %}
                              <span class="text-dark"><i class="fa fa-check-circle" aria-hidden="true"></i></span>
                           {% elseif dn.is_adaikan == '0' %}
                              <span class="text-dark"><i class="fa fa-check-circle" aria-hidden="true"></i></span>
                           {% else %}
                           -
                           {% endif %}
                        </td>
                        <td align="center">
                           {% if dn.goreng > '00:00:01' %}
                              <span class="text-dark"><i class="fa fa-check-circle" aria-hidden="true"></i></span>
                           {% elseif dn.is_adaikan == '0' %}
                              <span class="text-dark"><i class="fa fa-check-circle" aria-hidden="true"></i></span>
                           {% else %}
                           -
                           {% endif %}
                        </td>
                        <td align="center">
                           {% if dn.bakar > '00:00:01' %}
                              <span class="text-dark"><i class="fa fa-check-circle" aria-hidden="true"></i></span>
                           {% elseif dn.is_adaikan == '0' %}
                              <span class="text-dark"><i class="fa fa-check-circle" aria-hidden="true"></i></span>
                           {% else %}
                           -
                           {% endif %}
                        </td>
                        <td class="text-center">{{ dn.waktu_saji }}</td>
                        <td>{{ dn.catatan }}</td>
                     </tr>
                     {% endfor %}
                     {% if hasRow == false %}
                     <tr>
                        <td colspan="8" class="text-center text-muted">Belum ada nota yang menunggu disajikan.</td>
                     </tr>
                     {% endif %}
                  </tbody>
               </table>
            </div>
         </div>
      </div>
   </div>

   <div class="col-lg-3">
      <div class="card card-orange card-outline presence-card-body">
         <div class="card-header">
            <h3 class="card-title m-0">Daftar Menu Sudah Di Order</h3>
         </div>
         <div class="card-body p-2">
            <div class="table-responsive">
               <table class="table table-sm table-bordered table-striped table-hover mb-0">
                  <thead class="text-center bg-orange">
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
