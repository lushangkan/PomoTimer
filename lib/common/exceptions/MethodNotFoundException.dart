class MethodNotFoundException implements Exception {
  final dynamic message;

  MethodNotFoundException(this.message);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "MethodNotFoundException";
    return "MethodNotFoundException: $message";
  }
}