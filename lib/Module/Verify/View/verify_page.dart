import 'package:learning_project/Constant/public_constant.dart';
import 'package:learning_project/Module/Verify/cubit/cubit/verify_cubit.dart';
import 'package:learning_project/Module/home_page/View/home_page.dart';
import 'package:learning_project/Utils/App_color.dart';
import 'package:learning_project/Utils/Big_text.dart';
import 'package:learning_project/Utils/Small_text.dart';
import 'package:learning_project/generated/l10n.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 
import 'package:pinput/pinput.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyCubit, VerifyState>(
      listener: (context, state) {
        if (state is VerifyError) {}
        if (state is VerifySuccess) {
          pushAndRemoveUntiTo(context: context, toPage: HomePage());
          customSnackBar(
            context: context,
            success: 1,
            message: S.of(context).sign_up_successfully_now_login,
          );
        }
      },
      builder: (context, state) {
        VerifyCubit cubit = VerifyCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              children: [
                SizedBox(height: 100.h),
                Center(
                  child: BigText(
                    S.of(context).Verify_Code,
                    weight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.h),

                // New OTP Field
                Pinput(
                  length: 5,
                  controller: _otpController,
                  defaultPinTheme: PinTheme(
                    width: 50.w,
                    height: 60.h,
                    textStyle: TextStyle(fontSize: 20.sp),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.primeColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    cubit.setCode(value);
                  },
                  onCompleted: (value) {
                    cubit.verifyCode();
                  },
                ),
                SizedBox(height: 20.h),

                // Verify button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        state is VerifyButtonActive
                            ? AppColor.primeColor
                            : AppColor.lightprimeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(double.infinity, 50.h),
                  ),
                  onPressed:
                      state is VerifyButtonActive
                          ? () => cubit.verifyCode()
                          : null,
                  child: Smalltext(
                    S.of(context).VERIFY,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
