import 'package:dartz/dartz.dart';
import 'package:flutter_pos_responsive_app/data/models/response/customer_response_model.dart';

class CustomerRemoteDatasource {
  // Dummy data for customers
  static final List<Customer> _dummyCustomers = [
    Customer(
      customerId: 1,
      name: "Budi Santoso",
      phoneNumber: "08123456789",
      address: "Jl. Merdeka No. 123, Jakarta",
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      createdBy: 1,
      vehicles: [
        CustomerVehicle(
          vehicleId: 1,
          customerId: 1,
          plateNumber: "B 1234 ABC",
          brand: "Honda",
          model: "Vario 125",
          type: "Matic",
          productionYear: 2020,
          chassisNumber: "MH3JF4420LK123456",
          engineNumber: "JF42E1234567",
          color: "Merah",
          notes: "Kondisi baik, rutin service",
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
          updatedAt: DateTime.now().subtract(const Duration(days: 5)),
          createdBy: 1,
        ),
        CustomerVehicle(
          vehicleId: 2,
          customerId: 1,
          plateNumber: "B 5678 DEF",
          brand: "Yamaha",
          model: "NMAX",
          type: "Matic",
          productionYear: 2021,
          chassisNumber: "MH3SA4420LK654321",
          engineNumber: "SA42E7654321",
          color: "Hitam",
          notes: "Motor baru, masih garansi",
          createdAt: DateTime.now().subtract(const Duration(days: 15)),
          updatedAt: DateTime.now().subtract(const Duration(days: 2)),
          createdBy: 1,
        ),
      ],
    ),
    Customer(
      customerId: 2,
      name: "Siti Nurhaliza",
      phoneNumber: "08987654321",
      address: "Jl. Sudirman No. 456, Bandung",
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
      createdBy: 1,
      vehicles: [
        CustomerVehicle(
          vehicleId: 3,
          customerId: 2,
          plateNumber: "D 9876 GHI",
          brand: "Honda",
          model: "Beat",
          type: "Matic",
          productionYear: 2019,
          chassisNumber: "MH3JF4420LK987654",
          engineNumber: "JF42E9876543",
          color: "Putih",
          notes: "Sering digunakan untuk kerja",
          createdAt: DateTime.now().subtract(const Duration(days: 20)),
          updatedAt: DateTime.now().subtract(const Duration(days: 3)),
          createdBy: 1,
        ),
      ],
    ),
    Customer(
      customerId: 3,
      name: "Agus Wibowo",
      phoneNumber: "08156789012",
      address: "Jl. Gatot Subroto No. 789, Surabaya",
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      createdBy: 1,
      vehicles: [
        CustomerVehicle(
          vehicleId: 4,
          customerId: 3,
          plateNumber: "L 1357 JKL",
          brand: "Suzuki",
          model: "Satria FU",
          type: "Sport",
          productionYear: 2018,
          chassisNumber: "JSAEAJ420LK135790",
          engineNumber: "G150A1357924",
          color: "Biru",
          notes: "Motor sport, sering dipakai balap",
          createdAt: DateTime.now().subtract(const Duration(days: 10)),
          updatedAt: DateTime.now().subtract(const Duration(days: 1)),
          createdBy: 1,
        ),
        CustomerVehicle(
          vehicleId: 5,
          customerId: 3,
          plateNumber: "L 2468 MNO",
          brand: "Kawasaki",
          model: "Ninja 150",
          type: "Sport",
          productionYear: 2017,
          chassisNumber: "JKAEXGJ420LK246800",
          engineNumber: "EX150A2468135",
          color: "Hijau",
          notes: "Motor kedua, jarang dipakai",
          createdAt: DateTime.now().subtract(const Duration(days: 8)),
          updatedAt: DateTime.now().subtract(const Duration(days: 1)),
          createdBy: 1,
        ),
      ],
    ),
  ];

  Future<Either<String, CustomerResponseModel>> getCustomers() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      return Right(CustomerResponseModel(
        message: "Customers retrieved successfully",
        data: _dummyCustomers,
      ));
    } catch (e) {
      return Left("Error fetching customers: $e");
    }
  }

  Future<Either<String, CustomerResponseModel>> getCustomerById(int customerId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final customer = _dummyCustomers.firstWhere(
        (customer) => customer.customerId == customerId,
        orElse: () => Customer(),
      );
      
      if (customer.customerId == null) {
        return Left("Customer not found");
      }
      
      return Right(CustomerResponseModel(
        message: "Customer retrieved successfully",
        data: [customer],
      ));
    } catch (e) {
      return Left("Error fetching customer: $e");
    }
  }

  Future<Either<String, CustomerResponseModel>> searchCustomers(String query) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));
      
      final filteredCustomers = _dummyCustomers
          .where((customer) =>
              customer.name!.toLowerCase().contains(query.toLowerCase()) ||
              customer.phoneNumber!.contains(query))
          .toList();
      
      return Right(CustomerResponseModel(
        message: "Search completed successfully",
        data: filteredCustomers,
      ));
    } catch (e) {
      return Left("Error searching customers: $e");
    }
  }

  Future<Either<String, CustomerResponseModel>> createCustomer(Map<String, dynamic> data) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      final newCustomer = Customer(
        customerId: _dummyCustomers.length + 1,
        name: data['name'],
        phoneNumber: data['phone_number'],
        address: data['address'],
        status: data['status'] ?? 'Aktif',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        createdBy: 1,
        vehicles: [],
      );
      
      _dummyCustomers.add(newCustomer);
      
      return Right(CustomerResponseModel(
        message: "Customer created successfully",
        data: [newCustomer],
      ));
    } catch (e) {
      return Left("Error creating customer: $e");
    }
  }

  Future<Either<String, CustomerResponseModel>> updateCustomer(int customerId, Map<String, dynamic> data) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      final index = _dummyCustomers.indexWhere((customer) => customer.customerId == customerId);
      
      if (index == -1) {
        return Left("Customer not found");
      }
      
      final existingCustomer = _dummyCustomers[index];
      final updatedCustomer = Customer(
        customerId: customerId,
        name: data['name'] ?? existingCustomer.name,
        phoneNumber: data['phone_number'] ?? existingCustomer.phoneNumber,
        address: data['address'] ?? existingCustomer.address,
        status: data['status'] ?? existingCustomer.status,
        createdAt: existingCustomer.createdAt,
        updatedAt: DateTime.now(),
        createdBy: existingCustomer.createdBy,
        vehicles: existingCustomer.vehicles,
      );
      
      _dummyCustomers[index] = updatedCustomer;
      
      return Right(CustomerResponseModel(
        message: "Customer updated successfully",
        data: [updatedCustomer],
      ));
    } catch (e) {
      return Left("Error updating customer: $e");
    }
  }

  Future<Either<String, CustomerResponseModel>> deleteCustomer(int customerId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      final index = _dummyCustomers.indexWhere((customer) => customer.customerId == customerId);
      
      if (index == -1) {
        return Left("Customer not found");
      }
      
      final existingCustomer = _dummyCustomers[index];
      final deletedCustomer = Customer(
        customerId: customerId,
        name: existingCustomer.name,
        phoneNumber: existingCustomer.phoneNumber,
        address: existingCustomer.address,
        status: existingCustomer.status,
        createdAt: existingCustomer.createdAt,
        updatedAt: DateTime.now(),
        deletedAt: DateTime.now(),
        createdBy: existingCustomer.createdBy,
        vehicles: existingCustomer.vehicles,
      );
      
      _dummyCustomers[index] = deletedCustomer;
      
      return Right(CustomerResponseModel(
        message: "Customer deleted successfully",
        data: [deletedCustomer],
      ));
    } catch (e) {
      return Left("Error deleting customer: $e");
    }
  }
}