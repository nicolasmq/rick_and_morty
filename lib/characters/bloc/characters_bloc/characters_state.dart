part of 'characters_bloc.dart';

sealed class CharactersState extends Equatable {
  final Character? character;
  final bool hasReachedMax;

  const CharactersState({this.hasReachedMax = false, this.character});

  @override
  List<Object?> get props => [character, hasReachedMax];
}

final class CharactersInitial extends CharactersState {
  const CharactersInitial();
}

final class CharactersLoading extends CharactersState {
  const CharactersLoading({super.character});
}

final class CharactersLoaded extends CharactersState {
  const CharactersLoaded({super.character, super.hasReachedMax});
}

final class CharactersFailure extends CharactersState {
  const CharactersFailure();
}
