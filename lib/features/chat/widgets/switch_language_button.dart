import 'package:flutter/material.dart';
import 'package:flutter_bloc_chat/core/constants/constanst.dart';
import 'package:flutter_bloc_chat/core/localization/localization.dart';

class SwitchLanguageButton extends StatelessWidget {
  const SwitchLanguageButton({
    super.key,
    required this.setLocale,
    required this.localizations,
  });

  final Function(Locale p1) setLocale;
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > tabletScreen;

    return PopupMenuButton<String>(
      iconSize: isLargeScreen ? 40 : 25,
      onSelected: (String result) {
        if (result == 'en') {
          setLocale(const Locale('en', ''));
        } else if (result == 'ja') {
          setLocale(const Locale('ja', ''));
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'en',
          child: Text(
            localizations.switchToEnglish,
            style: TextStyle(
              fontSize: isLargeScreen ? 20 : 16,
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'ja',
          child: Text(
            localizations.switchToJapanese,
            style: TextStyle(
              fontSize: isLargeScreen ? 20 : 16,
            ),
          ),
        ),
      ],
    );
  }
}
