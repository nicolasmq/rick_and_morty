part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class SignInEvent extends LoginEvent{}

class SignOutEvent extends LoginEvent{}