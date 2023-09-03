import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:choppi_prueba_tecnica/home/bloc/home_bloc/home_bloc.dart';
import 'package:choppi_prueba_tecnica/services/repository/rick_and_morty_repository.dart';
import 'package:choppi_prueba_tecnica/home/view/view.dart';
import 'package:choppi_prueba_tecnica/home/widgets/characters_carrousel.dart';
import 'package:choppi_prueba_tecnica/home/widgets/episodes_carrousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final mainBloc = BlocProvider.of<HomeBloc>(context);
    return BlocProvider(
      create: (context) => HomeBloc(RickAndMortyRepository())..add(HomeFetched()),
      child: const HomeContent(),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (BuildContext context, state) {
            if(state is HomeFailure){
              return const Center(child: Text('Ups... Ocurrió un error'),);
            }
            else if(state is HomeInitial) {
              return const Center(child: CircularProgressIndicator(),);
            }
            else if (state is HomeLoaded) {
              return Stack(
                children: [
                  const HomeHeaderBackground(),
                  const HomeBodyBackground(),
                  Column(
                    children: [
                      const SizedBox(
                        height: 30.0,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Opacity(
                                  opacity: 0.0,
                                  child: Image.asset(
                                    'assets/images/header-background.png',
                                  ),
                                ),
                                CharactersCarrousel(
                                    characters: state.character!
                                        .characterDataList),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                EpisodesCarrousel(
                                    episodes: state.episode!.episodeDataList),
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
                        // loginBloc.add(SignOutEvent());
                        // mainBloc.add(MainInitialEvent());
                        // context.goNamed('main');
                      },
                      backgroundColor: Colors.white38,
                      foregroundColor: Colors.black,
                      child: const Icon(Icons.exit_to_app_outlined),
                    ),
                  ),
                ],
              );
            } else if (state is HomeLoading) {
              return const LoadingScreen();
            } else {
              return const LoadingScreen();
            }
          },
        ),
      ),
    );
  }
}

class HomeBodyBackground extends StatelessWidget {
  const HomeBodyBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class HomeHeaderBackground extends StatelessWidget {
  const HomeHeaderBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/header-background.png',
        ),
        Transform(
          transform: Matrix4.identity()
            ..scale(1.0, -1.0),
          alignment: FractionalOffset.center,
          child: Image.asset(
            'assets/images/header-background.png',
          ),
        ),
      ],
    );
  }
}
