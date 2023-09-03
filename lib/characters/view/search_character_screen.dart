import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:choppi_prueba_tecnica/characters/bloc/button_search/search_button_bloc.dart';
import 'package:choppi_prueba_tecnica/characters/bloc/search_bloc/search_character_bloc.dart';
import 'package:choppi_prueba_tecnica/characters/models/character.dart';
import 'package:choppi_prueba_tecnica/characters/widgets/horizontal_card_character.dart';
import 'package:choppi_prueba_tecnica/characters/widgets/rick_and_morty_layout.dart';
import 'package:choppi_prueba_tecnica/home/widgets/characters_carrousel.dart';
import 'package:choppi_prueba_tecnica/services/repository/rick_and_morty_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';

class SearchCharacterScreen extends StatelessWidget {
  const SearchCharacterScreen({Key? key, required this.name}) : super(key: key);

  final String? name;

  @override
  Widget build(BuildContext context) {
    return RickAndMortyLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Resultados para: "$name"',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w800),
          ),
          foregroundColor: Colors.white,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: BlocProvider(
            create: (context) => SearchCharacterBloc(RickAndMortyRepository()),
            child: BodySearchCharacter(name: name),
          ),
        ),
      ),
    );
  }
}

class BodySearchCharacter extends StatelessWidget {
  const BodySearchCharacter({
    super.key,
    required this.name,
  });
  final String? name;

  @override
  Widget build(BuildContext context) {
    final searchCharactersBloc = BlocProvider.of<SearchCharacterBloc>(context);
    return BlocBuilder<SearchCharacterBloc, SearchCharacterState>(
      builder: (context, state) {
        if (state is FilterCharacter) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50.0,
                  child: Visibility(
                      visible:
                          state.filteredCharacter!.characterDataList!.length >
                              1,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            state.filteredCharacter!.characterDataList!.length,
                        itemBuilder: (context, index) =>
                            HorizontalCardCharacter(
                              onTap: () {
                                if(index != 0) {
                                  Navigator.pushNamed(
                                      context, 'selected-character',
                                      arguments: state.filteredCharacter!
                                          .characterDataList![index]);
                                }
                              },
                                characterData: state.filteredCharacter!
                                    .characterDataList![index]),
                      )),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CharacterInfo(
                  characterData:
                      state.filteredCharacter!.characterDataList!.first,
                ),
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
        } else if (state is LoadingCharacterInfo) {
          return Center(
              child: Container(
            height: 70.0,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/loading.gif",
                    ),
                    fit: BoxFit.scaleDown,
                    opacity: 0.8)),
          ));
        } else if (state is CharacterNotFound) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/error-img.png',
                fit: BoxFit.cover,
                height: 150.0,
              ),
              const Center(
                child: Text(
                  'Al parecer el personaje que buscas no existe',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
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
          );
        } else {
          searchCharactersBloc.add(FormSubmitted(name!));
          return const Center(
            child: Text(
              'Al parecer hubo un error',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      },
    );
  }
}

class CharacterInfo extends StatelessWidget {
  const CharacterInfo({
    super.key,
    required this.characterData,
  });

  final CharacterData characterData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: characterData.id!,
          child: CachedNetworkImage(
            height: 250.0,
            width: 250.0,
            fit: BoxFit.cover,
            imageUrl: characterData.image ?? '',
            imageBuilder: (context, imageProvider) => Container(
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
          'Sobre ${characterData.name}:',
          style: const TextStyle(color: Colors.white, fontSize: 22.0),
        ),
        ListTile(
            title: const Text(
              'Gender:',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              characterData.gender ?? '',
              style: const TextStyle(color: Colors.white),
            )),
        ListTile(
            title: const Text(
              'Status:',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              characterData.status ?? '',
              style: const TextStyle(color: Colors.white),
            )),
        ListTile(
            title: const Text(
              'Episodes:',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              '${characterData.episode!.length}',
              style: const TextStyle(color: Colors.white),
            )),
        ListTile(
            title: const Text(
              'Species:',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              characterData.species ?? '',
              style: const TextStyle(color: Colors.white),
            )),
        ListTile(
            title: const Text(
              'Origen:',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              characterData.origin?.name ?? '',
              style: const TextStyle(color: Colors.white),
            )),
        ListTile(
            title: const Text(
              'Location:',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              characterData.location?.name ?? '',
              style: const TextStyle(color: Colors.white),
            )),
      ],
    );
  }
}
