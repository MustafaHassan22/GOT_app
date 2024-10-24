import 'package:bloc/bloc.dart';
import 'package:breaking_bad/data/models/char_continent.dart';
import 'package:breaking_bad/data/models/characters_model.dart';
import 'package:breaking_bad/data/repository/characters_repo.dart';
import 'package:flutter/material.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepo charactersRepo;
  List<Character> characters = [];
  CharactersCubit(this.charactersRepo) : super(CharactersInitial());

  List<Character> getAllCharacters() {
    charactersRepo.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getCharacterContinent(int charId) {
    charactersRepo.getCharacterContinent(charId).then((continents) {
      emit(ContinentLoaded(continents));
    });
  }
}
