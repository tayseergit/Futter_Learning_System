import 'package:learning_project/Helper/cach_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'lang_state.dart';

class LangCubit extends Cubit<LangState> {
  static LangCubit get(context) => BlocProvider.of(context);

  LangCubit() : super(LangInitial()) {
    final cachedKey =
        CacheHelper.getData(key: "lang") ?? "en"; // fallback to "en"
    savedLang = languages.indexWhere((lang) => lang["key"] == cachedKey);
    selectedLang = savedLang;
  }

  int selectedLang = 0;
  int savedLang = 0;

  final List<Map<String, String>> languages = [
    {"key": "ar", "name": "العربية", "image": "assets/images/ar.png"},
    {"key": "en", "name": "English", "image": "assets/images/en.png"},
  ];

  void changeLanguage(int index) {
    selectedLang = index;
    emit(ChangeLang());
  }

  void savedLanguage() {
    savedLang = selectedLang;
    CacheHelper.saveData(key: "lang", value: languages[savedLang]["key"]);
    emit(SavedLang()); // ✅ this will trigger the rebuild
  }

  String get currentLangKey => languages[savedLang]["key"]!;
}
