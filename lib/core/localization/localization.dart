


import 'package:flutter/material.dart';
import 'package:flutter_bloc_chat/l10n/messages_all_locales.dart';
import 'package:intl/intl.dart';

// Localization delegate
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

// Localization class
class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode == null || locale.countryCode!.isEmpty
        ? locale.languageCode
        : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get chatWithBot => Intl.message('Chat with Bot', name: 'chatWithBot');
  String get typeAMessage => Intl.message('Type a message', name: 'typeAMessage');
  String get user => Intl.message('User', name: 'user');
  String get bot => Intl.message('Bot', name: 'bot');
  String get switchToEnglish => Intl.message('Switch to English', name: 'switchToEnglish');
  String get switchToJapanese => Intl.message('Switch to Japanese', name: 'switchToJapanese');
}
