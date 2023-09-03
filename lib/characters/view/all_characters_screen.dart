import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:choppi_prueba_tecnica/characters/bloc/characters_bloc/characters_bloc.dart';
import 'package:choppi_prueba_tecnica/characters/models/character.dart';
import 'package:choppi_prueba_tecnica/characters/widgets/rick_and_morty_layout.dart';
import 'package:choppi_prueba_tecnica/services/repository/rick_and_morty_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view.dart';

class AllCharactersScreen extends StatelessWidget {
  const AllCharactersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RickAndMortyLayout(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
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
        body: BlocProvider(
          create: (context) => CharactersBloc(RickAndMortyRepository())
            ..add(CharactersFetched()),
          child: const SafeArea(
            child: CharacterList(),
          ),
        ),
      ),
    );
  }
}

class CharacterList extends StatefulWidget {
  const CharacterList({
    super.key,
  });

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersBloc, CharactersState>(
      builder: (context, state) {
        if (state is CharactersFailure) {
          return const Center(child: Text('failed to fetch Characters'));
        } else if (state is CharactersLoaded) {
          if (state.character!.characterDataList!.isEmpty) {
            return const Center(
              child: Text('Ups, no hay nada que mostrar'),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.hasReachedMax
                        ? state.character!.characterDataList!.length
                        : state.character!.characterDataList!.length + 1,
                    itemBuilder: (context, index) {
                      return index >= state.character!.characterDataList!.length
                          ? const BottomLoader()
                          : CharacterCard(
                              character:
                                  state.character!.characterDataList![index],
                            );
                    }),
              ),
            ],
          );
        } else if (state is CharactersInitial) {
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
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<CharactersBloc>().add(CharactersFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 2.5),
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
        transitionDuration: const Duration(milliseconds: 650),
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
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Status:',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400),
                          ),
                          CharacterCardChip(label: character!.status!)
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Species:',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400),
                          ),
                          CharacterCardChip(label: character!.species)
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Episodes:',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400),
                          ),
                          CharacterCardChip(
                              label: character!.episode!.length.toString()),
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
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        label!,
        overflow: TextOverflow.fade,
        maxLines: 1,
        style: const TextStyle(
            overflow: TextOverflow.fade,
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
