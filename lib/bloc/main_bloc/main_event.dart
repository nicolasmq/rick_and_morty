part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class LoadHomeEvent extends MainEvent {

  final List<CharacterData> characters;
  final List<EpisodeData> episodes;

  LoadHomeEvent(this.characters, this.episodes);

}

class MainInitialEvent extends MainEvent{

}


