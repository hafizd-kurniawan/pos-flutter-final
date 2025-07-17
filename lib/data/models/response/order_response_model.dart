import 'dart:convert';

import 'package:flutter_pos_responsive_app/data/models/response/product_response_model.dart';

class OrderResponseModel {
  final String? message;
  final Order? data;

  OrderResponseModel({this.message, this.data});

  factory OrderResponseModel.fromJson(String str) =>
      OrderResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderResponseModel.fromMap(Map<String, dynamic> json) =>
      OrderResponseModel(
        message: json["message"],
        data: json["data"] == null ? null : Order.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {"message": message, "data": data?.toMap()};
}

class Order {
  final String? transactionNumber;
  final int? cashierId;
  final int? totalPrice;
  final int? totalItem;
  final String? paymentMethod;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final List<OrderItemModel>? orderItems;

  Order({
    this.transactionNumber,
    this.cashierId,
    this.totalPrice,
    this.totalItem,
    this.paymentMethod,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.orderItems,
  });

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    transactionNumber: json["transaction_number"],
    cashierId: json["cashier_id"],
    totalPrice: json["total_price"],
    totalItem: json["total_item"],
    paymentMethod: json["payment_method"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    id: json["id"],
    orderItems: json["order_items"] == null
        ? []
        : List<OrderItemModel>.from(
            json["order_items"]!.map((x) => OrderItemModel.fromMap(x)),
          ),
  );

  Map<String, dynamic> toMap() => {
    "transaction_number": transactionNumber,
    "cashier_id": cashierId,
    "total_price": totalPrice,
    "total_item": totalItem,
    "payment_method": paymentMethod,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "order_items": orderItems == null
        ? []
        : List<dynamic>.from(orderItems!.map((x) => x.toMap())),
  };
}

class OrderItemModel {
  final int? id;
  final int? orderId;
  final int? productId;
  final int? quantity;
  final String? totalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;

  OrderItemModel({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory OrderItemModel.fromJson(String str) =>
      OrderItemModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderItemModel.fromMap(Map<String, dynamic> json) => OrderItemModel(
    id: json["id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    totalPrice: json["total_price"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    product: json["product"] == null ? null : Product.fromMap(json["product"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "quantity": quantity,
    "total_price": totalPrice,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "product": product?.toMap(),
  };
}
