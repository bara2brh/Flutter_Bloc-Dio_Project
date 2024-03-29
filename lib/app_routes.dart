import 'package:bloc_pattern_api_practice/Data/WebServices/characters_web_services.dart';
import 'package:bloc_pattern_api_practice/UI/Screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Business_Logic/cubit/characters_cubit.dart';
import 'Constants/strings.dart';
import 'Data/Models/character.dart';
import 'Data/Repository/characters_repository.dart';
import 'UI/Screens/character_details_screen.dart';

class AppRoutes {
  late CharacterRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRoutes() {
    charactersRepository = CharacterRepository(CharacterWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterDetailScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(builder:(_)=>CharacterDetailsScreen(character: character,));

      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext contxt) => charactersCubit,
            child: CharactersScreen(),
          ),
        );
    }
  }
}
