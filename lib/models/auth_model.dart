
enum UserStatus { active, inactive }
enum UserRole { guest, worker, manager, admin, headAdmin }

extension UserRoleExtension on UserRole {
  static UserRole fromInt(int value) {
    return UserRole.values[value];
  }
}

class AuthModel {
  final String token;
  final String fullname;
  final String email;
  final UserRole role;
  final UserStatus status;
  AuthModel({required this.fullname, required this.email, required this.role, required this.status, required this.token});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    print("AuthModel.fromJson");
    print(json);
    return AuthModel(
      token: json['token'],
      fullname: json['fullname'],
      email: json['email'],
      role: UserRoleExtension.fromInt(json['role']),
      status: UserStatus.values.firstWhere((e) => e.name == json['status']),
    );
  }

}