part of 'verify_cubit.dart';

 
abstract class VerifyState {}

final class VerifyInitial extends VerifyState {}

final class VerifyButtonActive extends VerifyState {}

final class VerifyButtonInactive extends VerifyState {}
final class VerifySuccess  extends VerifyState {}
final class VerifyError extends VerifyState {
   final String message;
  VerifyError({required this.message});
}
