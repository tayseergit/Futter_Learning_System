part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileImagePicked extends ProfileState {
  final File imageFile;
  ProfileImagePicked(this.imageFile);
}
class ProfileUploaded extends ProfileState {
  final String imageUrl;

  ProfileUploaded(this.imageUrl);
}


class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
