import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:choppi_prueba_tecnica/characters/models/character.dart';
import 'package:choppi_prueba_tecnica/services/repository/rick_and_morty_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'search_character_event.dart';
part 'search_character_state.dart';

class SearchCharacterBloc extends Bloc<SearchCharacterEvent, SearchCharacterState> {

  late Character? filteredCharacter;
  final RickAndMortyRepository rickAndMortyRepository;
  final TextEditingController editingController = TextEditingController();

  SearchCharacterBloc(this.rickAndMortyRepository) : super(SearchCharacterInitial()) {
    on<FormSubmitted>((event, emit) async {
      emit(LoadingCharacterInfo());
      await Future.delayed(const Duration(milliseconds: 2000));
      filteredCharacter = await rickAndMortyRepository.filterCharacters(name: event.name);
      if(filteredCharacter != null) {
        emit(FilterCharacter(filteredCharacter: filteredCharacter!));
        return;
      }
      emit(CharacterNotFound());
    });


  }
}
