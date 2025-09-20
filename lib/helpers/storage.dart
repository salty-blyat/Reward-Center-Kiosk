import 'dart:io';
import 'dart:convert';

class StorageKeys {
  static String member = "member";
  static String selectedLocation = "selected_location";
  static String company = "company";
}

class InMemoryStorage {
  static final InMemoryStorage _instance = InMemoryStorage._();
  InMemoryStorage._();
  factory InMemoryStorage() => _instance;

  final String _fileName = 'temp_storage.json';

  File get _file => File('${Directory.systemTemp.path}/$_fileName');

  Future<void> write(String key, dynamic value) async {
    Map<String, dynamic> data = await _readFile() ?? {};
    data[key] = value;
    await _file.writeAsString(jsonEncode(data));
  }

  Future<dynamic> read(String key) async {
    final data = await _readFile();
    return data?[key];
  }

  Future<T?> loadDataAsync<T>(
      String key, Function(Map<String, dynamic>) fromJson) async {
    final data = await read(key);

    if (data == null) return null;
    if (data is String) {
      final Map<String, dynamic> map = jsonDecode(data);
      final model = fromJson(map);
      return model;
    }
    return null;
  }

  Future<void> delete(String key) async {
    final data = await _readFile() ?? {};
    data.remove(key);
    await _file.writeAsString(jsonEncode(data));
  }

  Future<void> deleteAll() async {
    if (await _file.exists()) {
      await _file.delete();
    }
  }

  Future<Map<String, dynamic>?> _readFile() async {
    if (!await _file.exists()) return null;
    final content = await _file.readAsString();
    return jsonDecode(content);
  }
}
