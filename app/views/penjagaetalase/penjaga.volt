<div class="content-header">
   <div class="container">
      <div class="row mb-2">
         <div class="col-sm-6">
            <h1 class="m-0">Plotting Penjaga</h1>
         </div>
         <div class="col-sm-6 small">
            <ol class="breadcrumb float-sm-right">
               <li class="breadcrumb-item"><a href="#">Home</a></li>
               <li class="breadcrumb-item"><a href="#">Penjaga Etalase</a></li>
               <li class="breadcrumb-item active">Plotting Penjaga</li>
            </ol>
         </div>
      </div>
   </div>
</div>

<div class="content">
   <div class="container">
      <div class="row justify-content-center">
         <div class="col-lg-9">
            <div class="card card-primary card-outline">
               <div class="card-header">
                  <h3 class="card-title m-0">Plotting Penjaga Etalase Hari Ini</h3>
                  <div class="card-tools">
                     <button type="button" class="btn btn-tool bg-primary" data-toggle="modal" data-target="#modal-tambah-penjaga">
                        <i class="fas fa-plus"></i>
                        <span class="text-white">Tambah Penjaga</span>
                     </button>
                  </div>
               </div>
               <div class="card-body p-2">
                  <div class="table-responsive">
                     <table class="table table-sm table-striped table-hover">
                        <thead class="text-center">
                           <tr>
                              <th>No</th>
                              <th>Area Etalase</th>
                              <th>Penjaga</th>
                              <th>Aksi</th>
                           </tr>
                        </thead>
                        <tbody>
                           {% for item in penjaga_etalase %}
                           <tr>
                              <td class="text-center">{{ loop.index }}</td>
                              <td>{{ item.area_etalase }}</td>
                              <td>{{ item.nama_alias }}</td>
                              <td class="text-center">
                                 <button
                                    type="button"
                                    class="btn btn-warning btn-xs btn-edit-penjaga"
                                    data-toggle="modal"
                                    data-target="#modal-edit-penjaga"
                                    data-id="{{ item.id }}"
                                    data-id-area="{{ item.id_area }}"
                                    data-penjaga="{{ item.penjaga }}">
                                    <i class="fas fa-edit"></i> Edit
                                 </button>
                                 <button
                                    type="button"
                                    class="btn btn-danger btn-xs btn-hapus-penjaga"
                                    data-toggle="modal"
                                    data-target="#modal-hapus-penjaga"
                                    data-id="{{ item.id }}"
                                    data-area="{{ item.area_etalase }}"
                                    data-penjaga-nama="{{ item.nama_alias }}">
                                    <i class="fas fa-trash"></i> Hapus
                                 </button>
                              </td>
                           </tr>
                           {% else %}
                           <tr>
                              <td colspan="4" class="text-center text-muted">Belum ada data penjaga etalase hari ini.</td>
                           </tr>
                           {% endfor %}
                        </tbody>
                     </table>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>

<div id="modal-tambah-penjaga" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modal-tambah-penjaga-title" aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
         <div class="modal-header bg-primary">
            <h5 class="modal-title" id="modal-tambah-penjaga-title">Tambah Penjaga Etalase</h5>
            <button class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <form action="{{ url('penjagaetalase/tambah_penjaga') }}" method="post" id="form-tambah-penjaga">
            <div class="modal-body">
               <div class="form-group">
                  <label for="id-area">Area Etalase</label>
                  <select name="id_area" id="id-area" class="form-control form-control-sm" required>
                     <option value="">Pilih area etalase</option>
                     {% for area in area_etalase %}
                     <option value="{{ area.id_area }}">{{ area.area_etalase }}</option>
                     {% endfor %}
                  </select>
               </div>
               <div class="form-group mb-0">
                  <label for="penjaga">Nama Penjaga</label>
                  <select name="penjaga" id="penjaga" class="form-control form-control-sm" required>
                     <option value="">Pilih penjaga</option>
                     {% for pt in parttimer_gudang_peralatan %}
                     <option value="{{ pt.pt_mparttimer_id }}">{{ pt.nama_alias }}</option>
                     {% endfor %}
                  </select>
               </div>
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal"><i class="fas fa-times" aria-hidden="true"></i> Tutup</button>
               <button type="submit" class="btn btn-primary btn-sm" id="btn-simpan-penjaga"><i class="fa fa-save" aria-hidden="true"></i> <span class="btn-label">Simpan</span></button>
            </div>
         </form>
      </div>
   </div>
</div>

<div id="modal-edit-penjaga" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modal-edit-penjaga-title" aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
         <div class="modal-header bg-warning">
            <h5 class="modal-title" id="modal-edit-penjaga-title">Edit Penjaga Etalase</h5>
            <button class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <form action="{{ url('penjagaetalase/edit_penjaga') }}" method="post" id="form-edit-penjaga">
            <input type="hidden" name="id" id="edit-id">
            <div class="modal-body">
               <div class="form-group">
                  <label for="edit-id-area">Area Etalase</label>
                  <select name="id_area" id="edit-id-area" class="form-control form-control-sm" required>
                     <option value="">Pilih area etalase</option>
                     {% for area in area_etalase %}
                     <option value="{{ area.id_area }}">{{ area.area_etalase }}</option>
                     {% endfor %}
                  </select>
               </div>
               <div class="form-group mb-0">
                  <label for="edit-penjaga">Nama Penjaga</label>
                  <select name="penjaga" id="edit-penjaga" class="form-control form-control-sm" required>
                     <option value="">Pilih penjaga</option>
                     {% for pt in parttimer_gudang_peralatan %}
                     <option value="{{ pt.pt_mparttimer_id }}">{{ pt.nama_alias }}</option>
                     {% endfor %}
                  </select>
               </div>
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal"><i class="fas fa-times" aria-hidden="true"></i> Tutup</button>
               <button type="submit" class="btn btn-warning btn-sm" id="btn-edit-penjaga"><i class="fa fa-save" aria-hidden="true"></i> <span class="btn-label">Update</span></button>
            </div>
         </form>
      </div>
   </div>
</div>

<div id="modal-hapus-penjaga" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modal-hapus-penjaga-title" aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
         <div class="modal-header bg-danger">
            <h5 class="modal-title" id="modal-hapus-penjaga-title">Konfirmasi Hapus Penjaga</h5>
            <button class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <form action="{{ url('penjagaetalase/hapus_penjaga') }}" method="post" id="form-hapus-penjaga">
            <input type="hidden" name="id" id="hapus-id">
            <div class="modal-body">
               <p class="mb-2">Data berikut akan dihapus:</p>
               <div class="small">
                  <div><strong>Area:</strong> <span id="hapus-area">-</span></div>
                  <div><strong>Penjaga:</strong> <span id="hapus-penjaga">-</span></div>
               </div>
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal"><i class="fas fa-times" aria-hidden="true"></i> Batal</button>
               <button type="submit" class="btn btn-danger btn-sm" id="btn-hapus-penjaga"><i class="fas fa-trash" aria-hidden="true"></i> <span class="btn-label">Ya, Hapus</span></button>
            </div>
         </form>
      </div>
   </div>
</div>

<script>
   $(function () {
      $('#form-tambah-penjaga').on('submit', function () {
         var $button = $('#btn-simpan-penjaga');

         if ($button.prop('disabled')) {
            return false;
         }

         $button.prop('disabled', true);
         $button.html('<i class="fa fa-spinner fa-spin" aria-hidden="true"></i> Menyimpan...');
      });

      $('.btn-edit-penjaga').on('click', function () {
         var $button = $(this);
         $('#edit-id').val($button.data('id'));
         $('#edit-id-area').val($button.data('id-area'));
         $('#edit-penjaga').val($button.data('penjaga'));
      });

      $('#form-edit-penjaga').on('submit', function () {
         var $button = $('#btn-edit-penjaga');

         if ($button.prop('disabled')) {
            return false;
         }

         $button.prop('disabled', true);
         $button.html('<i class="fa fa-spinner fa-spin" aria-hidden="true"></i> Menyimpan...');
      });

      $('.btn-hapus-penjaga').on('click', function () {
         var $button = $(this);
         $('#hapus-id').val($button.data('id'));
         $('#hapus-area').text($button.data('area'));
         $('#hapus-penjaga').text($button.data('penjaga-nama'));
      });

      $('#form-hapus-penjaga').on('submit', function () {
         var $button = $('#btn-hapus-penjaga');

         if ($button.prop('disabled')) {
            return false;
         }

         $button.prop('disabled', true);
         $button.html('<i class="fa fa-spinner fa-spin" aria-hidden="true"></i> Menghapus...');
      });
   });
</script>
