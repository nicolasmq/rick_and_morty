import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'search_button_event.dart';
part 'search_button_state.dart';

class SearchButtonBloc extends Bloc<SearchButtonEvent, SearchButtonState> {
  SearchButtonBloc() : super(SearchButtonInitial()) {
    on<SearchButtonPressed>((event, emit)  {
      emit(SearchButtonExpanded(width: event.width));
    });
    on<SearchButtonShrank>((event, emit)  {
      emit(SearchButtonClosed(width: event.width));
    });
  }
}
