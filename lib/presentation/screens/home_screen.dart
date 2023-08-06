import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:choppi_prueba_tecnica/bloc/main_bloc/main_bloc.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/loading_screen.dart';
import 'package:choppi_prueba_tecnica/presentation/widgets/characters_carrousel.dart';
import 'package:choppi_prueba_tecnica/presentation/widgets/episodes_carrousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<MainBloc>(context, listen: false);
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
                ],
              );
            } else if (state is LoadingHome) {
              return LoadingScreen();
            } else {
              mainBloc.add(LoadHomeEvent(const [], const []));
              return const Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: Text(
                    'Al parecer ocurrió un error',
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
