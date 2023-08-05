import 'package:choppi_prueba_tecnica/presentation/screens/character_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/characters_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/episodes_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/home_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

class GoNavigator {
  static final router = GoRouter(initialLocation: '/', routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => HomeScreen(),
      routes: [
        GoRoute(
          name: 'characters',
          path: 'characters',
          builder: (context, state) => CharactersScreen(),
        ),
        GoRoute(
          name: 'episodes',
          path: 'episodes',
          builder: (context, state) => EpisodesScreen(),
        ),
      ]
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),


    GoRoute(
      name: 'character',
      path: '/character/:id',
      builder: (context, state) => CharacterScreen(),
    ),
  ]);
}
