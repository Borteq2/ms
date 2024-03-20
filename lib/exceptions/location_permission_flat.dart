class LocationPermissionFlatException implements Exception {
  final String message;
  LocationPermissionFlatException(this.message);

  @override
  String toString() {
    return 'LocationPermissionFlatException: $message';
  }
}