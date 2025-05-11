 import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:learning_project/Utils/Small_text.dart';

class DefaultFormText extends StatelessWidget {
  final String text;
  final String hinttext;
  final String? error;
  final Widget? suffix;
  final Widget? prefix;
  final TextEditingController controller;
  final TextInputType? keyboard;
  final bool readonly;
  final bool obscureText;
  final TextAlign textAlign;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  const DefaultFormText({
    super.key,
    required this.text,
    required this.controller,
    this.hinttext = '',
    this.suffix,
    this.prefix,
    this.keyboard,
    this.readonly = false,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.onTap,
    this.error,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Smalltext(text, size: 13.sp),
        SizedBox(height: 5.h),
        TextFormField(
          readOnly: readonly,
          controller: controller,
          keyboardType: keyboard,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          textAlign: textAlign,
          onTap: onTap,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
          decoration: InputDecoration(
            fillColor: Colors.white,
            hintText: hinttext,
            hintStyle: TextStyle(color: Colors.grey[600]),
            suffixIcon: suffix,
            prefixIcon: prefix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
      ],
    );
  }
}
