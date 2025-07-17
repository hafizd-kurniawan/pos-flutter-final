import 'package:dartz/dartz.dart';
import 'package:flutter_pos_responsive_app/data/models/response/service_job_response_model.dart';

class ServiceJobRemoteDatasource {
  // Dummy data for service jobs
  static final List<ServiceJob> _dummyServiceJobs = [
    ServiceJob(
      serviceJobId: 1,
      serviceCode: "SJ001",
      queueNumber: 1,
      customerId: 1,
      vehicleId: 1,
      technicianId: 2,
      receivedByUserId: 1,
      outletId: 1,
      problemDescription: "Motor tidak mau hidup, starter lemah",
      technicianNotes: "Perlu ganti aki dan busi",
      status: "Dalam Proses",
      serviceInDate: DateTime.now().subtract(const Duration(hours: 2)),
      downPayment: 100000.0,
      grandTotal: 285000.0,
      technicianCommission: 50000.0,
      shopProfit: 135000.0,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      updatedAt: DateTime.now().subtract(const Duration(minutes: 30)),
      createdBy: 1,
      customer: ServiceJobCustomer(
        customerId: 1,
        name: "Budi Santoso",
        phoneNumber: "08123456789",
        address: "Jl. Merdeka No. 123, Jakarta",
      ),
      vehicle: ServiceJobVehicle(
        vehicleId: 1,
        plateNumber: "B 1234 ABC",
        brand: "Honda",
        model: "Vario 125",
        type: "Matic",
        productionYear: 2020,
        color: "Merah",
      ),
      technician: ServiceJobTechnician(
        userId: 2,
        name: "Joko Susilo",
        email: "joko@bengkel.com",
      ),
      outlet: ServiceJobOutlet(
        outletId: 1,
        outletName: "Bengkel Pusat Jakarta",
        city: "Jakarta",
      ),
      serviceDetails: [
        ServiceDetail(
          detailId: 1,
          serviceJobId: 1,
          itemId: 7,
          itemType: "App\\Models\\Service",
          description: "Ganti Aki",
          quantity: 1,
          pricePerItem: 85000.0,
          costPerItem: 0.0,
        ),
        ServiceDetail(
          detailId: 2,
          serviceJobId: 1,
          itemId: 15,
          itemType: "App\\Models\\Product",
          description: "Aki Motor 12V",
          quantity: 1,
          pricePerItem: 200000.0,
          costPerItem: 150000.0,
        ),
      ],
    ),
    ServiceJob(
      serviceJobId: 2,
      serviceCode: "SJ002",
      queueNumber: 2,
      customerId: 2,
      vehicleId: 3,
      technicianId: 3,
      receivedByUserId: 1,
      outletId: 1,
      problemDescription: "Suara mesin kasar, perlu tune up",
      technicianNotes: "Tune up lengkap dengan ganti oli",
      status: "Selesai",
      serviceInDate: DateTime.now().subtract(const Duration(days: 1)),
      pickedUpDate: DateTime.now().subtract(const Duration(hours: 4)),
      downPayment: 50000.0,
      grandTotal: 225000.0,
      technicianCommission: 45000.0,
      shopProfit: 130000.0,
      warrantyExpiresAt: DateTime.now().add(const Duration(days: 30)),
      nextServiceReminderDate: DateTime.now().add(const Duration(days: 90)),
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 4)),
      createdBy: 1,
      customer: ServiceJobCustomer(
        customerId: 2,
        name: "Siti Nurhaliza",
        phoneNumber: "08987654321",
        address: "Jl. Sudirman No. 456, Bandung",
      ),
      vehicle: ServiceJobVehicle(
        vehicleId: 3,
        plateNumber: "D 9876 GHI",
        brand: "Honda",
        model: "Beat",
        type: "Matic",
        productionYear: 2019,
        color: "Putih",
      ),
      technician: ServiceJobTechnician(
        userId: 3,
        name: "Andi Pratama",
        email: "andi@bengkel.com",
      ),
      outlet: ServiceJobOutlet(
        outletId: 1,
        outletName: "Bengkel Pusat Jakarta",
        city: "Jakarta",
      ),
      serviceDetails: [
        ServiceDetail(
          detailId: 3,
          serviceJobId: 2,
          itemId: 2,
          itemType: "App\\Models\\Service",
          description: "Tune Up Mesin",
          quantity: 1,
          pricePerItem: 150000.0,
          costPerItem: 0.0,
        ),
        ServiceDetail(
          detailId: 4,
          serviceJobId: 2,
          itemId: 8,
          itemType: "App\\Models\\Product",
          description: "Oli Mesin 10W-40",
          quantity: 1,
          pricePerItem: 75000.0,
          costPerItem: 50000.0,
        ),
      ],
    ),
    ServiceJob(
      serviceJobId: 3,
      serviceCode: "SJ003",
      queueNumber: 3,
      customerId: 3,
      vehicleId: 4,
      technicianId: 2,
      receivedByUserId: 1,
      outletId: 1,
      problemDescription: "Rem tidak pakem, perlu ganti kampas rem",
      technicianNotes: "Ganti kampas rem depan dan belakang",
      status: "Menunggu Sparepart",
      serviceInDate: DateTime.now().subtract(const Duration(hours: 6)),
      downPayment: 75000.0,
      grandTotal: 325000.0,
      technicianCommission: 60000.0,
      shopProfit: 190000.0,
      createdAt: DateTime.now().subtract(const Duration(hours: 7)),
      updatedAt: DateTime.now().subtract(const Duration(minutes: 15)),
      createdBy: 1,
      customer: ServiceJobCustomer(
        customerId: 3,
        name: "Agus Wibowo",
        phoneNumber: "08156789012",
        address: "Jl. Gatot Subroto No. 789, Surabaya",
      ),
      vehicle: ServiceJobVehicle(
        vehicleId: 4,
        plateNumber: "L 1357 JKL",
        brand: "Suzuki",
        model: "Satria FU",
        type: "Sport",
        productionYear: 2018,
        color: "Biru",
      ),
      technician: ServiceJobTechnician(
        userId: 2,
        name: "Joko Susilo",
        email: "joko@bengkel.com",
      ),
      outlet: ServiceJobOutlet(
        outletId: 1,
        outletName: "Bengkel Pusat Jakarta",
        city: "Jakarta",
      ),
      serviceDetails: [
        ServiceDetail(
          detailId: 5,
          serviceJobId: 3,
          itemId: 3,
          itemType: "App\\Models\\Service",
          description: "Ganti Kampas Rem",
          quantity: 1,
          pricePerItem: 125000.0,
          costPerItem: 0.0,
        ),
        ServiceDetail(
          detailId: 6,
          serviceJobId: 3,
          itemId: 22,
          itemType: "App\\Models\\Product",
          description: "Kampas Rem Depan",
          quantity: 1,
          pricePerItem: 100000.0,
          costPerItem: 75000.0,
        ),
        ServiceDetail(
          detailId: 7,
          serviceJobId: 3,
          itemId: 23,
          itemType: "App\\Models\\Product",
          description: "Kampas Rem Belakang",
          quantity: 1,
          pricePerItem: 100000.0,
          costPerItem: 75000.0,
        ),
      ],
    ),
  ];

  Future<Either<String, ServiceJobResponseModel>> getServiceJobs() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      return Right(
        ServiceJobResponseModel(
          message: "Service jobs retrieved successfully",
          data: _dummyServiceJobs,
        ),
      );
    } catch (e) {
      return Left("Error fetching service jobs: $e");
    }
  }

  Future<Either<String, ServiceJobResponseModel>> getServiceJobById(
    int serviceJobId,
  ) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      final serviceJob = _dummyServiceJobs.firstWhere(
        (job) => job.serviceJobId == serviceJobId,
        orElse: () => ServiceJob(),
      );

      if (serviceJob.serviceJobId == null) {
        return Left("Service job not found");
      }

      return Right(
        ServiceJobResponseModel(
          message: "Service job retrieved successfully",
          data: [serviceJob],
        ),
      );
    } catch (e) {
      return Left("Error fetching service job: $e");
    }
  }

  Future<Either<String, ServiceJobResponseModel>> getServiceJobsByStatus(
    String status,
  ) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));

      final filteredJobs = _dummyServiceJobs
          .where((job) => job.status?.toLowerCase() == status.toLowerCase())
          .toList();

      return Right(
        ServiceJobResponseModel(
          message: "Service jobs retrieved successfully",
          data: filteredJobs,
        ),
      );
    } catch (e) {
      return Left("Error fetching service jobs by status: $e");
    }
  }

  Future<Either<String, ServiceJobResponseModel>> getServiceJobsByCustomer(
    int customerId,
  ) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));

      final filteredJobs = _dummyServiceJobs
          .where((job) => job.customerId == customerId)
          .toList();

      return Right(
        ServiceJobResponseModel(
          message: "Service jobs retrieved successfully",
          data: filteredJobs,
        ),
      );
    } catch (e) {
      return Left("Error fetching service jobs by customer: $e");
    }
  }

  Future<Either<String, ServiceJobResponseModel>> createServiceJob(
    Map<String, dynamic> data,
  ) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      final newServiceJob = ServiceJob(
        serviceJobId: _dummyServiceJobs.length + 1,
        serviceCode: data['service_code'] ?? 'SJ${_dummyServiceJobs.length}',
        queueNumber: _dummyServiceJobs.length + 1,
        customerId: data['customer_id'],
        vehicleId: data['vehicle_id'],
        technicianId: data['technician_id'],
        receivedByUserId: data['received_by_user_id'] ?? 1,
        outletId: data['outlet_id'] ?? 1,
        problemDescription: data['problem_description'],
        technicianNotes: data['technician_notes'],
        status: data['status'] ?? 'Menunggu',
        serviceInDate: data['service_in_date'] != null
            ? DateTime.parse(data['service_in_date'])
            : DateTime.now(),
        downPayment: data['down_payment']?.toDouble() ?? 0.0,
        grandTotal: data['grand_total']?.toDouble() ?? 0.0,
        technicianCommission: data['technician_commission']?.toDouble() ?? 0.0,
        shopProfit: data['shop_profit']?.toDouble() ?? 0.0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        createdBy: 1,
        serviceDetails: [],
      );

      _dummyServiceJobs.add(newServiceJob);

      return Right(
        ServiceJobResponseModel(
          message: "Service job created successfully",
          data: [newServiceJob],
        ),
      );
    } catch (e) {
      return Left("Error creating service job: $e");
    }
  }

  Future<Either<String, ServiceJobResponseModel>> updateServiceJob(
    int serviceJobId,
    Map<String, dynamic> data,
  ) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      final index = _dummyServiceJobs.indexWhere(
        (job) => job.serviceJobId == serviceJobId,
      );

      if (index == -1) {
        return Left("Service job not found");
      }

      final existingJob = _dummyServiceJobs[index];
      final updatedJob = ServiceJob(
        serviceJobId: serviceJobId,
        serviceCode: existingJob.serviceCode,
        queueNumber: existingJob.queueNumber,
        customerId: existingJob.customerId,
        vehicleId: existingJob.vehicleId,
        technicianId: data['technician_id'] ?? existingJob.technicianId,
        receivedByUserId: existingJob.receivedByUserId,
        outletId: existingJob.outletId,
        problemDescription:
            data['problem_description'] ?? existingJob.problemDescription,
        technicianNotes:
            data['technician_notes'] ?? existingJob.technicianNotes,
        status: data['status'] ?? existingJob.status,
        serviceInDate: existingJob.serviceInDate,
        pickedUpDate: data['picked_up_date'] != null
            ? DateTime.parse(data['picked_up_date'])
            : existingJob.pickedUpDate,
        complainDate: data['complain_date'] != null
            ? DateTime.parse(data['complain_date'])
            : existingJob.complainDate,
        warrantyExpiresAt: data['warranty_expires_at'] != null
            ? DateTime.parse(data['warranty_expires_at'])
            : existingJob.warrantyExpiresAt,
        nextServiceReminderDate: data['next_service_reminder_date'] != null
            ? DateTime.parse(data['next_service_reminder_date'])
            : existingJob.nextServiceReminderDate,
        downPayment:
            data['down_payment']?.toDouble() ?? existingJob.downPayment,
        grandTotal: data['grand_total']?.toDouble() ?? existingJob.grandTotal,
        technicianCommission:
            data['technician_commission']?.toDouble() ??
            existingJob.technicianCommission,
        shopProfit: data['shop_profit']?.toDouble() ?? existingJob.shopProfit,
        createdAt: existingJob.createdAt,
        updatedAt: DateTime.now(),
        createdBy: existingJob.createdBy,
        customer: existingJob.customer,
        vehicle: existingJob.vehicle,
        technician: existingJob.technician,
        outlet: existingJob.outlet,
        serviceDetails: existingJob.serviceDetails,
      );

      _dummyServiceJobs[index] = updatedJob;

      return Right(
        ServiceJobResponseModel(
          message: "Service job updated successfully",
          data: [updatedJob],
        ),
      );
    } catch (e) {
      return Left("Error updating service job: $e");
    }
  }

  Future<Either<String, ServiceJobResponseModel>> deleteServiceJob(
    int serviceJobId,
  ) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      final index = _dummyServiceJobs.indexWhere(
        (job) => job.serviceJobId == serviceJobId,
      );

      if (index == -1) {
        return Left("Service job not found");
      }

      final existingJob = _dummyServiceJobs[index];
      final deletedJob = ServiceJob(
        serviceJobId: serviceJobId,
        serviceCode: existingJob.serviceCode,
        queueNumber: existingJob.queueNumber,
        customerId: existingJob.customerId,
        vehicleId: existingJob.vehicleId,
        technicianId: existingJob.technicianId,
        receivedByUserId: existingJob.receivedByUserId,
        outletId: existingJob.outletId,
        problemDescription: existingJob.problemDescription,
        technicianNotes: existingJob.technicianNotes,
        status: existingJob.status,
        serviceInDate: existingJob.serviceInDate,
        pickedUpDate: existingJob.pickedUpDate,
        complainDate: existingJob.complainDate,
        warrantyExpiresAt: existingJob.warrantyExpiresAt,
        nextServiceReminderDate: existingJob.nextServiceReminderDate,
        downPayment: existingJob.downPayment,
        grandTotal: existingJob.grandTotal,
        technicianCommission: existingJob.technicianCommission,
        shopProfit: existingJob.shopProfit,
        createdAt: existingJob.createdAt,
        updatedAt: DateTime.now(),
        deletedAt: DateTime.now(),
        createdBy: existingJob.createdBy,
        customer: existingJob.customer,
        vehicle: existingJob.vehicle,
        technician: existingJob.technician,
        outlet: existingJob.outlet,
        serviceDetails: existingJob.serviceDetails,
      );

      _dummyServiceJobs[index] = deletedJob;

      return Right(
        ServiceJobResponseModel(
          message: "Service job deleted successfully",
          data: [deletedJob],
        ),
      );
    } catch (e) {
      return Left("Error deleting service job: $e");
    }
  }
}

