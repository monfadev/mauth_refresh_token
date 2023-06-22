import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mauth_refresh_token/core/viewmodels/auth/user_provider.dart';

import 'core/data/base_api_client.dart';
import 'core/data/base_api_interface.dart';
import 'core/services/http/auth/auth_http.dart';
import 'core/services/http/auth/auth_interface.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  /// Registering api
  if (locator.isRegistered(instance: http.Client()) == false) {
    locator.registerSingleton(http.Client());
  }

  if (locator.isRegistered(instance: BaseAPIClient(locator<http.Client>())) == false) {
    locator.registerSingleton(BaseAPIClient(locator<http.Client>()));
  }

  /// Registering repository & services
  locator.registerLazySingleton<BaseAPIInterface>(() => BaseAPIClient(locator()));
  locator.registerLazySingleton<AuthInterface>(() => AuthHttp(locator<BaseAPIClient>()));

  /// Registering provider
  locator.registerFactory<UserProvider>(() => UserProvider(locator()));
}
