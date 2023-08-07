import 'package:choppi_prueba_tecnica/bloc/login_bloc/login_bloc.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/home_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key, required this.preferences}) : super(key: key);
  final SharedPreferences? preferences;
  @override
  Widget build(BuildContext context) {

    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
      final bool isAuthenticated = loginBloc.preferences.getBool('authenticated') ?? false;
        if (state is Authenticated || isAuthenticated) {
          return HomeScreen();
        } else if (state is Unauthenticated || state is LoginInitial) {
          return const LoginScreen();
        } else {
          return Container();
        }
      },);

  }
}
