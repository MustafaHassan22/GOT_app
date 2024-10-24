import 'package:breaking_bad/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/constanst/my_colors.dart';
import 'package:breaking_bad/data/models/characters_model.dart';
import 'package:breaking_bad/presentation/widget/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacter;
  bool isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Find a character...',
        helperStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
      style: const TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedForCharacter = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();

    setState(() {});
  }

  List<Widget> _buildAppBarAction() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
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
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        )
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadedWidgetes();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myGrey,
      ),
    );
  }

  Widget buildLoadedWidgetes() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [buildCharacterList()],
        ),
      ),
    );
  }

  Widget buildCharacterList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: _searchTextController.text.isEmpty
            ? allCharacters.length
            : searchedForCharacter.length,
        itemBuilder: (context, index) {
          return CharacterItem(
            character: _searchTextController.text.isEmpty
                ? allCharacters[index]
                : searchedForCharacter[index],
          );
        });
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'can\'t connect... check internet',
              style: TextStyle(
                color: MyColors.myGrey,
                fontSize: 22,
              ),
            ),
            Image.network(
              'assets/images/no_internet.png',
              // fit: BoxFit.contain,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarAction(),
        leading: isSearching
            ? const BackButton(
                color: MyColors.myGrey,
              )
            : Container(),
      ),
      body: OfflineBuilder(
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
        child: showLoadingIndicator(),
      ),
    );
  }
}
