import 'package:flutter/material.dart';
import '../models/merch_item.dart';
import '../data/merchandise_data.dart';
import '../theme/app_theme.dart';
import 'crop_image.dart';

class StockSection extends StatelessWidget {
  final List<MerchItem> items;
  final void Function(MerchItem item, String size) onOrder;

  const StockSection({
    super.key,
    required this.items,
    required this.onOrder,
  });

  @override
  Widget build(BuildContext context) {
    final totalUnits = items.fold<int>(0, (sum, i) => sum + i.stockCount);
    final limitedCount = items.where((i) => i.isLimited).length;

    return ContentBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            eyebrow: 'INVENTORY STATUS',
            title: 'GR Merchandise Availability',
            subtitle: '${items.length} produk  •  $totalUnits unit total  •  $limitedCount stok terbatas',
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 12.0;
              final twoColumns = constraints.maxWidth >= 820;
              final tileWidth = twoColumns ? (constraints.maxWidth - gap) / 2 : constraints.maxWidth;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final item in items)
                    SizedBox(width: tileWidth, child: _buildTile(item)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTile(MerchItem item) {
    final color = item.isLimited ? kWarning : kSuccess;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kBorder),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(width: 52, height: 52, child: CroppedImage.forItem(item)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: Colors.white),
                ),
                const SizedBox(height: 3),
                Text(
                  item.partNumberBase,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: kTextMuted, fontFamily: 'monospace'),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '${item.availability}  •  ${item.stockCount} unit',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatRupiah(item.price),
                style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 30,
                child: OutlinedButton(
                  onPressed: () => onOrder(item, item.sizes.first.size),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kWhatsApp,
                    side: const BorderSide(color: kWhatsApp),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: const Text('Pesan WA', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}