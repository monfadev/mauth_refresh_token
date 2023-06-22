import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

void clog(dynamic object) => kDebugMode ? log(object.toString()) : null;
void cprint(dynamic object) =>
    kDebugMode ? debugPrint(object.toString()) : null;

String prettyJson(dynamic json) {
  var spaces = ' ' * 4;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}
