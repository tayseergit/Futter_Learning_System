import 'package:learning_project/Constant/public_constant.dart';
import 'package:learning_project/Module/Auth/View/Login.dart';
import 'package:learning_project/Module/Languages/Cubit/cubit/lang_cubit.dart';
import 'package:learning_project/Utils/App_color.dart';
import 'package:learning_project/generated/l10n.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LangCubit, LangState>(
      listener: (context, state) {
        if (state is SavedLang) {
          pushAndRemoveUntiTo(context: context, toPage: LoginPage());
        }
      },
      builder: (context, state) {
        return BlocBuilder<LangCubit, LangState>(
          builder: (context, state) {
            final langCubit = context.read<LangCubit>();

            return Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        langCubit.languages.length,
                        (index) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: InkWell(
                              onTap: () {
                                langCubit.changeLanguage(index);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        index == langCubit.selectedLang
                                            ? AppColor.primeColor
                                            : AppColor.notActive,
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      langCubit.languages[index]['image']!,
                                      height: 200.h,
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      langCubit.languages[index]['name']!,
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          langCubit.savedLanguage();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          S.of(context).Change_Language,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
