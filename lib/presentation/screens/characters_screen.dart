import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:choppi_prueba_tecnica/bloc/characters_bloc/characters_bloc.dart';
import 'package:choppi_prueba_tecnica/model/character.dart';
import 'package:choppi_prueba_tecnica/presentation/screens/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final characterBloc =
        BlocProvider.of<CharactersBloc>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/group-characters.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
            ),
            Container(
              color: Colors.black.withOpacity(0.95),
            ),
            BlocBuilder<CharactersBloc, CharactersState>(
              builder: (context, state) {
                if (state is LoadedCharacters) {
                  return Column(
                    children: [
                      AppBar(
                        title: const Text(
                          'Personajes',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w800),
                        ),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: characterBloc.charactersScrollController,
                          child: Column(
                            children: [
                              ...state.character.characterDataList!
                                  .map((character) => CharacterCard(
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
                  return Center(child: Container(
                    height: 50.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage("assets/images/loading.gif",), fit: BoxFit.scaleDown,opacity: 0.8)
                    ),));
                } else if (state is LoadingMoreCharacters) {
                  return Column(
                    children: [
                      AppBar(
                        title: const Text(
                          'Personajes',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w800),
                        ),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: characterBloc.charactersScrollController,
                          child: Column(
                            children: [
                              ...state.character.characterDataList!
                                  .map((character) => CharacterCard(
                                        character: character,
                                      ))
                                  .toList()
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
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
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 3,
                                )),
                          )),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  );
                } else {
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
          ],
        ),
      ),
    );
  }
}

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    this.character,
  });
  final CharacterData? character;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //
      },
      child: OpenContainer(
        middleColor: Colors.black,
        transitionDuration: Duration(milliseconds: 650),
        openBuilder: (context, action) =>
            CharacterScreen(character: character!),
        onClosed: (data) async {},
        openColor: Colors.black,
        closedElevation: 3.0,
        closedColor: Colors.transparent,
        closedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        closedBuilder: (context, action) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Colors.black,
                Colors.black,
                Colors.black87,
                Colors.black87,
                Colors.black87,
              ]),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.white.withOpacity(0.45),
                    blurRadius: 0.3,
                    spreadRadius: 0.0,
                    offset: const Offset(0.0, 0.0))
              ]),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13.0),
                    boxShadow: [
                      const BoxShadow(
                          color: Colors.white12,
                          blurRadius: 2.0,
                          offset: Offset(1.0, -1.5)),
                      BoxShadow(
                          color: const Color(0xFF114d40).withOpacity(0.6),
                          blurRadius: 5.0,
                          offset: const Offset(-1.0, 1.5))
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    height: 120.0,
                    width: 120.0,
                    fit: BoxFit.cover,
                    imageUrl: character!.image!,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 120,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            character!.name!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Status:',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400),
                          ),
                          CharacterCardChip(label: character!.status!)
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Species:',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500),
                          ),
                          CharacterCardChip(
                              label: character!.species)
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Episodes:',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500),
                          ),
                          CharacterCardChip(
                              label: character!.episode!.length.toString())
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CharacterCardChip extends StatelessWidget {
  const CharacterCardChip({
    super.key,
    required this.label,
  });

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        label!,
        style: const TextStyle(
            color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w400),
      ),
    );
  }
}
