import 'package:flutter/material.dart';
import '../data/merchandise_data.dart';
import '../theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onExplore;
  final VoidCallback onOpenSizeGuide;

  const HeroSection({
    super.key,
    required this.onExplore,
    required this.onOpenSizeGuide,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildBanner(context),
        _buildInfoStrip(context),
      ],
    );
  }

  Widget _buildBanner(BuildContext context) {
    final narrow = isNarrow(context);

    return SizedBox(
      height: narrow ? 560 : 620,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'images/hero-racing.jpg',
            fit: BoxFit.cover,
            alignment: narrow ? const Alignment(0.3, 0) : Alignment.center,
            errorBuilder: (_, _, _) => Container(color: const Color(0xFF16181D)),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: narrow
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        kBg.withValues(alpha: 0.25),
                        kBg.withValues(alpha: 0.7),
                        kBg.withValues(alpha: 0.96),
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    )
                  : LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        kBg.withValues(alpha: 0.94),
                        kBg.withValues(alpha: 0.72),
                        kBg.withValues(alpha: 0.0),
                      ],
                      stops: const [0.0, 0.42, 0.85],
                    ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [kBg.withValues(alpha: 0.0), kBg],
                stops: const [0.78, 1.0],
              ),
            ),
          ),
          Align(
            alignment: narrow ? Alignment.bottomLeft : Alignment.centerLeft,
            child: ContentBox(
              padding: EdgeInsets.only(bottom: narrow ? 36 : 0),
              child: Align(
                alignment: narrow ? Alignment.bottomLeft : Alignment.centerLeft,
                child: _buildHeroText(narrow),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroText(bool narrow) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: kRed.withValues(alpha: 0.18),
              border: Border.all(color: kRed.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'OFFICIAL MERCHANDISE',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
                color: Color(0xFFFF6B78),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'TOYOTA GAZOO RACING',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 4.0,
              color: Color(0xFFD5D9E3),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pushing the limits.',
            style: TextStyle(
              fontSize: narrow ? 42 : 66,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.0,
              height: 1.05,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Apparel dan merchandise balap resmi untuk penggemar motorsport sejati, dihadirkan oleh Nasmoco, dealer resmi Toyota di Jawa Tengah & DIY.',
            style: TextStyle(fontSize: 15, color: Color(0xFFB4B9C6), height: 1.6),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton(
                onPressed: onExplore,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kRed,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text(
                  'Lihat Koleksi',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 1.0),
                ),
              ),
              OutlinedButton(
                onPressed: onOpenSizeGuide,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black.withValues(alpha: 0.25),
                  side: const BorderSide(color: Color(0xFF5A5F6E)),
                  padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text(
                  'Panduan Ukuran',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoStrip(BuildContext context) {
    final narrow = isNarrow(context);
    final items = [
      _InfoItem(Icons.verified_outlined, '${kMerchandiseList.length} Produk Resmi', 'Apparel & merchandise TGR'),
      const _InfoItem(Icons.tag, 'Part Number Jelas', 'Setiap ukuran punya kode sendiri'),
      const _InfoItem(Icons.chat_bubble_outline, 'Pesan via WhatsApp', 'Format pesan terisi otomatis'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: kSurfaceAlt,
        border: Border.symmetric(horizontal: BorderSide(color: kBorder)),
      ),
      child: ContentBox(
        padding: EdgeInsets.symmetric(vertical: narrow ? 20 : 24),
        child: SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 40,
            runSpacing: 18,
            children: items,
          ),
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoItem(this.icon, this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: kRed.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: kRed),
        ),
        const SizedBox(width: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: kTextMuted)),
          ],
        ),
      ],
    );
  }
}