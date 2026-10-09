import 'package:flutter/material.dart';
import '../models/merch_item.dart';
import '../theme/app_theme.dart';
import 'crop_image.dart';

class SizeChartSection extends StatefulWidget {
  final List<MerchItem> items;
  final void Function(MerchItem item, String size) onOrder;

  const SizeChartSection({
    super.key,
    required this.items,
    required this.onOrder,
  });

  @override
  State<SizeChartSection> createState() => _SizeChartSectionState();
}

class _SizeChartSectionState extends State<SizeChartSection> {
  int _tabIndex = 0; // 0: Apparel, 1: Gears & Cap
  int _apparelIndex = 0; // produk apparel yang sedang ditampilkan

    @override
  Widget build(BuildContext context) {
    final apparelItems = widget.items.where((i) => i.category == 'apparel').toList();
    final gearsItems = widget.items.where((i) => i.category == 'gears').toList();
    final hasApparel = apparelItems.isNotEmpty;
    final hasGears = gearsItems.isNotEmpty;
    if (!hasApparel && !hasGears) return const SizedBox.shrink();

    // Tab hanya muncul kalau kedua jenis ada.
    final showApparel = hasApparel && (!hasGears || _tabIndex == 0);
    final safeApparelIndex = _apparelIndex < apparelItems.length ? _apparelIndex : 0;

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
              eyebrow: 'SIZE SPECIFICATIONS',
              title: 'Tabel Ukuran & Part Number',
              subtitle: 'Semua ukuran dalam cm. Pilih produk untuk melihat detail tiap size.',
            ),
            const SizedBox(height: 24),

            if (hasApparel && hasGears) ...[
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _tabBtn(0, 'Apparel', Icons.checkroom_outlined),
                  _tabBtn(1, 'Gears & Cap', Icons.backpack_outlined),
                ],
              ),
              const SizedBox(height: 20),
            ],

            if (showApparel) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (int i = 0; i < apparelItems.length; i++)
                    _productChip(apparelItems[i].subcategory, i == safeApparelIndex, () {
                      setState(() => _apparelIndex = i);
                    }),
                ],
              ),
              const SizedBox(height: 16),
              _buildApparelTable(apparelItems[safeApparelIndex]),
            ] else
              _buildGearsTable(gearsItems),
          ],
        ),
      ),
    );
  }

  Widget _tabBtn(int index, String label, IconData icon) {
    final isSelected = _tabIndex == index;
    return InkWell(
      onTap: () => setState(() => _tabIndex = index),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? kRed : const Color(0xFF161820),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isSelected ? kRed : const Color(0xFF2A2E38)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: isSelected ? Colors.white : const Color(0xFFA0A5B5)),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFFA0A5B5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productChip(String label, bool selected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? Colors.white : const Color(0xFF2F3340)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.black : kTextSoft,
          ),
        ),
      ),
    );
  }

  Widget _tableShell(Widget table) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: kSurfaceAlt,
        border: Border.all(color: kBorder),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth - 2),
            child: table,
          ),
        ),
      ),
    );
  }

  Widget _thumb(MerchItem item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: SizedBox(width: 44, height: 44, child: CroppedImage.forItem(item)),
    );
  }

  Widget _orderLink(MerchItem item, String size) {
    return TextButton.icon(
      onPressed: () => widget.onOrder(item, size),
      icon: const Icon(Icons.chat_bubble_outline, size: 14, color: kWhatsApp),
      label: const Text('Pesan', style: TextStyle(color: kWhatsApp, fontWeight: FontWeight.w600, fontSize: 12)),
    );
  }

  Widget _buildApparelTable(MerchItem item) {
    return _tableShell(
      DataTable(
        headingRowColor: WidgetStateProperty.all(const Color(0xFF161820)),
        dataRowColor: WidgetStateProperty.all(kSurfaceAlt),
        headingRowHeight: 46,
        dataRowMinHeight: 56,
        dataRowMaxHeight: 56,
        columnSpacing: 28,
        dividerThickness: 0.6,
        headingTextStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),
        dataTextStyle: const TextStyle(fontSize: 12.5, color: kTextSoft),
        columns: const [
          DataColumn(label: Text('Image')),
          DataColumn(label: Text('Nama Produk')),
          DataColumn(label: Text('Size')),
          DataColumn(label: Text('Part Number')),
          DataColumn(label: Text('Lingkar Badan')),
          DataColumn(label: Text('Lebar Bahu')),
          DataColumn(label: Text('Panjang Badan')),
          DataColumn(label: Text('Panjang Lengan')),
          DataColumn(label: Text('Lebar Leher')),
          DataColumn(label: Text('Aksi')),
        ],
        rows: [
          for (final size in item.sizes)
            DataRow(
              cells: [
                DataCell(_thumb(item)),
                DataCell(Text(item.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                DataCell(Text(size.size, style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.white))),
                DataCell(Text(size.partNumber, style: const TextStyle(fontFamily: 'monospace'))),
                DataCell(Text(size.bodyCircumference ?? '-')),
                DataCell(Text(size.shoulderWidth ?? '-')),
                DataCell(Text(size.bodyLength ?? '-')),
                DataCell(Text(size.sleeveLength ?? '-')),
                DataCell(Text(size.neckWidth ?? '-')),
                DataCell(_orderLink(item, size.size)),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildGearsTable(List<MerchItem> items) {
    return _tableShell(
      DataTable(
        headingRowColor: WidgetStateProperty.all(const Color(0xFF161820)),
        dataRowColor: WidgetStateProperty.all(kSurfaceAlt),
        headingRowHeight: 46,
        dataRowMinHeight: 56,
        dataRowMaxHeight: 56,
        columnSpacing: 32,
        dividerThickness: 0.6,
        headingTextStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),
        dataTextStyle: const TextStyle(fontSize: 12.5, color: kTextSoft),
        columns: const [
          DataColumn(label: Text('Image')),
          DataColumn(label: Text('Nama Produk')),
          DataColumn(label: Text('Size / Dimensi')),
          DataColumn(label: Text('Part Number')),
          DataColumn(label: Text('Ketersediaan')),
          DataColumn(label: Text('Aksi')),
        ],
        rows: [
          for (final item in items)
            for (final size in item.sizes)
              DataRow(
                cells: [
                  DataCell(_thumb(item)),
                  DataCell(Text(item.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                  DataCell(Text(size.size, style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white))),
                  DataCell(Text(size.partNumber, style: const TextStyle(fontFamily: 'monospace'))),
                  DataCell(
                    Text(
                      item.availability,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: item.isLimited ? kWarning : kSuccess,
                      ),
                    ),
                  ),
                  DataCell(_orderLink(item, size.size)),
                ],
              ),
        ],
      ),
    );
  }
}