import '../errors/user_errors.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String jobTitle;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
  });

  static List<UserModel> fromMapList(dynamic mapList) {
    if (mapList is! List) {
      throw const UserListIsNull();
    }
    return mapList.map((e) => UserModel.fromMap(e)).toList();
  }

  factory UserModel.fromMap(dynamic map) {
    if (map is! Map || map.isEmpty) {
      throw const UserDataIsUnavailable();
    }
    final id = map['id'];
    if (id is! String || id.isEmpty) {
      throw const UserMissingAttribute('id');
    }
    final firstName = map['firstName'];
    if (firstName is! String || firstName.isEmpty) {
      throw const UserMissingAttribute('firstName');
    }
    final lastName = map['lastName'];
    if (lastName is! String || lastName.isEmpty) {
      throw const UserMissingAttribute('lastName');
    }
    final jobTitle = map['jobTitle'];
    if (jobTitle is! String || jobTitle.isEmpty) {
      throw const UserMissingAttribute('jobTitle');
    }
    return UserModel(id: id, firstName: firstName, lastName: lastName, jobTitle: jobTitle);
  }

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'firstName':firstName,
      'lastName':lastName,
      'jobTitle':jobTitle
    };
  }
}
