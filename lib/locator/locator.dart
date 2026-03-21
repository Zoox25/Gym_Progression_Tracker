class Locator {
  static final Locator _instance = Locator._internal();
  Locator._internal();
  factory Locator() => _instance;

  final Map<Type, dynamic> _services = {};

  void register<T>(T service) {
    _services[T] = service;
  }

  T get<T>() => _services[T] as T;
}

final locator = Locator();
