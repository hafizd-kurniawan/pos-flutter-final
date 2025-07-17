import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_responsive_app/data/datasource/auth_local_datasource.dart';
import 'package:flutter_pos_responsive_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter_pos_responsive_app/presentation/home/pages/dashboard_page.dart';
import 'package:flutter_pos_responsive_app/presentation/tablet/home/pages/dashboard_tablet_page.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SpaceHeight(80.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 130.0),
            child: Image.asset(
              Assets.images.logo.path,
              width: 100,
              height: 100,
            ),
          ),
          const SpaceHeight(24.0),
          const Center(
            child: Text(
              "Kasir Jago",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SpaceHeight(8.0),
          const Center(
            child: Text(
              'Login to your account',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
          const SpaceHeight(40.0),
          CustomTextField(controller: usernameController, label: 'Email'),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: passwordController,
            label: 'Password',
            obscureText: true,
          ),
          const SpaceHeight(24.0),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              switch (state) {
                case Success(data: final data):
                  //simpan data di shared preferences
                  AuthLocalDatasource().saveAuthData(data);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return screenSize > 600
                            ? const DashboardTabletPage()
                            : const DashboardPage();
                      },
                    ),
                  );
                case Failure(message: final message):
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(message)));
                default:
                  break;
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                switch (state) {
                  case Loading():
                    return const Center(child: CircularProgressIndicator());
                  case _:
                    return Button.filled(
                      onPressed: () {
                        context.read<LoginBloc>().add(
                          LoginEvent.login(
                            email: usernameController.text,
                            password: passwordController.text,
                          ),
                        );
                      },
                      label: 'Login',
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
