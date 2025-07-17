import 'dart:convert';

class OutletResponseModel {
  final String? message;
  final List<Outlet>? data;

  OutletResponseModel({this.message, this.data});

  factory OutletResponseModel.fromJson(String str) =>
      OutletResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OutletResponseModel.fromMap(Map<String, dynamic> json) =>
      OutletResponseModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Outlet>.from(json["data"]!.map((x) => Outlet.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Outlet {
  final int? outletId;
  final String? outletName;
  final String? branchType;
  final String? city;
  final String? address;
  final String? phoneNumber;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final int? createdBy;

  Outlet({
    this.outletId,
    this.outletName,
    this.branchType,
    this.city,
    this.address,
    this.phoneNumber,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
  });

  factory Outlet.fromJson(String str) => Outlet.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Outlet.fromMap(Map<String, dynamic> json) => Outlet(
        outletId: json["outlet_id"],
        outletName: json["outlet_name"],
        branchType: json["branch_type"],
        city: json["city"],
        address: json["address"],
        phoneNumber: json["phone_number"],
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
        "outlet_id": outletId,
        "outlet_name": outletName,
        "branch_type": branchType,
        "city": city,
        "address": address,
        "phone_number": phoneNumber,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt?.toIso8601String(),
        "created_by": createdBy,
      };
}