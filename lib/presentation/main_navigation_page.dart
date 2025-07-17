import 'package:flutter/material.dart';
import 'package:flutter_pos_responsive_app/core/constants/colors.dart';
import 'package:flutter_pos_responsive_app/core/constants/variables.dart';
import 'package:flutter_pos_responsive_app/presentation/customer/pages/customer_page.dart';
import 'package:flutter_pos_responsive_app/presentation/home/pages/dashboard_page.dart';
import 'package:flutter_pos_responsive_app/presentation/outlet/pages/outlet_page.dart';
import 'package:flutter_pos_responsive_app/presentation/service/pages/service_page.dart';
import 'package:flutter_pos_responsive_app/presentation/service_job/pages/service_job_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const ServiceJobPage(),
    const CustomerPage(),
    const ServicePage(),
    const OutletPage(),
  ];

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.point_of_sale,
      label: 'POS',
      description: 'Point of Sale System',
    ),
    NavigationItem(
      icon: Icons.build,
      label: 'Jobs',
      description: 'Service Jobs',
    ),
    NavigationItem(
      icon: Icons.people,
      label: 'Customers',
      description: 'Customer Management',
    ),
    NavigationItem(
      icon: Icons.miscellaneous_services,
      label: 'Services',
      description: 'Service Management',
    ),
    NavigationItem(
      icon: Icons.store,
      label: 'Outlets',
      description: 'Branch Management',
    ),
  ];

  void _onItemTapped(int index) {
    debugPrint('Navigation item tapped: $index (${_navigationItems[index].label})'); // Debug log
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Variables.isTestMode
          ? AppBar(
              title: const Text('POS System'),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              actions: [
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'TEST MODE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          : null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _navigationItems.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isSelected = _selectedIndex == index;
                
                return GestureDetector(
                  onTap: () => _onItemTapped(index),
                  behavior: HitTestBehavior.opaque, // Ensure touch events are captured
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 48, minWidth: 48), // Ensure minimum touch target
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.icon,
                          color: isSelected ? AppColors.primary : Colors.grey,
                          size: 22,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: TextStyle(
                            color: isSelected ? AppColors.primary : Colors.grey,
                            fontSize: 10,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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