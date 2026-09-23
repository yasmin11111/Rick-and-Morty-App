import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Data/Models/CharcterModel.dart';
import '../../Presentation/Screens/characterDetails_screen.dart' show CharacterdetailsScreen;
import '../../Logic/characters_cubit.dart' show CharactersCubit;
import '../../Presentation/Screens/characters_screen.dart' show CharactersScreen;
import '../../Data/Repository/CharacterRepo.dart' show CharacterRepository;
import 'package:flutter_bloc/flutter_bloc.dart';
class RoutesManager{
  // late CharactersCubit charactersCubit;
  // late CharacterRepository characterRepository;
  // RoutesManager(){
  //   characterRepository = CharacterRepository(
  //     CharactersModel:Characters()
  //   );
  //   charactersCubit = CharactersCubit(characterRepository: characterRepository);
  // }
 static Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
      switch (settings.name) {
        case RoutesNames.CharactersScreen:
          return MaterialPageRoute(builder: (context) => BlocProvider(
            create: (context) => CharactersCubit( CharacterRepository(),
            ),
            child: CharactersScreen(),
          ));
        case RoutesNames.CharacterDetailsScreen:
          final  characters = settings.arguments as CharactersModel;
          return MaterialPageRoute(builder: (context) => CharacterdetailsScreen(
            characters: characters  ,
          ));

      }

    }
  }

class RoutesNames{
  static const String CharactersScreen = '/';
  static const String CharacterDetailsScreen = '/CharacterdetailsScreen';
}