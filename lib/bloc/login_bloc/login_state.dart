part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class Authenticated extends LoginState {}

class Unauthenticated extends LoginState {}
