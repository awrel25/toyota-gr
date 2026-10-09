import 'package:flutter/material.dart';
import '../data/merchandise_data.dart';
import '../data/shop_categories.dart';
import '../theme/app_theme.dart';
import '../widgets/product_grid.dart';
import '../widgets/site_shell.dart';
import '../widgets/size_chart_section.dart';
import '../widgets/stock_section.dart';

class CategoryPage extends StatelessWidget {
  final ShopCategory category;
  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final items = category.items;
    final narrow = isNarrow(context);
    final gap = narrow ? 64.0 : 88.0;

    void order(item, String size) =>
        orderViaWhatsApp(item: item, selectedSize: size, context: context);

    return SitePage(
      currentRoute: category.route,
      slivers: [
        SliverToBoxAdapter(
          child: _CategoryBanner(category: category, count: items.length),
        ),
        SliverToBoxAdapter(
          child: ContentBox(
            padding: EdgeInsets.only(top: narrow ? 32 : 48),
            child: ProductGrid(items: items),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(top: gap),
            child: SizeChartSection(items: items, onOrder: order),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.only(top: gap),
            child: StockSection(items: items, onOrder: order),
          ),
        ),
      ],
    );
  }
}

class _CategoryBanner extends StatelessWidget {
  final ShopCategory category;
  final int count;

  const _CategoryBanner({required this.category, required this.count});

  @override
  Widget build(BuildContext context) {
    final narrow = isNarrow(context);

    return SizedBox(
      height: narrow ? 250 : 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            category.image,
            fit: BoxFit.cover,
            alignment: category.imageAlignment,
            errorBuilder: (_, _, _) => Container(color: const Color(0xFF16181D)),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  kBg.withValues(alpha: 0.96),
                  kBg.withValues(alpha: narrow ? 0.85 : 0.7),
                  kBg.withValues(alpha: narrow ? 0.6 : 0.1),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [kBg.withValues(alpha: 0.0), kBg],
                stops: const [0.7, 1.0],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ContentBox(
              child: Align(
                alignment: Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () => goTo(context, '/', current: category.route),
                            child: const Text(
                              'Beranda',
                              style: TextStyle(fontSize: 12.5, color: Color(0xFFA0A5B5)),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text('/', style: TextStyle(fontSize: 12.5, color: Color(0xFF6E7485))),
                          ),
                          Text(
                            category.label,
                            style: const TextStyle(fontSize: 12.5, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        category.title,
                        style: TextStyle(
                          fontSize: narrow ? 34 : 48,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          height: 1.05,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        category.description,
                        style: const TextStyle(fontSize: 14, color: Color(0xFFB4B9C6), height: 1.6),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        '$count produk',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: Color(0xFFFF6B78),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}