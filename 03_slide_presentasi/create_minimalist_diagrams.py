import os
import subprocess
import re

output_dir = r"c:\Users\anton\vibecoding\mobile2026_v2\03_slide_presentasi\diagram_assets"
chrome_path = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
temp_html = os.path.join(output_dir, "_temp_render_minimalist.html")

svg_files = {}

# ---------------------------------------------------------------------
# 1. state-spectrum.svg
# ---------------------------------------------------------------------
svg_files["state-spectrum.svg"] = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 880 290" width="100%" height="100%">
  <!-- Background Canvas -->
  <rect width="880" height="290" rx="8" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1.5"/>

  <!-- Header -->
  <rect x="30" y="20" width="130" height="24" rx="4" fill="#F3F4F6" stroke="#E5E7EB" stroke-width="1"/>
  <text x="95" y="36" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5" font-weight="bold" text-anchor="middle">TAKSONOMI STATE</text>
  <text x="175" y="37" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="14" font-weight="bold">SPEKTRUM PENGELOLAAN STATE: EPHEMERAL VS APP STATE</text>

  <!-- Left: Ephemeral State -->
  <g transform="translate(30, 60)">
    <rect width="395" height="205" rx="6" fill="#FAFAFA" stroke="#E5E7EB" stroke-width="1.5"/>
    <rect width="395" height="36" rx="6" fill="#F3F4F6"/>
    <rect x="0" y="35" width="395" height="1" fill="#E5E7EB"/>
    <text x="20" y="23" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="12" font-weight="bold">1. EPHEMERAL STATE (Lokal Widget)</text>
    <rect x="275" y="9" width="105" height="18" rx="3" fill="#E5E7EB"/>
    <text x="327" y="22" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5" font-weight="bold" text-anchor="middle">LOCAL LIFECYCLE</text>

    <!-- Scope Box -->
    <rect x="18" y="48" width="359" height="64" rx="4" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="197" y="68" fill="#111827" font-family="'Consolas', 'Courier New', monospace" font-size="12" font-weight="bold" text-anchor="middle">setState()  /  ValueNotifier</text>
    <text x="197" y="87" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10.5" text-anchor="middle">Hanya hidup di dalam 1 sub-pohon widget lokal</text>
    <text x="197" y="103" fill="#6B7280" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10" text-anchor="middle">Otomatis dihancurkan saat widget keluar dari pohon antarmuka</text>

    <!-- Usage Cases -->
    <rect x="18" y="122" width="359" height="68" rx="4" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="30" y="142" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10" font-weight="bold">Contoh Kasus Implementasi:</text>
    <text x="30" y="160" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.8">• Visibilitas input password (obscureText toggle)</text>
    <text x="30" y="177" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.8">• Index tab aktif, status accordion, animasi transisi lokal</text>
  </g>

  <!-- Right: App State -->
  <g transform="translate(455, 60)">
    <rect width="395" height="205" rx="6" fill="#FAFAFA" stroke="#111827" stroke-width="1.5"/>
    <rect width="395" height="36" rx="6" fill="#18181B"/>
    <text x="20" y="23" fill="#FFFFFF" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="12" font-weight="bold">2. APP STATE (Global / Shared State)</text>
    <rect x="265" y="9" width="115" height="18" rx="3" fill="#3F3F46"/>
    <text x="322" y="22" fill="#FFFFFF" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5" font-weight="bold" text-anchor="middle">GLOBAL LIFECYCLE</text>

    <!-- Scope Box -->
    <rect x="18" y="48" width="359" height="64" rx="4" fill="#FFFFFF" stroke="#D1D5DB" stroke-width="1"/>
    <text x="197" y="68" fill="#111827" font-family="'Consolas', 'Courier New', monospace" font-size="12" font-weight="bold" text-anchor="middle">BlocProvider  /  Cubit  /  Riverpod</text>
    <text x="197" y="87" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10.5" text-anchor="middle">Dibagikan ke banyak rute layar dan dapat dipersistensikan</text>
    <text x="197" y="103" fill="#6B7280" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10" text-anchor="middle">Tetap terjaga dan aktif selama sesi aplikasi berlangsung</text>

    <!-- Usage Cases -->
    <rect x="18" y="122" width="359" height="68" rx="4" fill="#FFFFFF" stroke="#D1D5DB" stroke-width="1"/>
    <text x="30" y="142" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10" font-weight="bold">Contoh Kasus Implementasi:</text>
    <text x="30" y="160" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.8">• Keranjang belanja e-commerce &amp; kalkulasi harga checkout</text>
    <text x="30" y="177" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.8">• Sesi login pengguna (AuthToken) &amp; preferensi tema aplikasi</text>
  </g>
</svg>"""

# ---------------------------------------------------------------------
# 2. prop-drilling-vs-provider.svg
# ---------------------------------------------------------------------
svg_files["prop-drilling-vs-provider.svg"] = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 920 360" width="100%" height="100%">
  <defs>
    <marker id="arrowDark" markerWidth="6" markerHeight="6" refX="5" refY="3" orient="auto">
      <path d="M 0 0 L 6 3 L 0 6 z" fill="#111827"/>
    </marker>
    <marker id="arrowGrey" markerWidth="6" markerHeight="6" refX="5" refY="3" orient="auto">
      <path d="M 0 0 L 6 3 L 0 6 z" fill="#6B7280"/>
    </marker>
  </defs>

  <!-- Background Canvas -->
  <rect width="920" height="360" rx="8" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1.5"/>

  <!-- Header -->
  <text x="460" y="28" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="13.5" font-weight="bold" text-anchor="middle">PERBANDINGAN DISTRIBUSI DATA: PROP DRILLING VS SCOPED STATE MANAGEMENT</text>

  <!-- Left Panel: Prop Drilling -->
  <g transform="translate(25, 45)">
    <rect width="425" height="265" rx="6" fill="#FAFAFA" stroke="#E5E7EB" stroke-width="1.5"/>
    <rect width="425" height="34" rx="6" fill="#F3F4F6"/>
    <rect x="0" y="33" width="425" height="1" fill="#E5E7EB"/>
    <text x="20" y="22" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="11.5" font-weight="bold">POLA 1: PROP DRILLING</text>
    <rect x="300" y="8" width="110" height="18" rx="3" fill="#E5E7EB"/>
    <text x="355" y="20.5" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5" font-weight="bold" text-anchor="middle">ANTIPOLA STRUKTUR</text>

    <!-- Node 1 -->
    <rect x="135" y="46" width="155" height="28" rx="4" fill="#FFFFFF" stroke="#111827" stroke-width="1.2"/>
    <text x="212" y="64" fill="#111827" font-family="'Consolas', 'Courier New', monospace" font-size="10.5" font-weight="bold" text-anchor="middle">LayarUtama(cart)</text>

    <!-- Arrow 1 -->
    <line x1="212" y1="74" x2="212" y2="92" stroke="#6B7280" stroke-width="1.2" stroke-dasharray="3,3" marker-end="url(#arrowGrey)"/>
    <text x="270" y="86" fill="#6B7280" font-family="'Consolas', 'Courier New', monospace" font-size="8.5">pass cart</text>

    <!-- Node 2 -->
    <rect x="135" y="94" width="155" height="28" rx="4" fill="#FFFFFF" stroke="#9CA3AF" stroke-width="1"/>
    <text x="212" y="112" fill="#4B5563" font-family="'Consolas', 'Courier New', monospace" font-size="10" text-anchor="middle">DaftarProduk(cart)</text>

    <!-- Arrow 2 -->
    <line x1="212" y1="122" x2="212" y2="140" stroke="#6B7280" stroke-width="1.2" stroke-dasharray="3,3" marker-end="url(#arrowGrey)"/>
    <text x="270" y="134" fill="#6B7280" font-family="'Consolas', 'Courier New', monospace" font-size="8.5">pass cart</text>

    <!-- Node 3 -->
    <rect x="135" y="142" width="155" height="28" rx="4" fill="#FFFFFF" stroke="#9CA3AF" stroke-width="1"/>
    <text x="212" y="160" fill="#4B5563" font-family="'Consolas', 'Courier New', monospace" font-size="10" text-anchor="middle">ItemCard(cart)</text>

    <!-- Arrow 3 -->
    <line x1="212" y1="170" x2="212" y2="188" stroke="#6B7280" stroke-width="1.2" stroke-dasharray="3,3" marker-end="url(#arrowGrey)"/>
    <text x="270" y="182" fill="#6B7280" font-family="'Consolas', 'Courier New', monospace" font-size="8.5">pass cart</text>

    <!-- Node 4 -->
    <rect x="135" y="190" width="155" height="28" rx="4" fill="#FFFFFF" stroke="#111827" stroke-width="1.2"/>
    <text x="212" y="208" fill="#111827" font-family="'Consolas', 'Courier New', monospace" font-size="10.5" font-weight="bold" text-anchor="middle">TombolBeli(cart)</text>

    <!-- Evaluation Box -->
    <rect x="15" y="228" width="395" height="26" rx="4" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="212" y="245" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9" text-anchor="middle">Kelemahan: Widget perantara terbebani parameter yang tidak relevan dengan tugas visualnya.</text>
  </g>

  <!-- Right Panel: Scoped Provider -->
  <g transform="translate(470, 45)">
    <rect width="425" height="265" rx="6" fill="#FAFAFA" stroke="#111827" stroke-width="1.5"/>
    <rect width="425" height="34" rx="6" fill="#18181B"/>
    <text x="20" y="22" fill="#FFFFFF" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="11.5" font-weight="bold">POLA 2: SCOPED STATE DISTRIBUTION</text>
    <rect x="290" y="8" width="120" height="18" rx="3" fill="#3F3F46"/>
    <text x="350" y="20.5" fill="#FFFFFF" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5" font-weight="bold" text-anchor="middle">REKOMENDASI RESMI</text>

    <!-- Central Provider Node -->
    <rect x="110" y="46" width="205" height="34" rx="4" fill="#18181B" stroke="#3F3F46" stroke-width="1"/>
    <text x="212" y="62" fill="#FFFFFF" font-family="'Consolas', 'Courier New', monospace" font-size="10.5" font-weight="bold" text-anchor="middle">BlocProvider&lt;CartCubit&gt;</text>
    <text x="212" y="74" fill="#A1A1AA" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8" text-anchor="middle">Pusat State &amp; Logika Bisnis Mandiri</text>

    <!-- Clean Tree Middle -->
    <rect x="145" y="98" width="135" height="24" rx="3" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="212" y="114" fill="#6B7280" font-family="'Consolas', 'Courier New', monospace" font-size="9.5" text-anchor="middle">LayarUtama()</text>

    <line x1="212" y1="122" x2="212" y2="134" stroke="#D1D5DB" stroke-width="1"/>

    <rect x="145" y="134" width="135" height="24" rx="3" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="212" y="150" fill="#6B7280" font-family="'Consolas', 'Courier New', monospace" font-size="9.5" text-anchor="middle">DaftarProduk()</text>

    <!-- Direct Subscriptions -->
    <!-- Direct to Badge -->
    <path d="M 125 80 C 45 105 45 155 55 185" fill="none" stroke="#111827" stroke-width="1.4" stroke-dasharray="3,3" marker-end="url(#arrowDark)"/>
    <rect x="15" y="188" width="145" height="32" rx="4" fill="#FFFFFF" stroke="#111827" stroke-width="1.2"/>
    <text x="87" y="202" fill="#111827" font-family="'Consolas', 'Courier New', monospace" font-size="9.5" font-weight="bold" text-anchor="middle">BadgeKeranjang</text>
    <text x="87" y="214" fill="#6B7280" font-family="'Consolas', 'Courier New', monospace" font-size="8" text-anchor="middle">context.watch&lt;Cart&gt;()</text>

    <!-- Direct to Button -->
    <path d="M 300 80 C 380 105 380 155 370 185" fill="none" stroke="#111827" stroke-width="1.4" marker-end="url(#arrowDark)"/>
    <rect x="265" y="188" width="145" height="32" rx="4" fill="#FFFFFF" stroke="#111827" stroke-width="1.2"/>
    <text x="337" y="202" fill="#111827" font-family="'Consolas', 'Courier New', monospace" font-size="9.5" font-weight="bold" text-anchor="middle">TombolBeli</text>
    <text x="337" y="214" fill="#6B7280" font-family="'Consolas', 'Courier New', monospace" font-size="8" text-anchor="middle">context.read&lt;Cart&gt;()</text>

    <!-- Evaluation Box -->
    <rect x="15" y="228" width="395" height="26" rx="4" fill="#FFFFFF" stroke="#D1D5DB" stroke-width="1"/>
    <text x="212" y="245" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9" text-anchor="middle">Keunggulan: Widget anak mengakses data langsung dari context tanpa kopling hierarkis.</text>
  </g>

  <!-- Bottom Technical Strip -->
  <rect x="25" y="322" width="870" height="26" rx="4" fill="#F3F4F6" stroke="#E5E7EB" stroke-width="1"/>
  <text x="460" y="339" fill="#374151" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10" font-weight="600" text-anchor="middle">Prinsip Rekayasa: Scoped Provider memisahkan state dari pohon widget sehingga mereduksi kompleksitas pemeliharaan.</text>
</svg>"""

# ---------------------------------------------------------------------
# 3. cubit-vs-bloc.svg
# ---------------------------------------------------------------------
svg_files["cubit-vs-bloc.svg"] = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 920 360" width="100%" height="100%">
  <defs>
    <marker id="arrowDark" markerWidth="6" markerHeight="6" refX="5" refY="3" orient="auto">
      <path d="M 0 0 L 6 3 L 0 6 z" fill="#111827"/>
    </marker>
  </defs>

  <!-- Background Canvas -->
  <rect width="920" height="360" rx="8" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1.5"/>

  <!-- Header -->
  <text x="460" y="28" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="13.5" font-weight="bold" text-anchor="middle">PERBANDINGAN ARSITEKTUR: CUBIT (BERBASIS FUNGSI) VS BLOC (EVENT-DRIVEN)</text>

  <!-- Left: Cubit -->
  <g transform="translate(25, 45)">
    <rect width="425" height="295" rx="6" fill="#FAFAFA" stroke="#E5E7EB" stroke-width="1.5"/>
    <rect width="425" height="34" rx="6" fill="#F3F4F6"/>
    <rect x="0" y="33" width="425" height="1" fill="#E5E7EB"/>
    <text x="20" y="22" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="11.5" font-weight="bold">CUBIT: PENDEKATAN BERBASIS FUNGSI</text>
    <rect x="315" y="8" width="95" height="18" rx="3" fill="#E5E7EB"/>
    <text x="362" y="20.5" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5" font-weight="bold" text-anchor="middle">RINGKAS &amp; LINIER</text>

    <!-- Pipeline -->
    <rect x="15" y="46" width="115" height="42" rx="4" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="72" y="63" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5" font-weight="bold" text-anchor="middle">1. UI Screen</text>
    <text x="72" y="78" fill="#4B5563" font-family="'Consolas', monospace" font-size="8.5" text-anchor="middle">cubit.tambah()</text>

    <line x1="130" y1="67" x2="160" y2="67" stroke="#111827" stroke-width="1.4" marker-end="url(#arrowDark)"/>

    <rect x="165" y="46" width="125" height="42" rx="4" fill="#FFFFFF" stroke="#111827" stroke-width="1.2"/>
    <text x="227" y="63" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5" font-weight="bold" text-anchor="middle">2. Cubit Engine</text>
    <text x="227" y="78" fill="#111827" font-family="'Consolas', monospace" font-size="8.5" font-weight="bold" text-anchor="middle">emit(state + 1)</text>

    <line x1="290" y1="67" x2="320" y2="67" stroke="#111827" stroke-width="1.4" marker-end="url(#arrowDark)"/>

    <rect x="325" y="46" width="85" height="42" rx="4" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="367" y="63" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5" font-weight="bold" text-anchor="middle">3. Rebuild</text>
    <text x="367" y="78" fill="#4B5563" font-family="'Consolas', monospace" font-size="8.5" text-anchor="middle">UI Update</text>

    <!-- Characteristics Box -->
    <rect x="15" y="100" width="395" height="180" rx="4" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="25" y="120" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10.5" font-weight="bold">Karakteristik Arsitektur Cubit:</text>
    <text x="25" y="140" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.8">• Tidak memerlukan definisi kelas Event terpisah.</text>
    <text x="25" y="158" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.8">• Memanggil method langsung dari handler interaksi UI.</text>
    <text x="25" y="176" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.8">• Sedikit baris kode (minimal boilerplate); cepat diimplementasikan.</text>

    <line x1="25" y1="190" x2="385" y2="190" stroke="#F3F4F6" stroke-width="1"/>
    <text x="25" y="208" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10.5" font-weight="bold">Rekomendasi Penggunaan:</text>
    <text x="25" y="226" fill="#6B7280" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5">Form sederhana, toggle tema gelap/terang, filter katalog produk,</text>
    <text x="25" y="242" fill="#6B7280" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5">serta kebutuhan state lokal modul yang tidak butuh audit event.</text>
  </g>

  <!-- Right: BLoC -->
  <g transform="translate(470, 45)">
    <rect width="425" height="295" rx="6" fill="#FAFAFA" stroke="#111827" stroke-width="1.5"/>
    <rect width="425" height="34" rx="6" fill="#18181B"/>
    <text x="20" y="22" fill="#FFFFFF" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="11.5" font-weight="bold">BLOC: PENDEKATAN BERBASIS EVENT (FORMAL)</text>
    <rect x="295" y="8" width="115" height="18" rx="3" fill="#3F3F46"/>
    <text x="352" y="20.5" fill="#FFFFFF" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5" font-weight="bold" text-anchor="middle">ENTERPRISE GRADE</text>

    <!-- Pipeline -->
    <rect x="10" y="46" width="85" height="42" rx="4" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="52" y="63" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9" font-weight="bold" text-anchor="middle">1. Event UI</text>
    <text x="52" y="78" fill="#4B5563" font-family="'Consolas', monospace" font-size="8" text-anchor="middle">add(Submit())</text>

    <line x1="95" y1="67" x2="115" y2="67" stroke="#111827" stroke-width="1.4" marker-end="url(#arrowDark)"/>

    <rect x="120" y="46" width="95" height="42" rx="4" fill="#FFFFFF" stroke="#111827" stroke-width="1.2"/>
    <text x="167" y="63" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9" font-weight="bold" text-anchor="middle">2. Transformer</text>
    <text x="167" y="78" fill="#6B7280" font-family="'Consolas', monospace" font-size="7.8" text-anchor="middle">droppable()</text>

    <line x1="215" y1="67" x2="235" y2="67" stroke="#111827" stroke-width="1.4" marker-end="url(#arrowDark)"/>

    <rect x="240" y="46" width="85" height="42" rx="4" fill="#FFFFFF" stroke="#111827" stroke-width="1.2"/>
    <text x="282" y="63" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9" font-weight="bold" text-anchor="middle">3. Engine</text>
    <text x="282" y="78" fill="#111827" font-family="'Consolas', monospace" font-size="8" font-weight="bold" text-anchor="middle">emit(State)</text>

    <line x1="325" y1="67" x2="345" y2="67" stroke="#111827" stroke-width="1.4" marker-end="url(#arrowDark)"/>

    <rect x="350" y="46" width="65" height="42" rx="4" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="382" y="63" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9" font-weight="bold" text-anchor="middle">4. Rebuild</text>
    <text x="382" y="78" fill="#4B5563" font-family="'Consolas', monospace" font-size="8" text-anchor="middle">UI Update</text>

    <!-- Characteristics Box -->
    <rect x="15" y="100" width="395" height="180" rx="4" fill="#FFFFFF" stroke="#D1D5DB" stroke-width="1"/>
    <text x="25" y="120" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10.5" font-weight="bold">Karakteristik Arsitektur BLoC:</text>
    <text x="25" y="140" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.8">• Memisahkan masukan (Event) dan luaran (State) secara ketat.</text>
    <text x="25" y="158" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.8">• Mendukung debounce, throttle, droppable via event transformers.</text>
    <text x="25" y="176" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.8">• Jejak audit lengkap; seluruh interaksi dapat direkam dan diulang.</text>

    <line x1="25" y1="190" x2="385" y2="190" stroke="#F3F4F6" stroke-width="1"/>
    <text x="25" y="208" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10.5" font-weight="bold">Rekomendasi Penggunaan:</text>
    <text x="25" y="226" fill="#6B7280" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5">Modul transaksi perbankan, form checkout e-commerce,</text>
    <text x="25" y="242" fill="#6B7280" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5">pencarian asinkron real-time, dan sistem skala enterprise.</text>
  </g>
</svg>"""

# ---------------------------------------------------------------------
# 4. bloc-udf-flow.svg
# ---------------------------------------------------------------------
svg_files["bloc-udf-flow.svg"] = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 880 290" width="100%" height="100%">
  <defs>
    <marker id="arrowDark" markerWidth="6" markerHeight="6" refX="5" refY="3" orient="auto">
      <path d="M 0 0 L 6 3 L 0 6 z" fill="#111827"/>
    </marker>
  </defs>

  <!-- Background Canvas -->
  <rect width="880" height="290" rx="8" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1.5"/>

  <!-- Header -->
  <text x="440" y="28" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="13.5" font-weight="bold" text-anchor="middle">SIKLUS TERTUTUP UNIDIRECTIONAL DATA FLOW (UDF) PADA BLOC</text>

  <!-- Left: UI Screen -->
  <g transform="translate(30, 50)">
    <rect width="235" height="205" rx="6" fill="#FAFAFA" stroke="#E5E7EB" stroke-width="1.5"/>
    <rect width="235" height="34" rx="6" fill="#F3F4F6"/>
    <rect x="0" y="33" width="235" height="1" fill="#E5E7EB"/>
    <text x="117" y="22" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="11.5" font-weight="bold" text-anchor="middle">1. UI COMPONENT</text>

    <text x="117" y="60" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10.5" text-anchor="middle">Pengguna berinteraksi:</text>
    <text x="117" y="78" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="11" font-weight="bold" text-anchor="middle">Menekan "Tambah Produk"</text>

    <rect x="18" y="98" width="199" height="60" rx="4" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="117" y="120" fill="#4B5563" font-family="'Consolas', monospace" font-size="9" text-anchor="middle">context.read&lt;CartBloc&gt;()</text>
    <text x="117" y="140" fill="#111827" font-family="'Consolas', monospace" font-size="9.5" font-weight="bold" text-anchor="middle">.add(AddToCart(item))</text>

    <text x="117" y="185" fill="#6B7280" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9" text-anchor="middle">Aksi ditransformasi menjadi Event</text>
  </g>

  <!-- Arrow Top: EVENT -->
  <g transform="translate(265, 80)">
    <line x1="10" y1="15" x2="70" y2="15" stroke="#111827" stroke-width="2" marker-end="url(#arrowDark)"/>
    <rect x="16" y="2" width="48" height="13" rx="2" fill="#18181B"/>
    <text x="40" y="11.5" fill="#FFFFFF" font-family="'Consolas', monospace" font-size="8" font-weight="bold" text-anchor="middle">EVENT</text>
  </g>

  <!-- Middle: BLoC / Cubit Engine -->
  <g transform="translate(345, 50)">
    <rect width="250" height="205" rx="6" fill="#FAFAFA" stroke="#111827" stroke-width="1.5"/>
    <rect width="250" height="34" rx="6" fill="#18181B"/>
    <text x="125" y="22" fill="#FFFFFF" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="11.5" font-weight="bold" text-anchor="middle">2. BLOC ENGINE</text>

    <!-- Code Block Inside -->
    <rect x="15" y="48" width="220" height="118" rx="4" fill="#FFFFFF" stroke="#D1D5DB" stroke-width="1"/>
    <text x="25" y="68" fill="#6B7280" font-family="'Consolas', monospace" font-size="9">// Handler Event</text>
    <text x="25" y="86" fill="#111827" font-family="'Consolas', monospace" font-size="9">on&lt;AddToCart&gt;((e, emit) {</text>
    <text x="35" y="104" fill="#4B5563" font-family="'Consolas', monospace" font-size="8.8">  final items = update(e);</text>
    <text x="35" y="122" fill="#6B7280" font-family="'Consolas', monospace" font-size="8.8">  // Pancarkan state baru</text>
    <text x="35" y="140" fill="#111827" font-family="'Consolas', monospace" font-size="9" font-weight="bold">  emit(CartLoaded(items));</text>
    <text x="25" y="156" fill="#111827" font-family="'Consolas', monospace" font-size="9">});</text>

    <text x="125" y="188" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9" text-anchor="middle">Mengeksekusi kalkulasi bisnis</text>
  </g>

  <!-- Arrow Bottom: STATE -->
  <g transform="translate(595, 175)">
    <line x1="70" y1="15" x2="10" y2="15" stroke="#111827" stroke-width="2" marker-end="url(#arrowDark)"/>
    <rect x="16" y="2" width="48" height="13" rx="2" fill="#18181B"/>
    <text x="40" y="11.5" fill="#FFFFFF" font-family="'Consolas', monospace" font-size="8" font-weight="bold" text-anchor="middle">STATE</text>
  </g>

  <!-- Right: UI Re-render -->
  <g transform="translate(675, 50)">
    <rect width="235" height="205" rx="6" fill="#FAFAFA" stroke="#E5E7EB" stroke-width="1.5"/>
    <rect width="235" height="34" rx="6" fill="#F3F4F6"/>
    <rect x="0" y="33" width="235" height="1" fill="#E5E7EB"/>
    <text x="117" y="22" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="11.5" font-weight="bold" text-anchor="middle">3. RE-RENDER UI</text>

    <!-- Code Block Inside -->
    <rect x="15" y="48" width="205" height="118" rx="4" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="25" y="68" fill="#111827" font-family="'Consolas', monospace" font-size="8.8">BlocBuilder&lt;Cart, State&gt;(</text>
    <text x="35" y="86" fill="#4B5563" font-family="'Consolas', monospace" font-size="8.8">builder: (ctx, state) {</text>
    <text x="45" y="104" fill="#4B5563" font-family="'Consolas', monospace" font-size="8.5">  if (state is Loaded)</text>
    <text x="55" y="122" fill="#111827" font-family="'Consolas', monospace" font-size="8.8" font-weight="bold">    Badge(count: n);</text>
    <text x="35" y="140" fill="#4B5563" font-family="'Consolas', monospace" font-size="8.8">  return Empty();</text>
    <text x="25" y="156" fill="#111827" font-family="'Consolas', monospace" font-size="8.8">},</text>

    <text x="117" y="188" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9" text-anchor="middle">Widget me-rebuild tampilan visual</text>
  </g>
</svg>"""

# ---------------------------------------------------------------------
# 5. bloc-widgets-quadrant.svg
# ---------------------------------------------------------------------
svg_files["bloc-widgets-quadrant.svg"] = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 920 360" width="100%" height="100%">
  <!-- Background Canvas -->
  <rect width="920" height="360" rx="8" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1.5"/>

  <!-- Header -->
  <text x="460" y="28" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="13.5" font-weight="bold" text-anchor="middle">MATRIKS KUADRAN KONSUMSI WIDGET FLUTTER BLOC</text>

  <!-- Card 1: BlocBuilder (Top-Left) -->
  <g transform="translate(25, 45)">
    <rect width="425" height="135" rx="6" fill="#FAFAFA" stroke="#E5E7EB" stroke-width="1.5"/>
    <rect width="425" height="30" rx="6" fill="#F3F4F6"/>
    <rect x="0" y="29" width="425" height="1" fill="#E5E7EB"/>
    <text x="18" y="20" fill="#111827" font-family="'Consolas', monospace" font-size="11" font-weight="bold">1. BlocBuilder&lt;Bloc, State&gt;</text>
    <rect x="305" y="6" width="105" height="18" rx="3" fill="#E5E7EB"/>
    <text x="357" y="18.5" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8" font-weight="bold" text-anchor="middle">VISUAL REBUILD</text>

    <text x="18" y="50" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10" font-weight="bold">Fungsi: Menggambar ulang antarmuka visual secara reaktif.</text>
    <text x="18" y="70" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5">• Parameter Wajib: builder: (context, state) =&gt; Widget</text>
    <text x="18" y="88" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5">• Perilaku: Me-rebuild subtree setiap kali state baru yang valid terpancar.</text>

    <rect x="18" y="100" width="389" height="24" rx="3" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="212" y="116" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5" font-weight="bold" text-anchor="middle">Batasan: Dilarang memicu Dialog, SnackBar, atau Navigasi rute di dalam builder.</text>
  </g>

  <!-- Card 2: BlocListener (Top-Right) -->
  <g transform="translate(470, 45)">
    <rect width="425" height="135" rx="6" fill="#FAFAFA" stroke="#E5E7EB" stroke-width="1.5"/>
    <rect width="425" height="30" rx="6" fill="#F3F4F6"/>
    <rect x="0" y="29" width="425" height="1" fill="#E5E7EB"/>
    <text x="18" y="20" fill="#111827" font-family="'Consolas', monospace" font-size="11" font-weight="bold">2. BlocListener&lt;Bloc, State&gt;</text>
    <rect x="305" y="6" width="105" height="18" rx="3" fill="#E5E7EB"/>
    <text x="357" y="18.5" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8" font-weight="bold" text-anchor="middle">SIDE EFFECTS</text>

    <text x="18" y="50" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10" font-weight="bold">Fungsi: Menjalankan aksi satu kali (efek samping non-visual).</text>
    <text x="18" y="70" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5">• Parameter Wajib: listener: (context, state) { ... }</text>
    <text x="18" y="88" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5">• Perilaku: Dieksekusi tepat 1 kali per transisi state; TIDAK me-rebuild UI.</text>

    <rect x="18" y="100" width="389" height="24" rx="3" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="212" y="116" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5" font-weight="bold" text-anchor="middle">Tempat Resmi: SnackBar pemberitahuan, Dialog konfirmasi, dan Navigasi rute.</text>
  </g>

  <!-- Card 3: BlocConsumer (Bottom-Left) -->
  <g transform="translate(25, 195)">
    <rect width="425" height="145" rx="6" fill="#FAFAFA" stroke="#E5E7EB" stroke-width="1.5"/>
    <rect width="425" height="30" rx="6" fill="#F3F4F6"/>
    <rect x="0" y="29" width="425" height="1" fill="#E5E7EB"/>
    <text x="18" y="20" fill="#111827" font-family="'Consolas', monospace" font-size="11" font-weight="bold">3. BlocConsumer&lt;Bloc, State&gt;</text>
    <rect x="305" y="6" width="105" height="18" rx="3" fill="#18181B"/>
    <text x="357" y="18.5" fill="#FFFFFF" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8" font-weight="bold" text-anchor="middle">DUO HYBRID</text>

    <text x="18" y="50" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10" font-weight="bold">Fungsi: Menggabungkan Builder dan Listener dalam satu widget.</text>
    <text x="18" y="70" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5">• Parameter Wajib: Memiliki builder: DAN listener: sekaligus.</text>
    <text x="18" y="88" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5">• Perilaku: Me-rebuild visual antarmuka sekaligus memicu efek samping aksi.</text>

    <rect x="18" y="104" width="389" height="28" rx="3" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="212" y="122" fill="#374151" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5" text-anchor="middle">Keunggulan: Menghilangkan antipola nesting bertingkat (Listener membungkus Builder).</text>
  </g>

  <!-- Card 4: BlocSelector (Bottom-Right) -->
  <g transform="translate(470, 195)">
    <rect width="425" height="145" rx="6" fill="#FAFAFA" stroke="#111827" stroke-width="1.5"/>
    <rect width="425" height="30" rx="6" fill="#18181B"/>
    <text x="18" y="20" fill="#FFFFFF" font-family="'Consolas', monospace" font-size="11" font-weight="bold">4. BlocSelector&lt;Bloc, State, Value&gt;</text>
    <rect x="305" y="6" width="105" height="18" rx="3" fill="#3F3F46"/>
    <text x="357" y="18.5" fill="#FFFFFF" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8" font-weight="bold" text-anchor="middle">OPTIMASI TINGGI</text>

    <text x="18" y="50" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10" font-weight="bold">Fungsi: Filter nilai parsial spesifik untuk performa render maksimal.</text>
    <text x="18" y="70" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5">• Parameter Wajib: selector: (state) =&gt; state.selectedField</text>
    <text x="18" y="88" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5">• Perilaku: HANYA me-rebuild UI jika nilai properti yang dipilih berubah.</text>

    <rect x="18" y="104" width="389" height="28" rx="3" fill="#FFFFFF" stroke="#D1D5DB" stroke-width="1"/>
    <text x="212" y="122" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5" font-weight="bold" text-anchor="middle">Kasus Ideal: Badge jumlah notifikasi di AppBar tanpa me-rebuild seluruh layar.</text>
  </g>
</svg>"""

# ---------------------------------------------------------------------
# 6. bloc-concurrency-modes.svg
# ---------------------------------------------------------------------
svg_files["bloc-concurrency-modes.svg"] = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 920 360" width="100%" height="100%">
  <!-- Background Canvas -->
  <rect width="920" height="360" rx="8" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1.5"/>

  <!-- Header -->
  <text x="460" y="28" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="13.5" font-weight="bold" text-anchor="middle">4 STRATEGI CONCURRENCY EVENT TRANSFORMER PADA BLOC</text>

  <!-- Card 1: droppable() -->
  <g transform="translate(25, 45)">
    <rect width="205" height="295" rx="6" fill="#FAFAFA" stroke="#E5E7EB" stroke-width="1.5"/>
    <rect width="205" height="32" rx="6" fill="#F3F4F6"/>
    <rect x="0" y="31" width="205" height="1" fill="#E5E7EB"/>
    <text x="102" y="21" fill="#111827" font-family="'Consolas', monospace" font-size="11" font-weight="bold" text-anchor="middle">1. droppable()</text>

    <text x="102" y="52" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5" font-weight="bold" text-anchor="middle">Abaikan Jika Sedang Sibuk</text>

    <!-- Visual Timeline -->
    <rect x="15" y="65" width="175" height="26" rx="3" fill="#FFFFFF" stroke="#111827" stroke-width="1.2"/>
    <text x="102" y="81" fill="#111827" font-family="'Consolas', monospace" font-size="9" text-anchor="middle">Event 1: Diproses</text>

    <text x="102" y="105" fill="#6B7280" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5" text-anchor="middle">Event baru masuk saat sibuk:</text>

    <rect x="15" y="115" width="175" height="24" rx="3" fill="#F3F4F6" stroke="#D1D5DB" stroke-width="1"/>
    <text x="102" y="131" fill="#6B7280" font-family="'Consolas', monospace" font-size="8.5" text-anchor="middle">Event 2: Diabaikan (Drop)</text>

    <rect x="15" y="145" width="175" height="24" rx="3" fill="#F3F4F6" stroke="#D1D5DB" stroke-width="1"/>
    <text x="102" y="161" fill="#6B7280" font-family="'Consolas', monospace" font-size="8.5" text-anchor="middle">Event 3: Diabaikan (Drop)</text>

    <!-- Description -->
    <rect x="12" y="185" width="181" height="95" rx="4" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="20" y="202" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9" font-weight="bold">Karakteristik &amp; Kasus:</text>
    <text x="20" y="218" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5">• Mencegah duplikasi data.</text>
    <text x="20" y="233" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5">• Proteksi klik berulang.</text>
    <text x="20" y="252" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5" font-weight="bold">Kasus: Checkout &amp; Bayar</text>
  </g>

  <!-- Card 2: restartable() -->
  <g transform="translate(245, 45)">
    <rect width="205" height="295" rx="6" fill="#FAFAFA" stroke="#111827" stroke-width="1.5"/>
    <rect width="205" height="32" rx="6" fill="#18181B"/>
    <text x="102" y="21" fill="#FFFFFF" font-family="'Consolas', monospace" font-size="11" font-weight="bold" text-anchor="middle">2. restartable()</text>

    <text x="102" y="52" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5" font-weight="bold" text-anchor="middle">Batalkan Lama, Jalankan Baru</text>

    <!-- Visual Timeline -->
    <rect x="15" y="65" width="175" height="24" rx="3" fill="#F3F4F6" stroke="#D1D5DB" stroke-width="1"/>
    <text x="102" y="81" fill="#6B7280" font-family="'Consolas', monospace" font-size="8.5" text-anchor="middle">Ketik 'lap' : Dibatalkan</text>

    <rect x="15" y="95" width="175" height="24" rx="3" fill="#F3F4F6" stroke="#D1D5DB" stroke-width="1"/>
    <text x="102" y="111" fill="#6B7280" font-family="'Consolas', monospace" font-size="8.5" text-anchor="middle">Ketik 'lapt' : Dibatalkan</text>

    <rect x="15" y="125" width="175" height="26" rx="3" fill="#FFFFFF" stroke="#111827" stroke-width="1.2"/>
    <text x="102" y="141" fill="#111827" font-family="'Consolas', monospace" font-size="9" font-weight="bold" text-anchor="middle">Ketik 'laptop' : Selesai</text>

    <text x="102" y="168" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.2" text-anchor="middle">Hanya hasil mutakhir yang diproses</text>

    <!-- Description -->
    <rect x="12" y="185" width="181" height="95" rx="4" fill="#FFFFFF" stroke="#D1D5DB" stroke-width="1"/>
    <text x="20" y="202" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9" font-weight="bold">Karakteristik &amp; Kasus:</text>
    <text x="20" y="218" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5">• Mengabaikan respon lama.</text>
    <text x="20" y="233" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5">• Hemat bandwidth &amp; CPU.</text>
    <text x="20" y="252" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5" font-weight="bold">Kasus: Search Autocomplete</text>
  </g>

  <!-- Card 3: sequential() -->
  <g transform="translate(465, 45)">
    <rect width="205" height="295" rx="6" fill="#FAFAFA" stroke="#E5E7EB" stroke-width="1.5"/>
    <rect width="205" height="32" rx="6" fill="#F3F4F6"/>
    <rect x="0" y="31" width="205" height="1" fill="#E5E7EB"/>
    <text x="102" y="21" fill="#111827" font-family="'Consolas', monospace" font-size="11" font-weight="bold" text-anchor="middle">3. sequential()</text>

    <text x="102" y="52" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5" font-weight="bold" text-anchor="middle">Antrean Berurutan (FIFO)</text>

    <!-- Visual Timeline -->
    <rect x="15" y="65" width="175" height="24" rx="3" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="102" y="81" fill="#111827" font-family="'Consolas', monospace" font-size="8.5" text-anchor="middle">Event 1: Antrean 1</text>

    <rect x="15" y="95" width="175" height="24" rx="3" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="102" y="111" fill="#4B5563" font-family="'Consolas', monospace" font-size="8.5" text-anchor="middle">Event 2: Antrean 2</text>

    <rect x="15" y="125" width="175" height="24" rx="3" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="102" y="141" fill="#4B5563" font-family="'Consolas', monospace" font-size="8.5" text-anchor="middle">Event 3: Antrean 3</text>

    <text x="102" y="168" fill="#6B7280" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.2" text-anchor="middle">Default perilaku event pada BLoC</text>

    <!-- Description -->
    <rect x="12" y="185" width="181" height="95" rx="4" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="20" y="202" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9" font-weight="bold">Karakteristik &amp; Kasus:</text>
    <text x="20" y="218" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5">• Menjamin konsistensi data.</text>
    <text x="20" y="233" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5">• Eksekusi satu per satu.</text>
    <text x="20" y="252" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5" font-weight="bold">Kasus: Sinkronisasi Offline</text>
  </g>

  <!-- Card 4: concurrent() -->
  <g transform="translate(685, 45)">
    <rect width="205" height="295" rx="6" fill="#FAFAFA" stroke="#E5E7EB" stroke-width="1.5"/>
    <rect width="205" height="32" rx="6" fill="#F3F4F6"/>
    <rect x="0" y="31" width="205" height="1" fill="#E5E7EB"/>
    <text x="102" y="21" fill="#111827" font-family="'Consolas', monospace" font-size="11" font-weight="bold" text-anchor="middle">4. concurrent()</text>

    <text x="102" y="52" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5" font-weight="bold" text-anchor="middle">Eksekusi Paralel Simultan</text>

    <!-- Visual Timeline -->
    <rect x="15" y="65" width="175" height="24" rx="3" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="102" y="81" fill="#111827" font-family="'Consolas', monospace" font-size="8.5" text-anchor="middle">Event A: Berjalan paralel</text>

    <rect x="15" y="95" width="175" height="24" rx="3" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="102" y="111" fill="#111827" font-family="'Consolas', monospace" font-size="8.5" text-anchor="middle">Event B: Berjalan paralel</text>

    <rect x="15" y="125" width="175" height="24" rx="3" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="102" y="141" fill="#111827" font-family="'Consolas', monospace" font-size="8.5" text-anchor="middle">Event C: Berjalan paralel</text>

    <text x="102" y="168" fill="#6B7280" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.2" text-anchor="middle">Tidak saling menunggu atau memblokir</text>

    <!-- Description -->
    <rect x="12" y="185" width="181" height="95" rx="4" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="20" y="202" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9" font-weight="bold">Karakteristik &amp; Kasus:</text>
    <text x="20" y="218" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5">• Throughput maksimal.</text>
    <text x="20" y="233" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5">• Task independen satu sama lain.</text>
    <text x="20" y="252" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="8.5" font-weight="bold">Kasus: Multi-file Download</text>
  </g>
</svg>"""

# ---------------------------------------------------------------------
# 7. comparison-matrix-state.svg
# ---------------------------------------------------------------------
svg_files["comparison-matrix-state.svg"] = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 880 290" width="100%" height="100%">
  <!-- Background Canvas -->
  <rect width="880" height="290" rx="8" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1.5"/>

  <!-- Header -->
  <text x="440" y="28" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="13.5" font-weight="bold" text-anchor="middle">MATRIKS EVALUASI ARSITEKTUR STATE MANAGEMENT FLUTTER 2026</text>

  <!-- Column 1: Provider -->
  <g transform="translate(30, 48)">
    <rect width="250" height="225" rx="6" fill="#FAFAFA" stroke="#E5E7EB" stroke-width="1.5"/>
    <rect width="250" height="34" rx="6" fill="#F3F4F6"/>
    <rect x="0" y="33" width="250" height="1" fill="#E5E7EB"/>
    <text x="125" y="22" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="12" font-weight="bold" text-anchor="middle">PROVIDER</text>

    <text x="16" y="58" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10">Kurva Belajar: <tspan fill="#111827" font-weight="bold">Rendah (Cepat)</tspan></text>
    <text x="16" y="82" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10">Boilerplate: <tspan fill="#111827" font-weight="bold">Sangat Ringan</tspan></text>
    <text x="16" y="106" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10">BuildContext: <tspan fill="#4B5563" font-weight="bold">Wajib (Pohon Widget)</tspan></text>
    <text x="16" y="130" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10">Testabilitas: <tspan fill="#4B5563" font-weight="bold">Menengah</tspan></text>
    <text x="16" y="154" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10">Skala Proyek: <tspan fill="#111827" font-weight="bold">Kecil - Menengah</tspan></text>

    <rect x="15" y="172" width="220" height="38" rx="4" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="125" y="188" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5" font-weight="bold" text-anchor="middle">Target Penerapan:</text>
    <text x="125" y="202" fill="#6B7280" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9" text-anchor="middle">Fondasi Awal, Prototipe, &amp; MVP</text>
  </g>

  <!-- Column 2: Riverpod 2.x -->
  <g transform="translate(315, 48)">
    <rect width="250" height="225" rx="6" fill="#FAFAFA" stroke="#E5E7EB" stroke-width="1.5"/>
    <rect width="250" height="34" rx="6" fill="#F3F4F6"/>
    <rect x="0" y="33" width="250" height="1" fill="#E5E7EB"/>
    <text x="125" y="22" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="12" font-weight="bold" text-anchor="middle">RIVERPOD 2.X</text>

    <text x="16" y="58" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10">Kurva Belajar: <tspan fill="#111827" font-weight="bold">Menengah</tspan></text>
    <text x="16" y="82" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10">Boilerplate: <tspan fill="#111827" font-weight="bold">Ringan (Codegen)</tspan></text>
    <text x="16" y="106" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10">BuildContext: <tspan fill="#111827" font-weight="bold">Bebas (Compile-safe)</tspan></text>
    <text x="16" y="130" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10">Testabilitas: <tspan fill="#111827" font-weight="bold">Tinggi</tspan></text>
    <text x="16" y="154" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10">Skala Proyek: <tspan fill="#111827" font-weight="bold">Menengah - Besar</tspan></text>

    <rect x="15" y="172" width="220" height="38" rx="4" fill="#FFFFFF" stroke="#E5E7EB" stroke-width="1"/>
    <text x="125" y="188" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5" font-weight="bold" text-anchor="middle">Target Penerapan:</text>
    <text x="125" y="202" fill="#6B7280" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9" text-anchor="middle">Aplikasi Modern &amp; Reaktif</text>
  </g>

  <!-- Column 3: BLoC / Cubit -->
  <g transform="translate(600, 48)">
    <rect width="250" height="225" rx="6" fill="#FAFAFA" stroke="#111827" stroke-width="1.5"/>
    <rect width="250" height="34" rx="6" fill="#18181B"/>
    <text x="125" y="22" fill="#FFFFFF" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="12" font-weight="bold" text-anchor="middle">BLOC / CUBIT</text>

    <text x="16" y="58" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10">Kurva Belajar: <tspan fill="#111827" font-weight="bold">Menengah - Tinggi</tspan></text>
    <text x="16" y="82" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10">Boilerplate: <tspan fill="#111827" font-weight="bold">Terstruktur &amp; Ketat</tspan></text>
    <text x="16" y="106" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10">BuildContext: <tspan fill="#111827" font-weight="bold">Scoped Injection</tspan></text>
    <text x="16" y="130" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10">Testabilitas: <tspan fill="#111827" font-weight="bold">100% Deterministik</tspan></text>
    <text x="16" y="154" fill="#4B5563" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="10">Skala Proyek: <tspan fill="#111827" font-weight="bold">Enterprise &amp; FinTech</tspan></text>

    <rect x="15" y="172" width="220" height="38" rx="4" fill="#FFFFFF" stroke="#D1D5DB" stroke-width="1"/>
    <text x="125" y="188" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9.5" font-weight="bold" text-anchor="middle">Target Penerapan:</text>
    <text x="125" y="202" fill="#111827" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif" font-size="9" font-weight="bold" text-anchor="middle">Sistem Kritis &amp; Skala Besar</text>
  </g>
</svg>"""

# HTML template for Chrome rendering
html_template = """<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  html, body {
    margin: 0;
    padding: 0;
    background: transparent;
    width: __WIDTH__px;
    height: __HEIGHT__px;
    overflow: hidden;
  }
  svg {
    width: __WIDTH__px;
    height: __HEIGHT__px;
    display: block;
  }
</style>
</head>
<body>
__SVG__
</body>
</html>"""

print("Generating 7 clean minimalist SVGs and rendering via Chrome Headless...")

for filename, svg_content in svg_files.items():
    png_filename = filename.replace(".svg", ".png")
    png_path = os.path.join(output_dir, png_filename)

    # Extract viewBox
    match = re.search(r'viewBox="([^"]+)"', svg_content)
    if match:
        parts = [float(x) for x in match.group(1).split()]
        vb_w = int(parts[2])
        vb_h = int(parts[3])
    else:
        vb_w = 900
        vb_h = 360

    scale = 2.5
    w = int(vb_w * scale)
    h = int(vb_h * scale)

    html = html_template.replace('__WIDTH__', str(w)).replace('__HEIGHT__', str(h)).replace('__SVG__', svg_content)
    with open(temp_html, 'w', encoding='utf-8') as f:
        f.write(html)

    # Save raw SVG
    svg_path = os.path.join(output_dir, filename)
    with open(svg_path, 'w', encoding='utf-8') as sf:
        sf.write(svg_content)

    cmd = [
        chrome_path,
        '--headless=new',
        '--disable-gpu',
        f'--window-size={w},{h}',
        f'--screenshot={png_path}',
        temp_html
    ]
    subprocess.run(cmd, check=True)
    print(f"Generated: {filename} & {png_filename} ({w}x{h})")

if os.path.exists(temp_html):
    os.remove(temp_html)

print("All 7 minimalist diagrams successfully created and rendered.")
