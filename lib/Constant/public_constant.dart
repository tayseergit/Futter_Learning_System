import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 
import 'package:page_transition/page_transition.dart';
 
List<BoxShadow>? boxShadow = [
  BoxShadow(
    color: Colors.grey.shade400,
    offset: const Offset(0, 0.5),
    blurRadius: 1.5,
    spreadRadius: 1,
  )
];

List<BoxShadow>? textShadow = const [
  BoxShadow(
    color: Colors.black,
    offset: Offset(0, 0.5),
    blurRadius: 1.5,
    spreadRadius: 1,
  )
];

Future<dynamic> pushTo(
    {required BuildContext context, required Widget toPage}) async {
  return await Navigator.of(context).push(PageTransition(
      duration: const Duration(milliseconds: 450),
      child: toPage,
      type: PageTransitionType.rightToLeft));
}

void pushAndRemoveUntiTo(
    {required BuildContext context,
    required Widget toPage,
    PageTransitionType? pageTransitionType,
    int? milliseconds}) {
  Navigator.of(context).pushAndRemoveUntil(
    PageTransition(
      child: toPage,
      type: pageTransitionType ?? PageTransitionType.rightToLeft,
      duration: Duration(milliseconds: milliseconds ?? 500),
    ),
    (route) => false,
  );
}

void pushReplacement(
    {required BuildContext context,
    required Widget toPage,
    PageTransitionType? pageTransitionType,
    int? milliseconds}) {
  Navigator.of(context).pushReplacement(
    PageTransition(
      child: toPage,
      type: pageTransitionType ?? PageTransitionType.rightToLeft,
      duration: Duration(milliseconds: milliseconds ?? 500),
    ),
  );
}

void customSnackBar(
    {required BuildContext context,
    required int success,
    required String message,
    double horPadding = 14,
    double verPadding = 14}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        dismissDirection: DismissDirection.horizontal,
        duration: const Duration(seconds: 2),
        margin: EdgeInsets.symmetric(
            vertical: verPadding.w, horizontal: horPadding.w),
        backgroundColor: success == 0
            ? Colors.red
            : success == 1
                ? Colors.green
                : Colors.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        behavior: SnackBarBehavior.floating,
        content: ElasticIn(
          child: Text(
            message,
            textAlign: TextAlign.center,
           ),
        )),
  );
}
