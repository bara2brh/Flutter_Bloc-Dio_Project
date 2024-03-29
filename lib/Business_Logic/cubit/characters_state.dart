part of 'characters_cubit.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitial extends CharactersState {

}

final class CharactersLoaded extends CharactersState {
  late List<Character> characters;

  CharactersLoaded(this.characters);
}