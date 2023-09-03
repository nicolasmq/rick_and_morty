part of 'search_button_bloc.dart';

sealed class SearchButtonEvent extends Equatable {

  @override
  List<Object?> get props => [];
}


class SearchButtonPressed extends SearchButtonEvent {

  final double width;

  SearchButtonPressed(this.width);

}

class SearchButtonShrank extends SearchButtonEvent {

  final double width;

  SearchButtonShrank(this.width);

}
