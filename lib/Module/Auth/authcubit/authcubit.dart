import 'package:learning_project/Helper/cach_helper.dart';
import 'package:learning_project/Module/Auth/Model/user_response.dart';
import 'package:learning_project/Module/Auth/authcubit/authstate.dart';
import 'package:learning_project/Helper/http_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthCubit extends Cubit<Authstate> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  // var
  TextEditingController emailLogctrl = TextEditingController();
  TextEditingController passWordLogctrl = TextEditingController();

  final TextEditingController nameCtrl = TextEditingController(text: "tayseer");
  final TextEditingController emailCtrl = TextEditingController(
    text: "eng.tayseermatar@gmail.com",
  );
  final TextEditingController passwordCtrl = TextEditingController(
    text: "11111111",
  );
  final TextEditingController confirmPasswordCtrl = TextEditingController(
    text: "11111111",
  );
  bool obscuretext = true;
  bool isEmail = false, showIsNotEmail = false;
  bool isPassWord = false;

  var storage = GetStorage();

  late UsererResponse registerResponse;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  // method

  // Handle Google Sign-In
  Future<String?> googleSignIn() async {
    try {
      emit(logInLoading()); // Show loading state

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(logInError()); // Handle error if user cancels sign-in
        return null;
      }

      emit(logInsucess()); // If login successful
      return googleUser.email;
    } catch (error) {
      emit(logInError()); // Handle error
      print("Google Sign-In Error: $error");
    }
    return null;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    emit(AuthInitial());
  }

  void showPassword() {
    obscuretext = !obscuretext;
    emit(ShowPassword());
  }

  bool tokenExists() {
    return storage.read("auth_token") != null;
  }

  void validEmail(String email) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );

    if (email.isNotEmpty) {
      if (emailRegex.hasMatch(email)) {
        isEmail = true;
        showIsNotEmail = false;
        emit(IsEmail());
      } else {
        isEmail = false;
        showIsNotEmail = true;
        emit(IsNotEmail());
      }
    } else {
      isEmail = false;
      showIsNotEmail = false;
      emit(IsNotEmail());
    }
  }

  void logIn() {
    Future<Null> response;
    if (emailLogctrl.text.isEmpty || passWordLogctrl.text.isEmpty) {
      emit(logInvalidate());
    } else {
      emit(logInLoading());

      response = HttpHelper.postData(
            url: "users/login",
            postData: {
              'email': emailLogctrl.text,
              'password': passWordLogctrl.text,
            },
            headers: {"Accept": "application/json"},
          )
          .then((value) {
            if (value.statusCode == 200) {
              emit(logInsucess());
              final Map<String, dynamic> responseData = jsonDecode(value.body);
              CacheHelper.saveData(key: "token", value: responseData['token']);
              print("\n token ${responseData['token']}\n");
            } else if (value.statusCode == 404 || value.statusCode == 403) {
              emit(logInError());
              print("${value.statusCode}");
            }
          })
          .catchError((e) {
            emit(logInErrorConnection());
            print(e.toString());
          });
    }
  }

  void logOut() async {
    emit(LogOutLoading());

    try {
      String? token = CacheHelper.getData(key: "token");

      if (token != null) {
        // Send a logout request to the API
        final response = await HttpHelper.postData(
          url: "users/logout",
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          // Clear the stored token on successful logout
          CacheHelper.removeData(key: "token");
          emit(LogOutSuccess());
        } else {
          emit(
            LogOutError(
              "Failed to log out. Status code: ${response.statusCode}",
            ),
          );
        }
      } else {
        emit(LogOutError("No token found."));
      }
    } catch (e) {
      emit(LogOutError("An error occurred: $e"));
    }
  }

  //////////////  signup
  ///
  ///
  void signUp() async {
    if (nameCtrl.text.isEmpty ||
        emailCtrl.text.isEmpty ||
        passwordCtrl.text.isEmpty ||
        confirmPasswordCtrl.text.isEmpty) {
      emit(signUpError(message: "All fields are required"));
      return;
    }

    if (passwordCtrl.text != confirmPasswordCtrl.text) {
      emit(signUpError(message: "Passwords do not match"));
      return;
    }

    emit(signUpLoading());

    try {
      final response = await HttpHelper.postData(
        url: "users/register",
        postData: {
          "name": nameCtrl.text,
          "email": emailCtrl.text,
          "password": passwordCtrl.text,
          "password confirmation": confirmPasswordCtrl.text,
          "role": "User",
        },
        headers: {"Accept": "application/json"},
      );

      Map<String, dynamic> responseJson = jsonDecode(response.body);

      String message = responseJson['message'];

      if (response.statusCode == 200) {
        print(response.body);
        emit(signUpSuccess(message: message));
      } else {
        emit(signUpError(message: message));
      }
    } catch (e) {
      emit(signUpError(message: "Check your connection"));
    }
  }

  ////////
  ///
  Future<void> signUpWithGoogle() async {
    try {
      emit(signUpLoading());

      // Sign in with Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Get auth details from request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Use the obtained details to make an API request to your backend
        final response = await HttpHelper.postData(
          url: "users/google-auth",
          postData: {
            "name": googleUser.displayName ?? "",
            "email": googleUser.email,
            "photoUrl": googleUser.photoUrl ?? "",
            "idToken": googleAuth.idToken ?? "",
          },
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          // Store the auth token
          storage.write('auth_token', responseData["token"]);
          emit(signUpSuccess(message: "Google Sign-in successful"));
        } else {
          emit(signUpError(message: "Failed to authenticate with server"));
        }
      } else {
        emit(signUpError(message: "Google Sign-in cancelled"));
      }
    } catch (e) {
      print("Google Sign-in Error: $e");
      emit(signUpError(message: "An error occurred during Google Sign-in"));
    }
  }
}
