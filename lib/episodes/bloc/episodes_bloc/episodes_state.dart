part of 'episodes_bloc.dart';

sealed class EpisodesState extends Equatable {
  final Episode? episode;
  final bool hasReachedMax;

  const EpisodesState({this.episode, this.hasReachedMax = false});

  @override
  List<Object?> get props => [episode, hasReachedMax];
}

final class EpisodesInitial extends EpisodesState {
  const EpisodesInitial();
}

final class EpisodesLoading extends EpisodesState {
  const EpisodesLoading({super.episode});
}

final class EpisodesLoaded extends EpisodesState {
  const EpisodesLoaded({super.episode, super.hasReachedMax});
}

final class EpisodesFailure extends EpisodesState {}
