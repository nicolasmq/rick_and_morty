import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'button_search_event.dart';
part 'button_search_state.dart';

class ButtonSearchBloc extends Bloc<ButtonSearchEvent, ButtonSearchState> {
  ButtonSearchBloc() : super(ButtonSearchInitial()) {
    on<ExpandButtonEvent>((event, emit)  {
      emit(ExpandedSearchButton(event.width, ));
    });
    on<CloseButtonEvent>((event, emit)  {
      emit(ClosedSearchButton(event.width, ));
    });
  }
}
