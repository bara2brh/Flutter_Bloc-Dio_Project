import 'package:dio/dio.dart';
import '../../Constants/strings.dart';
import '../Models/character.dart';

class CharacterWebServices {
  late Dio _dio;

  CharacterWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
    );
    _dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await _dio.get('character');
      print(response.data.toString());
      return response.data['results'];
    } catch (e) {
      print(e.toString());
      return [];
    }

  }
}
