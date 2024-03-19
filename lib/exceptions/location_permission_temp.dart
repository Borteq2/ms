class LocationPermissionTemporaryException implements Exception {
  final String message;
  LocationPermissionTemporaryException(this.message);

  @override
  String toString() {
    return 'LocationPermissionTemporaryException: $message';
  }
}