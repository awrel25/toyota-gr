import 'dart:js_interop';
import 'package:flutter/material.dart';
import '../models/merch_item.dart';

@JS('window.open')
external void _openWebWindow(JSString url, JSString target);

void launchUrlWeb(String url) {
  try {
    _openWebWindow(url.toJS, '_blank'.toJS);
  } catch (e) {
    debugPrint('Gagal membuka URL: $e');
  }
}

String formatRupiah(int amount) {
  final str = amount.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < str.length; i++) {
    if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
    buffer.write(str[i]);
  }
  return 'Rp ${buffer.toString()}';
}

void orderViaWhatsApp({
  required MerchItem item,
  required String selectedSize,
  required BuildContext context,
  String adminPhone = '6287890743395',
}) {
  final sizeObj = item.sizes.firstWhere(
    (s) => s.size == selectedSize,
    orElse: () => item.sizes.first,
  );

  final message =
      '''Halo Admin TOYOTA GAZOO RACING Merchandise,
Saya berminat untuk memesan produk resmi berikut:

🏎️ *PRODUK:* ${item.name}
🏷️ *KATEGORI:* ${item.subcategory}
🔢 *PART NUMBER:* ${sizeObj.partNumber}
📏 *UKURAN:* ${sizeObj.size}
💰 *HARGA:* ${formatRupiah(item.price)}

Mohon informasi mengenai ketersediaan stok dan tata cara pembayarannya. Terima kasih!''';

  final encoded = Uri.encodeComponent(message);
  final url = 'https://wa.me/$adminPhone?text=$encoded';
  launchUrlWeb(url);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color(0xFF1E2129),
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Color(0xFF25D366),
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Membuka WhatsApp untuk memesan ${item.name} (${sizeObj.size})...',
              style: const TextStyle(fontSize: 13, color: Colors.white),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}

const List<MerchItem> kMerchandiseList = [
  // --- APPAREL ---
  MerchItem(
    id: 'app-1',
    name: 'GR Official Team Polo Shirt',
    category: 'apparel',
    subcategory: 'Polo Shirt',
    partNumberBase: '08234-GR101',
    price: 495000,
    availability: 'Tersedia',
    stockCount: 18,
    image: 'images/polo-tshirt.jpg',
    cropLeft: 0.0,
    cropTop: 0.134,
    cropWidth: 0.533,
    cropHeight: 0.714,
    description:
        'Polo shirt resmi TOYOTA GAZOO RACING berbahan katun pique berpori dengan emblem bordir GR presisi.',
    sizes: [
      SizeDetail(
        size: 'S',
        partNumber: '08234-GR101-S',
        bodyCircumference: '98 cm',
        shoulderWidth: '42 cm',
        bodyLength: '68 cm',
        sleeveLength: '21 cm',
        neckWidth: '16.5 cm',
      ),
      SizeDetail(
        size: 'M',
        partNumber: '08234-GR101-M',
        bodyCircumference: '104 cm',
        shoulderWidth: '44 cm',
        bodyLength: '70 cm',
        sleeveLength: '22 cm',
        neckWidth: '17.0 cm',
      ),
      SizeDetail(
        size: 'L',
        partNumber: '08234-GR101-L',
        bodyCircumference: '110 cm',
        shoulderWidth: '46 cm',
        bodyLength: '72 cm',
        sleeveLength: '23 cm',
        neckWidth: '17.5 cm',
      ),
      SizeDetail(
        size: 'XL',
        partNumber: '08234-GR101-XL',
        bodyCircumference: '116 cm',
        shoulderWidth: '48 cm',
        bodyLength: '74 cm',
        sleeveLength: '24 cm',
        neckWidth: '18.0 cm',
      ),
      SizeDetail(
        size: '2XL',
        partNumber: '08234-GR101-2X',
        bodyCircumference: '122 cm',
        shoulderWidth: '50 cm',
        bodyLength: '76 cm',
        sleeveLength: '25 cm',
        neckWidth: '18.5 cm',
      ),
    ],
  ),
  MerchItem(
    id: 'app-2',
    name: 'GR Heritage Hypercar T-Shirt',
    category: 'apparel',
    subcategory: 'T-Shirt',
    partNumberBase: '08234-GR102',
    price: 375000,
    availability: 'Tersedia',
    stockCount: 25,
    image: 'images/polo-tshirt.jpg',
    cropLeft: 0.467,
    cropTop: 0.134,
    cropWidth: 0.533,
    cropHeight: 0.714,
    description:
        'T-shirt grafis motorsport katun combed 24s dengan siluet mobil balap Le Mans GR010 Hybrid.',
    sizes: [
      SizeDetail(
        size: 'S',
        partNumber: '08234-GR102-S',
        bodyCircumference: '96 cm',
        shoulderWidth: '42 cm',
        bodyLength: '67 cm',
        sleeveLength: '20 cm',
        neckWidth: '16.0 cm',
      ),
      SizeDetail(
        size: 'M',
        partNumber: '08234-GR102-M',
        bodyCircumference: '102 cm',
        shoulderWidth: '44 cm',
        bodyLength: '69 cm',
        sleeveLength: '21 cm',
        neckWidth: '16.5 cm',
      ),
      SizeDetail(
        size: 'L',
        partNumber: '08234-GR102-L',
        bodyCircumference: '108 cm',
        shoulderWidth: '46 cm',
        bodyLength: '71 cm',
        sleeveLength: '22 cm',
        neckWidth: '17.0 cm',
      ),
      SizeDetail(
        size: 'XL',
        partNumber: '08234-GR102-XL',
        bodyCircumference: '114 cm',
        shoulderWidth: '48 cm',
        bodyLength: '73 cm',
        sleeveLength: '23 cm',
        neckWidth: '17.5 cm',
      ),
      SizeDetail(
        size: '2XL',
        partNumber: '08234-GR102-2X',
        bodyCircumference: '120 cm',
        shoulderWidth: '50 cm',
        bodyLength: '75 cm',
        sleeveLength: '24 cm',
        neckWidth: '18.0 cm',
      ),
    ],
  ),
  MerchItem(
    id: 'app-3',
    name: 'GR Pit Crew Mechanic Shirt',
    category: 'apparel',
    subcategory: 'Shirt',
    partNumberBase: '08234-GR103',
    price: 585000,
    availability: 'Stok Terbatas',
    stockCount: 6,
    image: 'images/polo-tshirt.jpg',
    cropLeft: 0.06,
    cropTop: 0.22,
    cropWidth: 0.38,
    cropHeight: 0.51,
    description:
        'Kemeja mekanik balap lengan pendek dengan bahan anti-kusut dan kantung dada berzipper aman.',
    sizes: [
      SizeDetail(
        size: 'S',
        partNumber: '08234-GR103-S',
        bodyCircumference: '102 cm',
        shoulderWidth: '43 cm',
        bodyLength: '70 cm',
        sleeveLength: '23 cm',
        neckWidth: '16.5 cm',
      ),
      SizeDetail(
        size: 'M',
        partNumber: '08234-GR103-M',
        bodyCircumference: '108 cm',
        shoulderWidth: '45 cm',
        bodyLength: '72 cm',
        sleeveLength: '24 cm',
        neckWidth: '17.0 cm',
      ),
      SizeDetail(
        size: 'L',
        partNumber: '08234-GR103-L',
        bodyCircumference: '114 cm',
        shoulderWidth: '47 cm',
        bodyLength: '74 cm',
        sleeveLength: '25 cm',
        neckWidth: '17.5 cm',
      ),
      SizeDetail(
        size: 'XL',
        partNumber: '08234-GR103-XL',
        bodyCircumference: '120 cm',
        shoulderWidth: '49 cm',
        bodyLength: '76 cm',
        sleeveLength: '26 cm',
        neckWidth: '18.0 cm',
      ),
      SizeDetail(
        size: '2XL',
        partNumber: '08234-GR103-2X',
        bodyCircumference: '126 cm',
        shoulderWidth: '51 cm',
        bodyLength: '78 cm',
        sleeveLength: '27 cm',
        neckWidth: '18.5 cm',
      ),
    ],
  ),
  MerchItem(
    id: 'app-4',
    name: 'GR Gazoo Casual Hoodie',
    category: 'apparel',
    subcategory: 'Gazoo Casual Hoodie',
    partNumberBase: '08234-GR104',
    price: 790000,
    availability: 'Tersedia',
    stockCount: 14,
    image: 'images/jacket-hoodie.jpg',
    cropLeft: 0.517,
    cropTop: 0.19,
    cropWidth: 0.385,
    cropHeight: 0.7,
    description:
        'Hoodie kasual hitam dengan interior kupluk merah Gazoo, bahan fleece premium tebal dan hangat.',
    sizes: [
      SizeDetail(
        size: 'S',
        partNumber: '08234-GR104-S',
        bodyCircumference: '106 cm',
        shoulderWidth: '46 cm',
        bodyLength: '68 cm',
        sleeveLength: '60 cm',
        neckWidth: '18.0 cm',
      ),
      SizeDetail(
        size: 'M',
        partNumber: '08234-GR104-M',
        bodyCircumference: '112 cm',
        shoulderWidth: '48 cm',
        bodyLength: '70 cm',
        sleeveLength: '62 cm',
        neckWidth: '18.5 cm',
      ),
      SizeDetail(
        size: 'L',
        partNumber: '08234-GR104-L',
        bodyCircumference: '118 cm',
        shoulderWidth: '50 cm',
        bodyLength: '72 cm',
        sleeveLength: '64 cm',
        neckWidth: '19.0 cm',
      ),
      SizeDetail(
        size: 'XL',
        partNumber: '08234-GR104-XL',
        bodyCircumference: '124 cm',
        shoulderWidth: '52 cm',
        bodyLength: '74 cm',
        sleeveLength: '66 cm',
        neckWidth: '19.5 cm',
      ),
      SizeDetail(
        size: '2XL',
        partNumber: '08234-GR104-2X',
        bodyCircumference: '130 cm',
        shoulderWidth: '54 cm',
        bodyLength: '76 cm',
        sleeveLength: '68 cm',
        neckWidth: '20.0 cm',
      ),
    ],
  ),
  MerchItem(
    id: 'app-5',
    name: 'GR Track Windbreaker Light Jacket',
    category: 'apparel',
    subcategory: 'Light Jacket',
    partNumberBase: '08234-GR105',
    price: 890000,
    availability: 'Tersedia',
    stockCount: 11,
    image: 'images/jacket-hoodie.jpg',
    cropLeft: 0.108,
    cropTop: 0.19,
    cropWidth: 0.433,
    cropHeight: 0.68,
    description:
        'Jaket ringan tahan angin dengan lapisan DWR tahan percikan air, ringkas dan praktis dibawa.',
    sizes: [
      SizeDetail(
        size: 'S',
        partNumber: '08234-GR105-S',
        bodyCircumference: '108 cm',
        shoulderWidth: '45 cm',
        bodyLength: '69 cm',
        sleeveLength: '62 cm',
        neckWidth: '17.0 cm',
      ),
      SizeDetail(
        size: 'M',
        partNumber: '08234-GR105-M',
        bodyCircumference: '114 cm',
        shoulderWidth: '47 cm',
        bodyLength: '71 cm',
        sleeveLength: '64 cm',
        neckWidth: '17.5 cm',
      ),
      SizeDetail(
        size: 'L',
        partNumber: '08234-GR105-L',
        bodyCircumference: '120 cm',
        shoulderWidth: '49 cm',
        bodyLength: '73 cm',
        sleeveLength: '66 cm',
        neckWidth: '18.0 cm',
      ),
      SizeDetail(
        size: 'XL',
        partNumber: '08234-GR105-XL',
        bodyCircumference: '126 cm',
        shoulderWidth: '51 cm',
        bodyLength: '75 cm',
        sleeveLength: '68 cm',
        neckWidth: '18.5 cm',
      ),
      SizeDetail(
        size: '2XL',
        partNumber: '08234-GR105-2X',
        bodyCircumference: '132 cm',
        shoulderWidth: '53 cm',
        bodyLength: '77 cm',
        sleeveLength: '70 cm',
        neckWidth: '19.0 cm',
      ),
    ],
  ),
  MerchItem(
    id: 'app-6',
    name: 'GR Team Paddock Softshell Gazoo Jacket',
    category: 'apparel',
    subcategory: 'Gazoo Jacket',
    partNumberBase: '08234-GR106',
    price: 1350000,
    availability: 'Tersedia',
    stockCount: 8,
    image: 'images/jacket-hoodie.jpg',
    cropLeft: 0.17,
    cropTop: 0.28,
    cropWidth: 0.3,
    cropHeight: 0.4,
    description:
        'Jaket softshell motorsport kelas paddock WEC/WRC dengan isolasi termal dan patch resmi GR.',
    sizes: [
      SizeDetail(
        size: 'S',
        partNumber: '08234-GR106-S',
        bodyCircumference: '110 cm',
        shoulderWidth: '46 cm',
        bodyLength: '71 cm',
        sleeveLength: '63 cm',
        neckWidth: '18.0 cm',
      ),
      SizeDetail(
        size: 'M',
        partNumber: '08234-GR106-M',
        bodyCircumference: '116 cm',
        shoulderWidth: '48 cm',
        bodyLength: '73 cm',
        sleeveLength: '65 cm',
        neckWidth: '18.5 cm',
      ),
      SizeDetail(
        size: 'L',
        partNumber: '08234-GR106-L',
        bodyCircumference: '122 cm',
        shoulderWidth: '50 cm',
        bodyLength: '75 cm',
        sleeveLength: '67 cm',
        neckWidth: '19.0 cm',
      ),
      SizeDetail(
        size: 'XL',
        partNumber: '08234-GR106-XL',
        bodyCircumference: '128 cm',
        shoulderWidth: '52 cm',
        bodyLength: '77 cm',
        sleeveLength: '69 cm',
        neckWidth: '19.5 cm',
      ),
      SizeDetail(
        size: '2XL',
        partNumber: '08234-GR106-2X',
        bodyCircumference: '134 cm',
        shoulderWidth: '54 cm',
        bodyLength: '79 cm',
        sleeveLength: '71 cm',
        neckWidth: '20.0 cm',
      ),
    ],
  ),

  // --- GEARS ---
  MerchItem(
    id: 'gear-1',
    name: 'GR Motorsport Stormproof Umbrella',
    category: 'gears',
    subcategory: 'Umbrella',
    partNumberBase: '08234-GR201',
    price: 385000,
    availability: 'Tersedia',
    stockCount: 16,
    image: 'images/gears-merch.jpg',
    cropLeft: 0.583,
    cropTop: 0.29,
    cropWidth: 0.367,
    cropHeight: 0.52,
    description:
        'Payung paddock balap kokoh kanopi ganda tahan angin dengan rangka serat fiberglass.',
    sizes: [SizeDetail(size: 'Diameter 130 cm', partNumber: '08234-GR201-FS')],
  ),
  MerchItem(
    id: 'gear-2',
    name: 'GR Official Teamwear Snapback Cap',
    category: 'gears',
    subcategory: 'Cap',
    partNumberBase: '08234-GR202',
    price: 295000,
    availability: 'Tersedia',
    stockCount: 22,
    image: 'images/gears-merch.jpg',
    cropLeft: 0.275,
    cropTop: 0.022,
    cropWidth: 0.392,
    cropHeight: 0.524,
    description:
        'Topi balap bordir tim Gazoo Racing dengan visor bawah beraksen jahitan merah kontras.',
    sizes: [
      SizeDetail(size: 'One Size (Adjustable)', partNumber: '08234-GR202-OS'),
    ],
  ),
  MerchItem(
    id: 'gear-3',
    name: 'GR Quick-Release Paddock Lanyard',
    category: 'gears',
    subcategory: 'Lanyard',
    partNumberBase: '08234-GR203',
    price: 95000,
    availability: 'Tersedia',
    stockCount: 40,
    image: 'images/gears-merch.jpg',
    cropLeft: 0.475,
    cropTop: 0.212,
    cropWidth: 0.3,
    cropHeight: 0.48,
    description:
        'Tali gantungan ID card / kunci pit balap dengan klip carabiner gunmetal kokoh.',
    sizes: [SizeDetail(size: '52 cm x 2.5 cm', partNumber: '08234-GR203-FS')],
  ),
  MerchItem(
    id: 'gear-4',
    name: 'GR Vacuum Thermal Matte Tumbler 500ml',
    category: 'gears',
    subcategory: 'Tumbler',
    partNumberBase: '08234-GR204',
    price: 285000,
    availability: 'Tersedia',
    stockCount: 14,
    image: 'images/gears-merch.jpg',
    cropLeft: 0.158,
    cropTop: 0.3,
    cropWidth: 0.358,
    cropHeight: 0.37,
    description:
        'Botol termos stainless steel 304 food-grade berlogo laser GR, menjaga suhu hingga 24 jam.',
    sizes: [SizeDetail(size: '500 ml', partNumber: '08234-GR204-500M')],
  ),
  MerchItem(
    id: 'gear-5',
    name: 'GR Carbon Fiber Solid Keychain',
    category: 'gears',
    subcategory: 'Keychain',
    partNumberBase: '08234-GR205',
    price: 135000,
    availability: 'Tersedia',
    stockCount: 30,
    image: 'images/gears-merch.jpg',
    cropLeft: 0.221,
    cropTop: 0.569,
    cropWidth: 0.25,
    cropHeight: 0.335,
    description:
        'Gantungan kunci mewah dengan serat karbon asli 3K weave dan bingkai logam gunmetal.',
    sizes: [SizeDetail(size: '8.5 cm x 2.2 cm', partNumber: '08234-GR205-FS')],
  ),
  MerchItem(
    id: 'gear-6',
    name: 'GR Track Decal Vinyl Sticker Pack',
    category: 'gears',
    subcategory: 'Sticker',
    partNumberBase: '08234-GR206',
    price: 85000,
    availability: 'Tersedia',
    stockCount: 50,
    image: 'images/gears-merch.jpg',
    cropLeft: 0.045,
    cropTop: 0.51,
    cropWidth: 0.29,
    cropHeight: 0.39,
    description:
        'Set 6 stiker vinyl tahan air dan sinar UV untuk bodi kendaraan, helm, atau laptop.',
    sizes: [SizeDetail(size: '1 Pack (6 Pcs)', partNumber: '08234-GR206-PK6')],
  ),
];
// ---------------------------------------------------------------------------
// INFO TOKO — GANTI dengan data asli sebelum dipublikasikan.
// ---------------------------------------------------------------------------
const String kAdminPhone = '6287890743395';
const String kAdminPhoneDisplay = '+62 878-9074-3395';
const String kAdminEmail = 'epelinaaa112009@gmail.com';
const String kServiceHours = 'Senin – Sabtu, 09.00 – 17.00 WIB';
const String kAdminWhatsAppUrl = 'https://wa.me/$kAdminPhone';
