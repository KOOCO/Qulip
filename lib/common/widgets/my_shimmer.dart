// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:property_panda/common/colors.dart';
// import 'package:shimmer/shimmer.dart';

// class MySimmerWidget extends StatelessWidget {
//   const MySimmerWidget.rectanguler({
//     Key? key,
//     this.height = 100,
//     this.width = 100,
//     this.borderRadius,
//   })  : shape = BoxShape.rectangle,
//         super(key: key);
//   const MySimmerWidget.circular({
//     Key? key,
//     required this.height,
//     required this.width,
//     this.borderRadius,
//   })  : shape = BoxShape.circle,
//         super(key: key);
//   final double height;
//   final double width;
//   final BoxShape shape;
//   final double? borderRadius;

//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: shadowColor,
//       highlightColor: lightGrey,
//       child: Container(
//         width: width,
//         height: height,
//         decoration: shape == BoxShape.circle
//             ? BoxDecoration(
//                 color: shadowColor,
//                 shape: shape,
//               )
//             : BoxDecoration(
//                 color: shadowColor,
//                 shape: shape,
//                 borderRadius: BorderRadius.circular(borderRadius ?? 15.h),
//               ),
//       ),
//     );
//   }
// }
