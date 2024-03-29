import 'package:bloc_pattern_api_practice/Constants/colors.dart';
import 'package:bloc_pattern_api_practice/Data/Models/character.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants/strings.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({required this.character, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.all(8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, characterDetailScreen,
            arguments: character),
        child: GridTile(
          footer: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black54,
            ),
            child: Center(
              child: Text(
                character.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
          ),
          child: Hero(
            tag: character.id ,
            child: Container(
              color: AppColors.appGrey,
              child: character.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: character.image,
                      fit: BoxFit.fitHeight,
                      placeholderFit: BoxFit.scaleDown,
                    )
                  : Image.asset('assets/images/loading.gif'),
            ),
          ),
        ),
      ),
    );
  }
}
