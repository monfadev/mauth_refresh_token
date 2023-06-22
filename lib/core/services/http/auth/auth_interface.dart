import 'package:dartz/dartz.dart';
import 'package:mauth_refresh_token/core/models/api/message_response_model.dart';
import 'package:mauth_refresh_token/core/models/auth/user_profile.dart';

import '../../../models/auth/user_jwt.dart';

abstract class AuthInterface {
  Future<Either<MessageResponseModel, UserJWT>> login(String email, String password);
  Future<Either<MessageResponseModel, UserProfile>> authProfile();
}
