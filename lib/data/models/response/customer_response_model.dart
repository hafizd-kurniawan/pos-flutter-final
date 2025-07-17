import 'dart:convert';

class CustomerResponseModel {
  final String? message;
  final List<Customer>? data;

  CustomerResponseModel({this.message, this.data});

  factory CustomerResponseModel.fromJson(String str) =>
      CustomerResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerResponseModel.fromMap(Map<String, dynamic> json) =>
      CustomerResponseModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Customer>.from(json["data"]!.map((x) => Customer.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Customer {
  final int? customerId;
  final String? name;
  final String? phoneNumber;
  final String? address;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final int? createdBy;
  final List<CustomerVehicle>? vehicles;

  Customer({
    this.customerId,
    this.name,
    this.phoneNumber,
    this.address,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.vehicles,
  });

  factory Customer.fromJson(String str) => Customer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
        customerId: json["customer_id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
        createdBy: json["created_by"],
        vehicles: json["vehicles"] == null
            ? []
            : List<CustomerVehicle>.from(
                json["vehicles"]!.map((x) => CustomerVehicle.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "customer_id": customerId,
        "name": name,
        "phone_number": phoneNumber,
        "address": address,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt?.toIso8601String(),
        "created_by": createdBy,
        "vehicles": vehicles == null
            ? []
            : List<dynamic>.from(vehicles!.map((x) => x.toMap())),
      };
}

class CustomerVehicle {
  final int? vehicleId;
  final int? customerId;
  final String? plateNumber;
  final String? brand;
  final String? model;
  final String? type;
  final int? productionYear;
  final String? chassisNumber;
  final String? engineNumber;
  final String? color;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final int? createdBy;

  CustomerVehicle({
    this.vehicleId,
    this.customerId,
    this.plateNumber,
    this.brand,
    this.model,
    this.type,
    this.productionYear,
    this.chassisNumber,
    this.engineNumber,
    this.color,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
  });

  factory CustomerVehicle.fromJson(String str) =>
      CustomerVehicle.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerVehicle.fromMap(Map<String, dynamic> json) => CustomerVehicle(
        vehicleId: json["vehicle_id"],
        customerId: json["customer_id"],
        plateNumber: json["plate_number"],
        brand: json["brand"],
        model: json["model"],
        type: json["type"],
        productionYear: json["production_year"],
        chassisNumber: json["chassis_number"],
        engineNumber: json["engine_number"],
        color: json["color"],
        notes: json["notes"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toMap() => {
        "vehicle_id": vehicleId,
        "customer_id": customerId,
        "plate_number": plateNumber,
        "brand": brand,
        "model": model,
        "type": type,
        "production_year": productionYear,
        "chassis_number": chassisNumber,
        "engine_number": engineNumber,
        "color": color,
        "notes": notes,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt?.toIso8601String(),
        "created_by": createdBy,
      };
}