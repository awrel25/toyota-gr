# 🏎️ TOYOTA GAZOO RACING — Official Apparel & Merchandise Web App (Flutter & Dart)

> **Proyek Praktik Kerja Lapangan (PKL)**  
> Website dinamis katalog apparel & merchandise resmi **TOYOTA GAZOO RACING (TGR)** berbasis **Flutter Web & Dart**, bertema motorsport elegan dengan dominasi warna merah, hitam, abu-abu, dan putih, terintegrasi pemesanan WhatsApp otomatis.

---

## 🌟 Fitur Utama Website

### 1. 🏁 Hero Section Elegan ("Pushing the limits.")
- **Headline Kuat:** `"TOYOTA GAZOO RACING — Pushing the limits."`
- **Highlight Motorsport Series:** Kartu preview rapi untuk mobil balap dan apparel resmi (*GR010 Hybrid, Paddock Teamwear, Racing Gears*).

### 2. 👕 Koleksi Lengkap Apparel & Gears
- **Apparel:**
  1. `GR Official Team Polo Shirt` (08234-GR101)
  2. `GR Heritage Hypercar T-Shirt` (08234-GR102)
  3. `GR Pit Crew Mechanic Shirt` (08234-GR103)
  4. `GR Gazoo Casual Hoodie` (08234-GR104)
  5. `GR Track Windbreaker Light Jacket` (08234-GR105)
  6. `GR Team Paddock Softshell Gazoo Jacket` (08234-GR106)
- **Gears & Aksesori:**
  7. `GR Motorsport Stormproof Umbrella` (08234-GR201)
  8. `GR Official Teamwear Snapback Cap` (08234-GR202)
  9. `GR Quick-Release Paddock Lanyard` (08234-GR203)
  10. `GR Vacuum Thermal Matte Tumbler 500ml` (08234-GR204)
  11. `GR Carbon Fiber Solid Keychain` (08234-GR205)
  12. `GR Track Decal Vinyl Sticker Pack` (08234-GR206)

### 3. 📏 Tabel Ukuran Resmi (Size Chart Standard)
- **Tabel Apparel:** Memuat 9 kolom spesifikasi:
  - `Image` | `Nama Produk` | `Size` | `Part Number` | `Lingkar Badan` | `Lebar Bahu` | `Panjang Badan` | `Panjang Lengan` | `Lebar Leher`.
- **Tabel Gears Part & GR Cap:**
  - `Image` | `Nama Produk` | `Size / Dimensi` | `Part Number`.

### 4. 📊 GR Merchandise Availability (Status Ketersediaan Stok)
- Ringkasan ketersediaan unit merchandise (*Tersedia, Stok Terbatas*) dilengkapi jumlah unit dan tombol pemesanan cepat.

### 5. 📲 Pemesanan Otomatis via WhatsApp
Tombol **"Pesan WA"** langsung menyusun format pesan otomatis ke WhatsApp Admin dengan produk, part number, dan ukuran terpilih.

---

## 📂 Struktur Folder Proyek (Flutter & Dart Murni)

```text
lib/
├── main.dart                       # Entry point aplikasi Flutter & konfigurasi tema
├── models/
│   └── merch_item.dart             # Model data produk & detail ukuran
├── data/
│   └── merchandise_data.dart       # Master katalog produk resmi & helper WhatsApp
└── widgets/
    ├── hero_section.dart           # Widget hero section & preview motorsport
    ├── product_card.dart           # Widget kartu produk merchandise
    ├── size_chart_section.dart     # Widget tabel ukuran lengkap
    ├── stock_section.dart          # Widget ketersediaan stok
    └── size_chart_dialog.dart      # Dialog modal panduan ukuran
web/
├── index.html                      # HTML container Flutter Web
└── images/                         # Aset visual resmi Gazoo Racing
```

---

## 🚀 Cara Menjalankan

Jalankan perintah Flutter Web:
```bash
flutter run -d chrome
```
