// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Sign Up`
  String get signin {
    return Intl.message('Sign Up', name: 'signin', desc: '', args: []);
  }

  /// `Username`
  String get name {
    return Intl.message('Username', name: 'name', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Confirm Password`
  String get password_confirmation {
    return Intl.message(
      'Confirm Password',
      name: 'password_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get Change_Language {
    return Intl.message(
      'Change Language',
      name: 'Change_Language',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get FORGET_PASSWORD {
    return Intl.message(
      'Forgot Password',
      name: 'FORGET_PASSWORD',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get FIRST_NAME {
    return Intl.message('First Name', name: 'FIRST_NAME', desc: '', args: []);
  }

  /// `Last Name`
  String get LAST_NAME {
    return Intl.message('Last Name', name: 'LAST_NAME', desc: '', args: []);
  }

  /// `Enter your email`
  String get ENTER_YOUR_EMAIL {
    return Intl.message(
      'Enter your email',
      name: 'ENTER_YOUR_EMAIL',
      desc: '',
      args: [],
    );
  }

  /// `Enter your mobile number`
  String get ENTER_MOBILE_NUMBER {
    return Intl.message(
      'Enter your mobile number',
      name: 'ENTER_MOBILE_NUMBER',
      desc: '',
      args: [],
    );
  }

  /// `Account created successfully`
  String get sign_up_successfully_now_login {
    return Intl.message(
      'Account created successfully',
      name: 'sign_up_successfully_now_login',
      desc: '',
      args: [],
    );
  }

  /// `Dont have an account?`
  String get NO_ACCOUNT {
    return Intl.message(
      'Dont have an account?',
      name: 'NO_ACCOUNT',
      desc: '',
      args: [],
    );
  }

  /// `Verify Code`
  String get Verify_Code {
    return Intl.message('Verify Code', name: 'Verify_Code', desc: '', args: []);
  }

  /// `Verify code send to your email`
  String get Verify_Code_Send {
    return Intl.message(
      'Verify code send to your email',
      name: 'Verify_Code_Send',
      desc: '',
      args: [],
    );
  }

  /// `VERIFY`
  String get VERIFY {
    return Intl.message('VERIFY', name: 'VERIFY', desc: '', args: []);
  }

  /// `Check your email or password`
  String get Check_your_email_password {
    return Intl.message(
      'Check your email or password',
      name: 'Check_your_email_password',
      desc: '',
      args: [],
    );
  }

  /// `Check connection`
  String get Check_connection {
    return Intl.message(
      'Check connection',
      name: 'Check_connection',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get Enter_valid_email {
    return Intl.message(
      'Enter a valid email',
      name: 'Enter_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Forget password`
  String get Forget_password {
    return Intl.message(
      'Forget password',
      name: 'Forget_password',
      desc: '',
      args: [],
    );
  }

  /// `sign up with Google`
  String get sign_up_with_Google {
    return Intl.message(
      'sign up with Google',
      name: 'sign_up_with_Google',
      desc: '',
      args: [],
    );
  }

  /// `success`
  String get success {
    return Intl.message('success', name: 'success', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
