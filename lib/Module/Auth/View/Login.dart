import 'package:learning_project/Constant/public_constant.dart';
import 'package:learning_project/Module/Auth/View/Register.dart';
import 'package:learning_project/Module/Auth/authcubit/authcubit.dart';
import 'package:learning_project/Module/Auth/authcubit/authstate.dart';
import 'package:learning_project/Module/home_page/View/home_page.dart';
import 'package:learning_project/Utils/App_color.dart';
import 'package:learning_project/Utils/Big_text.dart';
import 'package:learning_project/Utils/Small_text.dart';
import 'package:learning_project/Utils/defult_botton.dart';
import 'package:learning_project/Utils/defult_field_text.dart';
import 'package:learning_project/generated/l10n.dart';
 
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, Authstate>(
        listener: (context, state) {
          if (state is logInvalidate) {
            print("empty\n");
          }
          if (state is logInsucess) {
            customSnackBar(
              context: context,
              success: 1,
              message: S.of(context).sign_up_successfully_now_login,
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
          if (state is logInError) {
            customSnackBar(
              context: context,
              success: 0,
              message: S.of(context).Check_your_email_password,
            );
          }
          if (state is logInErrorConnection) {
            customSnackBar(
              context: context,
              success: 0,
              message: S.of(context).Check_connection,
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<AuthCubit, Authstate>(
            builder: (context, state) {
              AuthCubit cubit = AuthCubit.get(context);
              return Scaffold(
                backgroundColor: Colors.white,
                body: Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: ListView(
                    children: [
                      SizedBox(height: 20.h),
                      Center(child: BigText(S.of(context).login, size: 20.sp)),
                      Image.asset(
                        "assets/images/login.gif",
                        width: 250.w,
                        height: 250.h,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultFormText(
                              text: S.of(context).email,
                              prefix: Icon(Icons.email),
                              controller: cubit.emailLogctrl,
                              keyboard: TextInputType.emailAddress,
                              onChanged: (value) {
                                cubit.validEmail(value);
                                print(value);
                              },
                              error:
                                  cubit.showIsNotEmail
                                      ? S.of(context).Enter_valid_email
                                      : null,
                            ),

                            SizedBox(height: 15.h),
                            DefaultFormText(
                              prefix: Icon(Icons.password),
                              controller: cubit.passWordLogctrl,
                              text: S.of(context).password,
                              obscureText: cubit.obscuretext,
                              suffix: IconButton(
                                onPressed: () {
                                  cubit.showPassword();
                                },
                                icon: Icon(
                                  cubit.obscuretext
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Smalltext(
                                    S.of(context).FORGET_PASSWORD,
                                    color: AppColor.primeColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            state is logInLoading
                                ? Center(child: CircularProgressIndicator())
                                : DefaultBottom(
                                  onTap: () {
                                    cubit.logIn();
                                    print(state);
                                    if (state is logInsucess) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                        (route) => false,
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 30.0.w,
                                      right: 30.w,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColor.primeColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Smalltext(
                                          S.of(context).login,
                                          size: 20.sp,
                                        ),
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
                                onPressed: () => cubit.googleSignIn(),
                                icon: Image.asset(
                                  "assets/images/google.png",
                                  height: 50.h,
                                ),
                                label: const Text(
                                  "Log in with Google",
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: Smalltext(
                                    S.of(context).signin,
                                    color: AppColor.primeColor,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  //
}

void requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('🔐 Notification permission: ${settings.authorizationStatus}');
}

void getToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  print("📱 Device Token: $token");
}
