import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty_app/Data/Repository/CharacterRepo.dart';

import '../Data/Models/CharcterModel.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository characterRepository;

  late List<CharactersModel> characters;

  CharactersCubit(this.characterRepository) : super(CharactersInitial());

  Future<void> getAllCharacters() async {
    try {
      emit(CharactersLoading());

      final characters =
      await characterRepository.getAllCharacters();

      this.characters = characters;

      emit(CharactersLoaded(characters));
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }
}