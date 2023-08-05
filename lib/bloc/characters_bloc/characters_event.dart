part of 'characters_bloc.dart';

@immutable
abstract class CharactersEvent {}

class AddCharactersEvent extends CharactersEvent {

  final List<Result> characters;
  final int page;
  AddCharactersEvent(this.characters, this.page);

}

class AddNextPageCharactersEvent extends CharactersEvent {

  final List<Result> characters;
  final int page;
  AddNextPageCharactersEvent(this.characters, this.page);

}
