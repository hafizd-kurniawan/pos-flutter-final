import 'package:flutter_pos_responsive_app/core/extensions/int_ext.dart';

class HistoryTransactionModel {
  final String name;
  final String category;
  final int price;

  HistoryTransactionModel({
    required this.name,
    required this.category,
    required this.price,
  });

  String get priceFormat => price.currencyFormatRp;
}
