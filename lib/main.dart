import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_responsive_app/core/constants/colors.dart';
import 'package:flutter_pos_responsive_app/data/datasource/auth_local_datasource.dart';
import 'package:flutter_pos_responsive_app/data/datasource/auth_remote_datasource.dart';
import 'package:flutter_pos_responsive_app/data/datasource/category_remote_datasource.dart';
import 'package:flutter_pos_responsive_app/data/datasource/order_remote_datasource.dart';
import 'package:flutter_pos_responsive_app/data/datasource/product_remote_datasource.dart';
import 'package:flutter_pos_responsive_app/data/datasource/report_remote_datasource.dart';
import 'package:flutter_pos_responsive_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/auth/pages/login_page.dart';
import 'package:flutter_pos_responsive_app/presentation/history/bloc/history/history_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/home/bloc/category/category_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/home/bloc/product/product_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/home/pages/dashboard_page.dart';
import 'package:flutter_pos_responsive_app/presentation/order/bloc/order/order_bloc.dart';
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
      ],
      child: MaterialApp(
        title: 'POS Responsive FIC 23',
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
        home: FutureBuilder<bool>(
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
              return DashboardPage();
            } else {
              // If not authenticated, show the login page
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: LoginPage(),
    );
  }
}
