import 'package:breaking_bad/constanst/my_colors.dart';
import 'package:breaking_bad/constanst/strings.dart';
import 'package:breaking_bad/data/models/characters_model.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, charactersDetialsScreen,
            arguments: character),
        child: GridTile(
          footer: Hero(
            tag: character.charId,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                character.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MyColors.myWhite,
                    height: 1.3),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            color: MyColors.myGrey,
            child: character.imageUrl.isNotEmpty
                ? FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: 'assets/images/loading.gif',
                    image: character.imageUrl,
                    fit: BoxFit.cover,
                  )
                : Image.asset('assets/images/placholder.jpg'),
          ),
        ),
      ),
    );
  }
}
