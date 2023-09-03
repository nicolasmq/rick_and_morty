import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:choppi_prueba_tecnica/characters/models/character.dart';
import 'package:choppi_prueba_tecnica/services/repository/rick_and_morty_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'characters_event.dart';
part 'characters_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  int currentPage = 1;
  late Character character;
  late Character newCharacter;
  late Character filteredCharacter;
  final RickAndMortyRepository rickAndMortyRepository;

  CharactersBloc(this.rickAndMortyRepository)
      : super(const CharactersInitial()) {
    on<CharactersFetched>(_onCharacterFetched,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onCharacterFetched(
      CharactersEvent event, Emitter<CharactersState> emit) async {
    if (state.hasReachedMax) return;

    try {
      if (state is CharactersInitial) {
        character = await rickAndMortyRepository.getCharacters();
        return emit(CharactersLoaded(character: character));
      }
      currentPage++;
      final List<CharacterData> characterList = character.characterDataList!;
      final Info info = character.info!;
      await Future.delayed(const Duration(milliseconds: 600));
      newCharacter =
          await rickAndMortyRepository.getCharacters(currentPage: currentPage);
      characterList.addAll(newCharacter.characterDataList!);
      info.copyWith(next: newCharacter.info!.next);
      emit(CharactersLoading(
          character:
              newCharacter.copyWith(info: info, results: characterList)));
      emit(newCharacter.info!.next == null
          ? CharactersLoaded(
              hasReachedMax: true,
              character:
                  newCharacter.copyWith(info: info, results: characterList))
          : CharactersLoaded(
              character:
                  newCharacter.copyWith(info: info, results: characterList)));
    } catch (_) {
      emit(const CharactersFailure());
    }
  }
}
