import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class BaseAPIInterface {
  Future<http.StreamedResponse> send(http.BaseRequest request);
  Future<http.Response> get(Uri url, {Map<String, String>? headers});
  Future<http.Response> post(Uri url, {Map<String, String>? headers, body, Encoding? encoding});
}
