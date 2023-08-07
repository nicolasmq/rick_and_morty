
import 'package:cached_network_image/cached_network_image.dart';
import 'package:choppi_prueba_tecnica/bloc/characters_bloc/characters_bloc.dart';
import 'package:choppi_prueba_tecnica/bloc/episodes_bloc/episodes_bloc.dart';
import 'package:choppi_prueba_tecnica/model/episode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EpisodesScreen extends StatelessWidget {
  const EpisodesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final episodesBloc =
    BlocProvider.of<EpisodesBloc>(context, listen: false);
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
            BlocBuilder<EpisodesBloc, EpisodesState>(
              builder: (context, state) {
                if (state is LoadedEpisodes) {
                  return Column(
                    children: [
                      AppBar(
                        title: const Text(
                          'Episodios',
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
                          controller: episodesBloc.episodesScrollController,
                          child: Column(
                            children: [
                              ...state.episode!.episodeDataList!
                                  .map((character) => EpisodeCard(
                                episode: character,
                              ))
                                  .toList()
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is LoadingEpisodes) {
                  return Center(child: Container(
                    height: 70.0,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage("assets/images/loading.gif",), fit: BoxFit.scaleDown,opacity: 0.8)
                    ),));
                } else if (state is LoadingMoreEpisodes) {
                  return Column(
                    children: [
                      AppBar(
                        title: const Text(
                          'Episodios',
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
                          controller: episodesBloc.episodesScrollController,
                          child: Column(
                            children: [
                              ...state.episode!.episodeDataList!
                                  .map((character) => EpisodeCard(
                                episode: character,
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
                  episodesBloc.add(AddEpisodesEvent(const [], 1));
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      title: const Text(
                        'Episodios',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w800),
                      ),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                    body: const Center(
                      child: Text(
                        'No hay informacion',
                        style: TextStyle(color: Colors.white),
                      ),
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

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    super.key,
    this.episode,
  });
  final EpisodeData? episode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //
      },
      child: Container(
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
                child: Image.asset(coverImage(context, episode!.episode!),
                  height: 120.0,
                  width: 120.0,
                  fit: BoxFit.cover,
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
                          episode!.name!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Episode:',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400),
                        ),
                        EpisodeCardChip(label: episode!.episode!)
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Air date:',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        ),
                        EpisodeCardChip(
                            label: episode!.airDate)
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  String coverImage(BuildContext contex, String episodeName) {
    if (episodeName.startsWith('S01')) {
      return 'assets/images/cover-s1.png';
    } else if (episodeName.startsWith('S02')) {
      return 'assets/images/cover-s2.png';
    } else if (episodeName.startsWith('S03')) {
      return 'assets/images/cover-s3.png';
    } else if (episodeName.startsWith('S04')) {
      return 'assets/images/cover-s4.png';
    } else {
      return 'assets/images/cover-s5.png';
    }
  }
}

class EpisodeCardChip extends StatelessWidget {
  const EpisodeCardChip({
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
            color: Colors.white, fontSize: 11.0, fontWeight: FontWeight.w400),
      ),
    );
  }
}

