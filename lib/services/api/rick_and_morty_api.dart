import 'package:choppi_prueba_tecnica/characters/models/character.dart';
import 'package:choppi_prueba_tecnica/episodes/models/episode.dart';
import 'package:dio/dio.dart';

class RickAndMortyApi {

  Dio dio = Dio();

  Future<Character> getCharacters({int? currentPage = 1}) async {

    Response response;
    try {
      response = await dio.get(
          'https://rickandmortyapi.com/api/character/?page=$currentPage');

      return Character.fromMap(response.data);
    } catch (e) {
      print(e);
    }
    return Character();
  }

  Future<Character?> filterCharacters({String? name}) async {
    Response response;
    try {
      response =
      await dio.get('https://rickandmortyapi.com/api/character/?name=$name');

      return Character.fromMap(response.data);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Episode> getEpisodes({int? currentPage = 1}) async {

    Response response;
    response = await dio.get('https://rickandmortyapi.com/api/episode?page=$currentPage');


    return Episode.fromMap(response.data);
  }
}