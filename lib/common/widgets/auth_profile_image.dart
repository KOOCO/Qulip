import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qulip/common/widgets/my_aws_image.dart';

class AuthProfileImage extends StatelessWidget {
  const AuthProfileImage({
    super.key,
    required this.imageSize,
    this.borderSize = 2.0,
    this.borderColor = Colors.white,
    this.networkImage,
    this.isShowShadow = true,
    this.imageBytes,
    this.errorWidget,
  });

  final double imageSize;
  final double borderSize;
  final Color borderColor;
  final String? networkImage;
  final bool isShowShadow;
  final Uint8List? imageBytes;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(imageSize / 2),
        boxShadow: [
          if (isShowShadow)
            BoxShadow(blurRadius: 5, color: Colors.grey.shade500),
          BoxShadow(color: borderColor, spreadRadius: borderSize),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(imageSize / 2),
        child: imageBytes != null
            ? Image.memory(imageBytes!)
            : networkImage != null
                ? MyAwsImage(
                    networkImage ?? '',
                    placeholder: (p0, p1) {
                      return _placeHolder();
                    },
                    errorWidget: errorWidget ?? _placeHolder(),
                  )
                : _placeHolder(),
      ),
    );
  }

  Widget _placeHolder() {
    return Container(
      color: Colors.grey.shade300,
      child: Icon(
        Icons.person,
        size: max(imageSize - 30, 10),
        color: Colors.grey,
      ),
    );
  }
}
