import 'package:bloc_pattern_api_practice/Constants/colors.dart';
import 'package:flutter/material.dart';

import '../../Data/Models/character.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({required this.character, super.key});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.appGreen,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: Text(
          character.name,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
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
        text: TextSpan(children: [
          TextSpan(
              text: title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          TextSpan(
              text: value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              )),
        ]));
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: AppColors.appGrey,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appGreen,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  characterInfo('Status : ', character.status),
                  buildDivider(290),
                  characterInfo('Species : ', character.species),
                  buildDivider(275),
                  characterInfo('Gender : ', character.gender),
                  buildDivider(280),
                  characterInfo('Origin name : ', character.origin.name),
                  buildDivider(240),
                  characterInfo('Location name : ', character.location.name),
                  buildDivider(220),
                ],
              ),
            ),
            const SizedBox(
              height: 430,
            ),
          ])),
        ],
      ),
    );
  }
}
