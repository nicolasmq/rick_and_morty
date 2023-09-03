part of 'search_character_bloc.dart';

sealed class SearchCharacterEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

final class FormSubmitted extends SearchCharacterEvent {

  final String name;
  FormSubmitted(this.name);

}

