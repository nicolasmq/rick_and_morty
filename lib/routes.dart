
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:choppi_prueba_tecnica/characters/models/models.dart';
import 'package:choppi_prueba_tecnica/characters/view/view.dart';
import 'package:choppi_prueba_tecnica/episodes/view/view.dart';
import 'package:choppi_prueba_tecnica/home/view/view.dart';

class Routes {

  static Route<dynamic> settings( RouteSettings settings) {

    switch(settings.name) {
      case 'home':
        return _pageRoute(page: const HomeScreen());
      case 'all-characters':
        return _pageRoute(page: const AllCharactersScreen());
      case 'all-episodes':
        return _pageRoute(page: const AllEpisodesScreen());
      case 'selected-character':
        final character = settings.arguments as CharacterData;
        return _pageRoute(page: CharacterScreen(character: character));
      case 'searched-character':
        final name = settings.arguments as String;
        return _pageRoute(page: SearchCharacterScreen(name: name));
      default:
        return _pageRoute(page: const HomeScreen());
    }
  }

  static PageRoute _pageRoute({Widget? page}) {
    if(Platform.isAndroid) {
      return MaterialPageRoute(builder: (context) => page!,);
    } else if(Platform.isIOS) {
      return CupertinoPageRoute(builder: (context) => page!,);
    } else {
      return MaterialPageRoute(builder: (context) => page!,);
    }
  }

}