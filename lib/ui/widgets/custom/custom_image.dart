import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

import '../../constants/app_image.dart';
import 'custom_shimmer.dart';

class CustomImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxFit? fit;
  final bool showBlackGradient;
  final bool? zoomOnTap;
  final String? errorAssets;
  final BoxShape? boxShape;

  const CustomImage({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius,
    this.errorAssets,
    this.fit = BoxFit.cover,
    this.zoomOnTap = false,
    this.showBlackGradient = false,
    this.boxShape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (zoomOnTap ?? false)
          ? () => ZoomDialog(
                child: CustomImage(
                  url: url,
                  boxShape: boxShape,
                  errorAssets: errorAssets,
                  fit: fit,
                  height: height,
                  width: width,
                ),
              ).show(context)
          : null,
      child: Container(
        height: height ?? double.infinity,
        width: width ?? double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: boxShape != null ? null : (borderRadius ?? BorderRadius.circular(0.0)),
          shape: boxShape ?? BoxShape.rectangle,
        ),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            CachedNetworkImage(
              fit: fit!,
              imageUrl: url ?? '',
              placeholder: (context, string) => Container(
                alignment: Alignment.center,
                child: ShimmeringObject(radius: borderRadius ?? BorderRadius.circular(0.0)),
              ),
              errorWidget: (context, string, obj) => Image.asset(
                errorAssets ?? AppImage.imgNoImage,
                fit: BoxFit.cover,
              ),
            ),
            if (showBlackGradient)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.black.withOpacity(.7), Colors.transparent, Colors.black.withOpacity(.7)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
              )
          ],
        ),
      ),
    );
  }
}
