import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../constants/app_color.dart';

class AdaptiveProgressIndicator extends StatelessWidget {
  final Color? color;

  const AdaptiveProgressIndicator({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || Platform.isAndroid) {
      return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(color ?? AppColor.primaryColor));
    } else {
      return CupertinoActivityIndicator(color: color ?? AppColor.primaryColor);
    }
  }

  static Widget loadingWidget() {
    return Container(
      padding: const EdgeInsets.all((20)),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: const AdaptiveProgressIndicator(),
    );
  }
}
