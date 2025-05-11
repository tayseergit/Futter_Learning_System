import 'dart:convert';

 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_project/Helper/http_helper.dart';
import 'package:learning_project/Module/Adress/cubit/address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());
  static AddressCubit get(context) => BlocProvider.of(context);
  Future<void> createAddress() async {
    Future<Null> response;

    emit(AddressLoading());
    response = HttpHelper.postData(
          url: "address/create",
          postData: {
            'name': "",
            'city': "",
            'region': "",
            'details': "",
            'lon': "",
            'lat': "",
            'note': "",
          },
        )
        .then((value) {
          if (value.statusCode == 200) {
            emit(AddressSuceess());
            final Map<String, dynamic> responseData = jsonDecode(value.body);
            print( responseData);
          } else  {
            emit(AddressError());
            print("${value.statusCode}");
          }
        })
        .catchError((e) {
          emit(AddressError());
          print(e.toString());
        });
  }
}
/** void logIn() {
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
          )
          .then((value) {
            if (value.statusCode == 200) {
              emit(logInsucess());
              final Map<String, dynamic> responseData = jsonDecode(value.body);
              storage.write('auth_token', '${responseData["token"]}');
              // Print the entire JSON response
              print("JSON Response: ${responseData['token']}");
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
  } */