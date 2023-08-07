import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:choppi_prueba_tecnica/model/character.dart';
import 'package:choppi_prueba_tecnica/services/repository/rick_and_morty_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  int currentPage = 1;
  late Character character;
  late Character newCharacter;
  late Character filteredCharacter;
  final ScrollController charactersScrollController = ScrollController();
  final RickAndMortyRepository rickAndMortyRepository;

  CharactersBloc(this.rickAndMortyRepository) : super(CharactersInitial()) {
    charactersScrollController.addListener(() {
      if (charactersScrollController.position.atEdge &&
          charactersScrollController.position.pixels > 0.0) {
        add(AddNextPageCharactersEvent(
            state.character!.characterDataList!, currentPage++));
      }
    });

    on<AddCharactersEvent>((event, emit) async {
      if (!state.isLogged) return;
      emit(LoadingCharacters());
      await Future.delayed(const Duration(milliseconds: 2000));
      character = await rickAndMortyRepository.getCharacters(
          currentPage: state.currentPage);
      emit(LoadedCharacters(character, 1));
    });
    on<AddNextPageCharactersEvent>((event, emit) async {
      if (!state.isLogged) return;
      if (state.currentPage == 43) return;
      final List<CharacterData> moreResults =
          state.character!.characterDataList!;
      final Info newInfo = state.character!.info!;
      emit(LoadingMoreCharacters(state.character!));
      fetchData();
      newCharacter =
          await rickAndMortyRepository.getCharacters(currentPage: currentPage);
      moreResults.addAll(newCharacter.characterDataList!);
      newInfo.copyWith(
          next: newCharacter.info!.next, prev: newCharacter.info!.prev);
      emit(LoadedCharacters(
          state.character!.copyWith(results: moreResults, info: newInfo),
          currentPage));
      state.currentPage = currentPage;
    });

  }
  Future fetchData() async {
    const duration = Duration(milliseconds: 500);
    Timer(duration, response);
  }

  void response() {
    charactersScrollController.animateTo(
        charactersScrollController.position.pixels + 200,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastOutSlowIn);
  }
}
