part of 'episodes_bloc.dart';

@immutable
abstract class EpisodesEvent {}

class AddEpisodesEvent extends EpisodesEvent {

  final List<EpisodeData> episodes;
  final int page;
  AddEpisodesEvent(this.episodes, this.page);

}

class AddNextPageEpisodesEvent extends EpisodesEvent {

  final List<EpisodeData> episodes;
  final int page;
  AddNextPageEpisodesEvent(this.episodes, this.page);

}
