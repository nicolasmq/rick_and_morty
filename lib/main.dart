import 'package:choppi_prueba_tecnica/bloc/button_search/button_search_bloc.dart';
import 'package:choppi_prueba_tecnica/bloc/characters_bloc/characters_bloc.dart';
import 'package:choppi_prueba_tecnica/bloc/episodes_bloc/episodes_bloc.dart';
import 'package:choppi_prueba_tecnica/bloc/login_bloc/login_bloc.dart';
import 'package:choppi_prueba_tecnica/bloc/main_bloc/main_bloc.dart';
import 'package:choppi_prueba_tecnica/bloc/search_bloc/search_character_bloc.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/home_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/login_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/main_screen.dart';
import 'package:choppi_prueba_tecnica/services/repository/rick_and_morty_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/navigator/go_navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(MyApp(preferences: preferences));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.preferences});
  // This widget is the root of your application.
  final SharedPreferences? preferences;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainBloc(RickAndMortyRepository(), preferences!),),
        BlocProvider(create: (context) => CharactersBloc(RickAndMortyRepository()),),
        BlocProvider(create: (context) => EpisodesBloc(RickAndMortyRepository()),),
        BlocProvider(create: (context) => SearchCharacterBloc(RickAndMortyRepository()),),
        BlocProvider(create: (context) => ButtonSearchBloc()),
        BlocProvider(create: (context) => LoginBloc(preferences!)),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Rick And Morty',
        routerConfig: GoNavigator.router,
      ),
    );
  }
}

