import 'package:breaking_bad/data/models/char_continent.dart';
import 'package:breaking_bad/data/models/characters_model.dart';
import 'package:breaking_bad/data/web_servieces/characters_web_services.dart';

class CharactersRepo {
  final CharactersWebServices charactersWebServices;

  CharactersRepo(this.charactersWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  // Future<List<CharacterContinent>> getCharacterContinent(int charId) async {
  //   final continet = await charactersWebServices.getCharacterContinent(charId);
  //   return continet
  //       .map((charId) =>
  //           CharacterContinent.fromJson(charId as Map<String, dynamic>))
  //       .toList();
  // }

  Future<List<CharacterContinent>> getCharacterContinent(int charId) async {
    final continents =
        await charactersWebServices.getCharacterContinent(charId);
    return continents
        .map((continent) => CharacterContinent.fromJson(continent))
        .toList();
  }
}
