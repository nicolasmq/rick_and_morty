import 'package:choppi_prueba_tecnica/model/character.dart';
import 'package:dio/dio.dart';

class RickAndMortyApi {

  Dio dio = Dio();

  Future<Character> getCharacters(int currentPage) async {
    print('Get Characters');
    Response response;
    response = await dio.get('https://rickandmortyapi.com/api/character/?page=$currentPage');
    print(response.data);

    return Character.fromMap(response.data);
  }
}