import 'package:dio/dio.dart';
import 'package:light_notes/exception/server_exception.dart';
import 'package:light_notes/model/note_model.dart';
import 'package:light_notes/service/note/note_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteApiServiceImpl implements NoteService {
  Future<Dio> get _dio async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');

    final dio = Dio()
      ..options = BaseOptions(
        baseUrl: 'https://hsinote.donisaputra.com/api',
        headers: {
          if (token != null) 'AUTHORIZATION': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

    dio.interceptors.add(LogInterceptor(responseBody: true));

    return dio;
  }

  @override
  Future<bool> create({required String title, required String content}) async {
    try {
      final dio = await _dio;

      final response = await dio.post(
        '/notes',
        data: {'title': title, 'content': content},
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } on DioException catch (e) {
      throw ServerException(e.response?.data['meta']['message']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<NoteModel>> notes() async {
    try {
      final dio = await _dio;

      final response = await dio.get('/notes');

      final datas = List.from(response.data['data']);

      return datas.map((e) => NoteModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerException(e.response?.data['meta']['message']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> update({
    required String id,
    required String title,
    required String content,
  }) async {
    try {
      final dio = await _dio;

      final response = await dio.put(
        '/notes/$id',
        data: {'title': title, 'content': content},
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } on DioException catch (e) {
      throw ServerException(e.response?.data['meta']['message']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> delete(String id) async {
    try {
      final dio = await _dio;

      final response = await dio.delete('/notes/$id');

      return response.statusCode == 200 || response.statusCode == 201;
    } on DioException catch (e) {
      throw ServerException(e.response?.data['meta']['message']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
