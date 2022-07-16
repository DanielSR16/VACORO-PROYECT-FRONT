import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyUsername = 'id';

  static Future setId(String id) async =>
      await _storage.write(key: _keyUsername, value: id);

  static Future<String?> getId() async {
    return _storage.read(key: _keyUsername);
  }

  static Future deleteId(String id) async =>
      await _storage.delete(key: _keyUsername);
}