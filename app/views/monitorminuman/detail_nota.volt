<style>
   @import url('https://fonts.googleapis.com/css2?family=Share+Tech+Mono&family=Courier+Prime:wght@400;700&display=swap');

   body {
      background: #e8e4dc;
      background-image: repeating-linear-gradient(0deg,
            transparent,
            transparent 24px,
            rgba(0, 0, 0, 0.03) 24px,
            rgba(0, 0, 0, 0.03) 25px);
   }

   .struk-wrapper {
      display: flex;
      justify-content: center;
      padding: 10px 10px 60px;
   }

   .struk {
      width: 530px;
      max-width: 450px;
      background: #fffef9;
      font-family: 'Courier Prime', 'Courier New', monospace;
      font-size: 13px;
      color: #1a1a1a;
      padding: 0;
      position: relative;

      /* Efek kertas struk */
      box-shadow:
         0 2px 4px rgba(0, 0, 0, 0.1),
         0 8px 20px rgba(0, 0, 0, 0.15);
   }

   /* Gigi atas struk */
   .struk::before {
      content: '';
      display: block;
      height: 16px;
      background:
         radial-gradient(circle at 8px 16px, #e8e4dc 8px, transparent 8px),
         linear-gradient(#e8e4dc, #e8e4dc);
      background-size: 16px 16px, 100% 8px;
      background-repeat: repeat-x, no-repeat;
      background-position: 0 0, 0 0;
   }

   /* Gigi bawah struk */
   .struk::after {
      content: '';
      display: block;
      height: 16px;
      background:
         radial-gradient(circle at 8px 0px, #e8e4dc 8px, transparent 8px),
         linear-gradient(#e8e4dc, #e8e4dc);
      background-size: 16px 16px, 100% 8px;
      background-repeat: repeat-x, no-repeat;
      background-position: 0 0, 0 8px;
   }

   .struk-inner {
      padding: 16px 24px 20px;
   }

   /* ---- HEADER ---- */
   .struk-header {
      text-align: center;
      margin-bottom: 12px;
   }

   .struk-header .resto-name {
      font-size: 18px;
      font-weight: 700;
      letter-spacing: 3px;
      text-transform: uppercase;
   }

   .struk-header .tagline {
      font-size: 11px;
      color: #666;
      letter-spacing: 1px;
   }

   /* ---- DIVIDER ---- */
   .dash {
      border: none;
      border-top: 1px dashed #999;
      margin: 10px 0;
   }

   .solid {
      border: none;
      border-top: 2px solid #1a1a1a;
      margin: 10px 0;
   }

   .dash-double {
      border: none;
      border-top: 1px dashed #999;
      margin: 2px 0;
   }

   /* ---- INFO ROWS ---- */
   .info-row {
      display: flex;
      justify-content: space-between;
      margin-bottom: 3px;
      line-height: 1.5;
   }

   .info-row .label {
      color: #555;
      white-space: nowrap;
      flex-shrink: 0;
      min-width: 120px;
   }

   .info-row .value {
      font-weight: 700;
      text-align: right;
      word-break: break-word;
   }

   /* ---- NOTA BADGE ---- */
   .nota-badge {
      text-align: center;
      font-size: 28px;
      font-weight: 700;
      letter-spacing: 6px;
      padding: 6px 0;
      border-top: 2px solid #1a1a1a;
      border-bottom: 2px solid #1a1a1a;
      margin: 10px 0;
   }

   /* ---- SECTION TITLE ---- */
   .section-title {
      text-align: center;
      font-weight: 700;
      font-size: 11px;
      letter-spacing: 2px;
      text-transform: uppercase;
      color: #444;
      margin: 8px 0 6px;
   }

   /* ---- JAM SAJI ---- */
   .jamsaji-grid {
      display: grid;
      grid-template-columns: 1fr 1fr 1fr;
      gap: 6px;
      margin-bottom: 6px;
   }

   .jamsaji-item {
      text-align: center;
      border: 1px dashed #aaa;
      padding: 4px 2px;
      border-radius: 2px;
   }

   .jamsaji-item .js-label {
      font-size: 9px;
      color: #666;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      display: block;
   }

   .jamsaji-item .js-value {
      font-size: 13px;
      font-weight: 700;
   }

   /* ---- MENU TABLE ---- */
   .menu-table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 6px;
   }

   .menu-table thead tr {
      border-top: 1px dashed #999;
      border-bottom: 1px dashed #999;
   }

   .menu-table th {
      font-size: 10px;
      letter-spacing: 1px;
      text-transform: uppercase;
      padding: 4px 2px;
      color: #444;
      font-weight: 700;
   }

   .menu-table td {
      padding: 3px 2px;
      vertical-align: top;
      font-size: 12.5px;
      line-height: 1.4;
   }

   .menu-table .col-nama {
      width: 45%;
   }

   .menu-table .col-qty {
      width: 10%;
      text-align: center;
   }

   .menu-table .col-sat {
      width: 12%;
      text-align: center;
   }

   .menu-table .col-ikan {
      width: 10%;
      text-align: center;
   }

   .menu-table .col-hrg {
      width: 23%;
      text-align: right;
   }

   /* ---- TOTAL AREA ---- */
   .total-row {
      display: flex;
      justify-content: space-between;
      padding: 2px 0;
      font-size: 12.5px;
   }

   .total-row.grand {
      font-size: 15px;
      font-weight: 700;
      padding: 5px 0;
      border-top: 2px solid #1a1a1a;
      border-bottom: 2px solid #1a1a1a;
      margin: 4px 0;
   }

   .total-row.bayar {
      font-weight: 700;
   }

   /* ---- FOOTER ---- */
   .struk-footer {
      text-align: center;
      font-size: 11px;
      color: #666;
      margin-top: 12px;
      letter-spacing: 0.5px;
   }

   .struk-footer .thankyou {
      font-size: 13px;
      font-weight: 700;
      color: #1a1a1a;
      letter-spacing: 2px;
      display: block;
      margin-bottom: 2px;
   }

   /* ---- NOTE ---- */
   .nota-note {
      font-size: 11px;
      color: #555;
      border-left: 3px solid #999;
      padding-left: 8px;
      margin-top: 4px;
      font-style: italic;
   }

   /* ---- CLOSE BUTTON ---- */
   .btn-close-struk {
      display: flex;
      justify-content: center;
      margin-top: 20px;
   }

   .btn-close-struk a {
      font-family: 'Courier Prime', monospace;
      font-size: 13px;
      letter-spacing: 2px;
      text-transform: uppercase;
      color: #555;
      border: 1px dashed #999;
      padding: 8px 28px;
      text-decoration: none;
      transition: all 0.2s;
   }

   .btn-close-struk a:hover {
      background: #1a1a1a;
      color: #fff;
      border-color: #1a1a1a;
   }
</style>

<div class="struk-wrapper">
   <div>
      <div class="struk">
         <div class="struk-inner">

            {# {{-- HEADER --}} #}
            <div class="struk-header">
               <div class="resto-name">Nota</div>
               <div class="tagline">Rincian Nota Transaksi</div>
            </div>

            {# {{-- NOTA NOMOR --}} #}
            <div class="nota-badge">{{ data.nota_format }}</div>

            {# {{-- INFO TAMU --}} #}
            <div class="info-row">
               <span class="label">Nama</span>
               <span class="value">{{ data.o_cnama }}</span>
            </div>
            <div class="info-row">
               <span class="label">Tempat</span>
               <span class="value">{{ data.o_meja }}</span>
            </div>
            <div class="info-row">
               <span class="label">Jumlah Tamu</span>
               <span class="value">{{ data.o_jmlorg }} Orang</span>
            </div>

            <hr class="dash">

            {# {{-- INFO TRANSAKSI --}} #}
            <div class="info-row">
               <span class="label">Waktu Pesan</span>
               <span class="value">{{ Helpers.tgl_indo(data1.j_tgl) }} {{ Helpers.showJam(data1.j_jam, 'H:i') }}</span>
            </div>
            <div class="info-row">
               <span class="label">Petugas Order</span>
               <span class="value">{{ Helpers.ucwords(data1.username) }}</span>
            </div>
            <div class="info-row">
               <span class="label">Kasir</span>
               <span class="value">{{ data1.j_namakasir }}</span>
            </div>
            <div class="info-row">
               <span class="label">Pengantar</span>
               <span class="value">{{ Helpers.ucwords(data1.j_pengantar) }}</span>
            </div>

            <hr class="dash">

            {# {{-- JAM SAJI --}} #}
            <div class="section-title">— Jam Saji —</div>
            <div class="jamsaji-grid">
               <div class="jamsaji-item">
                  <span class="js-label">Ikan & Makanan</span>
                  <span class="js-value">
                     {% if data1.j_jamsaji %}{{ Helpers.showJam(data1.j_jamsaji, 'H:i') }}{% else %}-{% endif %}
                  </span>
                  <hr class="m-1">
                  <span class="js-label">Pramusaji</span>
                  <span class="js-value">{{ penyaji }}</span>
               </div>
               <div class="jamsaji-item">
                  <span class="js-label">Minuman</span>
                  <span class="js-value">
                     {% if data1.j_jamsajiminum %}{{ Helpers.showJam(data1.j_jamsajiminum, 'H:i') }}{% else %}-{% endif
                     %}
                  </span>
                  <hr class="m-1">
                  <span class="js-label">Pramusaji</span>
                  <span class="js-value">{{ penyaji_minum }}</span>
               </div>
               <div class="jamsaji-item">
                  <span class="js-label">Lain-lain</span>
                  <span class="js-value">
                     {% if data1.j_jamsajigorengan %}{{ Helpers.showJam(data1.j_jamsajigorengan, 'H:i') }}{% else %}-{%
                     endif %}
                  </span>
                  <hr class="m-1">
                  <span class="js-label">Pramusaji</span>
                  <span class="js-value">{{ penyaji_gorengan }}</span>
               </div>
            </div>

            <hr class="dash">

            {# {{-- DAFTAR MENU --}} #}
            <div class="section-title">— Daftar Menu —</div>
            <table class="menu-table">
               <thead>
                  <tr>
                     <th class="col-nama">Menu</th>
                     <th class="col-qty">Qty</th>
                     <th class="col-sat">Sat</th>
                     <th class="col-ikan">Ikan</th>
                     <th class="col-hrg">Harga</th>
                  </tr>
               </thead>
               <tbody>
                  {% set ttl = 0 %}
                  {% for datum in data4 %}
                  <tr>
                     <td class="col-nama">{{ datum.nama_olahan }}</td>
                     <td class="col-qty">{{ datum.od_qty }}</td>
                     <td class="col-sat">{{ datum.satuan }}</td>
                     <td class="col-ikan">{% if datum.od_ekor > 0 %}{{ datum.od_ekor }}E{% else %}-{% endif %}</td>
                     <td class="col-hrg">{{ Helpers.number(datum.od_jmlhrg) }}</td>
                  </tr>
                  {% set ttl = ttl + datum.od_jmlhrg %}
                  {% endfor %}
               </tbody>
            </table>

            {# {{-- TOTAL AREA --}} #}
            <hr class="dash">
            <div class="total-row">
               <span>Subtotal</span>
               <span>{{ Helpers.number(ttl) }}</span>
            </div>
            <div class="total-row">
               <span>Diskon</span>
               <span>-{{ Helpers.number(data1.j_discashnom) }}</span>
            </div>
            <div class="total-row">
               <span>Pajak</span>
               <span>{{ Helpers.number(data1.j_pajaknom) }}</span>
            </div>
            <div class="total-row grand">
               <span>TOTAL</span>
               <span>{{ Helpers.number(data1.j_jmltotal) }}</span>
            </div>
            <div class="total-row bayar">
               <span>Bayar</span>
               <span>{{ Helpers.number(data1.j_cash) }}</span>
            </div>
            <div class="total-row">
               <span>Kembali</span>
               <span>{{ Helpers.number(data1.j_kembali) }}</span>
            </div>

            {# {{-- NOTE --}} #}
            {% if data1.catatan %}
            <hr class="dash">
            <div class="nota-note">NOTE: {{ data1.catatan }}</div>
            {% endif %}

            {# {{-- FOOTER --}} #}
            <hr class="dash">
            <div class="struk-footer">
               <span class="thankyou">Terima Kasih</span>
               {# Simpan struk ini sebagai bukti pembayaran #}
            </div>

         </div>
         {# {{-- end struk-inner --}} #}
      </div>
      {# {{-- end struk --}} #}

      {# {{-- CLOSE BUTTON --}} #}
      <div class="btn-close-struk">
         <a href="" onclick="window.history.back(); return false;">✕ Tutup</a>
      </div>
   </div>
</div>