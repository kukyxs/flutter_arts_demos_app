import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'base_localization.dart';
import 'localization_en.dart';
import 'localization_zh.dart';

class DemoLocalization {
  final Locale locale;

  DemoLocalization(this.locale);

  static Map<String, BaseLocalization> _localizationValue = {
    "en": LocalizationEn(),
    "zh": LocalizationZh(),
  };

  BaseLocalization get currentLocale => _localizationValue[locale.languageCode];

  static DemoLocalization of(BuildContext context) => Localizations.of(context, DemoLocalization);
}

class DemoLocalizationDelegate extends LocalizationsDelegate<DemoLocalization> {
  static DemoLocalizationDelegate delegate = DemoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale) {
    return SynchronousFuture<DemoLocalization>(DemoLocalization(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalization> old) {
    return false;
  }
}
