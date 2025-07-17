import 'package:flutter/material.dart';
import 'package:flutter_pos_responsive_app/core/constants/colors.dart';
import 'package:flutter_pos_responsive_app/data/data_dummy.dart';
import 'package:intl/intl.dart';

class SalesInvoicePage extends StatefulWidget {
  const SalesInvoicePage({super.key});

  @override
  State<SalesInvoicePage> createState() => _SalesInvoicePageState();
}

class _SalesInvoicePageState extends State<SalesInvoicePage> {
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  int _itemsPerPage = 10;
  String _searchQuery = '';
  
  @override
  Widget build(BuildContext context) {
    final filteredOrders = dummyOrders.where((order) {
      if (_searchQuery.isEmpty) return true;
      return order.invoiceNumber?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false ||
             order.customerName?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false ||
             order.namaKasir.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
    
    final totalEntries = filteredOrders.length;
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = (startIndex + _itemsPerPage > totalEntries) 
        ? totalEntries 
        : startIndex + _itemsPerPage;
    
    final currentPageOrders = filteredOrders.skip(startIndex).take(_itemsPerPage).toList();
    
    return Scaffold(
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data Barang Penjualan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Controls Row
                Row(
                  children: [
                    // Show entries dropdown
                    Row(
                      children: [
                        const Text('Show '),
                        DropdownButton<int>(
                          value: _itemsPerPage,
                          items: [10, 25, 50, 100].map((value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text('$value'),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _itemsPerPage = value!;
                              _currentPage = 1;
                            });
                          },
                        ),
                        const Text(' entries'),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    // Search
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          labelText: 'Search:',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                            _currentPage = 1;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Table Header
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: const Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'No.',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Invoice',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Tanggal Transaksi',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Customer',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Kasir',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Table Body
          Expanded(
            child: ListView.builder(
              itemCount: currentPageOrders.length,
              itemBuilder: (context, index) {
                final order = currentPageOrders[index];
                final displayIndex = startIndex + index + 1;
                
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!),
                    ),
                    color: index % 2 == 0 ? Colors.white : Colors.grey[50],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('$displayIndex'),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          order.invoiceNumber ?? '-',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(order.transactionDate ?? '-'),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(order.customerName ?? 'Customer Umum'),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(order.namaKasir),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Rp. ${NumberFormat('#,###').format(order.totalPrice)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => _viewOrderDetail(order),
                              icon: const Icon(Icons.visibility, color: AppColors.primary),
                              tooltip: 'Lihat Detail',
                            ),
                            IconButton(
                              onPressed: () => _printInvoice(order),
                              icon: const Icon(Icons.print, color: Colors.green),
                              tooltip: 'Print',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Pagination Footer
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing ${startIndex + 1} to $endIndex of $totalEntries entries'
                  '${_searchQuery.isNotEmpty ? " (filtered from ${dummyOrders.length} total entries)" : ""}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                
                // Pagination Controls
                Row(
                  children: [
                    IconButton(
                      onPressed: _currentPage > 1 
                          ? () => setState(() { _currentPage--; })
                          : null,
                      icon: const Icon(Icons.chevron_left),
                    ),
                    
                    // Page numbers
                    ...List.generate(
                      ((totalEntries / _itemsPerPage).ceil()).clamp(0, 5),
                      (index) {
                        final pageNumber = index + 1;
                        final isCurrentPage = pageNumber == _currentPage;
                        
                        return GestureDetector(
                          onTap: () => setState(() { _currentPage = pageNumber; }),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isCurrentPage ? AppColors.primary : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: isCurrentPage ? AppColors.primary : Colors.grey[300]!,
                              ),
                            ),
                            child: Text(
                              '$pageNumber',
                              style: TextStyle(
                                color: isCurrentPage ? Colors.white : Colors.black,
                                fontWeight: isCurrentPage ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    
                    IconButton(
                      onPressed: _currentPage < (totalEntries / _itemsPerPage).ceil()
                          ? () => setState(() { _currentPage++; })
                          : null,
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _viewOrderDetail(dynamic order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Detail Invoice ${order.invoiceNumber}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Invoice', order.invoiceNumber ?? '-'),
              _buildDetailRow('Tanggal', order.transactionDate ?? '-'),
              _buildDetailRow('Customer', order.customerName ?? 'Customer Umum'),
              _buildDetailRow('Kasir', order.namaKasir),
              _buildDetailRow('Metode Pembayaran', order.paymentMethod),
              _buildDetailRow('Total', 'Rp. ${NumberFormat('#,###').format(order.totalPrice)}'),
              const SizedBox(height: 16),
              const Text(
                'Items:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...order.orders.map<Widget>((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('${item.product.name} x${item.quantity}'),
                    ),
                    Text('Rp. ${NumberFormat('#,###').format(int.parse(item.product.price!) * item.quantity)}'),
                  ],
                ),
              )).toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _printInvoice(dynamic order) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Mencetak invoice ${order.invoiceNumber}...'),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}