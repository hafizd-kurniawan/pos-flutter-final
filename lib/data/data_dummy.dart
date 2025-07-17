import 'package:flutter_pos_responsive_app/data/models/response/category_response_model.dart';
import 'package:flutter_pos_responsive_app/data/models/response/product_sales_report.dart';
import 'package:flutter_pos_responsive_app/data/models/response/outlet_response_model.dart';
import 'package:flutter_pos_responsive_app/data/models/response/customer_response_model.dart';
import 'package:flutter_pos_responsive_app/data/models/response/service_job_response_model.dart';
import 'package:flutter_pos_responsive_app/data/models/response/service_response_model.dart';
import 'package:flutter_pos_responsive_app/presentation/home/models/category_model.dart';
import 'package:flutter_pos_responsive_app/presentation/order/models/order_model.dart';

import '../presentation/home/models/order_item.dart';
import 'models/response/product_response_model.dart';

// =======================================================
// KATALOG PRODUK UTAMA - SPAREPART & JASA BENGKEL
// =======================================================
List<Product> dummyProducts = [
  Product(
    id: 1,
    name: "Oli Mesin Shell Helix",
    price: '85000',
    categoryId: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    category: Category(id: 1, name: "Sparepart"),
    image: "https://example.com/oli_shell_helix.jpg",
    stock: 50,
  ),
  Product(
    id: 2,
    name: "Ban Michelin 185/65R15",
    price: '750000',
    categoryId: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    category: Category(id: 1, name: "Sparepart"),
    image: "https://example.com/ban_michelin.jpg",
    stock: 20,
  ),
  Product(
    id: 3,
    name: "Filter Udara",
    price: '45000',
    categoryId: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    category: Category(id: 1, name: "Sparepart"),
    image: "https://example.com/filter_udara.jpg",
    stock: 30,
  ),
];

List<CategoryModel> categories = [
  CategoryModel(name: 'Sparepart', value: 'sparepart'),
  CategoryModel(name: 'Jasa', value: 'jasa'),
  CategoryModel(name: 'Aksesoris', value: 'aksesoris'),
];

// =======================================================
// DUMMY ORDERS - TRANSAKSI BENGKEL
// =======================================================
List<OrderModel> dummyOrders = [
  // Order 1 - Ganti Oli + Filter
  OrderModel(
    id: 1,
    paymentMethod: 'Cash',
    nominalBayar: 130000,
    orders: [
      OrderItem(
        product: Product(
          id: 1,
          name: "Oli Mesin Shell Helix",
          price: '85000',
          category: Category(id: 1, name: "Sparepart"),
          image: "...",
          stock: 50,
          categoryId: 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        quantity: 1,
      ),
      OrderItem(
        product: Product(
          id: 3,
          name: "Filter Udara",
          price: '45000',
          category: Category(id: 1, name: "Sparepart"),
          image: "...",
          stock: 30,
          categoryId: 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        quantity: 1,
      ),
    ],
    totalQuantity: 2,
    totalPrice: 130000,
    idKasir: 1,
    namaKasir: "Ahmad Subandi",
    isSync: true,
    transactionTime: DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
  ),

  // Order 2 - Ganti Ban
  OrderModel(
    id: 2,
    paymentMethod: 'QRIS',
    nominalBayar: 750000,
    orders: [
      OrderItem(
        product: Product(
          id: 2,
          name: "Ban Michelin 185/65R15",
          price: '750000',
          category: Category(id: 1, name: "Sparepart"),
          image: "...",
          stock: 20,
          categoryId: 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        quantity: 1,
      ),
    ],
    totalQuantity: 1,
    totalPrice: 750000,
    idKasir: 2,
    namaKasir: "Siti Nurhaliza",
    isSync: true,
    transactionTime: DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
  ),
];

// =======================================================
// DUMMY ORDER ITEMS - ITEM BENGKEL
// =======================================================
List<OrderItem> dummyOrderItems = [
  OrderItem(
    product: Product(
      id: 1,
      name: "Oli Mesin Shell Helix",
      price: '85000',
      category: Category(id: 1, name: "Sparepart"),
      image: "...",
      stock: 50,
      categoryId: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    quantity: 1,
  ),
  OrderItem(
    product: Product(
      id: 2,
      name: "Ban Michelin 185/65R15",
      price: '750000',
      category: Category(id: 1, name: "Sparepart"),
      image: "...",
      stock: 20,
      categoryId: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    quantity: 1,
  ),
  OrderItem(
    product: Product(
      id: 3,
      name: "Filter Udara",
      price: '45000',
      category: Category(id: 1, name: "Sparepart"),
      image: "...",
      stock: 30,
      categoryId: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    quantity: 1,
  ),
];

// =======================================================
// DUMMY DRAFT ORDERS (VERSI BARU - TANPA DEPENDENSI)
// =======================================================
// List<DraftOrderModel> dummyDraftOrders = [
//   // Draft 1: Untuk Meja 5
//   DraftOrderModel(
//     id: 1,
//     orders: [
//       DraftOrderItem(
//           product: Product(
//             id: 1,
//             productId: 101,
//             name: "Nasi Goreng Spesial",
//             price: 25000,
//             category: "Makanan Berat",
//             image: "...", stock: 100, // Tambahkan stock untuk draft
//             categoryId: 1, // Tambahkan categoryId untuk draft
//             createdAt: DateTime.now(), // Tambahkan createdAt untuk draft
//             updatedAt: DateTime.now(), // Tambahkan updatedAt untuk draft
//           ),
//           quantity: 1),
//       DraftOrderItem(
//           product: Product(
//             id: 9,
//             productId: 304,
//             name: "Es Jeruk Peras",
//             price: 12000,
//             category: "Minuman Dingin",
//             image: "...",
//             stock: 100, // Tambahkan stock untuk draft
//             categoryId: 1, // Tambahkan categoryId untuk draft
//             createdAt: DateTime.now(), // Tambahkan createdAt untuk draft
//             updatedAt: DateTime.now(), // Tambahkan updatedAt untuk draft
//           ),
//           quantity: 2),
//     ],
//     totalQuantity: 3,
//     totalPrice: 25000 + (2 * 12000), // 49000
//     tableNumber: 5,
//     draftName: "Meja 5",
//     transactionTime:
//         DateTime.now().subtract(const Duration(minutes: 10)).toIso8601String(),
//   ),

//   // Draft 2: Untuk Rombongan di Meja 12
//   DraftOrderModel(
//     id: 2,
//     orders: [
//       DraftOrderItem(
//           product: Product(
//             id: 2,
//             productId: 102,
//             name: "Sate Ayam Madura",
//             price: 30000,
//             category: "Makanan Berat",
//             image: "...", stock: 100, // Tambahkan stock untuk draft
//             categoryId: 1, // Tambahkan categoryId untuk draft
//             createdAt: DateTime.now(), // Tambahkan createdAt untuk draft
//             updatedAt: DateTime.now(), // Tambahkan updatedAt untuk draft
//           ),
//           quantity: 2),
//       DraftOrderItem(
//           product: Product(
//             id: 7,
//             productId: 302,
//             name: "Jus Alpukat",
//             price: 18000,
//             category: "Minuman Dingin",
//             image: "...", stock: 100, // Tambahkan stock untuk draft
//             categoryId: 1, // Tambahkan categoryId untuk draft
//             createdAt: DateTime.now(), // Tambahkan createdAt untuk draft
//             updatedAt: DateTime.now(), // Tambahkan updatedAt untuk draft
//           ),
//           quantity: 3),
//     ],
//     totalQuantity: 5,
//     totalPrice: (2 * 30000) + (3 * 18000), // 114000
//     tableNumber: 12,
//     draftName: "Rombongan Pak Budi",
//     transactionTime:
//         DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
//   ),
// ];

final List<ProductSales> dummyProductSalesData = [
  // Laporan untuk Oli Mesin Shell Helix
  ProductSales(
    productId: 1,
    productName: "Oli Mesin Shell Helix",
    productPrice: 85000,
    totalQuantity: "24", // Total terjual 24 botol
    totalPrice: (85000 * 24), // "2040000"
  ),
  // Laporan untuk Ban Michelin 185/65R15
  ProductSales(
    productId: 2,
    productName: "Ban Michelin 185/65R15", 
    productPrice: 750000,
    totalQuantity: "8", // Total terjual 8 buah
    totalPrice: (750000 * 8), // "6000000"
  ),
  // Laporan untuk Filter Udara
  ProductSales(
    productId: 3,
    productName: "Filter Udara",
    productPrice: 45000,
    totalQuantity: "15", // Total terjual 15 buah
    totalPrice: (45000 * 15), // "675000"
  ),
];

// --- DATA DUMMY UNTUK ProductSalesResponseModel ---
// Ini adalah objek response lengkap yang akan Anda terima dari API.
final ProductSalesResponseModel dummyProductSalesResponse =
    ProductSalesResponseModel(
      status: "success",
      data: [
        ProductSales(
          productId: 1,
          productName: "Oli Mesin Shell Helix",
          productPrice: 85000,
          totalQuantity: "24", // Total terjual 24 botol
          totalPrice: (85000 * 24), // "2040000"
        ),
        ProductSales(
          productId: 2,
          productName: "Ban Michelin 185/65R15",
          productPrice: 750000,
          totalQuantity: "8", // Total terjual 8 buah
          totalPrice: (750000 * 8), // "6000000"
        ),
        ProductSales(
          productId: 102,
          productName: "Sate Ayam Madura",
          productPrice: 30000,
          totalQuantity: "28", // Total terjual 28 porsi
          totalPrice: (30000 * 28), // "840000"
        ),
        ProductSales(
          productId: 3,
          productName: "Filter Udara",
          productPrice: 45000,
          totalQuantity: "15", // Total terjual 15 buah
          totalPrice: (45000 * 15), // "675000"
        ),
      ],
    );

// CloseCashierShiftResponseModel dummyCloseShiftPerfect =
//     CloseCashierShiftResponseModel(
//   message: "Shift closed successfully. Cash matches.",
//   // Perhitungan: closeAmount - (openAmount + cashSales) = 0
//   difference: 0,
//   shift: Shift(
//     id: 101,
//     cashierId: 1,
//     openAmount: 500000,
//     cashSales: 1250000,
//     closeAmount: 1750000, // 500rb + 1.25jt = 1.75jt
//     status: "closed",
//     openedAt: DateTime.now().subtract(const Duration(hours: 8)),
//     closedAt: DateTime.now(),
//     createdAt: DateTime.now().subtract(const Duration(hours: 8)),
//     updatedAt: DateTime.now(),
//   ),
// );
