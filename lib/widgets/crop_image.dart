import 'package:flutter/material.dart';
import '../models/merch_item.dart';

/// Ukuran asli foto sumber (px). Dipakai untuk menghitung area crop.
const Map<String, Size> _kSourceSize = {
  'images/polo-tshirt.jpg': Size(1200, 896),
  'images/jacket-hoodie.jpg': Size(1200, 896),
  'images/gears-merch.jpg': Size(1200, 896),
};

/// Menampilkan sebagian area dari sebuah foto (crop pecahan 0..1),
/// lalu mengisi penuh kotak induknya (seperti BoxFit.cover).
///
/// Dipakai karena 1 foto berisi beberapa produk sekaligus, sehingga
/// tiap produk bisa tampil dengan potongan fotonya sendiri.
class CroppedImage extends StatelessWidget {
  final String src;
  final double left, top, width, height;

  const CroppedImage({
    super.key,
    required this.src,
    this.left = 0,
    this.top = 0,
    this.width = 1,
    this.height = 1,
  });

  factory CroppedImage.forItem(MerchItem item, {Key? key}) => CroppedImage(
        key: key,
        src: item.image,
        left: item.cropLeft,
        top: item.cropTop,
        width: item.cropWidth,
        height: item.cropHeight,
      );

  @override
  Widget build(BuildContext context) {
    final fallback = Container(color: const Color(0xFF1E2129));
    final source = _kSourceSize[src];
    if (source == null) {
      return Image.network(
        src,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => fallback,
      );
    }

    final cropW = source.width * width;
    final cropH = source.height * height;

    return ClipRect(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: cropW,
          height: cropH,
          child: ClipRect(
            child: OverflowBox(
              alignment: Alignment.topLeft,
              minWidth: source.width,
              maxWidth: source.width,
              minHeight: source.height,
              maxHeight: source.height,
              child: Transform.translate(
                offset: Offset(-source.width * left, -source.height * top),
                child: Image.network(
                  src,
                  width: source.width,
                  height: source.height,
                  fit: BoxFit.fill,
                  errorBuilder: (_, _, _) => fallback,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
