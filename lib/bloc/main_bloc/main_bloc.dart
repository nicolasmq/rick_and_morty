import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:choppi_prueba_tecnica/model/character.dart';
import 'package:choppi_prueba_tecnica/model/episode.dart';
import 'package:choppi_prueba_tecnica/services/repository/rick_and_morty_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  late Character character;
  late Episode episode;
  final RickAndMortyRepository rickAndMortyRepository;
  final SharedPreferences preferences;

  MainBloc(this.rickAndMortyRepository, this.preferences) : super(MainInitial()) {
    on<LoadHomeEvent>((event, emit) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (!preferences.getBool('authenticated')!) return;
      emit(LoadingHome());
      await Future.delayed(const Duration(milliseconds: 2000));
      character =
          await rickAndMortyRepository.getCharacters(currentPage: 1).timeout(
        const Duration(
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
    on<MainInitialEvent>((event, emit) {
      emit(MainInitial());

    });
  }
}
