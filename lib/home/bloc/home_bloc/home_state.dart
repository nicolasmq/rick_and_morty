part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  final Character? character;
  final Episode? episode;

  const HomeState({this.character, this.episode});

  @override
  List<Object?> get props => [character, episode];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  const HomeLoaded({super.character, super.episode});
}

final class HomeFailure extends HomeState {}
