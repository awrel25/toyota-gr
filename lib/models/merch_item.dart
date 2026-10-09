class MerchItem {
  final String id;
  final String name;
  final String category; // 'apparel' atau 'gears'
  final String subcategory;
  final String partNumberBase;
  final int price;
  final String availability;
  final int stockCount;
  final String image;
  final String description;
  final List<SizeDetail> sizes;

  /// Area crop foto (pecahan 0..1 dari foto sumber). Default = seluruh foto.
  final double cropLeft;
  final double cropTop;
  final double cropWidth;
  final double cropHeight;

  const MerchItem({
    required this.id,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.partNumberBase,
    required this.price,
    required this.availability,
    required this.stockCount,
    required this.image,
    required this.description,
    required this.sizes,
    this.cropLeft = 0,
    this.cropTop = 0,
    this.cropWidth = 1,
    this.cropHeight = 1,
  });

  bool get isLimited => stockCount <= 10 || availability != 'Tersedia';
}

class SizeDetail {
  final String size;
  final String partNumber;
  final String? bodyCircumference;
  final String? shoulderWidth;
  final String? bodyLength;
  final String? sleeveLength;
  final String? neckWidth;

  const SizeDetail({
    required this.size,
    required this.partNumber,
    this.bodyCircumference,
    this.shoulderWidth,
    this.bodyLength,
    this.sleeveLength,
    this.neckWidth,
  });
}