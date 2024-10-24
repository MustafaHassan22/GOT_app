import 'package:breaking_bad/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/constanst/strings.dart';
import 'package:breaking_bad/data/models/characters_model.dart';
import 'package:breaking_bad/data/repository/characters_repo.dart';
import 'package:breaking_bad/data/web_servieces/characters_web_services.dart';
import 'package:breaking_bad/presentation/screens/character_details.dart';
import 'package:breaking_bad/presentation/screens/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRotuer {
  late CharactersRepo charactersRepo;
  late CharactersCubit charactersCubit;

  AppRotuer() {
    charactersRepo = CharactersRepo(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepo);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => charactersCubit,
                  child: const CharacterScreen(),
                ));

      case charactersDetialsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => CharactersCubit(charactersRepo),
            child: CharacterDetailsScreen(
              character: character,
            ),
          ),
        );
    }
  }
}
