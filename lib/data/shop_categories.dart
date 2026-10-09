import 'package:flutter/material.dart';
import '../models/merch_item.dart';
import 'merchandise_data.dart';

/// Satu halaman produk (Baju / Hoodie & Jaket / Merchandise).
class ShopCategory {
  final String route;
  final String label; // teks di bar navigasi
  final String title; // judul besar di halaman
  final String description;
  final String image;
  final Alignment imageAlignment;
  final Set<String> itemIds; // id produk yang masuk kategori ini

  const ShopCategory({
    required this.route,
    required this.label,
    required this.title,
    required this.description,
    required this.image,
    required this.itemIds,
    this.imageAlignment = Alignment.center,
  });

  List<MerchItem> get items =>
      kMerchandiseList.where((i) => itemIds.contains(i.id)).toList();
}

const List<ShopCategory> kShopCategories = [
  ShopCategory(
    route: '/baju',
    label: 'Baju',
    title: 'Baju',
    description: 'Polo, T-Shirt, dan kemeja bertema motorsport dengan emblem GR resmi.',
    image: 'images/polo-tshirt.jpg',
    itemIds: {'app-1', 'app-2', 'app-3'},
  ),
  ShopCategory(
    route: '/hoodie',
    label: 'Hoodie & Jaket',
    title: 'Hoodie & Jaket',
    description: 'Hoodie dan jaket paddock untuk cuaca apa pun, dari trek sampai jalan raya.',
    image: 'images/jacket-hoodie.jpg',
    itemIds: {'app-4', 'app-5', 'app-6'},
  ),
  ShopCategory(
    route: '/merchandise',
    label: 'Merchandise',
    title: 'Merchandise',
    description: 'Cap, tumbler, payung, dan aksesori resmi untuk melengkapi koleksi Anda.',
    image: 'images/gears-merch.jpg',
    imageAlignment: Alignment(0, -0.3),
    itemIds: {'gear-1', 'gear-2', 'gear-3', 'gear-4', 'gear-5', 'gear-6'},
  ),
];

const Set<String> kBestSellerIds = {'app-1', 'app-4', 'gear-2', 'gear-4'};

ShopCategory? categoryForRoute(String route) {
  for (final c in kShopCategories) {
    if (c.route == route) return c;
  }
  return null;
}

List<MerchItem> bestSellerItems() =>
    kMerchandiseList.where((i) => kBestSellerIds.contains(i.id)).toList();