class UserJWT {
  String? accessToken;
  String? refreshToken;

  UserJWT({
    this.accessToken,
    this.refreshToken,
  });

  factory UserJWT.fromJson(Map<String, dynamic> json) => UserJWT(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };

  @override
  String toString() => "UserJWT(access_token: $accessToken, refresh_token: $refreshToken)";
}
