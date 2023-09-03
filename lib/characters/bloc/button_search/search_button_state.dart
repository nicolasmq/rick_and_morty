part of 'search_button_bloc.dart';

sealed class SearchButtonState extends Equatable {
  final double width;

  const SearchButtonState({this.width = 80.0});

  @override
  List<Object?> get props => [width];
}
final class SearchButtonInitial extends SearchButtonState {}

final class SearchButtonExpanded extends SearchButtonState {

  const SearchButtonExpanded({super.width});
}
final class SearchButtonClosed extends SearchButtonState {

  const SearchButtonClosed({super.width});
}


