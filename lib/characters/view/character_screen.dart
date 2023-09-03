import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:choppi_prueba_tecnica/characters/bloc/button_search/search_button_bloc.dart';
import 'package:choppi_prueba_tecnica/characters/bloc/search_bloc/search_character_bloc.dart';
import 'package:choppi_prueba_tecnica/characters/models/character.dart';
import 'package:choppi_prueba_tecnica/characters/widgets/rick_and_morty_layout.dart';
import 'package:choppi_prueba_tecnica/services/repository/rick_and_morty_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';

class CharacterScreen extends StatelessWidget {
  const CharacterScreen({Key? key, required this.character}) : super(key: key);
  final CharacterData character;

  @override
  Widget build(BuildContext context) {
    return RickAndMortyLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            character.name ?? '',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.w800),
          ),
          foregroundColor: Colors.white,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: BlocProvider(
            create: (context) => SearchCharacterBloc(RickAndMortyRepository()),
            child: CharacterProfile(character: character),
          ),
        ),
      ),
    );
  }
}

class CharacterProfile extends StatelessWidget {
  const CharacterProfile({
    super.key,
    required this.character,
  });

  final CharacterData character;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Hero(
            tag: character.name ?? '',
            child: CachedNetworkImage(
              height: 250.0,
              width: 250.0,
              fit: BoxFit.cover,
              imageUrl: character.image!,
              imageBuilder: (context, imageProvider) =>
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: imageProvider),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.white24,
                              spreadRadius: 2,
                              blurRadius: 10.0,
                              offset: Offset(2, 5)),
                          BoxShadow(
                              color: Colors.white12,
                              spreadRadius: 2,
                              blurRadius: 10.0,
                              offset: Offset(2, -5))
                        ]),
                  ),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            'Sobre ${character.name}:',
            style: const TextStyle(color: Colors.white, fontSize: 22.0),
          ),
          ListTile(
              title: const Text(
                'Gender:',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text(
                character.gender!,
                style: const TextStyle(color: Colors.white),
              )),
          ListTile(
              title: const Text(
                'Status:',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text(
                character.status!,
                style: const TextStyle(color: Colors.white),
              )),
          ListTile(
              title: const Text(
                'Episodes:',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text(
                '${character.episode!.length}',
                style: const TextStyle(color: Colors.white),
              )),
          ListTile(
              title: const Text(
                'Species:',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text(
                character.species!,
                style: const TextStyle(color: Colors.white),
              )),
          ListTile(
              title: const Text(
                'Origen:',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text(
                character.origin!.name!,
                style: const TextStyle(color: Colors.white),
              )),
          ListTile(
              title: const Text(
                'Location:',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text(
                character.location!.name!,
                style: const TextStyle(color: Colors.white),
              )),
          const SizedBox(
            height: 30.0,
          ),
          const Text(
            '¿Deseas buscar otro personaje?',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10.0,
          ),
          BlocProvider(
            create: (context) => SearchButtonBloc(),
            child: const SearchButton(),
          ),
          const SizedBox(
            height: 30.0,
          )
        ],
      ),
    );
  }
}
