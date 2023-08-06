part of 'characters_bloc.dart';

@immutable
abstract class CharactersEvent {}

class AddCharactersEvent extends CharactersEvent {

  final List<CharacterData> characters;
  final int page;
  AddCharactersEvent(this.characters, this.page);

}

class AddNextPageCharactersEvent extends CharactersEvent {

  final List<CharacterData> characters;
  final int page;
  AddNextPageCharactersEvent(this.characters, this.page);

}

class ScaleContainerEvent extends CharactersEvent {

  final double width;

  ScaleContainerEvent(this.width);

}



