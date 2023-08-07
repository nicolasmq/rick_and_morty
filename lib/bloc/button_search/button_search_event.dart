part of 'button_search_bloc.dart';

@immutable
abstract class ButtonSearchEvent {}


class ExpandButtonEvent extends ButtonSearchEvent {

  final double width;

  ExpandButtonEvent(this.width,);

}

class CloseButtonEvent extends ButtonSearchEvent {

  final double width;

  CloseButtonEvent(this.width,);

}
