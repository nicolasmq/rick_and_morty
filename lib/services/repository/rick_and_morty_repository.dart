

import 'package:choppi_prueba_tecnica/model/character.dart';
import 'package:choppi_prueba_tecnica/model/episode.dart';
import 'package:choppi_prueba_tecnica/services/api/rick_and_morty_api.dart';

class RickAndMortyRepository {

  final _rickAndMortyApi = RickAndMortyApi();

  Future<Character> getCharacters({int? currentPage = 1}) => _rickAndMortyApi.getCharacters(currentPage: currentPage);
  Future<Episode> getEpisodes({int? currentPage = 1}) => _rickAndMortyApi.getEpisodes(currentPage: currentPage);
  Future<Character> filterCharacters({String? name}) => _rickAndMortyApi.filterCharacters(name: name);
}