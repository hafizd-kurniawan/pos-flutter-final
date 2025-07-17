import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pos_responsive_app/data/data_dummy.dart';
import 'package:flutter_pos_responsive_app/presentation/home/models/category_model.dart';

void main() {
  group('UI Rework Tests - Automotive Workshop Focus', () {
    test('Dummy products should contain automotive spareparts only', () {
      // Test that all dummy products are automotive-related
      expect(dummyProducts.isNotEmpty, true);
      
      // Check that products are automotive spareparts
      final oilProduct = dummyProducts.firstWhere(
        (product) => product.name.contains('Oli'),
        orElse: () => throw Exception('Oli product not found'),
      );
      expect(oilProduct.name, 'Oli Mesin Shell Helix');
      expect(oilProduct.price, '85000');
      
      final tireProduct = dummyProducts.firstWhere(
        (product) => product.name.contains('Ban'),
        orElse: () => throw Exception('Ban product not found'),
      );
      expect(tireProduct.name, 'Ban Michelin 185/65R15');
      expect(tireProduct.price, '750000');
      
      final filterProduct = dummyProducts.firstWhere(
        (product) => product.name.contains('Filter'),
        orElse: () => throw Exception('Filter product not found'),
      );
      expect(filterProduct.name, 'Filter Udara');
      expect(filterProduct.price, '45000');
    });

    test('Categories should be automotive-focused', () {
      // Test that categories are automotive-related
      expect(categories.isNotEmpty, true);
      
      final sparepartCategory = categories.firstWhere(
        (category) => category.value == 'sparepart',
        orElse: () => throw Exception('Sparepart category not found'),
      );
      expect(sparepartCategory.name, 'Sparepart');
      
      final jasaCategory = categories.firstWhere(
        (category) => category.value == 'jasa',
        orElse: () => throw Exception('Jasa category not found'),
      );
      expect(jasaCategory.name, 'Jasa');
      
      final aksesorisCategory = categories.firstWhere(
        (category) => category.value == 'aksesoris',
        orElse: () => throw Exception('Aksesoris category not found'),
      );
      expect(aksesorisCategory.name, 'Aksesoris');
    });

    test('Dummy orders should reflect automotive transactions', () {
      // Test that orders contain automotive products
      expect(dummyOrders.isNotEmpty, true);
      
      // Check first order contains oil change
      final firstOrder = dummyOrders.first;
      expect(firstOrder.orders.any((item) => item.product.name.contains('Oli')), true);
      expect(firstOrder.namaKasir, 'Ahmad Subandi');
      
      // Check second order contains tire
      final secondOrder = dummyOrders[1];
      expect(secondOrder.orders.any((item) => item.product.name.contains('Ban')), true);
      expect(secondOrder.namaKasir, 'Siti Nurhaliza');
    });

    test('Product sales data should be automotive-focused', () {
      // Test that sales reports are for automotive products
      expect(dummyProductSalesData.isNotEmpty, true);
      
      final oilSales = dummyProductSalesData.firstWhere(
        (sales) => sales.productName.contains('Oli'),
        orElse: () => throw Exception('Oil sales not found'),
      );
      expect(oilSales.productName, 'Oli Mesin Shell Helix');
      expect(oilSales.totalQuantity, '24');
      
      final tireSales = dummyProductSalesData.firstWhere(
        (sales) => sales.productName.contains('Ban'),
        orElse: () => throw Exception('Tire sales not found'),
      );
      expect(tireSales.productName, 'Ban Michelin 185/65R15');
      expect(tireSales.totalQuantity, '8');
      
      final filterSales = dummyProductSalesData.firstWhere(
        (sales) => sales.productName.contains('Filter'),
        orElse: () => throw Exception('Filter sales not found'),
      );
      expect(filterSales.productName, 'Filter Udara');
      expect(filterSales.totalQuantity, '15');
    });

    test('No food/cafe references should remain in data', () {
      // Ensure no food/cafe references exist in products
      for (final product in dummyProducts) {
        expect(product.name.toLowerCase().contains('nasi'), false, 
          reason: 'Product name should not contain "nasi": ${product.name}');
        expect(product.name.toLowerCase().contains('sate'), false,
          reason: 'Product name should not contain "sate": ${product.name}');
        expect(product.name.toLowerCase().contains('pisang'), false,
          reason: 'Product name should not contain "pisang": ${product.name}');
        expect(product.name.toLowerCase().contains('kopi'), false,
          reason: 'Product name should not contain "kopi": ${product.name}');
        expect(product.name.toLowerCase().contains('cafe'), false,
          reason: 'Product name should not contain "cafe": ${product.name}');
      }
      
      // Ensure no food/cafe references exist in categories
      for (final category in categories) {
        expect(category.value.toLowerCase().contains('food'), false,
          reason: 'Category value should not contain "food": ${category.value}');
        expect(category.value.toLowerCase().contains('drink'), false,
          reason: 'Category value should not contain "drink": ${category.value}');
        expect(category.name.toLowerCase().contains('makanan'), false,
          reason: 'Category name should not contain "makanan": ${category.name}');
        expect(category.name.toLowerCase().contains('minuman'), false,
          reason: 'Category name should not contain "minuman": ${category.name}');
      }
    });
  });
}