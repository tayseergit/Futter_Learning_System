
class UsererResponse {
  final User user;
  final String token;

  UsererResponse({required this.user, required this.token});

  factory UsererResponse.fromJson(Map<String, dynamic> json) {
    return UsererResponse(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': user.toJson(), 'token': token};
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final dynamic emailVerifiedAt;
  final dynamic image;
  final String addressId;
  final int roleId;
  // final String createdAt;
  // final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.image,
    required this.addressId,
    required this.roleId,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      image: json['image'],
      addressId: json['address_id'],
      roleId: json['role_id'],
      // createdAt: DateTime.parse(json['created_at']),
      // updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'image': image,
      'address_id': addressId,
      'role_id': roleId,
      // 'created_at': createdAt.toIso8601String(),
      // 'updated_at': updatedAt.toIso8601String(),
    };
  }
}
