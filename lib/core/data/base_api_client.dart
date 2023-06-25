import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mauth_refresh_token/core/data/base_api_interface.dart';
import 'package:mauth_refresh_token/core/utils/cache/cache_manager.dart';

import '../models/auth/user_jwt.dart';
import '../utils/globals/logger.dart';
import 'api.dart';

class BaseAPIClient extends http.BaseClient implements BaseAPIInterface {
  final http.Client client;
  BaseAPIClient(this.client);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    clog('============================ REQUEST ============================');
    final resp = await CacheManager.instance.updateTokenFromStorage();

    if (resp.accessToken != null && resp.refreshToken != null) {
      request.headers.addAll({
        "Authorization": 'Bearer ${resp.accessToken}',
      });
      // request.headers.addAll({'Content-Type': 'application/json'});
    }

    return client.send(request).then((value) async {
      if (kDebugMode) {
        clog("REQUEST METHOD ${request.method} on : ${request.url}");
        clog("STATUS CODE = ${value.statusCode}");
        clog("============================ HEADERS ============================");
        clog(prettyJson(request.headers));
      }

      if (value.statusCode == 401) {
        final newToken = await refreshToken();

        if (newToken != null) {
          await CacheManager.instance.updateToken(newToken);
        }
      }

      return value;
    }).catchError((err) async {
      clog("========> CATCH ERROR BASEAPI on : ${err.toString()} <========");

      /// on socketexception
      /// on timeoutexception
      return http.StreamedResponse(Stream.fromIterable([err.toString().codeUnits]), 500);
    }).timeout(const Duration(seconds: 10));
  }

  Future<UserJWT?> authRefreshToken(String refresh) async {
    var body = {
      "refreshToken": refresh,
    };

    var response = await client.post(Uri.parse(Api.authRefreshToken), body: body);
    try {
      if (response.statusCode >= 199 && response.statusCode <= 300) {
        return UserJWT.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      throw jsonDecode(e.toString());
    }
    return null;
  }

  Future<UserJWT?> refreshToken() async {
    final cache = await CacheManager.instance.updateTokenFromStorage();
    final resp = await authRefreshToken(cache.refreshToken ?? '');

    if (resp != null) {
      return resp;
    } else {
      await CacheManager.instance.clear();
      return null;
    }
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    return super.get(url, headers: headers).then((value) {
      if (kDebugMode) {
        clog("============================ RESPONSE ===========================");
        if (value.statusCode == 200 || value.statusCode == 201) {
          if (value.body is Map<String, dynamic>) {
            clog(prettyJson(jsonDecode(value.body)));
          } else {
            clog(prettyJson(jsonDecode(value.body.toString())));
          }
        } else {
          clog(prettyJson(jsonDecode(value.body.toString())));
        }
        clog("\n");
        clog("\n=================================================================");
        clog("\n");
      }
      return value;
    }).catchError((err) {
      clog(err.toString());
      return err;
    });
  }

  @override
  Future<http.Response> post(Uri url, {Map<String, String>? headers, body, Encoding? encoding}) {
    return super.post(url, headers: headers, body: body, encoding: encoding).then((value) {
      if (kDebugMode) {
        clog("============================ BODY ===========================");
        clog(prettyJson(body));
        clog("============================ RESPONSE ===========================");
        if (value.statusCode == 200 || value.statusCode == 201) {
          if (value.body is Map<String, dynamic>) {
            clog(prettyJson(jsonDecode(value.body)));
          } else {
            clog(prettyJson(jsonDecode(value.body.toString())));
          }
        } else {
          clog(prettyJson(jsonDecode(value.body.toString())));
        }
        clog("\n");
        clog("\n=================================================================");
        clog("\n");
      }
      return value;
    }).catchError((err) {
      clog(err.toString());
      return err;
    });
  }
}
