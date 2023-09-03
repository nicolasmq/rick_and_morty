import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:choppi_prueba_tecnica/episodes/models/episode.dart';
import 'package:choppi_prueba_tecnica/services/repository/rick_and_morty_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  late Episode episode;
  late Episode newEpisode;
  int currentPage = 1;
  final ScrollController episodesScrollController = ScrollController();
  final RickAndMortyRepository rickAndMortyRepository;

  EpisodesBloc(this.rickAndMortyRepository) : super(const EpisodesInitial()) {
    on<EpisodesFetched>(_onEpisodeFetched,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onEpisodeFetched(
      EpisodesEvent event, Emitter<EpisodesState> emit) async {
    if (state.hasReachedMax) return;

    try {
    if (state is EpisodesInitial) {
      episode = await rickAndMortyRepository.getEpisodes();
      return emit(EpisodesLoaded(episode: episode));
    }
    currentPage++;
    final List<EpisodeData> episodeList = episode.episodeDataList!;
    final Info info = episode.info!;
    await Future.delayed(const Duration(milliseconds: 600));
    newEpisode =
        await rickAndMortyRepository.getEpisodes(currentPage: currentPage);
    episodeList.addAll(newEpisode.episodeDataList!);
    info.copyWith(next: newEpisode.info!.next);
    emit(EpisodesLoading(episode: newEpisode));
    emit(newEpisode.info!.next == null
        ? EpisodesLoaded(
            hasReachedMax: true,
            episode: newEpisode.copyWith(info: info, results: episodeList))
        : EpisodesLoaded(
            episode: newEpisode.copyWith(info: info, results: episodeList)));
    } catch (_) {
      emit(EpisodesFailure());
    }
  }
}
