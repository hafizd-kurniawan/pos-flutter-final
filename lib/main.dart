import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_responsive_app/core/constants/colors.dart';
import 'package:flutter_pos_responsive_app/core/constants/variables.dart';
import 'package:flutter_pos_responsive_app/data/datasource/auth_local_datasource.dart';
import 'package:flutter_pos_responsive_app/data/datasource/auth_remote_datasource.dart';
import 'package:flutter_pos_responsive_app/data/datasource/category_remote_datasource.dart';
import 'package:flutter_pos_responsive_app/data/datasource/order_remote_datasource.dart';
import 'package:flutter_pos_responsive_app/data/datasource/product_remote_datasource.dart';
import 'package:flutter_pos_responsive_app/data/datasource/report_remote_datasource.dart';
import 'package:flutter_pos_responsive_app/data/datasource/service_job_remote_datasource.dart';
import 'package:flutter_pos_responsive_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/auth/pages/login_page.dart';
import 'package:flutter_pos_responsive_app/presentation/history/bloc/history/history_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/home/bloc/category/category_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/home/bloc/product/product_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/welcome_screen.dart';
import 'package:flutter_pos_responsive_app/presentation/main_navigation_page.dart';
import 'package:flutter_pos_responsive_app/presentation/order/bloc/order/order_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/service_job/bloc/service_job_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/setting/bloc/product_sales/product_sales_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/setting/bloc/summary/summary_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/tablet/home/pages/dashboard_tablet_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(AuthRemoteDatasource())),
        BlocProvider(create: (context) => LogoutBloc(AuthRemoteDatasource())),
        BlocProvider(
          create: (context) => CategoryBloc(CategoryRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(create: (context) => CheckoutBloc()),
        BlocProvider(create: (context) => OrderBloc(OrderRemoteDatasource())),
        BlocProvider(create: (context) => HistoryBloc(OrderRemoteDatasource())),
        BlocProvider(
          create: (context) => SummaryBloc(ReportRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ProductSalesBloc(ReportRemoteDatasource()),
        ),
        // Core BLoC providers for automotive workshop
        BlocProvider(create: (context) => ServiceJobBloc(ServiceJobRemoteDatasource())),
      ],
      child: MaterialApp(
        title: 'Sistem Bengkel Otomotif',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.primary,
            elevation: 0,
            titleTextStyle: GoogleFonts.quicksand(
              color: AppColors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(color: AppColors.primary),
          ),
        ),
        home: Variables.isTestMode ? _buildTestModeHome(context) : _buildNormalHome(context),
      ),
    );
  }

  Widget _buildTestModeHome(BuildContext context) {
    return TestModeWelcomeScreen();
  }

  Widget _buildNormalHome(BuildContext context) {
    return FutureBuilder<bool>(
      future: AuthLocalDatasource().isAuthenticated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data!) {
          // If authenticated, navigate to the dashboard
          //if tablet view go to TabletDashboardPage
          if (MediaQuery.of(context).size.width >= 600) {
            // Return the tablet dashboard page
            return DashboardTabletPage();
          }
          return const WelcomeScreen();
        } else {
          // If not authenticated, show the login page
          return const LoginPage();
        }
      },
    );
  }
}

class TestModeWelcomeScreen extends StatelessWidget {
  const TestModeWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Mode'),
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
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.1),
              AppColors.primary.withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40), // Add top spacing since alignment changed
                  Icon(
                  Icons.science,
                  size: 100,
                  color: Colors.orange,
                ),
                const SizedBox(height: 24),
                Text(
                  'SISTEM BENGKEL OTOMOTIF',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  Variables.testModeMessage,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange, width: 2),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning, color: Colors.orange),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Fitur Mode Testing:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureItem('✓ Tidak perlu login'),
                      _buildFeatureItem('✓ Semua fitur dapat diakses'),
                      _buildFeatureItem('✓ Data dummy untuk testing'),
                      _buildFeatureItem('✓ Simulasi bengkel otomotif'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _buildFeatureCard(
                  icon: Icons.point_of_sale,
                  title: 'Kasir (Sparepart)',
                  description: 'Kelola penjualan sparepart dan aksesoris',
                ),
                const SizedBox(height: 16),
                _buildFeatureCard(
                  icon: Icons.build_circle,
                  title: 'Mekanik (Service)',
                  description: 'Tracking service dan perbaikan kendaraan',
                ),
                const SizedBox(height: 48),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          debugPrint('Start Testing button tapped'); // Debug log
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const MainNavigationPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'MULAI TESTING',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          debugPrint('Use Login button tapped'); // Debug log
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.grey[700],
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'GUNAKAN LOGIN',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40), // Add bottom spacing for better accessibility
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
