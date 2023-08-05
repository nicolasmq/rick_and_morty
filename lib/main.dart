import 'package:choppi_prueba_tecnica/bloc/characters_bloc/characters_bloc.dart';
import 'package:choppi_prueba_tecnica/bloc/main_bloc/main_bloc.dart';
import 'package:choppi_prueba_tecnica/services/repository/rick_and_morty_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/navigator/go_navigator.dart';

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
        BlocProvider(create: (context) => MainBloc(RickAndMortyRepository()),),
        BlocProvider(create: (context) => CharactersBloc(RickAndMortyRepository()),)
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        routerConfig: GoNavigator.router,
      ),
    );
  }
}

