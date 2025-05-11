part of 'lang_cubit.dart';

@immutable
sealed class LangState {}


final class ChangeLang extends LangState {}
final class LangInitial extends LangState {}
final class SavedLang extends LangState {}