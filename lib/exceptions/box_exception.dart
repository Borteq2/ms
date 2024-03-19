class BoxException implements Exception {
  final String message;
  BoxException(this.message);

  @override
  String toString() {
    return 'BoxException: $message';
  }
}