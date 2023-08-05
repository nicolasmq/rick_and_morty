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
  final RickAndMortyRepository rickAndMortyRepository;

  MainBloc(this.rickAndMortyRepository) : super(const MainInitial()) {
    on<LoadCharactersEvent>((event, emit) async {
      if(!state.isLogged) return;
      emit(LoadingCharacters());
      await Future.delayed(const Duration(milliseconds: 2000));
      character = await rickAndMortyRepository.getCharacters(1);
      emit(LoadedCharacters(character));
    });

  }
}
