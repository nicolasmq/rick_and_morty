import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:choppi_prueba_tecnica/model/character.dart';
import 'package:choppi_prueba_tecnica/model/episode.dart';
import 'package:choppi_prueba_tecnica/services/repository/rick_and_morty_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  late Character character;
  late Episode episode;
  final RickAndMortyRepository rickAndMortyRepository;

  MainBloc(this.rickAndMortyRepository) : super(const MainInitial()) {
    on<LoadHomeEvent>((event, emit) async {
      if (!state.isLogged) return;
      emit(LoadingHome());
      await Future.delayed(const Duration(milliseconds: 2000));
      character =
          await rickAndMortyRepository.getCharacters(currentPage: 1).timeout(
        Duration(
          seconds: 10,
        ),
        onTimeout: () {
          emit(MainInitial());
          return Character();
        },
      );
      episode = await rickAndMortyRepository.getEpisodes(currentPage: 1);
      emit(LoadedHome(character, episode));
    });
  }
}
