part of 'search_character_bloc.dart';

sealed class SearchCharacterState extends Equatable {
  final Character? filteredCharacter;

  const SearchCharacterState({this.filteredCharacter});

  @override
  List<Object?> get props => [filteredCharacter];
}

final class SearchCharacterInitial extends SearchCharacterState {}

final class LoadingCharacterInfo extends SearchCharacterState {}

final class PressedButton extends SearchCharacterState {
  const PressedButton({super.filteredCharacter});
}

final class FilterCharacter extends SearchCharacterState {
  const FilterCharacter({super.filteredCharacter});
}

final class CharacterNotFound extends SearchCharacterState {}
