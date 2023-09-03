import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:choppi_prueba_tecnica/characters/models/character.dart';
import 'package:choppi_prueba_tecnica/episodes/models/episode.dart';
import 'package:choppi_prueba_tecnica/services/repository/rick_and_morty_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late Character character;
  late Episode episode;
  final RickAndMortyRepository rickAndMortyRepository;
  // final SharedPreferences preferences;

  HomeBloc(this.rickAndMortyRepository) : super(HomeInitial()) {
    on<HomeFetched>(_fetchHome);
  }

  Future<void> _fetchHome (HomeEvent event, Emitter<HomeState> emit) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // if (!preferences.getBool('authenticated')!) return;
    emit(HomeLoading());
    await Future.delayed(const Duration(milliseconds: 2000));
    character =
    await rickAndMortyRepository.getCharacters(currentPage: 1).timeout(
      const Duration(
        seconds: 10,
      ),
    );
    episode = await rickAndMortyRepository.getEpisodes(currentPage: 1);
    emit(HomeLoaded(character: character, episode: episode));
  }
}
