import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:choppi_prueba_tecnica/bloc/search_bloc/search_character_bloc.dart';
import 'package:choppi_prueba_tecnica/model/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CharacterScreen extends StatelessWidget {
  const CharacterScreen({Key? key, required this.character}) : super(key: key);
  final CharacterData character;

  @override
  Widget build(BuildContext context) {
    final searchCharactersBloc = BlocProvider.of<SearchCharacterBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          character.name ?? '',
          style: const TextStyle(
              color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w800),
        ),
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: character.name ?? '',
                child: CachedNetworkImage(
                  height: 250.0,
                  width: 250.0,
                  fit: BoxFit.cover,
                  imageUrl: character.image!,
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
                                    style: TextStyle(color: Colors.white),
                                  ))),
                                  child: TextField(
                                    enabled: state.width == 300.0,
                                    onSubmitted: (value) {
                                      context.goNamed('search-character', pathParameters: {"name": value});
                                    },
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      hintText: 'Morty Smith',
                                      border: InputBorder.none,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              searchCharactersBloc.add(ScaleContainerEvent(100.0));
                                            },
                                            icon: Icon(Icons.close, color: Colors.white54,))),
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
        ),
      ),
    );
  }
}
