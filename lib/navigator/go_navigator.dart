import 'package:choppi_prueba_tecnica/presentation/screens/characters_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/episodes_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/home_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

class GoNavigator {
  static final router = GoRouter(initialLocation: '/', routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/characters',
      builder: (context, state) => CharactersScreen(),
    ),
    GoRoute(
      path: '/episodes',
      builder: (context, state) => EpisodesScreen(),
    ),
  ]);
}
