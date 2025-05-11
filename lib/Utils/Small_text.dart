import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Smalltext extends StatelessWidget {
  String text;
  String? font;
  double size, letterSpacing;
  FontWeight weight;
  Color? color;
  Smalltext(this.text,
      {super.key,
      this.size = 16,
      this.weight = FontWeight.w300,
      this.color,
      this.font = "cairoBold",
      this.letterSpacing = 1});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis, // Shows "..."
      maxLines: 1, // Limits text to 1 line
      style: TextStyle(
        fontSize: size.sp,
        fontWeight: weight,
        fontFamily: font,
        color: color,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
