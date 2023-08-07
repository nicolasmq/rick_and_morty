part of 'search_character_bloc.dart';

@immutable
abstract class SearchCharacterEvent {}

class SearchInitialEvent extends SearchCharacterEvent {
}

class FindCharacterEvent extends SearchCharacterEvent {

  final String name;

  FindCharacterEvent(this.name);

}

class CharacterNotFoundEvent extends SearchCharacterEvent {

  final String name;

  CharacterNotFoundEvent(this.name);

}

