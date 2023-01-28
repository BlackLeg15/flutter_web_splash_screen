abstract class UserError {
  final String message;

  const UserError(this.message);

  @override
  String toString() => message;
}

class UserMissingAttribute extends UserError {
  const UserMissingAttribute(String attribute) : super("User's $attribute is missing");
}

class UserListIsNull extends UserError {
  const UserListIsNull() : super("User list is null");
}

class UserDataIsUnavailable extends UserError {
  const UserDataIsUnavailable() : super("User data is unavailable");
}

class UserUnknownError extends UserError {
  const UserUnknownError(super.message);
}
