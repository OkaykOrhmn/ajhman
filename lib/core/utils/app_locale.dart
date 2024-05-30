import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeLocale {
  final BuildContext context;

  ChangeLocale(this.context);

  //get from database
  //final SharedPreferences prefs = await SharedPreferences.getInstance();
  //final String? action = prefs.getString('action');
  // Locale _locale = Locale(action);
  Locale _locale = const Locale("fa");
  final List<LocalizationsDelegate<Object>> _listLocalD = const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  final List<Locale> _supportedLocales = AppLocalizations.supportedLocales;

  //getter
  AppLocalizations? get appLocal => AppLocalizations.of(context);
  Locale get locale => _locale;
  List<LocalizationsDelegate<Object>> get listLocalD => _listLocalD;
  List<Locale> get supportedLocales => _supportedLocales;
  //setter
  set locale(Locale value) {
    _locale = value;
  }
}
