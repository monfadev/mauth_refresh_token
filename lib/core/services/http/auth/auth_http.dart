import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mauth_refresh_token/core/models/auth/user_jwt.dart';
import 'package:mauth_refresh_token/core/models/auth/user_profile.dart';

import '../../../../ui/constants/app_string.dart';
import '../../../data/api.dart';
import '../../../data/base_api_client.dart';
import '../../../models/api/message_response_model.dart';
import 'auth_interface.dart';

class AuthHttp extends BaseAPIClient implements AuthInterface {
  AuthHttp(super.client);

  @override
  Future<Either<MessageResponseModel, UserJWT>> login(String email, String password) async {
    var body = {
      "email": email,
      "password": password,
    };

    var response = await client.post(Uri.parse(Api.authLogin), body: body);

    try {
      if (response.statusCode >= 199 && response.statusCode <= 300) {
        final model = UserJWT.fromJson(jsonDecode(response.body));
        return Right(model);
      }

      return Left(MessageResponseModel.fromJson(jsonDecode(response.body)));
    } catch (e) {
      return Left(MessageResponseModel(status: 500, message: AppString.statusNotFound));
    }
  }

  @override
  Future<Either<MessageResponseModel, UserProfile>> authProfile() async {
    var response = await client.get(Uri.parse(Api.authProfile));

    try {
      if (response.statusCode >= 199 && response.statusCode <= 300) {
        final model = UserProfile.fromJson(jsonDecode(response.body));
        return Right(model);
      }

      return Left(MessageResponseModel.fromJson(jsonDecode(response.body)));
    } catch (e) {
      return Left(MessageResponseModel(status: 500, message: AppString.statusNotFound));
    }
  }
}
