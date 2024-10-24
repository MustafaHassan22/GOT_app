import 'package:breaking_bad/constanst/strings.dart';
import 'package:breaking_bad/data/models/characters_model.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('Characters');
      // print(response.data.toString());
      return response.data;
    } catch (e) {
      // print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getCharacterContinent(int charId) async {
    try {
      Response response =
          await dio.get('Continents', queryParameters: {'char Id': charId});
      // print('ddd' + response.data.toString());

      // print('API Response: ${response.data.toString()}');
      // print('Continent Name: ${data['name']}');

      print(response.data.toString());
      return response.data;
    } catch (e) {
      // print(e.toString());
      return [];
    }
  }
}
