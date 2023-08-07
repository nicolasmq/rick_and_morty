import 'package:choppi_prueba_tecnica/model/character.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/character_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/characters_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/episodes_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/home_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/loading_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/login_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/main_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/search_character_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoNavigator {

  static final router = GoRouter(routes: [
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      name: 'main',
      path: '/',
      builder: (context, state) => MainScreen(preferences: null,),
      routes: [
        GoRoute(
          name: 'characters',
          path: 'characters',
          builder: (context, state) => CharactersScreen(),
          routes: [
            GoRoute(
              name: 'character',
              path: 'character',
              builder: (context, GoRouterState state) => CharacterScreen(character: state.extra as CharacterData,),
            ),
          ]
        ),
        GoRoute(
          name: 'episodes',
          path: 'episodes',
          builder: (context, state) => EpisodesScreen(),
        ),
        GoRoute(
          name: 'home-character',
          path: 'character',
          builder: (context, GoRouterState state) => CharacterScreen(character: state.extra as CharacterData,),
        ),
        GoRoute(
          name: 'search-character',
          path: 'search-character/:name',
          builder: (context, GoRouterState state) => SearchCharacterScreen(name: state.pathParameters['name']),
        ),
      ]
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      name: 'loading',
      path: '/loading',
      builder: (context, state) => LoadingScreen(),
    ),


  ]);
}
