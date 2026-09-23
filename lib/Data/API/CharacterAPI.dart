import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/Constants/Strings.dart';

class Characterapi {
  late Dio dio;
  Characterapi() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);

  }
  Future<Map<String,dynamic>> getAllCharacters() async {
    try {
      print('START API');

      Response response = await dio.get('character');

      return response.data;
    } catch (e) {
      return {};
    }
  }
}