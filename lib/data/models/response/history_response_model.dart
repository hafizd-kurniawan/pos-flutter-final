import 'dart:convert';

import 'package:flutter_pos_responsive_app/data/models/response/order_response_model.dart';

class HistoryResponseModel {
  final List<History>? data;

  HistoryResponseModel({this.data});

  factory HistoryResponseModel.fromJson(String str) =>
      HistoryResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryResponseModel.fromMap(Map<String, dynamic> json) =>
      HistoryResponseModel(
        data: json["data"] == null
            ? []
            : List<History>.from(json["data"]!.map((x) => History.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class History {
  final int? id;
  final String? transactionNumber;
  final String? totalPrice;
  final int? totalItem;
  final int? cashierId;
  final PaymentMethod? paymentMethod;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<OrderItemModel>? orderItems;

  History({
    this.id,
    this.transactionNumber,
    this.totalPrice,
    this.totalItem,
    this.cashierId,
    this.paymentMethod,
    this.createdAt,
    this.updatedAt,
    this.orderItems,
  });

  factory History.fromJson(String str) => History.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory History.fromMap(Map<String, dynamic> json) => History(
    id: json["id"],
    transactionNumber: json["transaction_number"],
    totalPrice: json["total_price"],
    totalItem: json["total_item"],
    cashierId: json["cashier_id"],
    paymentMethod:
        paymentMethodValues.map[json["payment_method"]] ?? PaymentMethod.CASH,
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    orderItems: json["order_items"] == null
        ? []
        : List<OrderItemModel>.from(
            json["order_items"]!.map((x) => OrderItemModel.fromMap(x)),
          ),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "transaction_number": transactionNumber,
    "total_price": totalPrice,
    "total_item": totalItem,
    "cashier_id": cashierId,
    "payment_method": paymentMethodValues.reverse[paymentMethod],
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "order_items": orderItems == null
        ? []
        : List<dynamic>.from(orderItems!.map((x) => x.toMap())),
  };
}

enum Description { DESCRIPTION_ENAK, ENAK, ES }

final descriptionValues = EnumValues({
  "enak": Description.DESCRIPTION_ENAK,
  "Enak": Description.ENAK,
  "es": Description.ES,
});

enum Image {
  THE_01_JXFQC5_E6_STCDTSTPCJAJWZ8_A_JPEG,
  THE_01_JXFQR0_AGEY89_DC79_XSDZCP12_JPG,
  THE_01_JY4_CD5_QWA295_VWAAZQ4_KWR07_PNG,
}

final imageValues = EnumValues({
  "01JXFQC5E6STCDTSTPCJAJWZ8A.jpeg":
      Image.THE_01_JXFQC5_E6_STCDTSTPCJAJWZ8_A_JPEG,
  "01JXFQR0AGEY89DC79XSDZCP12.jpg":
      Image.THE_01_JXFQR0_AGEY89_DC79_XSDZCP12_JPG,
  "01JY4CD5QWA295VWAAZQ4KWR07.png":
      Image.THE_01_JY4_CD5_QWA295_VWAAZQ4_KWR07_PNG,
});

enum Name { JUS_JAMBU, MIE_AYAM, PISANG_GORENG }

final nameValues = EnumValues({
  "Jus Jambu": Name.JUS_JAMBU,
  "Mie Ayam": Name.MIE_AYAM,
  "Pisang Goreng": Name.PISANG_GORENG,
});

enum PaymentMethod { CASH, QR, TRANSFER }

final paymentMethodValues = EnumValues({
  "cash": PaymentMethod.CASH,
  "QR": PaymentMethod.QR,
  "TRANSFER": PaymentMethod.TRANSFER,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
