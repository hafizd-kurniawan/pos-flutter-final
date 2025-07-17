import 'dart:convert';

class ServiceJobResponseModel {
  final String? message;
  final List<ServiceJob>? data;

  ServiceJobResponseModel({this.message, this.data});

  factory ServiceJobResponseModel.fromJson(String str) =>
      ServiceJobResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceJobResponseModel.fromMap(Map<String, dynamic> json) =>
      ServiceJobResponseModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ServiceJob>.from(json["data"]!.map((x) => ServiceJob.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class ServiceJob {
  final int? serviceJobId;
  final String? serviceCode;
  final int? queueNumber;
  final int? customerId;
  final int? vehicleId;
  final int? technicianId;
  final int? receivedByUserId;
  final int? outletId;
  final String? problemDescription;
  final String? technicianNotes;
  final String? status;
  final DateTime? serviceInDate;
  final DateTime? pickedUpDate;
  final DateTime? complainDate;
  final DateTime? warrantyExpiresAt;
  final DateTime? nextServiceReminderDate;
  final double? downPayment;
  final double? grandTotal;
  final double? technicianCommission;
  final double? shopProfit;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final int? createdBy;
  final ServiceJobCustomer? customer;
  final ServiceJobVehicle? vehicle;
  final ServiceJobTechnician? technician;
  final ServiceJobOutlet? outlet;
  final List<ServiceDetail>? serviceDetails;

  ServiceJob({
    this.serviceJobId,
    this.serviceCode,
    this.queueNumber,
    this.customerId,
    this.vehicleId,
    this.technicianId,
    this.receivedByUserId,
    this.outletId,
    this.problemDescription,
    this.technicianNotes,
    this.status,
    this.serviceInDate,
    this.pickedUpDate,
    this.complainDate,
    this.warrantyExpiresAt,
    this.nextServiceReminderDate,
    this.downPayment,
    this.grandTotal,
    this.technicianCommission,
    this.shopProfit,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.customer,
    this.vehicle,
    this.technician,
    this.outlet,
    this.serviceDetails,
  });

  factory ServiceJob.fromJson(String str) => ServiceJob.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceJob.fromMap(Map<String, dynamic> json) => ServiceJob(
        serviceJobId: json["service_job_id"],
        serviceCode: json["service_code"],
        queueNumber: json["queue_number"],
        customerId: json["customer_id"],
        vehicleId: json["vehicle_id"],
        technicianId: json["technician_id"],
        receivedByUserId: json["received_by_user_id"],
        outletId: json["outlet_id"],
        problemDescription: json["problem_description"],
        technicianNotes: json["technician_notes"],
        status: json["status"],
        serviceInDate: json["service_in_date"] == null
            ? null
            : DateTime.parse(json["service_in_date"]),
        pickedUpDate: json["picked_up_date"] == null
            ? null
            : DateTime.parse(json["picked_up_date"]),
        complainDate: json["complain_date"] == null
            ? null
            : DateTime.parse(json["complain_date"]),
        warrantyExpiresAt: json["warranty_expires_at"] == null
            ? null
            : DateTime.parse(json["warranty_expires_at"]),
        nextServiceReminderDate: json["next_service_reminder_date"] == null
            ? null
            : DateTime.parse(json["next_service_reminder_date"]),
        downPayment: json["down_payment"]?.toDouble(),
        grandTotal: json["grand_total"]?.toDouble(),
        technicianCommission: json["technician_commission"]?.toDouble(),
        shopProfit: json["shop_profit"]?.toDouble(),
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
        customer: json["customer"] == null
            ? null
            : ServiceJobCustomer.fromMap(json["customer"]),
        vehicle: json["vehicle"] == null
            ? null
            : ServiceJobVehicle.fromMap(json["vehicle"]),
        technician: json["technician"] == null
            ? null
            : ServiceJobTechnician.fromMap(json["technician"]),
        outlet: json["outlet"] == null
            ? null
            : ServiceJobOutlet.fromMap(json["outlet"]),
        serviceDetails: json["service_details"] == null
            ? []
            : List<ServiceDetail>.from(
                json["service_details"]!.map((x) => ServiceDetail.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "service_job_id": serviceJobId,
        "service_code": serviceCode,
        "queue_number": queueNumber,
        "customer_id": customerId,
        "vehicle_id": vehicleId,
        "technician_id": technicianId,
        "received_by_user_id": receivedByUserId,
        "outlet_id": outletId,
        "problem_description": problemDescription,
        "technician_notes": technicianNotes,
        "status": status,
        "service_in_date": serviceInDate?.toIso8601String(),
        "picked_up_date": pickedUpDate?.toIso8601String(),
        "complain_date": complainDate?.toIso8601String(),
        "warranty_expires_at": warrantyExpiresAt?.toIso8601String(),
        "next_service_reminder_date": nextServiceReminderDate?.toIso8601String(),
        "down_payment": downPayment,
        "grand_total": grandTotal,
        "technician_commission": technicianCommission,
        "shop_profit": shopProfit,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt?.toIso8601String(),
        "created_by": createdBy,
        "customer": customer?.toMap(),
        "vehicle": vehicle?.toMap(),
        "technician": technician?.toMap(),
        "outlet": outlet?.toMap(),
        "service_details": serviceDetails == null
            ? []
            : List<dynamic>.from(serviceDetails!.map((x) => x.toMap())),
      };
}

class ServiceJobCustomer {
  final int? customerId;
  final String? name;
  final String? phoneNumber;
  final String? address;

  ServiceJobCustomer({
    this.customerId,
    this.name,
    this.phoneNumber,
    this.address,
  });

  factory ServiceJobCustomer.fromJson(String str) =>
      ServiceJobCustomer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceJobCustomer.fromMap(Map<String, dynamic> json) =>
      ServiceJobCustomer(
        customerId: json["customer_id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        address: json["address"],
      );

  Map<String, dynamic> toMap() => {
        "customer_id": customerId,
        "name": name,
        "phone_number": phoneNumber,
        "address": address,
      };
}

class ServiceJobVehicle {
  final int? vehicleId;
  final String? plateNumber;
  final String? brand;
  final String? model;
  final String? type;
  final int? productionYear;
  final String? color;

  ServiceJobVehicle({
    this.vehicleId,
    this.plateNumber,
    this.brand,
    this.model,
    this.type,
    this.productionYear,
    this.color,
  });

  factory ServiceJobVehicle.fromJson(String str) =>
      ServiceJobVehicle.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceJobVehicle.fromMap(Map<String, dynamic> json) =>
      ServiceJobVehicle(
        vehicleId: json["vehicle_id"],
        plateNumber: json["plate_number"],
        brand: json["brand"],
        model: json["model"],
        type: json["type"],
        productionYear: json["production_year"],
        color: json["color"],
      );

  Map<String, dynamic> toMap() => {
        "vehicle_id": vehicleId,
        "plate_number": plateNumber,
        "brand": brand,
        "model": model,
        "type": type,
        "production_year": productionYear,
        "color": color,
      };
}

class ServiceJobTechnician {
  final int? userId;
  final String? name;
  final String? email;

  ServiceJobTechnician({
    this.userId,
    this.name,
    this.email,
  });

  factory ServiceJobTechnician.fromJson(String str) =>
      ServiceJobTechnician.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceJobTechnician.fromMap(Map<String, dynamic> json) =>
      ServiceJobTechnician(
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "name": name,
        "email": email,
      };
}

class ServiceJobOutlet {
  final int? outletId;
  final String? outletName;
  final String? city;

  ServiceJobOutlet({
    this.outletId,
    this.outletName,
    this.city,
  });

  factory ServiceJobOutlet.fromJson(String str) =>
      ServiceJobOutlet.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceJobOutlet.fromMap(Map<String, dynamic> json) =>
      ServiceJobOutlet(
        outletId: json["outlet_id"],
        outletName: json["outlet_name"],
        city: json["city"],
      );

  Map<String, dynamic> toMap() => {
        "outlet_id": outletId,
        "outlet_name": outletName,
        "city": city,
      };
}

class ServiceDetail {
  final int? detailId;
  final int? serviceJobId;
  final int? itemId;
  final String? itemType;
  final String? description;
  final String? serialNumberUsed;
  final int? quantity;
  final double? pricePerItem;
  final double? costPerItem;

  ServiceDetail({
    this.detailId,
    this.serviceJobId,
    this.itemId,
    this.itemType,
    this.description,
    this.serialNumberUsed,
    this.quantity,
    this.pricePerItem,
    this.costPerItem,
  });

  factory ServiceDetail.fromJson(String str) =>
      ServiceDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceDetail.fromMap(Map<String, dynamic> json) => ServiceDetail(
        detailId: json["detail_id"],
        serviceJobId: json["service_job_id"],
        itemId: json["item_id"],
        itemType: json["item_type"],
        description: json["description"],
        serialNumberUsed: json["serial_number_used"],
        quantity: json["quantity"],
        pricePerItem: json["price_per_item"]?.toDouble(),
        costPerItem: json["cost_per_item"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "detail_id": detailId,
        "service_job_id": serviceJobId,
        "item_id": itemId,
        "item_type": itemType,
        "description": description,
        "serial_number_used": serialNumberUsed,
        "quantity": quantity,
        "price_per_item": pricePerItem,
        "cost_per_item": costPerItem,
      };
}