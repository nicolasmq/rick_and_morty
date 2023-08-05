part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class LoadCharactersEvent extends MainEvent {

  final List<Result> characters;

  LoadCharactersEvent(this.characters);

}


