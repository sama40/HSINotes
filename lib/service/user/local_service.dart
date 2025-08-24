import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:light_notes/model/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ulid/ulid.dart';

class UserLocalService {
  UserLocalService._();

  static Future<Box> get _box async {
    final path = await getTemporaryDirectory();

    Hive.init(path.path);

    return await Hive.openBox('user');
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final ulid = Ulid().toString();

      final data = UserModel(
        id: ulid,
        name: name,
        email: email,
        password: password,
      );

      final box = await _box;

      await box.put(ulid, jsonEncode(data.toJson()));

      await box.put('authentication', ulid);

      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<UserModel?> user() async {
    try {
      final box = await _box;

      final token = await box.get('authentication');

      if (token != null && token is String) {
        final data = await box.get(token);
        if (data != null && data is String) {
          return UserModel.fromJson(jsonDecode(data));
        }

        return null;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
