import 'dart:convert';

class ServiceResponseModel {
  final String? message;
  final List<Service>? data;

  ServiceResponseModel({this.message, this.data});

  factory ServiceResponseModel.fromJson(String str) =>
      ServiceResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceResponseModel.fromMap(Map<String, dynamic> json) =>
      ServiceResponseModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Service>.from(json["data"]!.map((x) => Service.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Service {
  final int? serviceId;
  final String? serviceCode;
  final String? name;
  final int? serviceCategoryId;
  final double? fee;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final int? createdBy;
  final ServiceCategory? serviceCategory;

  Service({
    this.serviceId,
    this.serviceCode,
    this.name,
    this.serviceCategoryId,
    this.fee,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.serviceCategory,
  });

  factory Service.fromJson(String str) => Service.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Service.fromMap(Map<String, dynamic> json) => Service(
        serviceId: json["service_id"],
        serviceCode: json["service_code"],
        name: json["name"],
        serviceCategoryId: json["service_category_id"],
        fee: json["fee"]?.toDouble(),
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
        serviceCategory: json["service_category"] == null
            ? null
            : ServiceCategory.fromMap(json["service_category"]),
      );

  Map<String, dynamic> toMap() => {
        "service_id": serviceId,
        "service_code": serviceCode,
        "name": name,
        "service_category_id": serviceCategoryId,
        "fee": fee,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt?.toIso8601String(),
        "created_by": createdBy,
        "service_category": serviceCategory?.toMap(),
      };
}

class ServiceCategory {
  final int? serviceCategoryId;
  final String? name;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final int? createdBy;

  ServiceCategory({
    this.serviceCategoryId,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
  });

  factory ServiceCategory.fromJson(String str) =>
      ServiceCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceCategory.fromMap(Map<String, dynamic> json) =>
      ServiceCategory(
        serviceCategoryId: json["service_category_id"],
        name: json["name"],
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
      );

  Map<String, dynamic> toMap() => {
        "service_category_id": serviceCategoryId,
        "name": name,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt?.toIso8601String(),
        "created_by": createdBy,
      };
}