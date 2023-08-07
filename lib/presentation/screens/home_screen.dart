
import 'package:choppi_prueba_tecnica/bloc/login_bloc/login_bloc.dart';
import 'package:choppi_prueba_tecnica/bloc/main_bloc/main_bloc.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/loading_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/widgets/characters_carrousel.dart';
import 'package:choppi_prueba_tecnica/presentation/widgets/episodes_carrousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<MainBloc>(context, listen: false);
    final loginBloc = BlocProvider.of<LoginBloc>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<MainBloc, MainState>(
          builder: (BuildContext context, state) {
            if (state is LoadedHome) {
              return Stack(
                children: [

                  Column(
                    children: [
                      Image.asset(
                        'assets/images/header-background.png',
                      ),
                      Transform(
                        transform: Matrix4.identity()..scale(1.0, -1.0),
                        alignment: FractionalOffset.center,
                        child: Image.asset(
                          'assets/images/header-background.png',
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        gradient: RadialGradient(
                            center: Alignment.topCenter,
                            radius: 2.0,
                            colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black87,
                          Colors.black,
                          Colors.black,
                          Colors.black,
                          Colors.black
                        ])),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 30.0,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Opacity(
                              opacity: 0.0,
                              child: Image.asset(
                                'assets/images/header-background.png',
                              ),
                            ),
                            CharactersCarrousel(
                                characters: state.character.characterDataList),
                            const SizedBox(
                              height: 30.0,
                            ),
                            EpisodesCarrousel(
                                episodes: state.episode.episodeDataList),
                            const SizedBox(
                              height: 30.0,
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton.small(
                      onPressed: () {
                        loginBloc.add(SignOutEvent());
                        mainBloc.add(MainInitialEvent());
                        context.goNamed('main');
                      },
                      backgroundColor: Colors.white38,
                      foregroundColor: Colors.black,
                      child: Icon(Icons.exit_to_app_outlined),
                    ),
                  ),
                ],
              );
            } else if (state is LoadingHome) {
              return LoadingScreen();
            } else {
              mainBloc.add(LoadHomeEvent(const [], const []));
              return Container();
            }
          },
        ),
      ),
    );
  }
}
