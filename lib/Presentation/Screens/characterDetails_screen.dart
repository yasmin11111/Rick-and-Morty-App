import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Constants/colors.dart';
import 'package:rick_and_morty_app/Data/Models/CharcterModel.dart';

import '../../Constants/Strings.dart';

class CharacterdetailsScreen extends StatelessWidget {
  final CharactersModel characters;
  CharacterdetailsScreen({required this.characters});
  @override
  Widget build(BuildContext context) {
    Widget buildAppBar() {
      return SliverAppBar(
        expandedHeight: 600,
        pinned: true,
        stretch: true,
        backgroundColor: MyColors.myGrey,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            characters.name,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
          background: Hero(
            tag: characters.id,
            child: Image.network(characters.image, fit: BoxFit.cover),
          ),
        ),
      );
    }

    Widget charcterInfo(String title, String value) {
      return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(text: title+ " : ",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
            TextSpan(text: value,style:  TextStyle(fontSize: 22,)),
          ]
        )
      );
    }

    Widget buildDivider(double end){
return Divider(
  endIndent: end,
height: 40,
thickness: 2,
  color: MyColors.yellow,
);

    }
     return Scaffold(
    backgroundColor: MyColors.myGrey,

    body:
    CustomScrollView(
      slivers: [
        buildAppBar(),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsetsGeometry.fromLTRB(14, 14, 14, 0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     charcterInfo("Status",characters.status),
                    buildDivider(300),
                     charcterInfo("Date",characters.created),
                    buildDivider(280),

                    charcterInfo("species",characters.species),
                    buildDivider(220),

                    charcterInfo("gender",characters.gender),
                    buildDivider(180),
                    charcterInfo("Origin Name",characters.originName),
                    buildDivider(180),

             DefaultTextStyle(
                  style: const TextStyle(
                  fontSize: 20,
                  color: Colors.yellow,
              shadows: [
              Shadow(
                  blurRadius: 7.0,
                  color: Colors.white,
                  offset: Offset(0, 0),
            ),
          ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(Quotes[Random().nextInt(Quotes.length)]),
              

            ],
            onTap: () {
              print("Tap Event");
            },
          ),
        ),


                     SizedBox(height: 550,)

                  ],
                ),
              ),
            ),
          ]),
    ) ]),

    );
  }
}
