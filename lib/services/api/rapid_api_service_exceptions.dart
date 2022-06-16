// General
class UnknownResponseCode implements Exception {
  final int statusCode;
  UnknownResponseCode(this.statusCode);
}

class InternalServerError implements Exception {}

// Register
class UserAlreadyExists implements Exception {}

class WeakPassword implements Exception {}

// Login
class BadCredentials implements Exception {}
// class UserDoesNotExist implements Exception{}
// class WrongPassword implements Exception{}