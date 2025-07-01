class OrderSaveException implements Exception {
  final String message;
  OrderSaveException(this.message);

  @override
  String toString() => 'OrderSaveException: $message';
}

class OrderLoadException implements Exception {
  final String message;
  OrderLoadException(this.message);

  @override
  String toString() => 'OrderLoadException: $message';
}

class OrderClearException implements Exception {
  final String message;
  OrderClearException(this.message);

  @override
  String toString() => 'OrderClearException: $message';
}