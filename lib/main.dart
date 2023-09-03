
import 'package:bloc/bloc.dart';
import 'package:choppi_prueba_tecnica/home/view/view.dart';
import 'package:choppi_prueba_tecnica/home/view/home_screen.dart';
import 'package:choppi_prueba_tecnica/routes.dart';
import 'package:choppi_prueba_tecnica/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const SimpleBlocObserver();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: HomeScreen(),
      onGenerateRoute: Routes.settings,
    );
  }


}

