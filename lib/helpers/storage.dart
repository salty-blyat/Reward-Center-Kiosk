class InMemoryStorage {
  static final InMemoryStorage _instance = InMemoryStorage._();
  InMemoryStorage._();
  factory InMemoryStorage() => _instance;

  final Map<String, String> _store = {};

  void write(String key, String value) {
    _store[key] = value;
  }

  String? read(String key) {
    return _store[key];
  }

  void delete(String key) {
    _store.remove(key);
  }

  void deleteAll() {
    _store.clear();
  }
}
