import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_responsive_app/core/constants/colors.dart';
import 'package:flutter_pos_responsive_app/data/data_dummy.dart';
import 'package:flutter_pos_responsive_app/data/models/response/product_response_model.dart';
import 'package:flutter_pos_responsive_app/data/models/response/customer_response_model.dart';
import 'package:flutter_pos_responsive_app/data/datasource/customer_remote_datasource.dart';
import 'package:flutter_pos_responsive_app/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/home/models/order_item.dart';
import 'package:flutter_pos_responsive_app/presentation/cashier/widgets/product_selection_dialog.dart';
import 'package:flutter_pos_responsive_app/presentation/cashier/widgets/customer_selection_dialog.dart';
import 'package:flutter_pos_responsive_app/presentation/customer/bloc/customer_bloc.dart';
import 'package:intl/intl.dart';

class CashierTransactionPage extends StatefulWidget {
  const CashierTransactionPage({super.key});

  @override
  State<CashierTransactionPage> createState() => _CashierTransactionPageState();
}

class _CashierTransactionPageState extends State<CashierTransactionPage> {
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _cashController = TextEditingController();
  
  Customer? selectedCustomer;
  String paymentType = 'Cash';
  String invoiceNumber = '';
  
  List<OrderItem> cartItems = [];
  int total = 0;
  int cash = 0;
  int change = 0;

  @override
  void initState() {
    super.initState();
    _generateInvoiceNumber();
    // Set default customer
    selectedCustomer = Customer(
      customerId: 1,
      name: 'Customer Umum',
      phoneNumber: '',
      address: '',
    );
  }

  void _generateInvoiceNumber() {
    final now = DateTime.now();
    final year = now.year.toString();
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    
    invoiceNumber = '$year$month$day$hour$minute';
    setState(() {});
  }

  void _addProductToCart(Product product) {
    setState(() {
      final existingItemIndex = cartItems.indexWhere(
        (item) => item.product.id == product.id,
      );

      if (existingItemIndex >= 0) {
        // Increase quantity if product already exists
        cartItems[existingItemIndex] = OrderItem(
          product: cartItems[existingItemIndex].product,
          quantity: cartItems[existingItemIndex].quantity + 1,
        );
      } else {
        // Add new item to cart
        cartItems.add(OrderItem(product: product, quantity: 1));
      }
      
      _calculateTotal();
    });
  }

  void _removeProductFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
      _calculateTotal();
    });
  }

  void _updateQuantity(int index, int quantity) {
    if (quantity <= 0) {
      _removeProductFromCart(index);
      return;
    }
    
    setState(() {
      cartItems[index] = OrderItem(
        product: cartItems[index].product,
        quantity: quantity,
      );
      _calculateTotal();
    });
  }

  void _calculateTotal() {
    total = cartItems.fold(0, (sum, item) {
      return sum + (int.parse(item.product.price!) * item.quantity);
    });
    _calculateChange();
  }

  void _calculateChange() {
    change = cash - total;
  }

  void _onCashChanged(String value) {
    cash = int.tryParse(value.replaceAll('.', '')) ?? 0;
    _calculateChange();
    setState(() {});
  }

  void _searchProduct(String barcode) {
    if (barcode.isEmpty) return;
    
    final product = dummyProducts.firstWhere(
      (p) => p.id.toString() == barcode || p.name!.toLowerCase().contains(barcode.toLowerCase()),
      orElse: () => dummyProducts.first, // Default to first product for demo
    );
    
    _addProductToCart(product);
    _barcodeController.clear();
  }

  void _processPayment() {
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Keranjang masih kosong')),
      );
      return;
    }
    
    if (cash < total) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah bayar kurang')),
      );
      return;
    }

    // Process payment (in real app, this would save to database)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaksi berhasil!')),
    );
    
    // Reset form
    setState(() {
      cartItems.clear();
      total = 0;
      cash = 0;
      change = 0;
      _cashController.clear();
      _generateInvoiceNumber();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.primary.withOpacity(0.05),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Workshop Header with Logo
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.build_circle,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'SISTEM POS BENGKEL',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            'Sparepart & Service Center',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Invoice and Barcode Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.receipt,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'No. Invoice',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              invoiceNumber,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.qr_code_scanner,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Scan Barcode / Pilih Produk',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _barcodeController,
                                    decoration: InputDecoration(
                                      hintText: 'Scan barcode atau ketik kode produk...',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 14,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.grey[300]!),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.grey[300]!),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: AppColors.primary, width: 2),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 14,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.qr_code_scanner_rounded,
                                        color: AppColors.primary,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[50],
                                    ),
                                    onSubmitted: _searchProduct,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => ProductSelectionDialog(
                                        onProductSelected: _addProductToCart,
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.add_circle_outline, size: 20),
                                  label: const Text(
                                    'Pilih Produk',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                    elevation: 2,
                                    shadowColor: AppColors.primary.withOpacity(0.3),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Cart Items Table
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Table Header
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary,
                          AppColors.primary.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'DAFTAR PRODUK TERPILIH',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${cartItems.length} item',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Column Headers
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    child: const Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'No.',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Nama Produk',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Harga',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'QTY',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Sub Total',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Aksi',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Cart Items Container
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: cartItems.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.build_circle_outlined,
                                      size: 64,
                                      color: AppColors.primary.withOpacity(0.7),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    'Keranjang Masih Kosong',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Mulai dengan scan barcode atau pilih\nproduk sparepart untuk customer',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[500],
                                      height: 1.4,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.qr_code_scanner,
                                        size: 16,
                                        color: AppColors.primary,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Scan barcode',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      const Text(
                                        'atau',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Icon(
                                        Icons.add_circle_outline,
                                        size: 16,
                                        color: AppColors.primary,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Pilih produk',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              itemCount: cartItems.length,
                              itemBuilder: (context, index) {
                                final item = cartItems[index];
                                final subtotal = int.parse(item.product.price!) * item.quantity;
                                
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey[200]!,
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.04),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      // Item Number
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${index + 1}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // Product Name
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.product.name!,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            if (item.product.description?.isNotEmpty == true) ...[
                                              const SizedBox(height: 2),
                                              Text(
                                                item.product.description!,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600],
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      // Price
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          NumberFormat.currency(
                                            locale: 'id_ID', 
                                            symbol: 'Rp ',
                                            decimalDigits: 0,
                                          ).format(int.parse(item.product.price!)),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      // Quantity Controls
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[50],
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.grey[200]!),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () => _updateQuantity(index, item.quantity - 1),
                                                child: Container(
                                                  width: 28,
                                                  height: 28,
                                                  decoration: BoxDecoration(
                                                    color: item.quantity > 1 ? Colors.red[400] : Colors.grey[300],
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 40,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '${item.quantity}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => _updateQuantity(index, item.quantity + 1),
                                                child: Container(
                                                  width: 28,
                                                  height: 28,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.primary,
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Subtotal
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          NumberFormat.currency(
                                            locale: 'id_ID', 
                                            symbol: 'Rp ',
                                            decimalDigits: 0,
                                          ).format(subtotal),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                      // Delete Button  
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () => _removeProductFromCart(index),
                                            child: Container(
                                              width: 32,
                                              height: 32,
                                              decoration: BoxDecoration(
                                                color: Colors.red[50],
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: Colors.red[200]!,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.delete_outline,
                                                color: Colors.red[400],
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
          
          // Footer Section - Transaction Summary & Processing
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Section Header
                  Row(
                    children: [
                      Icon(
                        Icons.receipt_long,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Ringkasan Transaksi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      if (cartItems.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${cartItems.length} produk',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Customer and Payment Type Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.grey[50]!,
                          Colors.white,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person_outline,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Customer',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => BlocProvider(
                                    create: (context) => CustomerBloc(
                                      CustomerRemoteDatasource(),
                                    ),
                                    child: CustomerSelectionDialog(
                                      selectedCustomer: selectedCustomer,
                                      onCustomerSelected: (customer) {
                                        setState(() {
                                          selectedCustomer = customer;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: selectedCustomer != null 
                                        ? AppColors.primary.withOpacity(0.5)
                                        : Colors.grey[300]!,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  color: selectedCustomer != null 
                                      ? AppColors.primary.withOpacity(0.05)
                                      : Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: selectedCustomer != null 
                                            ? AppColors.primary 
                                            : Colors.grey[400],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Icon(
                                        selectedCustomer != null 
                                            ? Icons.person 
                                            : Icons.person_outline,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            selectedCustomer?.name ?? 'Pilih Customer',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: selectedCustomer != null 
                                                  ? Colors.black87 
                                                  : Colors.grey[600],
                                            ),
                                          ),
                                          if (selectedCustomer != null) ...[
                                            const SizedBox(height: 4),
                                            if (selectedCustomer!.phoneNumber?.isNotEmpty == true)
                                              Text(
                                                selectedCustomer!.phoneNumber!,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            if (selectedCustomer!.vehicles?.isNotEmpty == true) ...[
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.directions_car,
                                                    size: 14,
                                                    color: AppColors.primary,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    '${selectedCustomer!.vehicles!.length} kendaraan',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppColors.primary,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ] else ...[
                                            const SizedBox(height: 4),
                                            Text(
                                              'Klik untuk memilih customer',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.expand_more,
                                      color: selectedCustomer != null 
                                          ? AppColors.primary 
                                          : Colors.grey[400],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.payment,
                                color: AppColors.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Pembayaran',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: DropdownButtonFormField<String>(
                              value: paymentType,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              items: [
                                {'value': 'Cash', 'label': 'Tunai', 'icon': Icons.money},
                                {'value': 'QRIS', 'label': 'QRIS', 'icon': Icons.qr_code},
                                {'value': 'Transfer', 'label': 'Transfer Bank', 'icon': Icons.account_balance},
                                {'value': 'Debit', 'label': 'Kartu Debit', 'icon': Icons.credit_card},
                              ].map((type) {
                                return DropdownMenuItem<String>(
                                  value: type['value'] as String,
                                  child: Row(
                                    children: [
                                      Icon(
                                        type['icon'] as IconData,
                                        size: 18,
                                        color: AppColors.primary,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        type['label'] as String,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  paymentType = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Transaction Summary Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withOpacity(0.1),
                        AppColors.primary.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Total and Cash Input Row
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.receipt_long,
                                      color: AppColors.primary,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Total Belanja',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  NumberFormat.currency(
                                    locale: 'id_ID', 
                                    symbol: 'Rp ',
                                    decimalDigits: 0,
                                  ).format(total),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      paymentType == 'Cash' ? Icons.money : 
                                      paymentType == 'QRIS' ? Icons.qr_code :
                                      paymentType == 'Transfer' ? Icons.account_balance :
                                      Icons.credit_card,
                                      color: AppColors.primary,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      paymentType == 'Cash' ? 'Uang Diterima' : 
                                      paymentType == 'QRIS' ? 'Scan QRIS' :
                                      'Konfirmasi',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                if (paymentType == 'Cash') ...[
                                  TextField(
                                    controller: _cashController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: '0',
                                      hintStyle: TextStyle(color: Colors.grey[400]),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.grey[300]!),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.grey[300]!),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: AppColors.primary, width: 2),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                      prefixText: 'Rp ',
                                      prefixStyle: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    onChanged: _onCashChanged,
                                  ),
                                ] else ...[
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          paymentType == 'QRIS' ? Icons.qr_code_2 : 
                                          paymentType == 'Transfer' ? Icons.account_balance :
                                          Icons.credit_card,
                                          color: AppColors.primary,
                                          size: 32,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          paymentType == 'QRIS' ? 'Siap Scan' :
                                          paymentType == 'Transfer' ? 'Siap Transfer' :
                                          'Siap Gesek',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Change Amount Display
                      if (paymentType == 'Cash' && _cashController.text.isNotEmpty) ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: change >= 0 ? Colors.green[50] : Colors.red[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: change >= 0 ? Colors.green[300]! : Colors.red[300]!,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                change >= 0 ? Icons.check_circle_outline : Icons.warning_outlined,
                                color: change >= 0 ? Colors.green[600] : Colors.red[600],
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      change >= 0 ? 'Kembalian' : 'Uang Kurang',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      NumberFormat.currency(
                                        locale: 'id_ID', 
                                        symbol: 'Rp ',
                                        decimalDigits: 0,
                                      ).format(change.abs()),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: change >= 0 ? Colors.green[700] : Colors.red[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ],
                  ),
                ),
                
                
                // Process Payment Button
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: cartItems.isNotEmpty 
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.primary,
                              AppColors.primary.withOpacity(0.8),
                            ],
                          )
                        : null,
                    color: cartItems.isEmpty ? Colors.grey[300] : null,
                    boxShadow: cartItems.isNotEmpty 
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: ElevatedButton.icon(
                    onPressed: cartItems.isNotEmpty && 
                               (paymentType != 'Cash' || change >= 0) 
                        ? _processPayment 
                        : null,
                    icon: Icon(
                      paymentType == 'Cash' ? Icons.money :
                      paymentType == 'QRIS' ? Icons.qr_code_scanner :
                      paymentType == 'Transfer' ? Icons.account_balance :
                      Icons.credit_card,
                      size: 24,
                    ),
                    label: Text(
                      cartItems.isEmpty 
                          ? 'TAMBAHKAN PRODUK DULU'
                          : paymentType == 'Cash' && change < 0
                              ? 'UANG BELUM CUKUP'
                              : 'PROSES PEMBAYARAN ${paymentType.toUpperCase()}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: cartItems.isNotEmpty ? Colors.white : Colors.grey[600],
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ))))));
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _cashController.dispose();
    super.dispose();
  }
}