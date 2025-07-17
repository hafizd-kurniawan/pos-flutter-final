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
    price: '56000',
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
    price: '112000',
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
    price: '100000',
    categoryId: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    category: Category(id: 1, name: "Sparepart"),
    image: "https://example.com/filter_udara.jpg",
    stock: 30,
  ),
  Product(
    id: 4,
    name: "Kampas Rem",
    price: '100000',
    categoryId: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    category: Category(id: 1, name: "Sparepart"),
    image: "https://example.com/kampas_rem.jpg",
    stock: 25,
  ),
  Product(
    id: 5,
    name: "Lampu Sein",
    price: '20000',
    categoryId: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    category: Category(id: 1, name: "Sparepart"),
    image: "https://example.com/lampu_sein.jpg",
    stock: 40,
  ),
  Product(
    id: 6,
    name: "Shock Absorber",
    price: '80000',
    categoryId: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    category: Category(id: 1, name: "Sparepart"),
    image: "https://example.com/shock_absorber.jpg",
    stock: 15,
  ),
  Product(
    id: 7,
    name: "Aki GS Astra",
    price: '350000',
    categoryId: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    category: Category(id: 1, name: "Sparepart"),
    image: "https://example.com/aki_gs.jpg",
    stock: 12,
  ),
  Product(
    id: 8,
    name: "Busi NGK",
    price: '35000',
    categoryId: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    category: Category(id: 1, name: "Sparepart"),
    image: "https://example.com/busi_ngk.jpg",
    stock: 60,
  ),
];

List<CategoryModel> categories = [
  CategoryModel(name: 'Sparepart', value: 'sparepart'),
  CategoryModel(name: 'Jasa', value: 'jasa'),
  CategoryModel(name: 'Aksesoris', value: 'aksesoris'),
];

// =======================================================
// DUMMY CUSTOMERS - PELANGGAN TOKO
// =======================================================
List<Map<String, dynamic>> dummyCustomers = [
  {
    'id': 1,
    'name': 'Customer Umum',
    'phone': '',
    'address': '',
  },
  {
    'id': 2,
    'name': 'AMIN',
    'phone': '081234567890',
    'address': 'Jl. Merdeka No. 123',
  },
  {
    'id': 3,
    'name': 'Yonglex',
    'phone': '081234567891',
    'address': 'Jl. Sudirman No. 456',
  },
  {
    'id': 4,
    'name': 'Pak Budi',
    'phone': '081234567892',
    'address': 'Jl. Thamrin No. 789',
  },
  {
    'id': 5,
    'name': 'Ibu Sari',
    'phone': '081234567893',
    'address': 'Jl. Gatot Subroto No. 101',
  },
];

// =======================================================
// DUMMY ORDERS - TRANSAKSI KASIR ENHANCED
// =======================================================
List<OrderModel> dummyOrders = [
  // Order 1 - July 13, 2025
  OrderModel(
    id: 1,
    invoiceNumber: '2025071339',
    paymentMethod: 'Cash',
    nominalBayar: 56000,
    orders: [
      OrderItem(
        product: Product(
          id: 1,
          name: "Oli Mesin Shell Helix",
          price: '56000',
          category: Category(id: 1, name: "Sparepart"),
          image: "...",
          stock: 50,
          categoryId: 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        quantity: 1,
      ),
    ],
    totalQuantity: 1,
    totalPrice: 56000,
    idKasir: 1,
    namaKasir: "Seniman Koding",
    customerName: "Customer Umum",
    isSync: true,
    transactionTime: DateTime(2025, 7, 13, 18, 21, 55).toIso8601String(),
    transactionDate: "13 July 2025 6:21:55 pm",
  ),

  // Order 2 - July 2, 2025  
  OrderModel(
    id: 2,
    invoiceNumber: '2025070238',
    paymentMethod: 'Cash',
    nominalBayar: 112000,
    orders: [
      OrderItem(
        product: Product(
          id: 2,
          name: "Ban Michelin 185/65R15",
          price: '112000',
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
    totalPrice: 112000,
    idKasir: 1,
    namaKasir: "Seniman Koding",
    customerName: "AMIN",
    isSync: true,
    transactionTime: DateTime(2025, 7, 2, 11, 13, 37).toIso8601String(),
    transactionDate: "02 July 2025 11:13:37 am",
  ),

  // Order 3 - June 25, 2025
  OrderModel(
    id: 3,
    invoiceNumber: '2025062537',
    paymentMethod: 'Cash',
    nominalBayar: 100000,
    orders: [
      OrderItem(
        product: Product(
          id: 3,
          name: "Filter Udara",
          price: '100000',
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
    totalQuantity: 1,
    totalPrice: 100000,
    idKasir: 2,
    namaKasir: "Kasir",
    customerName: "Customer Umum",
    isSync: true,
    transactionTime: DateTime(2025, 6, 25, 16, 4, 20).toIso8601String(),
    transactionDate: "25 June 2025 4:04:20 pm",
  ),

  // Order 4 - June 23, 2025
  OrderModel(
    id: 4,
    invoiceNumber: '2025062336',
    paymentMethod: 'Cash',
    nominalBayar: 100000,
    orders: [
      OrderItem(
        product: Product(
          id: 4,
          name: "Kampas Rem",
          price: '100000',
          category: Category(id: 1, name: "Sparepart"),
          image: "...",
          stock: 25,
          categoryId: 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        quantity: 1,
      ),
    ],
    totalQuantity: 1,
    totalPrice: 100000,
    idKasir: 3,
    namaKasir: "Doni Afandi",
    customerName: "Customer Umum",
    isSync: true,
    transactionTime: DateTime(2025, 6, 23, 9, 38, 7).toIso8601String(),
    transactionDate: "23 June 2025 9:38:07 am",
  ),

  // Order 5 - June 13, 2025
  OrderModel(
    id: 5,
    invoiceNumber: '2025061335',
    paymentMethod: 'Cash',
    nominalBayar: 20000,
    orders: [
      OrderItem(
        product: Product(
          id: 5,
          name: "Lampu Sein",
          price: '20000',
          category: Category(id: 1, name: "Sparepart"),
          image: "...",
          stock: 40,
          categoryId: 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        quantity: 1,
      ),
    ],
    totalQuantity: 1,
    totalPrice: 20000,
    idKasir: 2,
    namaKasir: "Kasir",
    customerName: "Yonglex",
    isSync: true,
    transactionTime: DateTime(2025, 6, 13, 10, 41, 44).toIso8601String(),
    transactionDate: "13 June 2025 10:41:44 am",
  ),

  // Order 6 - June 10, 2025
  OrderModel(
    id: 6,
    invoiceNumber: '2025061034',
    paymentMethod: 'Cash',
    nominalBayar: 20000,
    orders: [
      OrderItem(
        product: Product(
          id: 5,
          name: "Lampu Sein",
          price: '20000',
          category: Category(id: 1, name: "Sparepart"),
          image: "...",
          stock: 40,
          categoryId: 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        quantity: 1,
      ),
    ],
    totalQuantity: 1,
    totalPrice: 20000,
    idKasir: 1,
    namaKasir: "Seniman Koding",
    customerName: "Customer Umum",
    isSync: true,
    transactionTime: DateTime(2025, 6, 10, 10, 53, 3).toIso8601String(),
    transactionDate: "10 June 2025 10:53:03 am",
  ),

  // Order 7 - May 31, 2025 (3:09 PM)
  OrderModel(
    id: 7,
    invoiceNumber: '2025053133',
    paymentMethod: 'Cash',
    nominalBayar: 100000,
    orders: [
      OrderItem(
        product: Product(
          id: 4,
          name: "Kampas Rem",
          price: '100000',
          category: Category(id: 1, name: "Sparepart"),
          image: "...",
          stock: 25,
          categoryId: 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        quantity: 1,
      ),
    ],
    totalQuantity: 1,
    totalPrice: 100000,
    idKasir: 2,
    namaKasir: "Kasir",
    customerName: "Customer Umum",
    isSync: true,
    transactionTime: DateTime(2025, 5, 31, 15, 9, 10).toIso8601String(),
    transactionDate: "31 May 2025 3:09:10 pm",
  ),

  // Order 8 - May 31, 2025 (1:52 PM)
  OrderModel(
    id: 8,
    invoiceNumber: '2025053132',
    paymentMethod: 'Cash',
    nominalBayar: 100000,
    orders: [
      OrderItem(
        product: Product(
          id: 4,
          name: "Kampas Rem",
          price: '100000',
          category: Category(id: 1, name: "Sparepart"),
          image: "...",
          stock: 25,
          categoryId: 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        quantity: 1,
      ),
    ],
    totalQuantity: 1,
    totalPrice: 100000,
    idKasir: 2,
    namaKasir: "Kasir",
    customerName: "Customer Umum",
    isSync: true,
    transactionTime: DateTime(2025, 5, 31, 13, 52, 0).toIso8601String(),
    transactionDate: "31 May 2025 1:52:00 pm",
  ),

  // Order 9 - May 31, 2025 (1:48 PM)
  OrderModel(
    id: 9,
    invoiceNumber: '2025053131',
    paymentMethod: 'Cash',
    nominalBayar: 80000,
    orders: [
      OrderItem(
        product: Product(
          id: 6,
          name: "Shock Absorber",
          price: '80000',
          category: Category(id: 1, name: "Sparepart"),
          image: "...",
          stock: 15,
          categoryId: 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        quantity: 1,
      ),
    ],
    totalQuantity: 1,
    totalPrice: 80000,
    idKasir: 2,
    namaKasir: "Kasir",
    customerName: "Yonglex",
    isSync: true,
    transactionTime: DateTime(2025, 5, 31, 13, 48, 58).toIso8601String(),
    transactionDate: "31 May 2025 1:48:58 pm",
  ),

  // Order 10 - May 31, 2025 (1:44 PM)
  OrderModel(
    id: 10,
    invoiceNumber: '2025053130',
    paymentMethod: 'Cash',
    nominalBayar: 20000,
    orders: [
      OrderItem(
        product: Product(
          id: 5,
          name: "Lampu Sein",
          price: '20000',
          category: Category(id: 1, name: "Sparepart"),
          image: "...",
          stock: 40,
          categoryId: 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        quantity: 1,
      ),
    ],
    totalQuantity: 1,
    totalPrice: 20000,
    idKasir: 2,
    namaKasir: "Kasir",
    customerName: "Customer Umum",
    isSync: true,
    transactionTime: DateTime(2025, 5, 31, 13, 44, 10).toIso8601String(),
    transactionDate: "31 May 2025 1:44:10 pm",
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
