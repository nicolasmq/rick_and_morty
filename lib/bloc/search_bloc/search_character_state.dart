part of 'search_character_bloc.dart';

@immutable
abstract class SearchCharacterState {
  final Character? filteredCharacter;
  final double width;


  SearchCharacterState({this.filteredCharacter, this.width = 80.0,});
}

class SearchCharacterInitial extends SearchCharacterState {}


class LoadingCharacterInfo extends SearchCharacterState {

}

class PressedButton extends SearchCharacterState {
  final double width;

  PressedButton(this.width) : super(width: width);
}

class FilterCharacter extends SearchCharacterState {
  final Character filteredCharacter;

  FilterCharacter(this.filteredCharacter) : super(filteredCharacter: filteredCharacter,);
}