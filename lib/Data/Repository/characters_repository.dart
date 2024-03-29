import 'package:bloc_pattern_api_practice/Data/WebServices/characters_web_services.dart';
import '../Models/character.dart';

class CharacterRepository {
  final CharacterWebServices characterWebServices;

  CharacterRepository(this.characterWebServices);

  Future<List<Character>> getAllCharacters() async {
    try {
      final characters = await characterWebServices.getAllCharacters();
      return characters.map((character) => Character.fromJson(character)).toList();
    } catch (e) {
      // Proper error handling
      print('Failed to fetch characters: $e');
      throw Exception('Failed to fetch characters: $e');
    }
  }
}
