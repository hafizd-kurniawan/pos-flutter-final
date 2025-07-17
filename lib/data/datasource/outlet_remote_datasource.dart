import 'package:dartz/dartz.dart';
import 'package:flutter_pos_responsive_app/data/models/response/outlet_response_model.dart';

class OutletRemoteDatasource {
  // Dummy data for outlets
  static final List<Outlet> _dummyOutlets = [
    Outlet(
      outletId: 1,
      outletName: "Bengkel Pusat Jakarta",
      branchType: "Pusat",
      city: "Jakarta",
      address: "Jl. Sudirman No. 123, Jakarta Pusat",
      phoneNumber: "021-12345678",
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      createdBy: 1,
    ),
    Outlet(
      outletId: 2,
      outletName: "Bengkel Cabang Bandung",
      branchType: "Cabang",
      city: "Bandung",
      address: "Jl. Dago No. 456, Bandung",
      phoneNumber: "022-87654321",
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      createdBy: 1,
    ),
    Outlet(
      outletId: 3,
      outletName: "Bengkel Cabang Surabaya",
      branchType: "Cabang",
      city: "Surabaya",
      address: "Jl. Pemuda No. 789, Surabaya",
      phoneNumber: "031-11223344",
      status: "Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      createdBy: 1,
    ),
    Outlet(
      outletId: 4,
      outletName: "Bengkel Cabang Yogyakarta",
      branchType: "Cabang",
      city: "Yogyakarta",
      address: "Jl. Malioboro No. 101, Yogyakarta",
      phoneNumber: "0274-555666",
      status: "Non-Aktif",
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
      createdBy: 1,
    ),
  ];

  Future<Either<String, OutletResponseModel>> getOutlets() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      return Right(OutletResponseModel(
        message: "Outlets retrieved successfully",
        data: _dummyOutlets,
      ));
    } catch (e) {
      return Left("Error fetching outlets: $e");
    }
  }

  Future<Either<String, OutletResponseModel>> getOutletById(int outletId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final outlet = _dummyOutlets.firstWhere(
        (outlet) => outlet.outletId == outletId,
        orElse: () => Outlet(),
      );
      
      if (outlet.outletId == null) {
        return Left("Outlet not found");
      }
      
      return Right(OutletResponseModel(
        message: "Outlet retrieved successfully",
        data: [outlet],
      ));
    } catch (e) {
      return Left("Error fetching outlet: $e");
    }
  }

  Future<Either<String, OutletResponseModel>> createOutlet(Map<String, dynamic> data) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      final newOutlet = Outlet(
        outletId: _dummyOutlets.length + 1,
        outletName: data['outlet_name'],
        branchType: data['branch_type'],
        city: data['city'],
        address: data['address'],
        phoneNumber: data['phone_number'],
        status: data['status'] ?? 'Aktif',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        createdBy: 1,
      );
      
      _dummyOutlets.add(newOutlet);
      
      return Right(OutletResponseModel(
        message: "Outlet created successfully",
        data: [newOutlet],
      ));
    } catch (e) {
      return Left("Error creating outlet: $e");
    }
  }

  Future<Either<String, OutletResponseModel>> updateOutlet(int outletId, Map<String, dynamic> data) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      final index = _dummyOutlets.indexWhere((outlet) => outlet.outletId == outletId);
      
      if (index == -1) {
        return Left("Outlet not found");
      }
      
      final existingOutlet = _dummyOutlets[index];
      final updatedOutlet = Outlet(
        outletId: outletId,
        outletName: data['outlet_name'] ?? existingOutlet.outletName,
        branchType: data['branch_type'] ?? existingOutlet.branchType,
        city: data['city'] ?? existingOutlet.city,
        address: data['address'] ?? existingOutlet.address,
        phoneNumber: data['phone_number'] ?? existingOutlet.phoneNumber,
        status: data['status'] ?? existingOutlet.status,
        createdAt: existingOutlet.createdAt,
        updatedAt: DateTime.now(),
        createdBy: existingOutlet.createdBy,
      );
      
      _dummyOutlets[index] = updatedOutlet;
      
      return Right(OutletResponseModel(
        message: "Outlet updated successfully",
        data: [updatedOutlet],
      ));
    } catch (e) {
      return Left("Error updating outlet: $e");
    }
  }

  Future<Either<String, OutletResponseModel>> deleteOutlet(int outletId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      final index = _dummyOutlets.indexWhere((outlet) => outlet.outletId == outletId);
      
      if (index == -1) {
        return Left("Outlet not found");
      }
      
      final existingOutlet = _dummyOutlets[index];
      final deletedOutlet = Outlet(
        outletId: outletId,
        outletName: existingOutlet.outletName,
        branchType: existingOutlet.branchType,
        city: existingOutlet.city,
        address: existingOutlet.address,
        phoneNumber: existingOutlet.phoneNumber,
        status: existingOutlet.status,
        createdAt: existingOutlet.createdAt,
        updatedAt: DateTime.now(),
        deletedAt: DateTime.now(),
        createdBy: existingOutlet.createdBy,
      );
      
      _dummyOutlets[index] = deletedOutlet;
      
      return Right(OutletResponseModel(
        message: "Outlet deleted successfully",
        data: [deletedOutlet],
      ));
    } catch (e) {
      return Left("Error deleting outlet: $e");
    }
  }
}