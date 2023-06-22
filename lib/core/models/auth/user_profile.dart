class UserProfile {
  int? id;
  String? email;
  String? password;
  String? name;
  String? role;
  String? avatar;

  UserProfile({
    this.id,
    this.email,
    this.password,
    this.name,
    this.role,
    this.avatar,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        role: json["role"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "name": name,
        "role": role,
        "avatar": avatar,
      };

  @override
  String toString() {
    return 'UserProfile(id: $id, email: $email, password: $password, name: $name, role: $role, avatar: $avatar)';
  }
}
