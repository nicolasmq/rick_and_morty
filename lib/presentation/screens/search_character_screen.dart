import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:choppi_prueba_tecnica/bloc/search_bloc/search_character_bloc.dart';
import 'package:choppi_prueba_tecnica/model/character.dart';
import 'package:choppi_prueba_tecnica/presentation/widgets/characters_carrousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchCharacterScreen extends StatelessWidget {
  const SearchCharacterScreen({Key? key, required this.name})
      : super(key: key);

  final String? name;

  @override
  Widget build(BuildContext context) {
    final searchCharactersBloc = BlocProvider.of<SearchCharacterBloc>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          name!,
          style: const TextStyle(
              color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w800),
        ),
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: BlocBuilder<SearchCharacterBloc, SearchCharacterState>(
          builder: (context, state) {

            if(state is FilterCharacter) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Visibility(
                        visible: state.filteredCharacter.characterDataList!.length > 1,
                        child: CharactersCarrousel(characters: state.filteredCharacter.characterDataList, showMore: false)),
                    const SizedBox(
                      height: 30.0,
                    ),
                    CharacterInfo(characterData: state.filteredCharacter.characterDataList!.first,),
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
                    BlocBuilder<SearchCharacterBloc, SearchCharacterState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            searchCharactersBloc.add(ScaleContainerEvent(300.0));
                            if (state.width == 100.0) {
                              searchCharactersBloc.add(ScaleContainerEvent(300.0));
                            }
                            if (state.width == 300.0) {
                              searchCharactersBloc.add(ScaleContainerEvent(100.0));
                            }
                          },
                          child: AnimatedContainer(
                            padding: EdgeInsets.symmetric(
                                horizontal: state.width == 300.0 ? 20.0 : 0.0),
                            duration: Duration(milliseconds: 1000),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.white60),
                            height: 50.0,
                            width: state.width,
                            curve: Curves.fastOutSlowIn,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Visibility(
                                        visible: state.width == 300.0,
                                        replacement: FadeIn(
                                            child: const Center(
                                                child: Text(
                                                  'Buscar',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))),
                                        child: TextField(
                                          enabled: state.width == 300.0,
                                          onSubmitted: (value) {
                                            searchCharactersBloc
                                                .add(FindCharacterEvent(value));
                                          },
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                              hintText: 'Morty Smith',
                                              border: InputBorder.none,
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    searchCharactersBloc.add(
                                                        ScaleContainerEvent(
                                                            100.0));
                                                  },
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Colors.white54,
                                                  ))),
                                        )))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    )
                  ],
                ),
              );
            } else if(state is LoadingCharacterInfo){
              return Center(child: CircularProgressIndicator(),);
            } else {
              searchCharactersBloc.add(FindCharacterEvent(name!));
              return Center(child: Text('Al parecer hubo un error', style: TextStyle(color: Colors.white),),);
            }
          },
        ),
      ),
    );
  }
}

class CharacterInfo extends StatelessWidget {
  const CharacterInfo({
    super.key, required this.characterData,
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
          'Sobre ${characterData.name}:',
          style: const TextStyle(
              color: Colors.white, fontSize: 22.0),
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
