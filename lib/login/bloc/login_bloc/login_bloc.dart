import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SharedPreferences preferences;

  LoginBloc(this.preferences) : super(LoginInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(Authenticated());
      preferences.setBool('authenticated', true);
    });
    on<SignOutEvent>((event, emit) async {
      emit(Unauthenticated());
      preferences.setBool('authenticated', false);
    });
  }
}
