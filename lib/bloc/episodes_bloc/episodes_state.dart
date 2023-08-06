part of 'episodes_bloc.dart';

@immutable
abstract class EpisodesState {
  final Episode? episode;
  final bool isLogged;
  final bool isLoading;
  int currentPage;

  EpisodesState(
      {this.episode, this.isLogged = false, this.currentPage = 1, this.isLoading = false, });
}

class EpisodesInitial extends EpisodesState {
  final Episode? episode;

  EpisodesInitial({this.episode}) : super(currentPage: 1, episode: episode, isLogged: true);
}

class LoadingEpisodes extends EpisodesState {
  LoadingEpisodes()
      : super(isLogged: true);
}

class LoadingMoreEpisodes extends EpisodesState {
  final Episode? episode;
  LoadingMoreEpisodes(this.episode) : super(isLogged: true, isLoading: true, episode: episode);
}

class LoadedEpisodes extends EpisodesState {

  final Episode? episode;
  final int currentPage;

  LoadedEpisodes(this.episode, this.currentPage)
      : super(episode: episode, isLogged: true, currentPage: currentPage, isLoading: false);
}