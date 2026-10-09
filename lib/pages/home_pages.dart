import 'package:flutter/material.dart';
import '../data/shop_categories.dart';
import '../theme/app_theme.dart';
import '../widgets/about_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/info_section.dart';
import '../widgets/product_grid.dart';
import '../widgets/site_shell.dart';
import '../widgets/size_chart_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();
  final GlobalKey _categoryKey = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollToCategories() {
    final ctx = _categoryKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final gap = isNarrow(context) ? 64.0 : 88.0;

    return SitePage(
      currentRoute: '/',
      controller: _controller,
      slivers: [
        // 1. Pengenalan
        SliverToBoxAdapter(
          child: HeroSection(
            onExplore: _scrollToCategories,
            onOpenSizeGuide: () => showSizeChartDialog(context, null),
          ),
        ),

        // 2. Kategori
        SliverToBoxAdapter(
          child: Container(
            key: _categoryKey,
            padding: EdgeInsets.only(top: gap - 8),
            child: const _CategorySection(),
          ),
        ),

        // 3. Best seller
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(top: gap),
            child: const _BestSellerSection(),
          ),
        ),

        // 4. Tentang Nasmoco
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(top: gap),
            child: const AboutSection(),
          ),
        ),

        // 5. Cara pesan, FAQ & kontak
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(top: gap),
            child: const InfoSection(),
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// KATEGORI
// -----------------------------------------------------------------------------
class _CategorySection extends StatelessWidget {
  const _CategorySection();

  @override
  Widget build(BuildContext context) {
    final narrow = isNarrow(context);
    final tiles = [for (final c in kShopCategories) _CategoryTile(category: c)];

    return ContentBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'KOLEKSI',
            title: 'Belanja Berdasarkan Kategori',
          ),
          const SizedBox(height: 24),
          if (narrow)
            Column(
              children: [
                for (int i = 0; i < tiles.length; i++) ...[
                  if (i > 0) const SizedBox(height: 14),
                  SizedBox(height: 190, child: tiles[i]),
                ],
              ],
            )
          else
            SizedBox(
              height: 280,
              child: Row(
                children: [
                  for (int i = 0; i < tiles.length; i++) ...[
                    if (i > 0) const SizedBox(width: 18),
                    Expanded(child: tiles[i]),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final ShopCategory category;
  const _CategoryTile({required this.category});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            category.image,
            fit: BoxFit.cover,
            alignment: category.imageAlignment,
            errorBuilder: (_, _, _) => Container(color: const Color(0xFF1E2129)),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withValues(alpha: 0.05), Colors.black.withValues(alpha: 0.88)],
                stops: const [0.35, 1.0],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 64,
            bottom: 18,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${category.items.length} produk',
                  style: const TextStyle(fontSize: 12.5, color: Color(0xFFC4C8D4)),
                ),
              ],
            ),
          ),
          Positioned(
            right: 18,
            bottom: 18,
            child: Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(color: kRed, shape: BoxShape.circle),
              child: const Icon(Icons.arrow_forward, size: 18, color: Colors.white),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(onTap: () => goTo(context, category.route, current: '/')),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// BEST SELLER
// -----------------------------------------------------------------------------
class _BestSellerSection extends StatelessWidget {
  const _BestSellerSection();

  @override
  Widget build(BuildContext context) {
    return ContentBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'BEST SELLER',
            title: 'Pilihan Terpopuler',
            subtitle: 'Produk yang paling banyak dicari penggemar TOYOTA GAZOO RACING.',
          ),
          const SizedBox(height: 28),
          ProductGrid(items: bestSellerItems()),
        ],
      ),
    );
  }
}