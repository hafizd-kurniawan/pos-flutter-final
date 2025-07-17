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
      id: 1,
      name: 'Customer Umum',
      phone: '',
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
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey[50]!,
                  Colors.grey[100]!,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Invoice and Barcode Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
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
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
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
                                  'Barcode / Kode Barang',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
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
                                      hintText: 'Scan atau ketik kode barang',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 12,
                                      ),
                                      prefixIcon: const Icon(Icons.search),
                                    ),
                                    onSubmitted: _searchProduct,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => ProductSelectionDialog(
                                      onProductSelected: _addProductToCart,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.add),
                                label: const Text('Pilih'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
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
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Table Header
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: const Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'No.',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Nama Barang',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Harga',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'QTY',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Sub Total',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Aksi',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
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
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: cartItems.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 64,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Belum ada barang yang dipilih',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Scan barcode atau pilih barang untuk menambahkan ke keranjang',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: cartItems.length,
                              itemBuilder: (context, index) {
                                final item = cartItems[index];
                                final subtotal = int.parse(item.product.price!) * item.quantity;
                                
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 4),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: index % 2 == 0 ? Colors.grey[50] : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          item.product.name!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                  'Rp. ${NumberFormat('#,###').format(int.parse(item.product.price!))}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _updateQuantity(index, item.quantity - 1),
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Text('${item.quantity}'),
                                    ),
                                    GestureDetector(
                                      onTap: () => _updateQuantity(index, item.quantity + 1),
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(12),
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
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Rp. ${NumberFormat('#,###').format(subtotal)}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () => _removeProductFromCart(index),
                                  icon: const Icon(Icons.delete, color: Colors.red),
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
          
          // Footer Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Customer and Payment Type
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Customer',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
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
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Colors.grey[600],
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      selectedCustomer?.name ?? 'Pilih Customer',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: selectedCustomer != null 
                                            ? Colors.black87 
                                            : Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey[600],
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
                          const Text(
                            'Tipe Pembayaran',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: paymentType,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            items: ['Cash', 'QRIS', 'Transfer'].map((type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                paymentType = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Payment Section
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Rp. ${NumberFormat('#,###').format(total)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bayar',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: _cashController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: '0',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              prefixText: 'Rp. ',
                            ),
                            onChanged: _onCashChanged,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kembali',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Rp. ${NumberFormat('#,###').format(change >= 0 ? change : 0)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: change >= 0 ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Process Payment Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _processPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'PROSES PEMBAYARAN',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _cashController.dispose();
    super.dispose();
  }
}