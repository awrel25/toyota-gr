import 'package:flutter/material.dart';
import '../data/merchandise_data.dart';
import '../data/shop_categories.dart';
import '../theme/app_theme.dart';

/// Pindah halaman (tidak melakukan apa-apa jika sudah di halaman tujuan).
void goTo(BuildContext context, String route, {String? current}) {
  if (route == current) return;
  Navigator.of(context).pushNamed(route);
}

class _NavEntry {
  final String label;
  final String route;
  const _NavEntry(this.label, this.route);
}

final List<_NavEntry> _navEntries = [
  const _NavEntry('Beranda', '/'),
  for (final c in kShopCategories) _NavEntry(c.label, c.route),
];

/// Kerangka semua halaman: bar navigasi + isi + footer.
class SitePage extends StatelessWidget {
  final String currentRoute;
  final List<Widget> slivers;
  final ScrollController? controller;

  const SitePage({
    super.key,
    required this.currentRoute,
    required this.slivers,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: controller,
        slivers: [
          SiteAppBar(currentRoute: currentRoute),
          ...slivers,
          SliverToBoxAdapter(child: SiteFooter(currentRoute: currentRoute)),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// BAR NAVIGASI
// -----------------------------------------------------------------------------
class SiteAppBar extends StatelessWidget {
  final String currentRoute;
  const SiteAppBar({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    final compact = isCompactNav(context);

    return SliverAppBar(
      floating: true,
      pinned: true,
      toolbarHeight: 64,
      backgroundColor: kBg.withValues(alpha: 0.96),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1, thickness: 1, color: Color(0xFF22252C)),
      ),
      titleSpacing: pagePadding(context),
      title: InkWell(
        onTap: () => goTo(context, '/', current: currentRoute),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const GrBadge(),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                'TOYOTA GAZOO RACING',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: compact ? 13 : 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: compact ? 1.2 : 2.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        if (!compact) ...[
          for (final entry in _navEntries)
            _NavLink(
              label: entry.label,
              active: entry.route == currentRoute,
              onTap: () => goTo(context, entry.route, current: currentRoute),
            ),
          const SizedBox(width: 12),
          OutlinedButton.icon(
            onPressed: () => launchUrlWeb(kAdminWhatsAppUrl),
            icon: const Icon(Icons.chat_bubble_outline, size: 14, color: kWhatsApp),
            label: const Text('Kontak Admin', style: TextStyle(color: Colors.white, fontSize: 12)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF2F3440)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
          ),
          SizedBox(width: pagePadding(context)),
        ] else ...[
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, color: Colors.white),
            color: const Color(0xFF1A1C22),
            tooltip: 'Menu',
            onSelected: (value) {
              if (value == 'admin') {
                launchUrlWeb(kAdminWhatsAppUrl);
              } else {
                goTo(context, value, current: currentRoute);
              }
            },
            itemBuilder: (context) => [
              for (final entry in _navEntries)
                PopupMenuItem<String>(
                  value: entry.route,
                  child: Text(
                    entry.label,
                    style: TextStyle(
                      fontWeight: entry.route == currentRoute ? FontWeight.w800 : FontWeight.w400,
                      color: entry.route == currentRoute ? kRed : Colors.white,
                    ),
                  ),
                ),
              const PopupMenuItem<String>(
                value: 'admin',
                child: Text('Kontak Admin (WhatsApp)'),
              ),
            ],
          ),
          SizedBox(width: pagePadding(context) > 12 ? pagePadding(context) - 12 : 0),
        ],
      ],
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 64,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: active ? kRed : Colors.transparent, width: 2),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              color: active ? Colors.white : const Color(0xFFBAC0CD),
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// FOOTER
// -----------------------------------------------------------------------------
class SiteFooter extends StatelessWidget {
  final String currentRoute;
  const SiteFooter({super.key, required this.currentRoute});

  Widget _link(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFFA0A5B5))),
      ),
    );
  }

  Widget _heading(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.8,
          color: Color(0xFF6E7485),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: isNarrow(context) ? 72 : 100),
      decoration: const BoxDecoration(
        color: Color(0xFF090A0D),
        border: Border(top: BorderSide(color: Color(0xFF1C1E24))),
      ),
      child: ContentBox(
        padding: const EdgeInsets.only(top: 48, bottom: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 32,
                spacing: 40,
                children: [
                  SizedBox(
                    width: 320,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GrBadge(fontSize: 12),
                            SizedBox(width: 10),
                            Text(
                              'TOYOTA GAZOO RACING',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Katalog apparel dan merchandise balap resmi. Pushing the limits.',
                          style: TextStyle(fontSize: 13, color: kTextMuted, height: 1.6),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _heading('JELAJAHI'),
                      for (final entry in _navEntries)
                        _link(entry.label, () => goTo(context, entry.route, current: currentRoute)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _heading('HUBUNGI KAMI'),
                      _link('WhatsApp: $kAdminPhoneDisplay', () => launchUrlWeb(kAdminWhatsAppUrl)),
                      _link('Email: $kAdminEmail', () => launchUrlWeb('mailto:$kAdminEmail')),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(kServiceHours, style: const TextStyle(fontSize: 13, color: kTextMuted)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
            const Divider(height: 1, thickness: 1, color: Color(0xFF1C1E24)),
            const SizedBox(height: 20),
            const Text(
              'Situs ini adalah proyek demonstrasi (PKL) dan bukan situs resmi Toyota Motor Corporation. '
              'TOYOTA, GAZOO Racing, dan logo terkait adalah merek dagang dari pemiliknya masing-masing.',
              style: TextStyle(fontSize: 11.5, color: Color(0xFF6E7485), height: 1.6),
            ),
            const SizedBox(height: 10),
            const Text(
              '© 2026 Toyota Gazoo Racing Apparel. Hak Cipta Dilindungi.',
              style: TextStyle(fontSize: 11.5, color: Color(0xFF6E7485)),
            ),
          ],
        ),
      ),
    );
  }
}