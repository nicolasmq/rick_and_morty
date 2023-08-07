part of 'button_search_bloc.dart';

@immutable
abstract class ButtonSearchState {
  final double width;

  const ButtonSearchState({this.width = 80.0});
}
class ButtonSearchInitial extends ButtonSearchState {}

class ExpandedSearchButton extends ButtonSearchState {
  final double width;

  const ExpandedSearchButton(this.width) : super(width: width);
}
class ClosedSearchButton extends ButtonSearchState {
  final double width;

  const ClosedSearchButton(this.width): super(width: width);
}


