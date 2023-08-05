import 'package:cached_network_image/cached_network_image.dart';
import 'package:choppi_prueba_tecnica/bloc/characters_bloc/characters_bloc.dart';
import 'package:choppi_prueba_tecnica/model/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final characterBloc =
        BlocProvider.of<CharactersBloc>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: BlocBuilder<CharactersBloc, CharactersState>(
          builder: (context, state) {
            if (state is LoadedCharacters) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: characterBloc.charactersScrollController,
                      child: Column(
                        children: [
                          ...state.character.results!
                              .map((character) => CharacterListTile(
                                    character: character,
                                  ))
                              .toList()
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is LoadingCharacters) {
              return Center(child: CircularProgressIndicator());
            } else if(state is LoadingMoreCharacters) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: characterBloc.charactersScrollController,
                      child: Column(
                        children: [
                          ...state.character.results!
                              .map((character) => CharacterListTile(
                            character: character,
                          ))
                              .toList()
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Visibility(
                      visible: state.isLoading,
                      child: const FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        onPressed: null,
                        child: SizedBox(
                          height: 20.0,
                            width: 20.0,
                            child: CircularProgressIndicator(color: Colors.black,strokeWidth: 3, )),
                      ))
                ],
              );
            }else {
              characterBloc.add(AddCharactersEvent(const [], 1));

              return const Center(
                child: Text(
                  'No hay informacion',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class CharacterListTile extends StatelessWidget {
  const CharacterListTile({
    super.key,
    this.character,
  });
  final Result? character;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        height: 270.0,
        width: 150.0,
        fit: BoxFit.cover,
        imageUrl: character!.image!,
      ),
      title: Text(
        character!.name!,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
