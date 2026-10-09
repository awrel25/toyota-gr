import 'package:flutter/material.dart';
import '../data/merchandise_data.dart';
import '../theme/app_theme.dart';

class _Faq {
  final String question;
  final String answer;
  const _Faq(this.question, this.answer);
}

const List<_Faq> _faqs = [
  _Faq(
    'Bagaimana cara memesan?',
    'Pilih produk dan ukuran, lalu tekan tombol "Pesan". Anda akan diarahkan ke WhatsApp admin dengan pesan yang sudah terisi nama produk, part number, ukuran, dan harga.',
  ),
  _Faq(
    'Metode pembayaran apa saja yang tersedia?',
    'Pembayaran dilakukan setelah admin mengonfirmasi stok. Metode yang tersedia (transfer bank atau e-wallet) akan diinformasikan admin melalui WhatsApp.',
  ),
  _Faq(
    'Berapa lama pengiriman?',
    'Pesanan dikirim ke seluruh Indonesia. Estimasi waktu dan ongkos kirim dihitung admin sesuai alamat tujuan dan dikonfirmasi sebelum pembayaran.',
  ),
  _Faq(
    'Bagaimana jika ukuran tidak sesuai?',
    'Gunakan tabel ukuran sebelum memesan. Jika ukuran tidak pas, hubungi admin untuk menanyakan kemungkinan penukaran sesuai ketentuan yang berlaku.',
  ),
  _Faq(
    'Apakah stok yang tampil selalu terbaru?',
    'Jumlah stok adalah perkiraan. Admin akan memastikan ketersediaan terakhir saat Anda menghubungi lewat WhatsApp.',
  ),
];

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kSurfaceAlt,
        border: Border.symmetric(horizontal: BorderSide(color: kBorder)),
      ),
      child: ContentBox(
        padding: EdgeInsets.symmetric(vertical: isNarrow(context) ? 40 : 56),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              eyebrow: 'CARA PESAN & BANTUAN',
              title: 'Informasi Pemesanan',
              subtitle: 'Tiga langkah mudah, dan jawaban untuk pertanyaan yang paling sering diajukan.',
            ),
            const SizedBox(height: 28),
            _buildSteps(),
            const SizedBox(height: 40),
            _buildFaqAndContact(),
          ],
        ),
      ),
    );
  }

  Widget _buildSteps() {
    const steps = [
      _StepData('1', 'Pilih produk', 'Telusuri koleksi, pilih ukuran, dan cek part number serta tabel ukuran.'),
      _StepData('2', 'Pesan via WhatsApp', 'Tekan tombol Pesan. Detail produk otomatis terkirim ke admin.'),
      _StepData('3', 'Konfirmasi & bayar', 'Admin memastikan stok, ongkos kirim, dan metode pembayaran.'),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 16.0;
        final columns = constraints.maxWidth >= 820 ? 3 : 1;
        final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final step in steps) SizedBox(width: width, child: _StepCard(step)),
          ],
        );
      },
    );
  }

  Widget _buildFaqAndContact() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 820;
        final faq = _buildFaq(context);
        const contact = _ContactCard();

        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: faq),
              const SizedBox(width: 24),
              const Expanded(flex: 2, child: contact),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [faq, const SizedBox(height: 20), contact],
        );
      },
    );
  }

  Widget _buildFaq(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Column(
          children: [
            for (int i = 0; i < _faqs.length; i++) ...[
              if (i > 0) const Divider(height: 1, thickness: 1, color: kBorder),
              ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
                expandedAlignment: Alignment.centerLeft,
                iconColor: kRed,
                collapsedIconColor: kTextMuted,
                textColor: Colors.white,
                collapsedTextColor: Colors.white,
                shape: const Border(),
                collapsedShape: const Border(),
                title: Text(
                  _faqs[i].question,
                  style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600),
                ),
                children: [
                  Text(
                    _faqs[i].answer,
                    style: const TextStyle(fontSize: 13, color: kTextMuted, height: 1.65),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StepData {
  final String number;
  final String title;
  final String description;
  const _StepData(this.number, this.title, this.description);
}

class _StepCard extends StatelessWidget {
  final _StepData data;
  const _StepCard(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: kRed, shape: BoxShape.circle),
            child: Text(
              data.number,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                ),
                const SizedBox(height: 6),
                Text(
                  data.description,
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

class _ContactCard extends StatelessWidget {
  const _ContactCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Butuh bantuan?',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          const SizedBox(height: 6),
          const Text(
            'Tanyakan stok, ukuran, atau pengiriman langsung ke admin.',
            style: TextStyle(fontSize: 12.5, color: kTextMuted, height: 1.5),
          ),
          const SizedBox(height: 20),
          const _ContactRow(Icons.chat_bubble_outline, 'WhatsApp', kAdminPhoneDisplay),
          const SizedBox(height: 14),
          const _ContactRow(Icons.mail_outline, 'Email', kAdminEmail),
          const SizedBox(height: 14),
          const _ContactRow(Icons.schedule, 'Jam layanan', kServiceHours),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => launchUrlWeb(kAdminWhatsAppUrl),
              icon: const Icon(Icons.chat, size: 16),
              label: const Text('Chat via WhatsApp', style: TextStyle(fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: kWhatsApp,
                foregroundColor: Colors.black,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ContactRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: kRed),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF6E7485), letterSpacing: 0.5)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 13.5, color: Colors.white, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}