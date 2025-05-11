import 'dart:convert';

import 'package:learning_project/Helper/cach_helper.dart';
import 'package:learning_project/Helper/http_helper.dart';
import 'package:learning_project/Module/Auth/Model/user_response.dart';
import 'package:learning_project/Module/Auth/authcubit/authcubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  // Controllers for OTP fields
  VerifyCubit() : super(VerifyInitial());

  final TextEditingController nameCtrl = TextEditingController(
    text: AuthCubit().nameCtrl.text,
  );
  final TextEditingController emailCtrl = TextEditingController(
    text: AuthCubit().emailCtrl.text,
  );
  final TextEditingController passwordCtrl = TextEditingController(
    text: AuthCubit().passwordCtrl.text,
  );
  final TextEditingController confirmPasswordCtrl = TextEditingController(
    text: AuthCubit().confirmPasswordCtrl.text,
  );
  late UsererResponse usererResponse;
  static VerifyCubit get(context) => BlocProvider.of(context);

  String code = '';

  void setCode(String newCode) {
    code = newCode;
    if (code.length == 5) {
      emit(VerifyButtonActive());
    } else {
      emit(VerifyInitial());
    }
  }

  Future<void> verifyCode() async {
    // Send the POST request and await the response
    var response = await HttpHelper.postData(
          url: "users/verify",
          postData: {
            'code': code,
            "name": nameCtrl.text,
            "email": emailCtrl.text,
            "password": passwordCtrl.text,
            "password confirmation": confirmPasswordCtrl.text,
            "role": "User",
          },
          headers: {"Accept": "application/json"},
        )
        .then((value) {
          if (value.statusCode == 200) {
            emit(VerifySuccess());
            final Map<String, dynamic> responseData = jsonDecode(value.body);
            CacheHelper.saveData(key: "token", value: responseData['token']);
            print("\n token ${responseData['token']}\n");
          } else if (value.statusCode == 404 || value.statusCode == 403) {
            emit(VerifyError(message: 'error'));
            print("${value.statusCode}");
          }
        })
        .catchError((e) {
          emit(VerifyError(message: "error"));
          print(e.toString());
        });
  }
}
