import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/constanst/my_colors.dart';
import 'package:breaking_bad/data/models/characters_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key, required this.character});
  final Character character;

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 650,
      stretch: true,
      pinned: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: true,
        title: Text(
          character.title,
          style: const TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      endIndent: endIndent,
      height: 30,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  Widget checkIfContinentAreLoaded(CharactersState state) {
    if (state is ContinentLoaded) {
      return displayContinent(state);
    } else {
      return showLoadingIndicator();
    }
  }

  Widget displayContinent(state) {
    var continents = state.continents;
    if (continents != null) {
      return Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 35,
            color: Colors.white,
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
              FlickerAnimatedText(continents.map((e) => e.name).join(", ")),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context)
        .getCharacterContinent(character.charId);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  color: MyColors.myGrey,
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('full name : ', character.name),
                      buildDivider(270),
                      characterInfo('family : ', character.family),
                      buildDivider(300),
                      characterInfo('first name : ', character.firstName),
                      buildDivider(270),
                      characterInfo('last name : ', character.lastName),
                      buildDivider(260),
                      characterInfo('title : ', character.title),
                      buildDivider(300),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                          builder: (context, state) {
                        return checkIfContinentAreLoaded(state);
                      }),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 500,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
