import 'package:flutter/material.dart';
import 'package:flutter_pos_responsive_app/core/assets/assets.gen.dart';
import 'package:flutter_pos_responsive_app/core/constants/colors.dart';
import 'package:flutter_pos_responsive_app/core/constants/variables.dart';
import 'package:flutter_pos_responsive_app/core/extensions/build_context_ext.dart';
import 'package:flutter_pos_responsive_app/presentation/auth/pages/login_page.dart';
import 'package:flutter_pos_responsive_app/presentation/home/widgets/nav_item.dart';
import 'package:flutter_pos_responsive_app/presentation/tablet/history/pages/history_tablet_page.dart';
import 'package:flutter_pos_responsive_app/presentation/tablet/home/pages/home_tablet_page.dart';
import 'package:flutter_pos_responsive_app/presentation/tablet/setting/pages/setting_tablet_page.dart';

class DashboardTabletPage extends StatefulWidget {
  const DashboardTabletPage({super.key});

  @override
  State<DashboardTabletPage> createState() => _DashboardTabletPageState();
}

class _DashboardTabletPageState extends State<DashboardTabletPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeTabletPage(),
    const HistoryTabletPage(),
    const SettingTabletPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            SingleChildScrollView(
              child: Container(
                height: context.deviceHeight - 20.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(16.0),
                  ),
                  color: AppColors.primary,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, -2),
                      blurRadius: 30.0,
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 0,
                      color: AppColors.black.withOpacity(0.08),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    NavItem(
                      iconPath: Assets.icons.home.path,
                      label: '',
                      isActive: _selectedIndex == 0,
                      onTap: () => _onItemTapped(0),
                      isTablet: true,
                    ),
                    NavItem(
                      iconPath: Assets.icons.history.path,
                      label: '',
                      isActive: _selectedIndex == 1,
                      onTap: () => _onItemTapped(1),
                      isTablet: true,
                    ),

                    NavItem(
                      iconPath: Assets.icons.dashboard.path,
                      label: '',
                      isActive: _selectedIndex == 2,
                      onTap: () => _onItemTapped(2),
                      isTablet: true,
                    ),
                    // NavItem(
                    //   iconPath: Assets.icons.snack.path,
                    //   label: '',
                    //   isActive: _selectedIndex == 3,
                    //   onTap: () => _onItemTapped(3),
                    //   isTablet: true,
                    // ),
                    const Spacer(),
                    // Test mode indicator
                    if (Variables.isTestMode)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'TEST\nMODE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Container(
                      margin: const EdgeInsets.all(20.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.logout, color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: _pages[_selectedIndex]),
          ],
        ),
      ),
    );
  }
}
