class LocationPermissionPermanentException implements Exception {
  final String message;
  LocationPermissionPermanentException(this.message);

  @override
  String toString() {
    return 'LocationPermissionPermanentException: $message';
  }
}