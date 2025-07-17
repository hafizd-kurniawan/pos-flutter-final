import 'package:dartz/dartz.dart';
import 'package:flutter_pos_responsive_app/data/models/response/service_response_model.dart';

class ServiceRemoteDatasource {
  // Dummy data for service categories
  static final List<ServiceCategory> _dummyServiceCategories = [
    ServiceCategory(
      serviceCategoryId: 1,
      name: "Maintenance Rutin",
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      createdBy: 1,
    ),
    ServiceCategory(
      serviceCategoryId: 2,
      name: "Perbaikan Mesin",
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
      createdBy: 1,
    ),
    ServiceCategory(
      serviceCategoryId: 3,
      name: "Perbaikan Kelistrikan",
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      createdBy: 1,
    ),
    ServiceCategory(
      serviceCategoryId: 4,
      name: "Perbaikan Body",
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      createdBy: 1,
    ),
  ];

  // Dummy data for services
  static final List<Service> _dummyServices = [
    Service(
      serviceId: 1,
      serviceCode: "SRV001",
      name: "Ganti Oli Mesin",
      serviceCategoryId: 1,
      fee: 75000.0,
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      createdBy: 1,
      serviceCategory: _dummyServiceCategories[0],
    ),
    Service(
      serviceId: 2,
      serviceCode: "SRV002",
      name: "Tune Up Mesin",
      serviceCategoryId: 1,
      fee: 150000.0,
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 28)),
      updatedAt: DateTime.now().subtract(const Duration(days: 4)),
      createdBy: 1,
      serviceCategory: _dummyServiceCategories[0],
    ),
    Service(
      serviceId: 3,
      serviceCode: "SRV003",
      name: "Ganti Kampas Rem",
      serviceCategoryId: 1,
      fee: 125000.0,
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
      createdBy: 1,
      serviceCategory: _dummyServiceCategories[0],
    ),
    Service(
      serviceId: 4,
      serviceCode: "SRV004",
      name: "Overhaul Mesin",
      serviceCategoryId: 2,
      fee: 800000.0,
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 23)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      createdBy: 1,
      serviceCategory: _dummyServiceCategories[1],
    ),
    Service(
      serviceId: 5,
      serviceCode: "SRV005",
      name: "Ganti Piston",
      serviceCategoryId: 2,
      fee: 350000.0,
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      createdBy: 1,
      serviceCategory: _dummyServiceCategories[1],
    ),
    Service(
      serviceId: 6,
      serviceCode: "SRV006",
      name: "Perbaikan Starter",
      serviceCategoryId: 3,
      fee: 200000.0,
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 18)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      createdBy: 1,
      serviceCategory: _dummyServiceCategories[2],
    ),
    Service(
      serviceId: 7,
      serviceCode: "SRV007",
      name: "Ganti Aki",
      serviceCategoryId: 3,
      fee: 85000.0,
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      createdBy: 1,
      serviceCategory: _dummyServiceCategories[2],
    ),
    Service(
      serviceId: 8,
      serviceCode: "SRV008",
      name: "Cat Ulang Motor",
      serviceCategoryId: 4,
      fee: 450000.0,
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      createdBy: 1,
      serviceCategory: _dummyServiceCategories[3],
    ),
    Service(
      serviceId: 9,
      serviceCode: "SRV009",
      name: "Perbaikan Denting",
      serviceCategoryId: 4,
      fee: 125000.0,
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      createdBy: 1,
      serviceCategory: _dummyServiceCategories[3],
    ),
  ];

  Future<Either<String, ServiceResponseModel>> getServices() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      return Right(ServiceResponseModel(
        message: "Services retrieved successfully",
        data: _dummyServices,
      ));
    } catch (e) {
      return Left("Error fetching services: $e");
    }
  }

  Future<Either<String, ServiceResponseModel>> getServiceById(int serviceId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final service = _dummyServices.firstWhere(
        (service) => service.serviceId == serviceId,
        orElse: () => Service(),
      );
      
      if (service.serviceId == null) {
        return Left("Service not found");
      }
      
      return Right(ServiceResponseModel(
        message: "Service retrieved successfully",
        data: [service],
      ));
    } catch (e) {
      return Left("Error fetching service: $e");
    }
  }

  Future<Either<String, ServiceResponseModel>> getServicesByCategory(int categoryId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));
      
      final filteredServices = _dummyServices
          .where((service) => service.serviceCategoryId == categoryId)
          .toList();
      
      return Right(ServiceResponseModel(
        message: "Services retrieved successfully",
        data: filteredServices,
      ));
    } catch (e) {
      return Left("Error fetching services by category: $e");
    }
  }

  Future<Either<String, ServiceResponseModel>> searchServices(String query) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));
      
      final filteredServices = _dummyServices
          .where((service) =>
              service.name!.toLowerCase().contains(query.toLowerCase()) ||
              service.serviceCode!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      
      return Right(ServiceResponseModel(
        message: "Search completed successfully",
        data: filteredServices,
      ));
    } catch (e) {
      return Left("Error searching services: $e");
    }
  }

  Future<Either<String, ServiceResponseModel>> createService(Map<String, dynamic> data) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Find the category for the new service
      final category = _dummyServiceCategories.firstWhere(
        (cat) => cat.serviceCategoryId == data['service_category_id'],
        orElse: () => ServiceCategory(),
      );
      
      final newService = Service(
        serviceId: _dummyServices.length + 1,
        serviceCode: data['service_code'],
        name: data['name'],
        serviceCategoryId: data['service_category_id'],
        fee: data['fee']?.toDouble(),
        status: data['status'] ?? 'Aktif',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        createdBy: 1,
        serviceCategory: category.serviceCategoryId != null ? category : null,
      );
      
      _dummyServices.add(newService);
      
      return Right(ServiceResponseModel(
        message: "Service created successfully",
        data: [newService],
      ));
    } catch (e) {
      return Left("Error creating service: $e");
    }
  }

  Future<Either<String, ServiceResponseModel>> updateService(int serviceId, Map<String, dynamic> data) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      final index = _dummyServices.indexWhere((service) => service.serviceId == serviceId);
      
      if (index == -1) {
        return Left("Service not found");
      }
      
      final existingService = _dummyServices[index];
      
      // Find the category if it's being updated
      ServiceCategory? category = existingService.serviceCategory;
      if (data['service_category_id'] != null) {
        category = _dummyServiceCategories.firstWhere(
          (cat) => cat.serviceCategoryId == data['service_category_id'],
          orElse: () => ServiceCategory(),
        );
        if (category?.serviceCategoryId == null) {
          category = existingService.serviceCategory;
        }
      }
      
      final updatedService = Service(
        serviceId: serviceId,
        serviceCode: data['service_code'] ?? existingService.serviceCode,
        name: data['name'] ?? existingService.name,
        serviceCategoryId: data['service_category_id'] ?? existingService.serviceCategoryId,
        fee: data['fee']?.toDouble() ?? existingService.fee,
        status: data['status'] ?? existingService.status,
        createdAt: existingService.createdAt,
        updatedAt: DateTime.now(),
        createdBy: existingService.createdBy,
        serviceCategory: category,
      );
      
      _dummyServices[index] = updatedService;
      
      return Right(ServiceResponseModel(
        message: "Service updated successfully",
        data: [updatedService],
      ));
    } catch (e) {
      return Left("Error updating service: $e");
    }
  }

  Future<Either<String, ServiceResponseModel>> deleteService(int serviceId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      final index = _dummyServices.indexWhere((service) => service.serviceId == serviceId);
      
      if (index == -1) {
        return Left("Service not found");
      }
      
      final existingService = _dummyServices[index];
      final deletedService = Service(
        serviceId: serviceId,
        serviceCode: existingService.serviceCode,
        name: existingService.name,
        serviceCategoryId: existingService.serviceCategoryId,
        fee: existingService.fee,
        status: existingService.status,
        createdAt: existingService.createdAt,
        updatedAt: DateTime.now(),
        deletedAt: DateTime.now(),
        createdBy: existingService.createdBy,
        serviceCategory: existingService.serviceCategory,
      );
      
      _dummyServices[index] = deletedService;
      
      return Right(ServiceResponseModel(
        message: "Service deleted successfully",
        data: [deletedService],
      ));
    } catch (e) {
      return Left("Error deleting service: $e");
    }
  }
}