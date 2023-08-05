

import 'package:choppi_prueba_tecnica/model/character.dart';
import 'package:choppi_prueba_tecnica/services/api/rick_and_morty_api.dart';

class RickAndMortyRepository {

  final _rickAndMortyApi = RickAndMortyApi();

  Future<Character> getCharacters(int currentPage) => _rickAndMortyApi.getCharacters(currentPage);
}