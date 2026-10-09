import 'package:flutter/material.dart';
import '../models/merch_item.dart';
import '../data/merchandise_data.dart';
import '../theme/app_theme.dart';
import 'crop_image.dart';

class ProductCard extends StatefulWidget {
  final MerchItem item;
  final bool bestSeller;
  final VoidCallback onOpenSizeChart;
  final ValueChanged<String> onOrderWhatsApp;

  const ProductCard({
    super.key,
    required this.item,
    required this.onOpenSizeChart,
    required this.onOrderWhatsApp,
    this.bestSeller = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late String _selectedSize;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.item.sizes.isNotEmpty ? widget.item.sizes.first.size : 'Standard';
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final activeSize = item.sizes.firstWhere(
      (s) => s.size == _selectedSize,
      orElse: () => item.sizes.first,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: kSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _hovered ? kRed.withValues(alpha: 0.7) : kBorder),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar: mengisi sisa tinggi kartu, jadi tinggi kartu selalu pas
            Expanded(child: _buildImage(item)),

            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    activeSize.partNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      letterSpacing: 0.3,
                      color: kTextMuted,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 40,
                    child: Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 34,
                    child: Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11.5, color: kTextMuted, height: 1.45),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Label ukuran + link panduan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'UKURAN',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                          color: Color(0xFF6E7485),
                        ),
                      ),
                      InkWell(
                        onTap: widget.onOpenSizeChart,
                        child: const Text(
                          'Tabel ukuran',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFFFF4D5E),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFFFF4D5E),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 30,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (final s in item.sizes) ...[
                            _buildSizeChip(s.size),
                            const SizedBox(width: 6),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Harga + tombol pesan
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          formatRupiah(item.price),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () => widget.onOrderWhatsApp(_selectedSize),
                        icon: const Icon(Icons.chat, size: 14),
                        label: const Text(
                          'Pesan',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kWhatsApp,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(MerchItem item) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CroppedImage.forItem(item),
        // Gradien tipis di bawah foto supaya menyatu dengan kartu
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 40,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [kSurface.withValues(alpha: 0.0), kSurface.withValues(alpha: 0.9)],
              ),
            ),
          ),
        ),
                Positioned(
          top: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _badge(item.subcategory, Colors.black.withValues(alpha: 0.72), Colors.white),
              if (widget.bestSeller) ...[
                const SizedBox(height: 6),
                _badge('BEST SELLER', kRed, Colors.white),
              ],
            ],
          ),
        ),
        if (item.isLimited)
          Positioned(
            top: 10,
            right: 10,
            child: _badge('Sisa ${item.stockCount}', kWarning, Colors.black),
          ),
      ],
    );
  }

  Widget _badge(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
      child: Text(
        text,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: fg),
      ),
    );
  }

  Widget _buildSizeChip(String size) {
    final isChosen = _selectedSize == size;
    return InkWell(
      onTap: () => setState(() => _selectedSize = size),
      borderRadius: BorderRadius.circular(5),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isChosen ? kRed : const Color(0xFF1E2129),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: isChosen ? kRed : const Color(0xFF2B2E38)),
        ),
        child: Text(
          size,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: isChosen ? Colors.white : kTextSoft,
          ),
        ),
      ),
    );
  }
}