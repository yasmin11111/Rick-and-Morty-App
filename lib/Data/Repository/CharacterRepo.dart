import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Data/API/CharacterAPI.dart';
import 'package:rick_and_morty_app/Data/Models/CharcterModel.dart';

class CharacterRepository {
  CharactersModel? charactersModel;
  CharacterRepository({
     this.charactersModel,
}) ;
  Future<List<CharactersModel>> getAllCharacters() async {
    final charcters= await Characterapi().getAllCharacters();
    return charcters['results'].map<CharactersModel>((characterinJSON) => CharactersModel.fromJson(characterinJSON)).toList();


  }
}