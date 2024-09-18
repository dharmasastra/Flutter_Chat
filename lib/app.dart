import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_chat/core/constants/theme_manager.dart';
import 'package:flutter_bloc_chat/core/localization/localization.dart';
import 'package:flutter_bloc_chat/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_bloc_chat/features/chat/presentation/views/chat_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Locale _locale = const Locale('en', '');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('ja', ''),
      ],
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: getApplicationThemeData(),
      home: BlocProvider(
        create: (context) => ChatBloc(),
        child: ChatScreen(setLocale: setLocale),
      ),
    );
  }
}
