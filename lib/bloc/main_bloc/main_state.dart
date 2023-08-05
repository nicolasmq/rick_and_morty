part of 'main_bloc.dart';

@immutable
abstract class MainState {
  final bool isLogged;
  final Character? character;
  final List<Episode>? episodes;

  const MainState({this.character, this.episodes, this.isLogged = false});
}

class MainInitial extends MainState {

 const MainInitial() : super(isLogged: true);

}

class LoadingCharacters extends MainState {

}

class LoadedCharacters extends MainState {
  @override
  final Character character;

  const LoadedCharacters(this.character) : super(isLogged: true, character: character);
}
