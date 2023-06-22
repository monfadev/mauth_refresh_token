import 'package:flutter/material.dart';

import '../../../core/utils/globals/extensions.dart';
import '../../../core/utils/globals/navigations.dart';
import '../../constants/app_color.dart';

_getSnackbar({
  String? title,
  Widget? icon,
  Color? color,
  bool floating = false,
  bool isError = false,
  BuildContext? context,
}) {
  return SnackBar(
    duration: Duration(seconds: isError ? 3 : 2),
    behavior: floating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
    margin: floating ? const EdgeInsets.only(bottom: 30, left: 17, right: 17) : null,
    content: Row(
      children: [
        icon ?? const SizedBox.shrink(),
        icon != null ? const SizedBox(width: 10) : const SizedBox.shrink(),
        Expanded(
          child: Text(title!, maxLines: 10, overflow: TextOverflow.ellipsis, style: context?.labelMedium?.copyWith(color: Colors.white)),
        ),
      ],
    ),
    backgroundColor: color ?? AppColor.darkBackground,
  );
}

showSnackbar({
  required String? title,
  Icon? icon,
  Color? color,
  bool floating = false,
  bool isError = false,
}) =>
    ScaffoldMessenger.of(
      navigate.navigatorKey.currentContext!,
    ).showSnackBar(_getSnackbar(title: title, icon: icon, color: color, floating: floating, isError: isError));
