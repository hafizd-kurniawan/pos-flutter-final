import 'package:flutter/material.dart';
import 'package:flutter_pos_responsive_app/presentation/cashier/pages/cashier_transaction_page.dart';
import 'package:flutter_pos_responsive_app/presentation/cashier/pages/sales_invoice_page.dart';
import 'package:flutter_pos_responsive_app/presentation/cashier/pages/piutang_page.dart';
import 'package:flutter_pos_responsive_app/presentation/service_job/pages/service_job_page.dart';
import 'package:flutter_pos_responsive_app/core/constants/colors.dart';
import 'package:flutter_pos_responsive_app/core/constants/variables.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const CashierTransactionPage(),
    const SalesInvoicePage(),
    const PiutangPage(),
    const ServiceJobPage(),
  ];

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.point_of_sale,
      label: 'Transaksi',
      description: 'Transaksi Kasir',
    ),
    NavigationItem(
      icon: Icons.receipt_long,
      label: 'Penjualan',
      description: 'Invoice Penjualan',
    ),
    NavigationItem(
      icon: Icons.account_balance_wallet,
      label: 'Piutang',
      description: 'Manajemen Piutang',
    ),
    NavigationItem(
      icon: Icons.build_circle,
      label: 'Mekanik',
      description: 'Service Jobs',
    ),
  ];

  void _onItemTapped(int index) {
    debugPrint(
      'Navigation item tapped: $index (${_navigationItems[index].label})',
    );
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              'TRANSAKSI TOKO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              _navigationItems[_selectedIndex].description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        centerTitle: true,
        elevation: 0,
        actions: [
          if (Variables.isTestMode)
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'TEST MODE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _navigationItems.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isSelected = _selectedIndex == index;

                return GestureDetector(
                  onTap: () => _onItemTapped(index),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 65,
                      minWidth: 70,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withOpacity(0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: isSelected
                          ? Border.all(
                              color: AppColors.primary.withOpacity(0.4),
                              width: 2,
                            )
                          : null,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.icon,
                          color: isSelected
                              ? AppColors.primary
                              : Colors.grey[600],
                          size: 26,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.label,
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.grey[600],
                            fontSize: 11,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;
  final String description;

  NavigationItem({
    required this.icon,
    required this.label,
    required this.description,
  });
}

// class NavigationItem {
//   final IconData icon;
//   final String label;
//   final String description;
//
//   NavigationItem({
//     required this.icon,
//     required this.label,
//     required this.description,
//   });
// }

