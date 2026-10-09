import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kSurfaceAlt,
        border: Border.symmetric(horizontal: BorderSide(color: kBorder)),
      ),
      child: ContentBox(
        padding: EdgeInsets.symmetric(vertical: isNarrow(context) ? 40 : 64),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 820;
            final text = _buildText(context);
            final facts = _buildFacts();

            if (wide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: text),
                  const SizedBox(width: 48),
                  Expanded(flex: 4, child: facts),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [text, const SizedBox(height: 32), facts],
            );
          },
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          eyebrow: 'TENTANG KAMI',
          title: 'Nasmoco, Dealer Resmi Toyota di Jawa Tengah & DIY',
        ),
        const SizedBox(height: 18),
        // Wordmark sementara — ganti dengan logo Nasmoco asli bila tersedia.
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF2F3340)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NASMOCO',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'AUTHORIZED TOYOTA DEALER',
                style: TextStyle(fontSize: 9.5, letterSpacing: 1.8, color: kTextMuted),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Nasmoco adalah dealer utama resmi Toyota yang melayani wilayah Jawa Tengah dan '
          'Daerah Istimewa Yogyakarta melalui jaringan cabang di berbagai kota. Layanannya '
          'mencakup penjualan kendaraan, servis berkala, dan penyediaan suku cadang resmi Toyota.',
          style: TextStyle(fontSize: 14, color: Color(0xFFB4B9C6), height: 1.75),
        ),
        const SizedBox(height: 14),
        const Text(
          'Melalui katalog ini, Nasmoco menghadirkan apparel dan merchandise TOYOTA GAZOO RACING '
          'untuk para penggemar motorsport, lengkap dengan part number dan tabel ukuran yang jelas '
          'agar mudah dipesan.',
          style: TextStyle(fontSize: 14, color: Color(0xFFB4B9C6), height: 1.75),
        ),
      ],
    );
  }

  Widget _buildFacts() {
    return const Column(
      children: [
        _FactCard(
          icon: Icons.workspace_premium_outlined,
          title: 'Dealer utama resmi sejak 1972',
          description: 'Ditunjuk sebagai Authorized Toyota Main Dealer untuk wilayah Jawa Tengah dan DI Yogyakarta.',
        ),
        SizedBox(height: 14),
        _FactCard(
          icon: Icons.store_mall_directory_outlined,
          title: 'Jaringan cabang luas',
          description: 'Hadir di berbagai kota di Jawa Tengah dan DI Yogyakarta untuk menjangkau pelanggan.',
        ),
        SizedBox(height: 14),
        _FactCard(
          icon: Icons.build_circle_outlined,
          title: 'Layanan menyeluruh',
          description: 'Penjualan kendaraan, servis berkala, dan suku cadang asli Toyota.',
        ),
      ],
    );
  }
}

class _FactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FactCard({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: kRed.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 22, color: kRed),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: Colors.white),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12.5, color: kTextMuted, height: 1.55),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}