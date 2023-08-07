import 'package:choppi_prueba_tecnica/bloc/login_bloc/login_bloc.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/home_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key, }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
      final bool isAuthenticated = loginBloc.preferences.getBool('authenticated') ?? false;
        if (state is Authenticated || isAuthenticated) {
          return const HomeScreen();
        } else if (state is Unauthenticated || state is LoginInitial) {
          return const LoginScreen();
        } else {
          return Container();
        }
      },);

  }
}
