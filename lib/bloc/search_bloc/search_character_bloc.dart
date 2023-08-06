import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:choppi_prueba_tecnica/model/character.dart';
import 'package:choppi_prueba_tecnica/services/repository/rick_and_morty_repository.dart';
import 'package:meta/meta.dart';

part 'search_character_event.dart';
part 'search_character_state.dart';

class SearchCharacterBloc extends Bloc<SearchCharacterEvent, SearchCharacterState> {

  late Character filteredCharacter;
  final RickAndMortyRepository rickAndMortyRepository;

  SearchCharacterBloc(this.rickAndMortyRepository) : super(SearchCharacterInitial()) {
    on<FindCharacterEvent>((event, emit) async {
      print('Buscar character');
      emit(LoadingCharacterInfo());
      filteredCharacter = await rickAndMortyRepository.filterCharacters(name: event.name);
      emit(FilterCharacter(filteredCharacter));
    });
    on<ScaleContainerEvent>((event, emit)  {
      emit(PressedButton(event.width));
    });
  }
}
