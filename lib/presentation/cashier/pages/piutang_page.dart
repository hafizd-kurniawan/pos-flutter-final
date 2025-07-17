import 'package:flutter/material.dart';
import 'package:flutter_pos_responsive_app/core/constants/colors.dart';
import 'package:flutter_pos_responsive_app/data/data_dummy.dart';
import 'package:intl/intl.dart';

class PiutangPage extends StatefulWidget {
  const PiutangPage({super.key});

  @override
  State<PiutangPage> createState() => _PiutangPageState();
}

class _PiutangPageState extends State<PiutangPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Dummy data for outstanding payments
  final List<Map<String, dynamic>> _belumLunas = [
    {
      'id': 1,
      'invoiceNumber': '2025070139',
      'customerName': 'Pak Ahmad',
      'totalAmount': 150000,
      'paidAmount': 100000,
      'remainingAmount': 50000,
      'dueDate': '2025-07-20',
      'transactionDate': '01 July 2025 2:30:00 pm',
      'status': 'Belum Lunas',
    },
    {
      'id': 2,
      'invoiceNumber': '2025062840',
      'customerName': 'Ibu Sari',
      'totalAmount': 200000,
      'paidAmount': 75000,
      'remainingAmount': 125000,
      'dueDate': '2025-07-15',
      'transactionDate': '28 June 2025 10:15:00 am',
      'status': 'Belum Lunas',
    },
  ];

  final List<Map<String, dynamic>> _lunas = [
    {
      'id': 3,
      'invoiceNumber': '2025061041',
      'customerName': 'Pak Budi',
      'totalAmount': 180000,
      'paidAmount': 180000,
      'remainingAmount': 0,
      'dueDate': '2025-07-10',
      'transactionDate': '10 June 2025 3:45:00 pm',
      'paidDate': '05 July 2025 1:20:00 pm',
      'status': 'Lunas',
    },
    {
      'id': 4,
      'invoiceNumber': '2025060542',
      'customerName': 'Ibu Dewi',
      'totalAmount': 95000,
      'paidAmount': 95000,
      'remainingAmount': 0,
      'dueDate': '2025-06-25',
      'transactionDate': '05 June 2025 11:30:00 am',
      'paidDate': '20 June 2025 4:15:00 pm',
      'status': 'Lunas',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[50],
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manajemen Piutang',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Kelola piutang pelanggan toko',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          // Tab Bar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time),
                      const SizedBox(width: 8),
                      Text('Belum Lunas (${_belumLunas.length})'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle),
                      const SizedBox(width: 8),
                      Text('Lunas (${_lunas.length})'),
                    ],
                  ),
                ),
              ],
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.primary,
            ),
          ),
          
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPiutangList(_belumLunas, false),
                _buildPiutangList(_lunas, true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPiutangList(List<Map<String, dynamic>> piutangList, bool isLunas) {
    if (piutangList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isLunas ? Icons.check_circle_outline : Icons.access_time,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              isLunas ? 'Tidak ada piutang yang sudah lunas' : 'Tidak ada piutang yang belum lunas',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Table Header
        Container(
          color: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              const Expanded(
                flex: 2,
                child: Text(
                  'Invoice',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Text(
                  'Customer',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Text(
                  'Total',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (!isLunas)
                const Expanded(
                  flex: 2,
                  child: Text(
                    'Sisa',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const Expanded(
                flex: 2,
                child: Text(
                  'Tanggal',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Text(
                  'Status',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Expanded(
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
            itemCount: piutangList.length,
            itemBuilder: (context, index) {
              final piutang = piutangList[index];
              
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
                      flex: 2,
                      child: Text(
                        piutang['invoiceNumber'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(piutang['customerName']),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Rp. ${NumberFormat('#,###').format(piutang['totalAmount'])}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (!isLunas)
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Rp. ${NumberFormat('#,###').format(piutang['remainingAmount'])}',
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        isLunas ? (piutang['paidDate'] ?? '-') : piutang['transactionDate'],
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isLunas ? Colors.green : Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          piutang['status'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => _viewPiutangDetail(piutang),
                            icon: const Icon(Icons.visibility, color: AppColors.primary),
                            tooltip: 'Lihat Detail',
                          ),
                          if (!isLunas)
                            IconButton(
                              onPressed: () => _payPiutang(piutang),
                              icon: const Icon(Icons.payment, color: Colors.green),
                              tooltip: 'Bayar',
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
        
        // Summary Footer
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[50],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total ${isLunas ? 'Lunas' : 'Belum Lunas'}: ${piutangList.length} transaksi',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Total Nominal: Rp. ${NumberFormat('#,###').format(_calculateTotal(piutangList, isLunas))}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isLunas ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  int _calculateTotal(List<Map<String, dynamic>> piutangList, bool isLunas) {
    return piutangList.fold(0, (total, piutang) {
      return total + (isLunas ? piutang['totalAmount'] as int : piutang['remainingAmount'] as int);
    });
  }

  void _viewPiutangDetail(Map<String, dynamic> piutang) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Detail Piutang ${piutang['invoiceNumber']}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Invoice', piutang['invoiceNumber']),
              _buildDetailRow('Customer', piutang['customerName']),
              _buildDetailRow('Total Amount', 'Rp. ${NumberFormat('#,###').format(piutang['totalAmount'])}'),
              _buildDetailRow('Dibayar', 'Rp. ${NumberFormat('#,###').format(piutang['paidAmount'])}'),
              _buildDetailRow('Sisa', 'Rp. ${NumberFormat('#,###').format(piutang['remainingAmount'])}'),
              _buildDetailRow('Tanggal Transaksi', piutang['transactionDate']),
              _buildDetailRow('Jatuh Tempo', piutang['dueDate']),
              if (piutang['paidDate'] != null)
                _buildDetailRow('Tanggal Lunas', piutang['paidDate']),
              _buildDetailRow('Status', piutang['status']),
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

  void _payPiutang(Map<String, dynamic> piutang) {
    final TextEditingController paymentController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Bayar Piutang ${piutang['invoiceNumber']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer: ${piutang['customerName']}'),
            const SizedBox(height: 8),
            Text('Sisa Piutang: Rp. ${NumberFormat('#,###').format(piutang['remainingAmount'])}'),
            const SizedBox(height: 16),
            TextField(
              controller: paymentController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah Pembayaran',
                border: OutlineInputBorder(),
                prefixText: 'Rp. ',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              // Process payment logic here
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Pembayaran untuk invoice ${piutang['invoiceNumber']} berhasil diproses'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Proses Pembayaran'),
          ),
        ],
      ),
    );
  }
}