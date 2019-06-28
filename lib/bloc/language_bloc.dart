import 'bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LanguageBloc extends BaseBloc {

  Locale _currentLanguage;

  Locale get currentLanguage => _currentLanguage;

  BehaviorSubject<Locale> _localeController = BehaviorSubject();

  Observable<Locale> get localeStream => Observable(_localeController.stream);

  changeLanguage(Locale locale) {
    _currentLanguage = locale;
    _localeController.add(locale);
  }

  @override
  void dispose() {
    _localeController?.close();
  }
}
