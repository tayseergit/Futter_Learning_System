import 'dart:convert';
import 'dart:io';
import 'package:learning_project/Helper/cach_helper.dart';
import 'package:learning_project/Helper/http_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);
  String? imagePath; // local path
  File? profileImage; // File object

  final ImagePicker _picker = ImagePicker();

  Future<void> pickProfileImage() async {
    try {
      emit(ProfileLoading());
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        imagePath = pickedFile.path;
        profileImage = File(pickedFile.path);
        emit(ProfileImagePicked(profileImage!));
        print("imagePath :$imagePath");
      } else {
        emit(ProfileInitial());
      }
    } catch (e) {
      emit(ProfileError("Failed to pick image: $e"));
    }
  }

  Future<void> uploadProfileImage() async {
    if (profileImage == null) {
      emit(ProfileError("No image selected"));
      return;
    }
    emit(ProfileLoading());
    try {
      String url = '${HttpHelper.basic_url_api}users/upload';

      final request = http.MultipartRequest('POST', Uri.parse(url));

      print("${imagePath}ddd");
      if (imagePath != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "image", // Field name expected by the server
            imagePath!,
          ),
        );
      }
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] =
          "Bearer ${CacheHelper.getData(key: "token")}";

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decoded = jsonDecode(responseBody);

        final imageUrl = decoded['image']; // path like "/storage/images/..."

        CacheHelper.saveData(
          key: "profile_image",
          value: "${HttpHelper.basic_url_image}$imageUrl",
        );
        emit(ProfileUploaded("${HttpHelper.basic_url_image}$imageUrl"));
      } else {
        emit(ProfileError("error"));
      }
    } catch (e) {
      emit(ProfileError("error"));
      print("aaaaaaaa${e.toString()}");
      print("state is ///////$state");
    }
  }
}
