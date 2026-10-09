import 'package:flutter/material.dart';
import '../models/merch_item.dart';
import '../data/merchandise_data.dart';
import '../data/shop_categories.dart';
import '../theme/app_theme.dart';
import 'product_card.dart';
import 'size_chart_dialog.dart';

class ProductGrid extends StatelessWidget {
  final List<MerchItem> items;
  const ProductGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final narrow = isNarrow(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: narrow ? 460 : 290,
        mainAxisExtent: narrow ? 540 : 500,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ProductCard(
          key: ValueKey(item.id),
          item: item,
          bestSeller: kBestSellerIds.contains(item.id),
          onOpenSizeChart: () => showSizeChartDialog(context, item),
          onOrderWhatsApp: (size) =>
              orderViaWhatsApp(item: item, selectedSize: size, context: context),
        );
      },
    );
  }
}