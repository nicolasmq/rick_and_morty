part of 'search_character_bloc.dart';

@immutable
abstract class SearchCharacterState {
  final Character? filteredCharacter;
  final double width;

  const SearchCharacterState(
      {this.filteredCharacter, this.width = 80.0,});
}

class SearchCharacterInitial extends SearchCharacterState {}

class LoadingCharacterInfo extends SearchCharacterState {}

class PressedButton extends SearchCharacterState {
  final double width;
  final Character? filteredCharacter;

  PressedButton(this.width, this.filteredCharacter) : super(width: width,);

}

class FilterCharacter extends SearchCharacterState {
  final Character filteredCharacter;

  FilterCharacter(this.filteredCharacter)
      : super(filteredCharacter: filteredCharacter,);
}

class CharacterNotFound extends SearchCharacterState {
}


