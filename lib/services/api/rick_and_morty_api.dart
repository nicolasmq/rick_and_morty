import 'package:choppi_prueba_tecnica/model/character.dart';
import 'package:choppi_prueba_tecnica/model/episode.dart';
import 'package:dio/dio.dart';

class RickAndMortyApi {

  Dio dio = Dio();

  Future<Character> getCharacters({int? currentPage = 1}) async {
    print('Get Characters');
    Response response;
    try {
      response = await dio.get(
          'https://rickandmortyapi.com/api/character/?page=$currentPage');
      print(response.statusCode);

      return Character.fromMap(response.data);
    } catch (e) {
      print(e.toString());
    }
    return Character();
  }

  Future<Character> filterCharacters({String? name}) async {
    print('Filter Character');
    Response response;
    response = await dio.get('https://rickandmortyapi.com/api/character/?name=$name');
    print(response.data);

    return Character.fromMap(response.data);
  }

  Future<Episode> getEpisodes({int? currentPage = 1}) async {
    print('Get Episodes');
    Response response;
    response = await dio.get('https://rickandmortyapi.com/api/episode?page=$currentPage');
    print(response.data);

    return Episode.fromMap(response.data);
  }
}