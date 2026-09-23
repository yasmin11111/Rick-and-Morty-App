import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Core/Resources/RoutesManager.dart';
import '../../Data/Models/CharcterModel.dart';

class cardWidget extends StatelessWidget {
  CharactersModel? charactersModel;
  final int index;
   cardWidget({super.key, required this.characters, required this.index});
  final List<CharactersModel> characters;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RoutesNames.CharacterDetailsScreen, arguments: characters[index]);
      },
      child: GridTile(

        footer: Hero(
          tag: characters[index].id,
          child: Container(
          color: Colors.black54,
          padding: const EdgeInsets.all(8),
          child: Text(
            characters[index].name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
                ),
        ),child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(characters[index].image),
            fit: BoxFit.cover,
          ),
        ),
      ),

      ),
    );
  }
}
