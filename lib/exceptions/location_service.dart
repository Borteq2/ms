class LocationServiceException implements Exception {
  final String message;
  LocationServiceException(this.message);

  @override
  String toString() {
    return 'LocationServiceException: $message';
  }
}