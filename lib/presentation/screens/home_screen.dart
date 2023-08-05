import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:choppi_prueba_tecnica/bloc/main_bloc/main_bloc.dart';
import 'package:choppi_prueba_tecnica/presentation/widgets/carrousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<MainBloc>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
                  gradient: RadialGradient(center: Alignment.topCenter,
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
                Opacity(
                  opacity: 0.0,
                  child: Image.asset(
                    'assets/images/header-background.png',
                  ),
                ),
                SizedBox(height: 30.0,),
                Expanded(
                  child: BlocBuilder<MainBloc, MainState>(
                    builder: (BuildContext context, state) {
                      if (state is LoadedCharacters) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              CharactersCarrousel(characters: state.character.results)
                            ],
                          ),
                        );
                      } else if (state is LoadingCharacters) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        mainBloc.add(LoadCharactersEvent(const []));
                        return const Center(
                          child: Text('No hay Informacion'),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
