class UserNotFoundException implements Exception{
  final String message;

  UserNotFoundException(this.message);

  @override
  String toString() {
    return 'Error: $message';
  }
}

class UserDetailException implements Exception{
  final String message;

  UserDetailException(this.message);

  @override
  String toString() {
    return 'Error: $message';
  }
}

class TimeOutException implements Exception{
  final String message;

  TimeOutException(this.message);

  @override
  String toString() {
    return 'Error: $message';
  }
}