import 'package:learning_project/Constant/public_constant.dart';
import 'package:learning_project/Module/Adress/cubit/address_state.dart';
import 'package:learning_project/Module/Auth/authcubit/authcubit.dart';
import 'package:learning_project/Module/Auth/authcubit/authstate.dart';
import 'package:learning_project/Module/Verify/View/verify_page.dart';
import 'package:learning_project/Module/Verify/cubit/cubit/verify_cubit.dart';
import 'package:learning_project/Utils/App_color.dart';
import 'package:learning_project/Utils/Small_text.dart';
import 'package:learning_project/Utils/defult_botton.dart';
import 'package:learning_project/Utils/defult_field_text.dart';
import 'package:learning_project/generated/l10n.dart';
 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, Authstate>(
        listener: (context, state) {
          if (state is signUpSuccess) {
            print("///////////");
            print(VerifyCubit().nameCtrl.text);
            customSnackBar(
              context: context,
              success: 1,
              message: S.of(context).Verify_Code_Send,
            );
            pushTo(
              context: context,
              toPage: BlocProvider.value(
                value: VerifyCubit.get(context),
                child: VerifyPage(),
              ),
            );
          }
          if (state is signUpError) {
            customSnackBar(
              context: context,
              success: 0,
              message: state.message,
            );
          }
        },
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: ListView(
                children: [
                  SizedBox(height: 20.h),
                  Center(child: Smalltext(S.of(context).signin, size: 20)),
                  Center(
                    child: Image.asset(
                      "assets/images/login.gif",
                      width: 250.w,
                      height: 250.h,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultFormText(
                        text: S.of(context).name,
                        prefix: Icon(Icons.person),
                        controller: cubit.nameCtrl,
                        keyboard: TextInputType.name,
                      ),
                      SizedBox(height: 10.h),
                      DefaultFormText(
                        text: S.of(context).ENTER_YOUR_EMAIL,
                        prefix: Icon(Icons.email),
                        controller: cubit.emailCtrl,
                        keyboard: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 10.h),
                      DefaultFormText(
                        text: S.of(context).password,
                        prefix: Icon(Icons.lock),
                        controller: cubit.passwordCtrl,
                        obscureText: cubit.obscuretext,
                        suffix: IconButton(
                          onPressed: () => cubit.showPassword(),
                          icon: Icon(
                            cubit.obscuretext
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      DefaultFormText(
                        text: S.of(context).password_confirmation,
                        prefix: Icon(Icons.lock),
                        controller: cubit.confirmPasswordCtrl,
                        obscureText: cubit.obscuretext,
                        suffix: IconButton(
                          onPressed: () => cubit.showPassword(),
                          icon: Icon(
                            cubit.obscuretext
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      state is signUpLoading || state is AddressLoading
                          ? Center(child: CircularProgressIndicator())
                          : DefaultBottom(
                            onTap: () {
                              cubit.signUp();
                              if (state is signUpSuccess) {
                                //   VerifyCubit().nameCtrl.text =
                                //       cubit.nameCtrl.text;
                                //       VerifyCubit().emailCtrl.text =
                                //       cubit.emailCtrl.text;
                                //       VerifyCubit().passwordCtrl.text =
                                //       cubit.passwordCtrl.text;
                                //       VerifyCubit().confirmPasswordCtrl.text =
                                //       cubit.confirmPasswordCtrl.text;
                                //
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColor.primeColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Smalltext(
                                  S.of(context).signin,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          ),
                      SizedBox(height: 20.h),
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide(color: AppColor.primeColor),
                          ),
                          onPressed: () => cubit.signUpWithGoogle(),
                          icon: Image.asset(
                            "assets/images/google.png",
                            height: 50.h,
                          ),
                          label: Text(
                            S.of(context).sign_up_with_Google,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Smalltext(S.of(context).NO_ACCOUNT),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Smalltext(
                              S.of(context).login,
                              color: AppColor.primeColor,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
