part of 'main_bloc.dart';

@immutable
abstract class MainState {
  final bool isLogged;
  final Character? character;
  final Episode? episode;

  const MainState({this.character, this.episode, this.isLogged = false});
}

class MainInitial extends MainState {
}

class LoadingHome extends MainState {}

class LoadedHome extends MainState {
  @override
  final Character character;
  @override
  final Episode episode;

  const LoadedHome(this.character, this.episode)
      : super(isLogged: true, character: character, episode: episode);
}
