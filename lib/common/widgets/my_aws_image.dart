import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAwsImage extends StatelessWidget {
  MyAwsImage(
    this.imageUrl, {
    Key? key,
    this.height = 480,
    this.width = 720,
    this.cacheHeight = 480,
    this.cacheWidth = 720,
    this.fit = BoxFit.cover,
    this.isProfilePic = false,
    this.borderRadius = 0,
    this.placeholder,
    this.isCircular = false,
    this.errorWidget,
  }) : super(key: key);
  final double? height;
  final double? width;
  final int? cacheHeight;
  final int? cacheWidth;
  final String imageUrl;
  final BoxFit? fit;
  final double borderRadius;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget? errorWidget;
  final bool isProfilePic;
  final awsImageUrl = ''.obs;
  final bool isCircular;

  @override
  Widget build(BuildContext context) {
    final fileNameWithExt = imageUrl.split('/').last;
    final awsFolderPath = imageUrl.replaceAll('/$fileNameWithExt', '');
    return SizedBox(
      height: height,
      width: width,
      // child: GetImageFile(
      //   awsFolderPath: awsFolderPath,
      //   fileNameWithExt: fileNameWithExt,
      //   fit: fit,
      //   errorWidget: errorWidget,
      // ),
    );
    // return CachedNetworkImage(
    //   imageUrl: imageUrl.contains('http') ? imageUrl : '',
    //   progressIndicatorBuilder: _imageLoader,
    //   errorWidget: (context, error, stackTrace) =>
    //       errorWidget ??
    //       const MySimmerWidget.rectanguler(
    //         borderRadius: 0,
    //       ),
    //   height: height,
    //   width: width,
    //   memCacheHeight: cacheHeight,
    //   memCacheWidth: cacheWidth,
    //   maxHeightDiskCache: cacheHeight,
    //   maxWidthDiskCache: cacheWidth,
    //   fit: fit,
    // );
  }
}
