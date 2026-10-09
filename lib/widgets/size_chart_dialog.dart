import 'package:flutter/material.dart';
import '../models/merch_item.dart';
import '../data/merchandise_data.dart';

class SizeChartDialog extends StatelessWidget {
  final MerchItem? initialItem;
  final void Function(MerchItem item, String size) onOrder;

  const SizeChartDialog({
    super.key,
    required this.initialItem,
    required this.onOrder,
  });

  @override
  Widget build(BuildContext context) {
    final isApparel = initialItem == null || initialItem!.category == 'apparel';
    final targetList = initialItem != null
        ? [initialItem!]
        : kMerchandiseList.where((i) => i.category == 'apparel').toList();

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: const Color(0xFF14161C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 880, maxHeight: 620),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      initialItem != null ? 'Tabel Ukuran: ${initialItem!.name}' : 'Panduan Ukuran Resmi TGR',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, size: 20, color: Color(0xFF8F95A5)),
                  ),
                ],
              ),
              const Divider(color: Color(0xFF22252E)),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: isApparel
                        ? DataTable(
                            headingRowColor: WidgetStateProperty.all(const Color(0xFF1C1E26)),
                            columns: const [
                              DataColumn(label: Text('Nama')),
                              DataColumn(label: Text('Size')),
                              DataColumn(label: Text('Part Number')),
                              DataColumn(label: Text('Lingkar Badan')),
                              DataColumn(label: Text('Lebar Bahu')),
                              DataColumn(label: Text('Panjang')),
                              DataColumn(label: Text('Aksi')),
                            ],
                            rows: [
                              for (final item in targetList)
                                for (final s in item.sizes)
                                  DataRow(cells: [
                                    DataCell(Text(item.name)),
                                    DataCell(Text(s.size, style: const TextStyle(fontWeight: FontWeight.w700))),
                                    DataCell(Text(s.partNumber, style: const TextStyle(fontFamily: 'monospace'))),
                                    DataCell(Text(s.bodyCircumference ?? '-')),
                                    DataCell(Text(s.shoulderWidth ?? '-')),
                                    DataCell(Text(s.bodyLength ?? '-')),
                                    DataCell(
                                      TextButton(
                                        onPressed: () => onOrder(item, s.size),
                                        child: const Text('Pesan WA', style: TextStyle(color: Color(0xFF25D366))),
                                      ),
                                    ),
                                  ]),
                            ],
                          )
                        : DataTable(
                            headingRowColor: WidgetStateProperty.all(const Color(0xFF1C1E26)),
                            columns: const [
                              DataColumn(label: Text('Nama')),
                              DataColumn(label: Text('Size')),
                              DataColumn(label: Text('Part Number')),
                              DataColumn(label: Text('Aksi')),
                            ],
                            rows: [
                              for (final item in [initialItem!])
                                for (final s in item.sizes)
                                  DataRow(cells: [
                                    DataCell(Text(item.name)),
                                    DataCell(Text(s.size, style: const TextStyle(fontWeight: FontWeight.w700))),
                                    DataCell(Text(s.partNumber, style: const TextStyle(fontFamily: 'monospace'))),
                                    DataCell(
                                      TextButton(
                                        onPressed: () => onOrder(item, s.size),
                                        child: const Text('Pesan WA', style: TextStyle(color: Color(0xFF25D366))),
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/// Membuka dialog tabel ukuran. [item] null = panduan ukuran semua apparel.
void showSizeChartDialog(BuildContext context, MerchItem? item) {
  showDialog(
    context: context,
    builder: (ctx) => SizeChartDialog(
      initialItem: item,
      onOrder: (i, size) {
        Navigator.pop(ctx);
        orderViaWhatsApp(item: i, selectedSize: size, context: context);
      },
    ),
  );
}
