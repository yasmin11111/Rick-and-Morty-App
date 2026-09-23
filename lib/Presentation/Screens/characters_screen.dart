import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:rick_and_morty_app/Core/Resources/RoutesManager.dart';
import 'package:rick_and_morty_app/Data/Models/CharcterModel.dart';

import '../../Constants/colors.dart';
import '../../Logic/characters_cubit.dart';
import '../Widgets/cardWidget.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {

  late List<CharactersModel> allcharacters;
  late List<CharactersModel> searchedCharacters;

  final TextEditingController searchController = TextEditingController();

  bool isSearching = false;

  Widget buildTextField() {
    return TextField(
      controller: searchController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 18,
        ),
      ),
      style: const TextStyle(
        color: MyColors.myGrey,
        fontSize: 18,
      ),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemsToSearchedList(
      String searchedCharacter) {
    searchedCharacters = allcharacters
        .where(
          (character) => character.name
              .toLowerCase()
              .startsWith(searchedCharacter.toLowerCase()),
        )
        .toList();

    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearch,
          icon: const Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }

  void startSearch() {
    //مجرد صفحه موقته
    ModalRoute.of(context)!.addLocalHistoryEntry(
      LocalHistoryEntry(
        //لما اضغط ع باك يعنى واوقف بحث اعمل كذا
        onRemove: stopSearching,
      ),
    );
             //دلوقتى ببحث قيمتها ب ترو 
    setState(() {
      isSearching = true;
    });
  }

  void stopSearching() {
    clearSearch();

    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
      searchedCharacters = allcharacters;
    });
  }
  Widget buildBlocWidget(){
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersInitial) {
          return  Center(
            child:Image.asset("Assets/Images/loading.gif") ,
          );
        }

        else if (state is CharactersLoaded) {
          allcharacters = state.characters;

          if (!isSearching) {
            searchedCharacters = allcharacters;
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: searchedCharacters.length,
            itemBuilder: (context, index) {
              return cardWidget(
                characters: searchedCharacters,
                index: index,
              );
            },
          );
        }

        return Center(
          child:Image.asset("Assets/Images/loading.gif") ,
        );
      },
    );
  }
  Widget buildNoInternetWidget(){
    return Center(child: Image.asset("Assets/Images/undraw_no-signal_nqfa.png"));
  }
@override
  void initState() {
  BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myWhite,
      appBar: AppBar(
        backgroundColor: MyColors.yellow,
        centerTitle: true,
        title: isSearching
            ? buildTextField()
            : const Text(
                'Characters',
                style: TextStyle(
                  color: MyColors.myGrey,
                  fontSize: 25,
                ),
              ),
        actions: buildAppBarActions(),
      ),

      body:OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
            ) {
          final bool connected =
          !connectivity.contains(ConnectivityResult.none);

          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child:CircularProgressIndicator(),
      )

    );
  }
}