import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:choppi_prueba_tecnica/model/episode.dart';
import 'package:choppi_prueba_tecnica/services/repository/rick_and_morty_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  late Episode episode;
  late Episode newEpisode;
  int currentPage = 1;
  final ScrollController episodesScrollController = ScrollController();
  final RickAndMortyRepository rickAndMortyRepository;

  EpisodesBloc(this.rickAndMortyRepository) : super(EpisodesInitial()) {
    episodesScrollController.addListener(() {
      if (episodesScrollController.position.atEdge && episodesScrollController.position.pixels > 0.0) {

        add(AddNextPageEpisodesEvent(state.episode!.episodeDataList!, currentPage++));
      }
    });
    on<AddEpisodesEvent>((event, emit) async {
      print('entramos');
      if(!state.isLogged) return;
      emit(LoadingEpisodes());
      await Future.delayed(const Duration(milliseconds: 2000));
      episode = await rickAndMortyRepository.getEpisodes(currentPage: state.currentPage);
      emit(LoadedEpisodes(episode, 1));
    });

    on<AddNextPageEpisodesEvent>((event, emit)  async {
      print('entramos 2');
      if(!state.isLogged) return;
      if(state.currentPage == 3) return;
      final List<EpisodeData> moreResults = state.episode!.episodeDataList!;
      final Info newInfo = state.episode!.info!;
      emit(LoadingMoreEpisodes(state.episode!));
      fetchData();
      newEpisode = await rickAndMortyRepository.getEpisodes(currentPage: currentPage);
      moreResults.addAll(newEpisode.episodeDataList!);
      newInfo.copyWith(next: newEpisode.info!.next, prev: newEpisode.info!.prev);
      emit(LoadedEpisodes(state.episode!.copyWith(results: moreResults, info: newInfo ), currentPage));
      state.currentPage = currentPage;
    });
  }

  Future fetchData() async {
    const duration = Duration(milliseconds: 500);
    Timer(duration, response);
  }
  void response() {
    episodesScrollController.animateTo(episodesScrollController.position.pixels + 200,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastOutSlowIn);
  }




}
