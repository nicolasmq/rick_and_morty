part of 'characters_bloc.dart';

@immutable
abstract class CharactersState {
  final Character? character;
  final bool isLogged;
  final bool isLoading;
  int currentPage;

  CharactersState(
      {this.character, this.isLogged = false, this.currentPage = 1, this.isLoading = false, });
}

class CharactersInitial extends CharactersState {
  final Character? character;

  CharactersInitial({this.character}) : super(currentPage: 1, character: character, isLogged: true);
}

class LoadingCharacters extends CharactersState {
  LoadingCharacters()
      : super(isLogged: true);
}

class LoadingMoreCharacters extends CharactersState {
  final Character character;
  LoadingMoreCharacters(this.character) : super(isLogged: true, isLoading: true, character: character);
}

class LoadedCharacters extends CharactersState {

  final Character character;
  final int currentPage;

  LoadedCharacters(this.character, this.currentPage)
      : super(character: character, isLogged: true, currentPage: currentPage, isLoading: false);
}
