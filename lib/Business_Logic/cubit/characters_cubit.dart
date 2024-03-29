import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Data/Models/character.dart';
import '../../Data/Repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
    late CharacterRepository characterRepository;
     List<Character> character=[];
  CharactersCubit(this.characterRepository) : super(CharactersInitial());

  List<Character> getAllChahracters(){
    characterRepository.getAllCharacters().then((character) => {
      emit(CharactersLoaded(character)),
       this.character = character,
    });

    return character;
  }


}
