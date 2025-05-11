import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class DefaultBottom extends StatelessWidget {
  DefaultBottom({
    super.key,
    required this.onTap,
    this.height = 50,
    this.width = double.infinity,
    // this.color = AppColor.primeColor,
    this.radius = 20,
    this.alignment = Alignment.center,
    this.child,
  });
  void Function() onTap;
  double height, radius;
  double? width;
  Color? color;
  Widget? child;
  Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: alignment,
        height: height.h,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius.r),
        ),
        child: child,
      ),
    );
  }
}
