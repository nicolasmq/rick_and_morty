part of 'search_character_bloc.dart';

@immutable
abstract class SearchCharacterEvent {}

class FindCharacterEvent extends SearchCharacterEvent {

  final String name;

  FindCharacterEvent(this.name);

}

class ScaleContainerEvent extends SearchCharacterEvent {

  final double width;

  ScaleContainerEvent(this.width);

}
